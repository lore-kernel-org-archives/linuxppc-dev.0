Return-Path: <bounces@nabble.com>
Received: from talk.nabble.com (www.nabble.com [72.21.53.35])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C0594DDE2F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 20 Apr 2007 01:10:33 +1000 (EST)
Received: from [72.21.53.38] (helo=jubjub.nabble.com)
	by talk.nabble.com with esmtp (Exim 4.50) id 1HeYHF-0008Ge-UI
	for linuxppc-embedded@ozlabs.org; Thu, 19 Apr 2007 08:10:29 -0700
Message-ID: <10079346.post@talk.nabble.com>
Date: Thu, 19 Apr 2007 08:10:29 -0700 (PDT)
From: Mirek23 <miroslaw.dach@psi.ch>
To: linuxppc-embedded@ozlabs.org
Subject: zImage.elf loads but not starts
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi All,

    I am just trying to build, load and run the kernel 2.6 on ppc405 of the
Avnet evaluation board which uses Xilinx Virtex 4 FX-12 chip (ml403 like).

I have downloaded the kernel 2.6 from Grant using git. I have downloaded
ELDK 4.1 to my PC.
I have compiled successfully the kernel with the crosscompiler from ELDK
4.1.

So far so good.

The kernel configuration was done according to the spec on the page:
http://www.linux.get2knowmore.com/2006/06/30/quick-guide-linux-26-on-xilinx-virtex-ii-pro-boards-part-i/

I have set during configuration phase additional parameters:

Default bootloader kernel arguments:
console=ttyS0

* 8250/16550 and compatible serial support
* Console on 8250/16550 and compatible serial support

* Initial RAM filesystem and RAM disk (initramfs/initrd) suppor

*RAM disk support
16 Default number of RAM disks
8192 Default RAM disk size (kbytes)
(1024) Default RAM disk block size (bytes)
---------------------------------------------------------------------------

when I use objdump -h zImage.elf I get:

arch/ppc/boot/images/zImage.elf:     file format elf32-big

Sections:
Idx Name          Size      VMA       LMA       File off  Algn
  0 .text         00003848  00400000  00400000  00010000  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
  1 .data         000f5000  00404000  00404000  00014000  2**2
                  CONTENTS, ALLOC, LOAD, DATA
  2 .bss          0000213c  004f9000  004f9000  00109000  2**2
                  ALLOC
  3 .debug_abbrev 00000c3a  00000000  00000000  00109000  2**0
                  CONTENTS, READONLY, DEBUGGING
  4 .debug_info   0000267d  00000000  00000000  00109c3a  2**0
                  CONTENTS, READONLY, DEBUGGING
  5 .debug_line   00000bc8  00000000  00000000  0010c2b7  2**0
                  CONTENTS, READONLY, DEBUGGING
  6 .debug_frame  000004c0  00000000  00000000  0010ce80  2**2
                  CONTENTS, READONLY, DEBUGGING
  7 .debug_loc    00002c7c  00000000  00000000  0010d340  2**0
                 CONTENTS, READONLY, DEBUGGING
  8 .debug_pubnames 000003c5  00000000  00000000  0010ffbc  2**0
                  CONTENTS, READONLY, DEBUGGING
  9 .debug_aranges 00000120  00000000  00000000  00110381  2**0
                  CONTENTS, READONLY, DEBUGGING
 10 .debug_ranges 00000078  00000000  00000000  001104a1  2**0
                  CONTENTS, READONLY, DEBUGGING
 11 .debug_str    00000ae0  00000000  00000000  00110519  2**0
                  CONTENTS, READONLY, DEBUGGING
 12 .note.GNU-stack 00000000  00000000  00000000  00110ff9  2**0
                  CONTENTS, READONLY


To load the zImage.elf to the SDRAM of my Avent evaluation board I use JTAG
and Xilinx XMD program:

XMD% dow zImage.elf
        section, .text: 0x00400000-0x00403848
        section, .data: 0x00404000-0x004f0000
        section, .bss: 0x004f0000-0x004f21a0
Downloaded Program zImage.elf
Setting PC with program start addr = 0x00400000
PC reset to 0x00400000, Clearing MSR Register
XMD% run
PC reset to 0x00400000, Clearing MSR Register
Processor started. Type "stop" to stop processor
RUNNING> stop


I do not see any output in the XMD session nor in the minicom window
connected to the Xilinx serial port.

It seems to be that the kernel did not start.

The Avent board has 32 MB of SD RAM. Before loading the zImage.elf I have
loaded the bitstream to setup the Xillinx FPGA.

Do you have an idea what could be wrong.

Best Regards

Mirek



-- 
View this message in context: http://www.nabble.com/zImage.elf-loads-but-not-starts-tf3607582.html#a10079346
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
