Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 03EDD679FC
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Aug 2006 04:29:34 +1000 (EST)
Date: Thu, 3 Aug 2006 13:02:19 -0500
From: Milton Miller <miltonm@bga.com>
To: dhlii@comcast.net, grant.likely@secretlab.ca, linuxppc-embedded@ozlabs.org,
Subject: Re: Booting Linux Kernel without bootloader
Message-Id: <31154628139507ed7ab4.783368690.miltonm@bga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu Aug  3 2006 11:49:24 AM CDT, David H. Lynch Jr. wrote:
>  Grant Likely wrote:
>  >
>  > I've got a similar situation on my Virtex-4 platform.  The FPGA takes
>  > care of all device initialization.  However, the kernel is loaded of a
>  > CF card via a *slow* JTAG interface.  Loading an uncompressed image is
>  > more time consuming than loading a compressed image and uncompressing
>  > it in software.
>  >
>   
>      I am working with the Pico E-12. It is a CF formfactor device. It
>  has only a pseudo Parallel/Jtag
>      interface exported through the >  CF connector Pico calls the Keyhole
>  Port, and A UartLite, and TEMAC off some mini connector.
>      Pico has their own "monitor" program that fits in 32K of ram inside
>  the FPGA that loads and executes ELF files (or FPGA bit images)
>      from a very simple FileSystem (basically a linked list). Then they
>  have Host software to Read/Write the Flash, update files in Flash, ...
>      that works primarily through the Keyhole.
>  
>      I just build the Kernel as an ELF file, update the ELF File in Flash
>  and tell it to boot that file and away it goes.


The kernel requires some data be passed to it via both memory (the
device tree struct) and registers (pointer to same and a bit), or registers
set and a client interface.  You don't want the later.  See
Documentation/powerpc/booting-without-of.txt. 

If loading from the filesystem is faster than decompressing and copying
the image to place, and the loader supports multiple load segments, 
defined entry points, and loading to address 0, then you could construct 
an elf that is the kernel load segment, the device tree, and an entry point 
that sets the few registers and jumps to the kernel.  Generating such an 
image would still belong to the boot directory.

A zImage based compressed image may still be faster.

milton
