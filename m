Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3D185263.DBFE0AE1@sgi.com>
Date: Tue, 25 Jun 2002 06:22:12 -0500
From: Steven Hein <ssh@sgi.com>
MIME-Version: 1.0
To: David Blythe <blythe@broadon.com>
Cc: steve.cameron@hp.com,
	linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: cramfs for root filesystem?
References: <20020624161952.A28796@zuul.cca.cpqcorp.net> <3D17BF93.3060207@broadon.com>
Content-Type: multipart/mixed;
 boundary="------------61AFDE7AF8E585B4DFF9828C"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------61AFDE7AF8E585B4DFF9828C
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi Stephen,

I have actually been using a cramfs initrd reliably for about 2
years.  You do need a kernel patch to add cramfs to the list of
filesystems to check for in the initrd, also my patch forces the
blocksize of the initrd to 4K if it finds that it contains cramfs.
(I unfortunately don't have a publicly accessible web page to
stick this patch, so I'll attach it at the end of this email).

I have also previously posted a patch to mkcramfs to swap
endianness on a cramfs filesystem   (this is also what I do,
create a PPC big endian cramfs using a little endian Intel PC).
I have posted this a couple of times, here's a link to the
most recent:

    http://lists.linuxppc.org/linuxppc-embedded/200206/msg00128.html

These two patches should get you going with a cramfs initrd.
Good luck!

Steve



David Blythe wrote:
>
> It looks like you still have an initrd.  Don't try running cramfs as an
> initrd. I don't know if anything has changed in later versions of 2.4
> but earlier ones used a 1k blocks size for the ramdisk and even if you
> tried changing the rd blocksize to 4k to match cramfs it still didn't
> work properly ...
>
> There were patches floating around for building a big-endian cramfs,
> rather than fixing the cramfs implemention to convert to little endian.
>     I don't know if newer versions of cramfs support explicit little
> endian rather than native endian.  I can send you a version of mkcramfs
> with the swap endian flag if you want.
>
> I'm in the process of getting ramfs to work with cramfs on my system as
> we speak.
>         david
>


--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Steve Hein (ssh@sgi.com)              Engineering Diagnostics/Software
Silicon Graphics, Inc.
1168 Industrial Blvd.                 Phone: (715) 726-8410
Chippewa Falls, WI 54729              Fax:   (715) 726-6715
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--------------61AFDE7AF8E585B4DFF9828C
Content-Type: text/plain; charset=us-ascii;
 name="cramfs_initrd.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cramfs_initrd.patch"

diff -uNr linux/drivers/block/rd.c linux-2.4.4/drivers/block/rd.c
--- linux/drivers/block/rd.c	Fri Feb  9 13:30:22 2001
+++ linux-2.4.4/drivers/block/rd.c	Mon May  7 14:04:15 2001
@@ -47,6 +47,7 @@
 #include <linux/minix_fs.h>
 #include <linux/ext2_fs.h>
 #include <linux/romfs_fs.h>
+#include <linux/cramfs_fs.h>
 #include <linux/fs.h>
 #include <linux/kernel.h>
 #include <linux/hdreg.h>
@@ -469,10 +470,11 @@
 int __init
 identify_ramdisk_image(kdev_t device, struct file *fp, int start_block)
 {
-	const int size = 512;
+	const int size = 1024;
 	struct minix_super_block *minixsb;
 	struct ext2_super_block *ext2sb;
 	struct romfs_super_block *romfsb;
+	struct cramfs_super *cramfsb, *cramfsb2;
 	int nblocks = -1;
 	unsigned char *buf;

@@ -483,6 +485,8 @@
 	minixsb = (struct minix_super_block *) buf;
 	ext2sb = (struct ext2_super_block *) buf;
 	romfsb = (struct romfs_super_block *) buf;
+	cramfsb = (struct cramfs_super *) buf;
+	cramfsb2 = (struct cramfs_super *) (&buf[512]);
 	memset(buf, 0xe5, size);

 	/*
@@ -515,6 +519,41 @@
 		goto done;
 	}

+	/* cramfs also at block zero */
+	/* (superblock can also live at 512-byte offset in block zero) */
+	if ((cramfsb->magic == CRAMFS_MAGIC &&
+		memcmp(cramfsb->signature, CRAMFS_SIGNATURE,
+                                       sizeof(cramfsb->signature)) == 0) ||
+	    ((cramfsb = cramfsb2)  &&  cramfsb2->magic == CRAMFS_MAGIC &&
+		memcmp(cramfsb2->signature, CRAMFS_SIGNATURE,
+                                       sizeof(cramfsb2->signature)) == 0)) {
+
+		printk(KERN_NOTICE
+		       "RAMDISK: cramfs filesystem found at block %d\n",
+		       start_block);
+
+		/* cramfs probably has a different blocksize--adjust the
+		   ramdisk's block size to accomodate */
+		/* FIXME: should have a way to determine the cramfs
+		          blocksize (if it's going to be variable.....) */
+		if (rd_blocksize != PAGE_CACHE_SIZE) {
+			int i;
+
+			rd_blocksize = PAGE_CACHE_SIZE;
+			for (i = 0; i < NUM_RAMDISKS; i++) {
+				rd_hardsec[i] = rd_blocksize;
+				rd_blocksizes[i] = rd_blocksize;
+			}
+			printk(KERN_NOTICE
+				"RAMDISK: overriding ramdisk block size to %d for cramfs filesystem\n",
+				rd_blocksize);
+		}
+		/* Note: even if ramdisk blocksize is changed, nblocks is still
+                   calculated using 1k blocksize for the INITRD device */
+		nblocks = (cramfsb->size+BLOCK_SIZE-1)>>BLOCK_SIZE_BITS;
+		goto done;
+	}
+
 	/*
 	 * Read block 1 to test for minix and ext2 superblock
 	 */

--------------61AFDE7AF8E585B4DFF9828C--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
