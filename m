Return-Path: <peter.ryser@xilinx.com>
Received: from mail86-ash-R.bigfish.com (mail-ash.bigfish.com [206.16.192.253])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 9FC8467BE5
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  8 Jul 2005 03:33:58 +1000 (EST)
Message-ID: <42CD6759.9090203@xilinx.com>
Date: Thu, 07 Jul 2005 10:33:13 -0700
From: Peter Ryser <peter.ryser@xilinx.com>
MIME-Version: 1.0
To: mcnernbm@notes.udayton.edu
References: <OFEB66331D.10CE4400-ON85257037.005D805A-85257037.005D85D7@notes.udayton.edu>
In-Reply-To: <OFEB66331D.10CE4400-ON85257037.005D805A-85257037.005D85D7@notes.udayton.edu>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Fw: Montavista Patch for ml403
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

The linux/patch_linux script has some information on how to apply the=20
patch. For the next release of the reference design we will include more=20
information and also have updated the patch. The new release will be=20
available within the next few days. Check=20
http://www.xilinx.com/products/boards/ml403/reference_designs.htm for=20
availability of the updates.

Further down find the updated instructions. I'll send you the updated=20
patch in a private email.

- Peter


  Building the Linux BSP (PPC405 Systems Only)

The EDK design comes with MLD/TCL technology to generate a Linux BSP for=20
ML40x and a script to patch a MontaVista Linux kernel from the ML300 LSP=20
for use with this BSP.

To build a BSP for and to patch the Linux kernel, proceed as follows:

1. Start XPS and load the Linux XMP:
$ xps system_linux.xmp

2. Generate the Linux BSP with Tools->Generate Libraries and BSPs

The resulting Linux BSP is located in=20
ppc405_0/libsrc/linux_mvl31_v1_00_a/linux.

3. Quit XPS

4. Create a copy of the MontaVista Linux kernel for the ML300 board.

The Linux kernel and the tools to build the Linux kernel are available=20
from MontaVista (http://www.mvista.com). For further information about=20
using Linux with EDK, refer to XAPP765: Getting Started with EDK and=20
MontaVista Linux (http://www.xilinx.com/bvdocs/appnotes/xapp765.pdf).

5. Patch the Linux kernel for use with the ML40x board
$ cd linux
$ ./patch_linux <path to the copy of the MontaVista Linux kernel>

This step copies the .config file from the linux directory to the Linux=20
kernel, patches the Linux kernel with necessary changes for the ML40x=20
board, and copies the Linux BSP into the Linux kernel.

Build the Linux kernel.
$ cd <path to the copy of the MontaVista Linux kernel>
$ make oldconfig dep bzImage

The resulting Linux kernel resides in arch/ppc/boot/images/zImage.elf

6. To build an ACE file consisting of the FPGA bitstream and the Linux=20
kernel, click Tools->Xygwin shell to run a shell, then type:
$ xmd =96tcl genace.tcl =96jprog =96hw implementation/download.bit =96elf=
 <Linux=20
elf file> -ace implementation/system.ace



mcnernbm@notes.udayton.edu wrote:

>
> Contained with in the reference design for the xilinx ml403 board is a=20
> patch for the montavista ml403 preview kit ot allow one to build the=20
> kernel for the ml403 board. But I am having trouble applying the=20
> patch. Does anyone know how to properly apply this patch. Also I tried=20
> to follow the instrucions on coping the bsp files over but exactly=20
> where to place them. Do I over write the folders with in the arch=20
> directory and the drivers folder in the main kernel directory? Its not=20
> 100% clear what files I need to over write.
> Any help would be greatly appreciated.
> Attached is the patch that come with the xilinx ml403 reference design
>
> Brett
>
>------------------------------------------------------------------------
>
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
