#==============================================================================
# (C) Copyright Albis Technologies Ltd 2011
#==============================================================================
#                STM32 Example Code
#==============================================================================
# File name:     Makefile
#
# Notes:         -
#==============================================================================

firsttarget: all

CROSS_COMPILE=arm-none-eabi-
SHELL=/bin/bash
GCC=$(CROSS_COMPILE)gcc
AS=$(CROSS_COMPILE)as
OBJCPY=$(CROSS_COMPILE)objcopy
RM=rm
ECHO=echo

#==============================================================================
#  Building.
#==============================================================================
AFLAGS=-mcpu=cortex-m4 \
	   -mthumb

CFLAGS=-Wpointer-arith \
       -Wstrict-prototypes \
       -Werror \
       -mcpu=cortex-m4 \
       -mthumb \
       -g \
       -O2

#LFLAGS=-nostartfiles \
LFLAGS=-nostdlib \
       -mcpu=cortex-m4

.s.o:
#	$(AS) $(AFLAGS) -c $< -o $@
	$(GCC) $(CFLAGS) $(INCL) -c $< -o $@

.S.o:
	$(GCC) $(CFLAGS) $(INCL) -c $< -o $@

.c.o:
	$(GCC) $(CFLAGS) $(INCL) -c $< -o $@

#==============================================================================
#  Repository directories.
#==============================================================================
PATH_OS_SRC=Software/uCOS-II/Source
PATH_CM4_SRC=Software/uCOS-II/Ports/ARM-Cortex-M4/Generic/GNU
PATH_BSP_SRC=Examples/ST/STM3240G-EVAL/BSP
PATH_CPU_SRC=Software/uC-CPU/ARM-Cortex-M4/GNU
PATH_CPU_INC=Software/uC-CPU
PATH_UCLIB_SRC=Software/uC-LIB
PATH_STM32_SRC=Examples/ST/STM32CubeF4/Drivers/STM32F4xx_HAL_Driver/Src
PATH_STM32_INC=Examples/ST/STM32CubeF4/Drivers/STM32F4xx_HAL_Driver/Inc
PATH_UC_SERIAL_SRC=Software/uC-Serial
PATH_APPL_SRC=Examples/ST/STM3240G-EVAL/OS2
PATH_APPL_INC=Examples/ST/STM3240G-EVAL/OS2

#==============================================================================
#  Board support package (BSP).
#==============================================================================
ASMS_START=$(PATH_BSP_SRC)/TrueSTUDIO/startup.o \

OBJS_BSP=$(PATH_BSP_SRC)/bsp.o \
         $(PATH_BSP_SRC)/bsp_int.o \
         $(PATH_BSP_SRC)/bsp_periph.o \
         $(PATH_BSP_SRC)/cpu_bsp.o \
         $(PATH_BSP_SRC)/serial_bsp_stm3240x.o \
         $(PATH_BSP_SRC)/OS/uCOS-II/bsp_os.o \
         $(PATH_BSP_SRC)/CMSIS/system_stm32f4xx.o

INCL_BSP=-I$(PATH_BSP_SRC) \
         -I$(PATH_BSP_SRC)/OS/uCOS-II

#==============================================================================
#  uC/OS-II.
#==============================================================================
ASMS_UCOS=$(PATH_CM4_SRC)/os_cpu_a.o \
          $(PATH_CPU_SRC)/cpu_a.o

OBJS_UCOS=$(PATH_OS_SRC)/os_core.o \
          $(PATH_OS_SRC)/os_flag.o \
          $(PATH_OS_SRC)/os_mbox.o \
          $(PATH_OS_SRC)/os_mem.o \
          $(PATH_OS_SRC)/os_mutex.o \
          $(PATH_OS_SRC)/os_q.o \
          $(PATH_OS_SRC)/os_sem.o \
          $(PATH_OS_SRC)/os_task.o \
          $(PATH_OS_SRC)/os_time.o \
          $(PATH_OS_SRC)/os_tmr.o \
          $(PATH_CM4_SRC)/os_cpu_c.o \
          $(PATH_CM4_SRC)/os_dbg.o \
          $(PATH_CPU_SRC)/cpu_c.o \
          $(PATH_CPU_INC)/cpu_core.o

INCL_UCOS=-I$(PATH_OS_SRC) \
          -I$(PATH_CM4_SRC) \
          -I$(PATH_CPU_SRC) \
          -I$(PATH_CPU_INC)

