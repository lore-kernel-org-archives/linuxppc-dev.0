Return-Path: <andrew.l.bomber@maxtek.com>
Received: from igate.tek.com (igate.tek.com [192.65.41.20])
	by ozlabs.org (Postfix) with ESMTP id 68193689E1
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jan 2006 13:03:56 +1100 (EST)
Received: from tektronix.tek.com (tektronix.tek.com [128.181.6.43])
	by igate.tek.com (8.12.10+Sun/8.12.10) with ESMTP id k0C23ttT006216
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jan 2006 18:03:55 -0800 (PST)
Received: from us-bv-u16.global.tektronix.net (us-bv-u16.bv.tek.com
	[128.181.2.45])
	by tektronix.tek.com (8.12.10+Sun/8.12.10) with SMTP id k0C23sdp017883
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jan 2006 18:03:55 -0800 (PST)
From: andrew.l.bomber@maxtek.com
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Date: Wed, 11 Jan 2006 18:03:53 -0800
Message-ID: <7E11C792A1D81242B9BFFC8355D4979387F6F7@us-bv-m23.global.tektronix.net>
To: <ali@pctlinux.com>, <linuxppc-dev@ozlabs.org>
Subject: RE: kernel hang on 'now booting the kernel'
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ali,

What is likely happening is that Linux's logical address space is not
configured appropriately. The MMU configuration is the first or Second
thing to happen after zImage boots into the Kernel.

I had the same problem for a custom board with a Xilinx Virtex 2 Pro.
The problem was that I edited the .config file without running
menuconfig and that I changed KERNELBASE. Don't change KERNELBASE
because if you do it will screw up Linux's logical address space. Second
always run make menuconfig before make dep and make zImage because
menuconfig alters a number of lower level files according to your
configuration. Also make sure that you copy the BSP into the kernel
source tree otherwise Linux will be writing to the wrong address when
trying to output to stdout.

Regards,

Andrew

-----Original Message-----
From: linuxppc-dev-bounces@ozlabs.org
[mailto:linuxppc-dev-bounces@ozlabs.org] On Behalf Of Ali Paikan
Sent: Sunday, December 25, 2005 2:19 AM
To: linuxppc-dev@ozlabs.org
Subject: kernel hang on 'now booting the kernel'



Dear Sir,
 I am a student and I tried to install Linux on ML300 board. I need that
for
doing my final project but I have many problems.=20

I compiled the open source PowerPC kernel (linuxppc_2_4_devel) with a
cross=20
compiler which I built it by Dan Kegel cross tools. Before compiling, I=20
updated xparameters_ml300.h according to my base system design from
Xilinx EDK. =20
Next, I tried to download kernel ELF file to board and every thing seen
well.
But My kernel hanged up when it was going to load main kernel image with
show=20
this message on serial console:

loaded at:     00400000 004B01E4                               =20
board data at: 004AD13C 004AD154                               =20
relocated to:  00405648 00405660                               =20
zimage at:     00405C13 004AC65E                               =20
avail ram:     004B1000 08000000                               =20

Linux/PPC load: console=3DttyS0,9600 ip=3Doff =
root=3D/dev/xsysace/disc0/part3
rw
Uncompressing Linux...done.
Now booting the kernel

I debugged the kernel and results showed memory initialized and
load_kernel=20
function decompressed image into address 0x0 as well. (I can see tree
NOP=20
instructions from address 0x0).
But, I am not sure about next step in jumping to address 0x000C and
running=20
the main part of kernel.

I wondered more when I tried to make a Xilinx System ACE file with
Impact.=20
It failed too with showing this fatal error:

FATAL_ERROR:GuiUtilities:WinApp.c:710:$Revision - This application has=20
discovered an exceptional condition from which it cannot recover.
Process
will terminate.  To resolve this error, please consult the Answers
Database
and other online resources at http://support.xilinx.com. If you need
further=20
assistance, please open a Webcase by clicking on the "WebCase" link at
http://support.xilinx.com.

