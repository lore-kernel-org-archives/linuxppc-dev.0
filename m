Return-Path: <bwarren@qstreams.com>
Received: from web304.biz.mail.mud.yahoo.com (web304.biz.mail.mud.yahoo.com
	[68.142.199.180]) by ozlabs.org (Postfix) with SMTP id F2C39DDED8
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 25 Feb 2007 09:15:50 +1100 (EST)
Message-ID: <20070224221549.11984.qmail@web304.biz.mail.mud.yahoo.com>
Date: Sat, 24 Feb 2007 14:15:49 -0800 (PST)
From: Ben Warren <bwarren@qstreams.com>
Subject: Re: [PATCH] jffs2 file system
To: Nethra <nethra_gmit@yahoo.co.in>, linuxppc-embedded@ozlabs.org
In-Reply-To: <9132046.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--- Nethra <nethra_gmit@yahoo.co.in> wrote:

> steps falloed are..
> 
> 1. erase FF800000 FFDFFFFF
> 2. tftpboot 0x100000 image.jffs2 
> 3. cp.b 100000 FF800000 4dc874
> 

This looks OK, assuming the size of the file was
4dc874...  Can you send the output of 'flinfo',
please?

<snip>
> physmap flash device: 800000 at ff800000
> RedBoot partition parsing not available
> Using physmap partition definition
> Creating 4 MTD partitions on "phys_mapped_flash":
> 0x00000000-0x00600000 : "User FS"
> mtd: Giving out device 0 to User FS
> ftl_cs: FTL header not found.
> 0x00600000-0x00700000 : "uImage"
> mtd: Giving out device 1 to uImage
> ftl_cs: FTL header not found.
> 0x00700000-0x00740000 : "bootloader"
> mtd: Giving out device 2 to bootloader
> ftl_cs: FTL header not found.
> 0x00740000-0x00780000 : "bootloader env"
> mtd: Giving out device 3 to bootloader env
> ftl_cs: FTL header not found.

I'm pretty sure FTL is for NAND flash.  You should
probably take it out of the kernel and try again.

> jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
> found at 0x00000000:
> 0xffff in
> ....
> jffs2_scan_eraseblock(): Magic bitmask 0x1985 not
> found at 0x005c0004:
> 0xffff in 
> 
The fact that it's reading 0xffff makes it look to me
that the flash is still erased.  After you copy the
JFFS2 image into flash in U-boot, look at its contents
using 'md' and compare to your image file (using od -x
on your host, for example)

e.g.: u-boot> md.b ff800000

Here are the first few lines of a JFFS2 image that I
know works:

linux$ od -x jffs2.img | less
0000000 8519 0320 0000 0c00 60f0 98dc 8519 01e0
0000020 0000 2b00 423e 2724 0000 0100 0000 0000
0000040 0000 0200 d345 aa6e 0403 0000 9948 4dea
0000060 6655 ff83 6962 ff6e 8519 02e0 0000 4400
0000100 efa4 3e22 0000 0200 0000 0100 0000 ed41

Note that the first word is 0x8519, which is the
big-endian representation of 0x1985.

Have you tried booting to an NFS file system and then
mounting your JFFS2 device?  Are you sure you know the
correct flash geometry and are using the correct block
size when using mkfs.jffs2?  Is it possible that your
device is bottom-boot (i.e. has a bunch of smaller
sectors @ 0xff800000?


regards,
Ben
