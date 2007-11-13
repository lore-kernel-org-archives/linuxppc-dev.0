Return-Path: <alan@nishioka.com>
Received: from elasmtp-junco.atl.sa.earthlink.net
	(elasmtp-junco.atl.sa.earthlink.net [209.86.89.63])
	by ozlabs.org (Postfix) with ESMTP id BD2D6DDDE9
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Nov 2007 05:48:18 +1100 (EST)
Received: from [68.122.118.126] (helo=[192.168.1.64])
	by elasmtp-junco.atl.sa.earthlink.net with asmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34) id 1Is0Y0-0008Ns-DS
	for linuxppc-embedded@ozlabs.org; Tue, 13 Nov 2007 13:31:41 -0500
Message-ID: <4739ED7D.5060001@nishioka.com>
Date: Tue, 13 Nov 2007 10:31:25 -0800
From: Alan Nishioka <alan@nishioka.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: inflate returned FFFFFFFB
Content-Type: multipart/mixed; boundary="------------040101050409040601030601"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------040101050409040601030601
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

After adding files to initramfs, I get the following error:
Uncompressing Linux...inflate returned FFFFFFFB

This is caused by zlib_inflate returning -5 or Z_BUF_ERROR.

The attached patch fixes this problem for me.
It is also available at
http://www.nishioka.com/misc/ppc-gunzip.patch

It probably also fixes the problem at
http://ozlabs.org/pipermail/linuxppc-embedded/2006-August/023851.html
and only 15 months too late.

It moves the link/load address higher in memory and tells gunzip it has 
more space to uncompress.
You need to change the address in .config

make menuconfig
Advanced setup -->
[*] Prompt for advanced configuration options
[*]   Set the boot link/load address
(0x00800000) Link/load address for booting

This is my first post to this list.
Please tell me if I am missing anything.

Alan Nishioka
alan@nishioka.com


--------------040101050409040601030601
Content-Type: text/plain;
 name="ppc-gunzip.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ppc-gunzip.patch"

diff -ur linux-2.6.23.1-orig/arch/ppc/boot/simple/misc-embedded.c linux-2.6.23.1/arch/ppc/boot/simple/misc-embedded.c
--- linux-2.6.23.1-orig/arch/ppc/boot/simple/misc-embedded.c	2007-10-12 12:43:44.000000000 -0400
+++ linux-2.6.23.1/arch/ppc/boot/simple/misc-embedded.c	2007-11-08 12:06:12.000000000 -0500
@@ -212,7 +212,7 @@
 	*cp = 0;
 	puts("\nUncompressing Linux...");
 
-	gunzip(0, 0x400000, zimage_start, &zimage_size);
+	gunzip(0, CONFIG_BOOT_LOAD, zimage_start, &zimage_size);
 	flush_instruction_cache();
 	puts("done.\n");
 	{
diff -ur linux-2.6.23.1-orig/arch/ppc/boot/simple/misc.c linux-2.6.23.1/arch/ppc/boot/simple/misc.c
--- linux-2.6.23.1-orig/arch/ppc/boot/simple/misc.c	2007-10-12 12:43:44.000000000 -0400
+++ linux-2.6.23.1/arch/ppc/boot/simple/misc.c	2007-11-08 13:08:34.000000000 -0500
@@ -216,7 +216,7 @@
 	puts("\n");
 
 	puts("Uncompressing Linux...");
-	gunzip(NULL, 0x400000, zimage_start, &zimage_size);
+	gunzip(NULL, CONFIG_BOOT_LOAD, zimage_start, &zimage_size);
 	puts("done.\n");
 
 	/* get the bi_rec address */

--------------040101050409040601030601--