#==============================================================================
#  uC/LIB.
#==============================================================================
ASMS_UCLIB=$(PATH_UCLIB_SRC)/Ports/ARM-Cortex-M4/GNU/lib_mem_a.o

OBJS_UCLIB=$(PATH_UCLIB_SRC)/lib_mem.o \
           $(PATH_UCLIB_SRC)/lib_str.o \
           $(PATH_UCLIB_SRC)/lib_math.o \
           $(PATH_UCLIB_SRC)/lib_ascii.o

INCL_UCLIB=-I$(PATH_UCLIB_SRC)

#==============================================================================
#  uC/Serial.
#==============================================================================
OBJS_UCSERIAL=$(PATH_UC_SERIAL_SRC)/Driver/ST/serial_drv_stm32.o \
              $(PATH_UC_SERIAL_SRC)/Line/serial_line_dflt.o \
              $(PATH_UC_SERIAL_SRC)/Line/serial_line_probe.o \
              $(PATH_UC_SERIAL_SRC)/Line/serial_line_tty.o \
              $(PATH_UC_SERIAL_SRC)/OS/uCOS-II/serial_os.o \
              $(PATH_UC_SERIAL_SRC)/Source/serial_buf.o \
              $(PATH_UC_SERIAL_SRC)/Source/serial.o

INCL_UCSERIAL=-I$(PATH_OS_SRC) \
          -I$(PATH_UC_SERIAL_SRC)/Driver/ST \
          -I$(PATH_UC_SERIAL_SRC)/Line \
          -I$(PATH_UC_SERIAL_SRC)/OS \
          -I$(PATH_UC_SERIAL_SRC)/Source

#==============================================================================
#  STM32.
#==============================================================================
OBJS_STM32=$(PATH_STM32_SRC)/stm32f4xx_hal_flash.o \
		   $(PATH_STM32_SRC)/stm32f4xx_hal_flash_ex.o \
           $(PATH_STM32_SRC)/stm32f4xx_hal_dma.o \
           $(PATH_STM32_SRC)/stm32f4xx_hal_cortex.o \
           $(PATH_STM32_SRC)/stm32f4xx_hal_gpio.o \
           $(PATH_STM32_SRC)/stm32f4xx_hal_rcc.o \
           $(PATH_STM32_SRC)/stm32f4xx_hal_usart.o \
           $(PATH_STM32_SRC)/stm32f4xx_hal.o

INCL_STM32=-I$(PATH_STM32_INC) \
           -I$(PATH_STM32_SRC) \
           -IExamples/ST/STM32CubeF4/Drivers/CMSIS/Device/ST/STM32F4xx/Include \
           -IExamples/ST/STM32CubeF4/Drivers/CMSIS/Include \
           -IExamples/ST/STM32CubeF4/Drivers/STM32F4xx_HAL_Driver/Inc

#==============================================================================
#  Application.
#==============================================================================
OBJS_APPL=$(PATH_APPL_SRC)/app.o \
          $(PATH_APPL_SRC)/app_hooks.o \
          $(PATH_APPL_SRC)/app_serial.o

INCL_APPL=-I$(PATH_APPL_INC)

#==============================================================================
#  All objects for binary.
#==============================================================================
ASMS=$(ASMS_START) $(ASMS_UCOS) $(ASMS_UCLIB)
OBJS=$(OBJS_BSP) $(OBJS_UCOS) $(OBJS_UCLIB) $(OBJS_STM32) $(OBJS_UCSERIAL) $(OBJS_APPL)
INCL=$(INCL_BSP) $(INCL_UCOS) $(INCL_UCLIB) $(INCL_STM32) $(INCL_UCSERIAL) $(INCL_APPL)
BIN=btstackfw

all: $(ASMS) $(OBJS)
	@$(ECHO) Linking Flash image...
	$(GCC) $(LFLAGS) -Wl,-Map,$(BIN).map -T$(PATH_APPL_SRC)/TrueSTUDIO/stm32f4_flash.ld -lrdimon -lc -lm -o $(BIN).elf $(ASMS) $(OBJS)
	$(OBJCPY) -O binary $(BIN).elf $(BIN).bin
	@$(ECHO)
	@$(ECHO) Successfully built BTstack Flash image for $(BT_CHIPSET), STM32 UART DMA $(STM32_USART_DMA).
	@$(ECHO)

clean:
	$(RM) -f *.elf *.bin *.map $(ASMS) $(OBJS)
