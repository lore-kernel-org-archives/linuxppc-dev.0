Message-ID: <3CFF8882.1E848DF8@sgi.com>
Date: Thu, 06 Jun 2002 11:06:26 -0500
From: Steven Hein <ssh@sgi.com>
MIME-Version: 1.0
To: Julien Eyries <julien.eyries@thales-bm.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [Fwd: Re: kernel command line for CRAMFS root filesystem]
References: <OEEHJMIIDJHHMFGGDNGDIEGLCOAA.fischi@epygi.de> <3CFF82BB.6080100@thales-bm.com>
Content-Type: multipart/mixed;
 boundary="------------7A3AC64A4479EFE0C5920697"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------7A3AC64A4479EFE0C5920697
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi Julien,

Attached is a patch to mkcramfs that adds a "-r" option.  This
reverses the endianness of the CRAMFS filesystem when creating it.
I use this patched mkcramfs to do exactly what you are doing.
It should apply to all kernels up to and including 2.4.18.

Steve


Julien Eyries wrote:
>
> > we use cramfs here and it works without additional parameter. How do you
> > generate the cramfs and on which kind of system are you using it? The
> > mkcramfs tool has an endianess problem so if you do mkcramfs on 86x platform
> > to use it on ppc it wont work. (maybe there is some newer version i am not
> > aware of where that is fixed)
>
> Well it seems it is the problem ... i have generated cramfs on my x86
> and my target is ppc .
> is there a simple trick to make my cramfs image correct for ppc ?
> should i build my cramfs image on the target ?
>
> thanks,
>
> Julien.
>

--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Steve Hein (ssh@sgi.com)              Engineering Diagnostics/Software
Silicon Graphics, Inc.
1168 Industrial Blvd.                 Phone: (715) 726-8410
Chippewa Falls, WI 54729              Fax:   (715) 726-6715
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--------------7A3AC64A4479EFE0C5920697
Content-Type: text/plain; charset=us-ascii;
 name="mkcramfs_endian.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mkcramfs_endian.patch"

--- linux-2.4.4/scripts/cramfs/mkcramfs.c.orig	Fri May  4 12:36:58 2001
+++ linux-2.4.4/scripts/cramfs/mkcramfs.c	Fri May  4 12:50:33 2001
@@ -52,6 +52,7 @@
 		" -p         pad by %d bytes for boot code\n"
 		" -s         sort directory entries (old option, ignored)\n"
 		" -z         make explicit holes (requires >= 2.3.39)\n"
+		" -r         reverse endian-ness of filesystem\n"
 		" dirname    root of the filesystem to be compressed\n"
 		" outfile    output file\n", progname, PAD_SIZE);

@@ -78,6 +79,7 @@
 static char *opt_image = NULL;

 static int warn_dev, warn_gid, warn_namelen, warn_skip, warn_size, warn_uid;
+static int swap_endian = 0;

 #ifndef MIN
 # define MIN(_a,_b) ((_a) < (_b) ? (_a) : (_b))
@@ -298,6 +300,50 @@
 	return totalsize;
 }

+/* routines to swap endianness/bitfields in inode/superblock block data */
+static void fix_inode(struct cramfs_inode *inode)
+{
+#define wswap(x)    (((x)>>24) | (((x)>>8)&0xff00) | (((x)&0xff00)<<8) | (((x)&0xff)<<24))
+	/* attempt #2 */
+	inode->mode = (inode->mode >> 8) | ((inode->mode&0xff)<<8);
+	inode->uid = (inode->uid >> 8) | ((inode->uid&0xff)<<8);
+	inode->size = (inode->size >> 16) | (inode->size&0xff00) |
+		((inode->size&0xff)<<16);
+	((u32*)inode)[2] = wswap(inode->offset | (inode->namelen<<26));
+}
+
+static void fix_offset(struct cramfs_inode *inode, u32 offset)
+{
+	u32 tmp = wswap(((u32*)inode)[2]);
+	((u32*)inode)[2] = wswap((offset >> 2) | (tmp&0xfc000000));
+}
+
+static void fix_block_pointer(u32 *p)
+{
+	*p = wswap(*p);
+}
+
+static void fix_super(struct cramfs_super *super)
+{
+	u32 *p = (u32*)super;
+
+	/* fix superblock fields */
+	p[0] = wswap(p[0]);	/* magic */
+	p[1] = wswap(p[1]);	/* size */
+	p[2] = wswap(p[2]);	/* flags */
+	p[3] = wswap(p[3]);	/* future */
+
+	/* fix filesystem info fields */
+	p = (u32*)&super->fsid;
+	p[0] = wswap(p[0]);	/* crc */
+	p[1] = wswap(p[1]);	/* edition */
+	p[2] = wswap(p[2]);	/* blocks */
+	p[3] = wswap(p[3]);	/* files */
+
+	fix_inode(&super->root);
+#undef wswap
+}
+
 /* Returns sizeof(struct cramfs_super), which includes the root inode. */
 static unsigned int write_superblock(struct entry *root, char *base, int size)
 {
@@ -333,6 +379,7 @@
 	super->root.gid = root->gid;
 	super->root.size = root->size;
 	super->root.offset = offset >> 2;
+	if (swap_endian) fix_super(super);

 	return offset;
 }
@@ -347,7 +394,10 @@
 		fprintf(stderr, "filesystem too big.  Exiting.\n");
 		exit(1);
 	}
-	inode->offset = (offset >> 2);
+	if (swap_endian)
+		fix_offset(inode, offset);
+	else
+		inode->offset = (offset >> 2);
 }


@@ -403,6 +453,7 @@
 				stack_entries++;
 			}
 			entry = entry->next;
+			if (swap_endian) fix_inode(inode);
 		}

 		/*
@@ -495,6 +546,7 @@
 		}

 		*(u32 *) (base + offset) = curr;
+		if (swap_endian) fix_block_pointer((u32*)(base + offset));
 		offset += 4;
 	} while (size);

@@ -595,7 +646,7 @@
 		progname = argv[0];

 	/* command line options */
-	while ((c = getopt(argc, argv, "hEe:i:n:psz")) != EOF) {
+	while ((c = getopt(argc, argv, "hEe:i:n:psrz")) != EOF) {
 		switch (c) {
 		case 'h':
 			usage(0);
@@ -625,6 +677,10 @@
 			break;
 		case 'z':
 			opt_holes = 1;
+			break;
+		case 'r':
+			swap_endian = 1;
+			printf("Swapping filesystem endian-ness\n");
 			break;
 		}
 	}

--------------7A3AC64A4479EFE0C5920697--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