I don't have any problem for making system ace from other ELF files.
Might it be for my bad compilation?
Is my base system building for FPGA not correct?
Where is my wrong?
=20
For more information I attached my all configuration and log files at
end of=20
this mail.

I am too great if you help me in this case and I look forward to hearing
from you.=20
Sorry my pure English!

Sincerely,
Ali Paikan



Cross compiler option:
CONFIG_TARGET=3D"powerpc-405-linux-gnu"
CONFIG_TARGET_CFLAGS=3D"-O -mcpu=3D405"
CONFIG_GCC_EXTRA_CONFIG=3D"--with-cpu=3D405 =
--enable-cxx-flags=3D-mcpu=3D405"
CONFIG_GLIBC_EXTRA_CONFIG=3D"-without-fp"

powerpc-405-linux-gnu-objdump -h:
zImage.:     file format elf32-powerpc
Sections:
Idx Name          Size      VMA       LMA       File off  Algn
  0 .text         00004798  00400000  00400000  00010000  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
  1 .data         00095000  00405000  00405000  00015000  2**2
                  CONTENTS, ALLOC, LOAD, DATA
  2 .bss          000031e0  0049a000  _u48 ?49a000  000aa000  2**2
                  ALLOC
  3 .note.GNU-stack 00000000  00000000  00000000  000aa000  2**0
                  CONTENTS, READONLY


Xparameters_ml300.h :
/*********************************************************_u42 ?********
*
* CAUTION: This file is automatically generated by libgen.
* Version: Xilinx EDK 7.1 EDK_H.10.4
* DO NOT EDIT.
*
* Copyright (c) 2005 Xilinx, Inc.  All rights reserved.=20
*=20
* Description: Driver parameters
*
*******************************************************************/

#define XPAR_XUARTLITE_NUM_INSTANCES 1
#define XPAR_RS232_UART_1_BASEADDR 0x40600000
#define XPAR_RS232_UART_1_HIGHADDR 0x4060FFFF
#define XPAR_RS232_UART_1_DEVICE_ID 0
#define XPAR_RS232_UART_1_BAUDRATE 9600
#define XPAR_RS232_UART_1_USE_PARITY 0
#define XPAR_RS232_UART_1_ODD_PARITY 0
#define XPAR_RS232_UART_1_DATA_BITS 8

/******************************************************************/

#define XPAR_XSYSACE_MEM_WIDTH 8
#define XPAR_XSYSACE_NUM_INSTANCES 1
#define XPAR_SYSACE_COMPACTFLASH_BASEADDR 0x41800000
#define XPAR_SYSACE_COMPACTFLASH_HIGHADDR 0x4180FFFF
#define XPAR_SYSACE_COMPACTFLASH_DEVICE_ID 0
#define XPAR_SYSACE_COMPACTFLASH_MEM_WIDTH 8

/******************************************************************/

#define XPAR_INTC_MAX_NUM_INTR_INPUTS 3
#define XPAR_XINTC_HAS_IPR 1
#define XPAR_XINTC_USE_DCR 0
#define XPAR_XINTC_NUM_INSTANCES 1
#define XPAR_OPB_INTC_0_BASEADDR 0x41200000
#define XPAR_OPB_INTC_0_HIGHADDR 0x4120FFFF
#define XPAR_OPB_INTC_0_DEVICE_ID 0
#define XPAR_OPB_INTC_0_KIND_OF_INTR 0x00000006

/******************************************************************/

#define XPAR_INTC_SINGLE_BASEADDR 0x41200000
#define XPAR_INTC_SINGLE_HIGHADDR 0x4120FFFF
#define XPAR_INTC_SINGLE_DEVICE_ID XPAR_OPB_INTC_0_DEVICE_ID
#define XPAR_SYSACE_COMPACTFLASH_SYSACE_IRQ_MASK 0X000001
#define XPAR_OPB_INTC_0_SYSACE_COMPACTFLASH_SYSACE_IRQ_INTR 0
#define XPAR_RS232_UART_1_INTERRUPT_MASK 0X000002
#define XPAR_OPB_INTC_0_RS232_UART_1_INTERRUPT_INTR 1
#define XPAR_DDR_SDRAM_32MX32_IP2INTC_IRPT_MASK 0X000004
#define XPAR_OPB_INTC_0_DDR_SDRAM_32MX32_IP2INTC_IRPT_INTR 2

