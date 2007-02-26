Return-Path: <bounces@nabble.com>
Received: from talk.nabble.com (www.nabble.com [72.21.53.35])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CC24DDDECE
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 26 Feb 2007 20:14:28 +1100 (EST)
Received: from [72.21.53.38] (helo=jubjub.nabble.com)
	by talk.nabble.com with esmtp (Exim 4.50) id 1HLbvw-0008Ra-P3
	for linuxppc-embedded@ozlabs.org; Mon, 26 Feb 2007 01:14:12 -0800
Message-ID: <9155572.post@talk.nabble.com>
Date: Mon, 26 Feb 2007 01:14:12 -0800 (PST)
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



yes, i tried mounting jffs2 rootfile system after nfs mounting.
fallowing are steps i fallowed......
 
root@cashel:~# cat /proc/mtd
dev:    size   erasesize  name
mtd0: 00600000 00020000 "User FS"
mtd1: 00100000 00020000 "uImage"
mtd2: 00040000 00020000 "bootloader"
mtd3: 00040000 00020000 "bootloader env"

root@cashel:~# cd /dev
root@cashel:/dev# cd mtd
mtd0       mtd1       mtd2       mtd3       mtdblock0  mtdblock2
mtd0ro     mtd1ro     mtd2ro     mtd3ro     mtdblock1  mtdblock3

root@cashel:~# flash_erase /dev/mtd0
Erase Total 1 Units

root@cashel:~# cp -rf ../jffs2.img /dev/mtd0

root@cashel:~# mount -t jffs2 /dev/mtdblock0 /mnt
ffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00580020: 0xffff
in
stead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00580024:
0xffff in
stead
Further such events for this erase block will not be printed
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x005a0000:
0xffff in
stead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x005a0004:
0xffff in
stead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x005a0008:
0xffff in
stead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x005a000c:
0xffff in
stead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x005a0010:
0xffff in
stead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x005a0014:
0xffff in
stead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x005a0018:
0xffff in
stead
Further such events for this erase block will not be printed
Cowardly refusing to erase blocks on filesystem with no valid JFFS2 nodes
empty_blocks 0, bad_blocks 0, c->nr_blocks 48
mount: /dev/mtdblock0: can't read superblock
root@cashel:~#

The attached .bmp gives comparision of jffs2.img with od and md commands...

Nethra


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
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded


http://www.nabble.com/file/6779/md_od.bmp md_od.bmp 
-- 
View this message in context: http://www.nabble.com/jffs2-file-system-tf3271928.html#a9155572
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
