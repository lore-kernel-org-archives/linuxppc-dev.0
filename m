Return-Path: <jrocnuck@hotmail.com>
Received: from bay0-omc3-s1.bay0.hotmail.com (bay0-omc3-s1.bay0.hotmail.com
	[65.54.246.201]) by ozlabs.org (Postfix) with ESMTP id 056E2DDE37
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Mar 2007 06:04:58 +1100 (EST)
Message-ID: <BAY117-F2369837F5EDAB8813B2421C8810@phx.gbl>
In-Reply-To: <3C02138692C13C4BB675FE7EA24095292E0871@bluefin.Soneticom.local>
From: "Eric Nuckols" <jrocnuck@hotmail.com>
To: cthomas@Soneticom.com, linuxppc-embedded@ozlabs.org
Subject: RE: MTD and U-boot
Date: Wed, 28 Feb 2007 14:04:52 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>




>From: "Clint Thomas" <cthomas@Soneticom.com>
>To: <linuxppc-embedded@ozlabs.org>
>Subject: MTD and U-boot
>Date: Wed, 28 Feb 2007 13:41:36 -0500
>
>Hey,
>
>I want to be able to write/read from the same boot flash U-boot resides
>on. Right now, u-boot and the vmlinux.img reside on the same 16bit NAND
>flash. Is it possible to setup the flash so that from linux, I can erase
>and write an updated vmlinux.img when I want to update a kernel build on
>the system, without partitioning off a section of it away from U-boot?
>
>Clinton Thomas
>

Not sure if this is exactly what I think it is, but I asked a similar 
question to this a couple weeks ago and didn't get any response.  So I will 
tell you what I found out (for my case only).

We have a PPC Bug boot image in our flash and we have partitioned off 5 
areas in the kernel mtd_physmap, one of which is used to store the 
compressed kernel image file and root disk all in one (PPC bugboot image 
file)

I wrote some code to extract the entire contents of the "kernel" partition 
and save off the binary to a file.  Then I figured out how my actual flashed 
kernel image matched up with the offsets into that partition, and from that 
was able to determine how to change the kernel image in flash to my new 
image from a currently booted and running kernel.  I was using the MTD flash 
device drivers and basically did something in userspace code like:

fd = open("/dev/mtd/1")
read from fd X bytes and store in file where X is size of kernel partition

use hex editor to compare real file image to contents of flash dumped file 
and determine offset into flash for start of actual bugboot image. (this 
works for us, because we only have a kernel image in that flash space and 
nothing else)


so in the update/reprogram software it goes something like:

eraseall /dev/mtd/1
fd = open("my new image file")
fd2 = open("/dev/mtd/1")

seek up to correct offset on fd2 (or just write zeros until the proper 
offset is reached)

loop over fd:
   read data from fd
   write bytes into fd2


that's it.. then reboot and bingo... new kernel image is running...

_________________________________________________________________
Don’t miss your chance to WIN 10 hours of private jet travel from Microsoft® 
Office Live http://clk.atdmt.com/MRT/go/mcrssaub0540002499mrt/direct/01/
