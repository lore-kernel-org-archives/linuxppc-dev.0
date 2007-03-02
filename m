Return-Path: <christophe.alayrac@cresitt.com>
Received: from postfix1-g20.free.fr (postfix1-g20.free.fr [212.27.60.42])
	by ozlabs.org (Postfix) with ESMTP id D1E6DDDED3
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Mar 2007 18:58:54 +1100 (EST)
Received: from smtp5-g19.free.fr (smtp5-g19.free.fr [212.27.42.35])
	by postfix1-g20.free.fr (Postfix) with ESMTP id 118A3ADAEFA
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Mar 2007 08:58:52 +0100 (CET)
Received: from CRESITTLAB (sou45-1-82-229-118-71.fbx.proxad.net
	[82.229.118.71])
	by smtp5-g19.free.fr (Postfix) with ESMTP id 7C1077200
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Mar 2007 08:58:49 +0100 (CET)
From: "alayrac" <christophe.alayrac@cresitt.com>
To: "'linux ppc'" <linuxppc-embedded@ozlabs.org>
Subject: Kernel start error
Date: Fri, 2 Mar 2007 08:58:45 +0100
Message-ID: <000001c75ca0$9a668040$c900a8c0@CRESITTLAB>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all.

I'am coming to you looking for some experience with HydraXC-50
(Virtex4FX12, Proc PPC405) to try to figure out some boot sequence
error.

On that platform there is an Atmega8L that load FPGA bitstream through
JTAG chain. The Loader V1.1 code is in FPGA internal BRAM so that after
FPGA initialisation the PPC405 start execution from that memory.

This loader start properly, read the kernel image.bin from SDCARD and
try to start the kernel at is start address, in my case 0x400000.

In the loader the last point is
    print("\n\rStarting image from Memory\n\r");
    jump();	

with jump function
   void jump() {
	cmdline[0]='\0';
	xil_printf("mem_start %08X\r\n",mem_start);
	kernel_start = (void_fn)mem_start;
	kernel_start(cmdline);
   }

The loader hangs up after the messages : 
	Starting image from Memory
	mem_start 00400000

If I download the kernel image (zImage.elf) using JTAG emulator under
Xilinx XMD shell, with commands
	dow zImage.elf
	con
then the kernel start properly.

I did not succeed to understand why the loader start procedure hangs up.

Thank in advance for any help.

Chris
