Return-Path: <peter.ryser@xilinx.com>
Received: from outbound2-res-R.bigfish.com (outbound-res.frontbridge.com
	[63.161.60.49])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 3E2EC68A02
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 31 Jan 2006 17:00:05 +1100 (EST)
Message-ID: <43DEFCB2.7000904@xilinx.com>
Date: Mon, 30 Jan 2006 21:59:14 -0800
From: Peter Ryser <peter.ryser@xilinx.com>
MIME-Version: 1.0
To: David Summers <embeddedxilinx@gmail.com>
Subject: Re: Getting started with Xilinx V4 PPC?
References: <e4619cf30601301111u269d7842j42a8ef88623cfdf8@mail.gmail.com>
In-Reply-To: <e4619cf30601301111u269d7842j42a8ef88623cfdf8@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi David,

you might want to have a look at the following documents beside the ones you mention in your email:
- XAPP765 (http://www.xilinx.com/bvdocs/appnotes/xapp765.pdf). This document describes on how to get started with EDK and the ML300 board. The approach for the ML403 board is the same as is for the Avnet board.
- UG080, pg. 37 (http://www.xilinx.com/bvdocs/userguides/ug082.pdf). This document contains a brief description on how to rebuild the Linux kernel for the ML403 board.

Start with rebuilding the reference design and Linux kernel for the ML403/Avnet board. All the necessary information can be found in the documents above and on  
http://www.xilinx.com/products/boards/ml403/reference_designs.htm (for the ML403 board)

At this time I recommend staying with the 2.4 Linux kernel as the support for ML300 (and the ML403 and the Avnet board) in the 2.6 kernel is very basic (UART only).

Since you only need Ethernet once the "project" returns from its flight you might want to consider to develop two hardware designs. The first one does not have Ethernet and is for the flight. The second one contains Ethernet but not some of the additional control logic and is for retrieving the data upon return. This might get you into a smaller device and I assume that size matters.

- Peter


David Summers wrote:

>I am starting a new project where I need to have a flash file system
>and an ethenet interface (HTTP and FTP).  The project is a solar
>physics experiment that will be launched on a sub-orbital rocket
>flight this fall.  The idea is that the experiment will write data
>files to the flash file system while in flight, and then I can
>download the data using ethernet after the experiment returns to
>earth.
>
>I think that Linux is the way to go for this project because of the
>JFFS2 filesystem and the strong networking support.  The only problem
>is that I am totally new to embedded linux.
>
>I am prototyping my system on an Avnet FX12 development board ( Specs
>here: http://tinyurl.com/4gfdv ) which is pretty similar to the Xilinx
>ML403 board except with less memory and no SystemACE slot.
>
>I will eventually build my own custom board with the same Xilinx
>Virtex 4 FX12 FPGA and additional flash memory and some custom
>interface hardware. My background is primarily as a hardware designer,
>and I am very confortable with the FPGA part of this project.   I am
>comfortable as a Linux user, and I am a pretty good C coder (for a
>hardware guy anyway :).  I have never built a linux system (embedded
>or desktop) before, and I need some help getting started with embedded
>linux.
>
>I have already found the following websites which have been a big help so far:
>
>http://www.klingauf.de/v2p/index.phtml
>http://splish.ee.byu.edu/projects/LinuxFPGA/configuring.htm
>http://www.crhc.uiuc.edu/IMPACT/gsrc/hardwarelab/docs/kernel-HOWTO.html#toc1
>
>I have a few questions that I hope someone can help me with:
>
>1. What is the best linux distribution to start out with?  I am
>currently working with the 2.4 kernel code from
>ppc.bkbits.net/linuxppc_2_4_devel, but I'm not sure that this version
>be being updated.  (MontaVista also seems to be making it rather
>difficult to download their free Linux Preview Kit, so I wouldn't mind
>finding another distribution)    Does the DENX distribution have good
>PPC support?  Are there any others that I should look at, or should I
>just download the kernel source directly from kernel.org?
>
>
>2. kernel 2.4 or 2.6?
>
>It is my understanding that the latest version of MTD and JFFS2 have
>dropped support for kernel 2.4.  I would like to use JFFS2 on a NAND
>flash device, so it seems like I should use 2.6.  (Can I use JFFS2 on
>a NAND device with kernel v 2.4?)
>
>Being a complete newbie, am I biting off more that I can handle by
>trying to use 2.6?
>
>I have been lurking on the mailing list for a while, and I know that
>there are several people working on 2.6.x patches for the Xilinx
>virtex 4 parts.  Could someone point me to a list of the patches that
>I need to get me started?  I think that the ML403 patches should work
>with my board, but I don't know which ones I need to download.
>
>
>Thank you for your help,
>
>David Summers
>University of Colorado
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>
>  
>