/******************************************************************/

#define XPAR_XDDR_NUM_INSTANCES 1
#define XPAR_DDR_SDRAM_32MX32_ECC_BASEADDR 0xFFFFFFFF
#define XPAR_DDR_SDRAM_32MX32_ECC_HIGHADDR 0x00000000
#define XPAR_DDR_SDRAM_32MX32_DEVICE_ID 0
#define XPAR_DDR_SDRAM_32MX32_INCLUDE_ECC_INTR 0

/******************************************************************/

#define XPAR_DDR_SDRAM_32MX32_MEM0_BASEADDR 0x00000000
#define XPAR_DDR_SDRAM_32MX32_MEM0_HIGHADDR 0x07FFFFFF

/******************************************************************/

#define XPAR_PLB_BRAM_IF_CNTLR_1_BASEADDR 0xffffc000
#define XPAR_PLB_BRAM_IF_CNTLR_1_HIGHADDR 0xffffffff

/******************************************************************/

#define XPAR_CPU_PPC405_CORE_CLOCK_FREQ_HZ 300000000

/******************************************************************/


/******************************************************************/

/* Linux Redefines */

/******************************************************************/

#define XPAR_UARTLITE_0_BASEADDR XPAR_RS232_UART_1_BASEADDR
#define XPAR_UARTLITE_0_HIGHADDR XPAR_RS232_UART_1_HIGHADDR
#define XPAR_UARTLITE_0_DEVICE_ID XPAR_RS232_UART_1_DEVICE_ID

/******************************************************************/

#define XPAR_SYSACE_0_BASEADDR XPAR_SYSACE_COMPACTFLASH_BASEADDR
#define XPAR_SYSACE_0_HIGHADDR XPAR_SYSACE_COMPACTFLASH_HIGHADDR
#define XPAR_SYSACE_0_DEVICE_ID XPAR_SYSACE_COMP8CTFLASH_DEVICE_ID

/******************************************************************/

#define XPAR_INTC_0_BASEADDR XPAR_OPB_INTC_0_BASEADDR
#define XPAR_INTC_0_HIGHADDR XPAR_OPB_INTC_0_HIGHADDR
#define XPAR_INTC_0_KIND_OF_INTR XPAR_OPB_INTC_0_KIND_OF_INTR
#define XPAR_INTC_0_DEVICE_ID XPAR_OPB_INTC_0_DEVICE_ID

/******************************************************************/

#define XPAR_INTC_0_SYSACE_0_VEC_ID
XPAR_OPB_INTC_0_SYSACE_COMPACTFLASH_SYSACE_IRQ_INTR
#define XPAR_INTC_0_UARTLITE_0_VEC_ID
XPAR_OPB_INTC_0_RS232_UART_1_INTERRUPT_INTR
#define XPAR_INTC_0_DDR_0_VEC_ID
XPAR_OPB_INTC_0_DDR_SDRAM_32MX32_IP2INTC_IRPT_INTR

/******************************************************************/

#define XPAR_PLB_CLOCK_FREQ_HZ 100000000
#define XPAR_CORE_CLOCK_FREQ_HZ XPAR_CPU_PPC405_CORE_CLOCK_FREQ_HZ
#define XPAR_DDR_0_SIZE 8000000

/******************************************************************/

#define XPAR_PERSISTENT_0_IIC_0_BASEADDR 0x00000400
#define XPAR_PERSISTENT_0_IIC_0_HIGHADDR 0x000007FF
#define XPAR_PERSISTENT_0_IIC_0_EEPROMADDR 0xA0

/******************************************************************/

#define XPAR_PCI_0_CLOCK_FREQ_HZ    0

/******************************************************************/



_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev
