Return-Path: <bounces@nabble.com>
Received: from talk.nabble.com (www.nabble.com [72.21.53.35])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B36B9DDEC3
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 26 Feb 2007 14:04:29 +1100 (EST)
Received: from [72.21.53.38] (helo=jubjub.nabble.com)
	by talk.nabble.com with esmtp (Exim 4.50) id 1HLWA1-0000aT-Dq
	for linuxppc-embedded@ozlabs.org; Sun, 25 Feb 2007 19:04:21 -0800
Message-ID: <9152845.post@talk.nabble.com>
Date: Sun, 25 Feb 2007 19:04:21 -0800 (PST)
From: Nethra <nethra_gmit@yahoo.co.in>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] jffs2 file system
In-Reply-To: <20070224221549.11984.qmail@web304.biz.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <9097247.post@talk.nabble.com>
	<1172144688.2759.0.camel@vader.jdub.homelinux.org>
	<9132046.post@talk.nabble.com>
	<20070224221549.11984.qmail@web304.biz.mail.mud.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


This is the output of flinfo in u-boot

=> flinfo

Bank # 1: Sharp 28F016SC (16 Mbit, 32 x 64K)
  Size: 8 MB in 32 Sectors
  Sector Start Addresses:
    FF800000      FF840000      FF880000      FF8C0000      FF900000
    FF940000      FF980000      FF9C0000      FFA00000      FFA40000
    FFA80000      FFAC0000      FFB00000      FFB40000      FFB80000
    FFBC0000      FFC00000      FFC40000      FFC80000      FFCC0000
    FFD00000      FFD40000      FFD80000      FFDC0000      FFE00000
    FFE40000      FFE80000      FFEC0000      FFF00000 (RO) FFF40000 (RO)
    FFF80000      FFFC0000
=>

nethra

> steps fallowed are..
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
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded



-- 
View this message in context: http://www.nabble.com/jffs2-file-system-tf3271928.html#a9152845
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
