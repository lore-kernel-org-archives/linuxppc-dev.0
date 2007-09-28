Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CDE77DDDF7
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Sep 2007 19:51:19 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IbCVA-0008Hh-A0
	for linuxppc-embedded@ozlabs.org; Fri, 28 Sep 2007 02:51:16 -0700
Message-ID: <12937526.post@talk.nabble.com>
Date: Fri, 28 Sep 2007 02:51:16 -0700 (PDT)
From: Mirek23 <miroslaw.dach@psi.ch>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Flash paritioning and JFFS2
In-Reply-To: <1189180542.4826.33.camel@louie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <12293748.post@talk.nabble.com> <1187885337.5160.55.camel@louie>
	<12557406.post@talk.nabble.com> <1189180542.4826.33.camel@louie>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Dear All,

Finally I have sorted out few problems with linux and u-boot and I have
tried to come back to the jffs2 and mtd partitioning issue.

I am using CFI driver and I pass partitioning information from command line
via u-boot.

This part works fine:

Unfortunatly I have the problem when accesing the flash partitions because
my Avnet evaluation board is designet in such a way that the data should be
accessed in the mode x16 (16 bits in each goal).

Linux CFI driver is able to detect the x16 mode but it does not handle it
correctly.

I will give you an example:

My mtd1 partition contains the u-boot environment. When I print the mtd1
contents with (busybox) hexdump I get:

00000000  eb 92 00 00 62 6f 00 00  61 72 00 00 3d 63 00 00 
|....bo..ar..=c..|
00000010  73 6f 00 00 3d 74 00 00  55 4c 00 00 39 36 00 00 
|so..=t..UL..96..|
00000020  20 72 00 00 74 3d 00 00  65 76 00 00 66 73 00 00  |
r..t=..ev..fs..|
00000030  77 20 00 00 73 72 00 00  74 3d 00 00 39 2e 00 00  |w
..sr..t=..9...|
00000040  39 2e 00 00 34 2e 00 00  33 3a 00 00 70 74 00 00 
|9...4...3:..pt..|
00000050  6c 64 00 00 31 2f 00 00  63 5f 00 00 78 2c 00 00 
|ld..1/..c_..x,..|
00000060  70 20 00 00 70 3d 00 00  3a 3a 00 00 72 74 00 00  |p
..p=..::..rt..|
00000070  34 2d 00 00 72 65 00 00  65 74 00 00 3a 64 00 00 
|4-..re..et..:d..|

When I copy the contents of the /dev/mtd1 to the file by 2 bytes (bs=2) I
get correct
readout:

dd if=/dev/mtd1 of=./u-boot_Env.txt bs=2 count=128k

hexdump  ./u-boot_Env.txt
00000000  eb 92 c9 6d 62 6f 6f 74  61 72 67 73 3d 63 6f 6e 
|...mbootargs=con|
00000010  73 6f 6c 65 3d 74 74 79  55 4c 30 2c 39 36 30 30 
|sole=ttyUL0,9600|
00000020  20 72 6f 6f 74 3d 2f 64  65 76 2f 6e 66 73 20 72  | root=/dev/nfs
r|
00000030  77 20 6e 66 73 72 6f 6f  74 3d 31 32 39 2e 31 32  |w
nfsroot=129.12|
00000040  39 2e 31 34 34 2e 31 31  33 3a 2f 6f 70 74 2f 65 
|9.144.113:/opt/e|
00000050  6c 64 6b 34 31 2f 70 70  63 5f 34 78 78 2c 74 63 
|ldk41/ppc_4xx,tc|

The real problems begin when I want to deal with jffs2 file system.

I have mtd3 partition which is intended to hold jffs2 fs.
To create the jffs2 fs I do:

./mkfs.jffs2 --pad=0xA0000 --eraseblock=0x20000 --root=/tmp/bin/mtd1/work/
--output=image2.jffs2
flash_erase /dev/mtd3
dd if=./image2.jffs2 of=/dev/mtd3 bs=2 count=655360

After that I have jffs2 fs under /dev/mtd3.

When I try to mount the jffs2 partition fun begins:

mount -t jffs2 /dev/mtdblock3 /mnt

[ 2828.462121] jffs2_scan_eraseblock(): Node at 0x00000000 {0x1985, 0x2003,
0x00000000) has invalid CRC 0xf0600000 (calculated 0xf9d690b3)
[ 2828.610485] jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at
0x00000008: 0xf060 instead
[ 2828.719326] jffs2_scan_eraseblock(): Node at 0x0000000c {0x1985, 0xe001,
0x00000000) has invalid CRC 0xc3200000 (calculated 0x92fedd67)
[ 2828.870047] jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at
0x00000014: 0xc320 instead
[ 2828.979854] jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at
0x00000024: 0x46fc instead

.
.
.
.

[ 2834.858103] Further such events for this erase block will not be printed
[ 2835.029913] Cowardly refusing to erase blocks on filesystem with no valid
JFFS2 nodes
[ 2835.124378] empty_blocks 0, bad_blocks 0, c->nr_blocks 5
mount: mounting /dev/mtdblock3 on /mnt failed


I have examined carefully the above output and what I see is that linux does
not properly access the flash memory:

I did the hexdump on the image2.jffs2 (which is placed in /dev/mtd3) and
compared it with the jffs2 mount messages:

hexdump -C image2.jffs2

00000000  19 85 20 03 00 00 00 0c  f0 60 dc 98 19 85 e0 01  |..
......`......|
00000010  00 00 00 31 c3 20 dd 5d  00 00 00 01 00 00 00 00  |...1.
.]........|

jffs2_scan_eraseblock(): Node at 0x00000000 {0x1985, 0x2003, 0x00000000) has
invalid CRC 0xf0600000 (calculated 0xf9d690b3)

The linux mount complains about wrong CRC (invalid CRC 0xf0600000) but in
the memory it is
f0 60 dc 98 (so it means that it was read in byte by byte mode but not in
x16 (2 bytes)  mode).

Does somebody know how to fix this problem?

Best Regards

Mirek









-- 
View this message in context: http://www.nabble.com/Flash-paritioning-and-JFFS2-tf4317566.html#a12937526
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
