Date: Tue, 25 Jun 2002 11:04:21 -0500
From: Stephen Cameron <steve.cameron@hp.com>
To: ssh@sgi.com, blythe@broadon.com,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: cramfs for root filesystem?
Message-ID: <20020625110421.A6712@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have tried to fix up the endian-swapping patch for
the mkcramfs from sourceforge CVS, circa Mon Jun 24, 2002
:pserver:anonymous@cvs.cramfs.sourceforge.net:/cvsroot/cramfs

No guarantees, of course, use at your own risk.

Currently, I get as far as trying to start init with this
patch, (the same filesystem via NFS works fine.)  This
may be due to the fact that I haven't touched the kernel
code, (that is, I have not allowed for ramdisk to handle
4k block size, as I've been led to believe I must.)

Here's what I'm seeing when I try to use my rootfs
(not that it's necessarily relevant, but I don't
want to imply that I know my patch is perfect):

	RAMDISK: Compressed image found at block 0
	Freeing initrd memory: 1270k freed
	VFS: Mounted root (cramfs filesystem) readonly.
	Freeing unused kernel memory: 196k init
	Warning: unable to open an initial console.
	Kernel panic: No init found.  Try passing init= option to kernel.
	<0>Rebooting in 180 seconds..

-- steve

And here's the patch:

diff -u -r1.1.1.1 mkcramfs.c
--- mkcramfs.c	24 Jun 2002 19:22:19 -0000	1.1.1.1
+++ mkcramfs.c	25 Jun 2002 15:56:42 -0000
@@ -95,6 +95,7 @@
 static char *opt_name = NULL;

 static int warn_dev, warn_gid, warn_namelen, warn_skip, warn_size, warn_uid;
+static int swap_endian = 0;

 /* In-core version of inode / directory entry. */
 struct entry {
@@ -130,6 +131,7 @@
 		" -i file    insert a file image into the filesystem (requires >= 2.4.0)\n"
 		" -n name    set name of cramfs filesystem\n"
 		" -p         pad by %d bytes for boot code\n"
+		" -r         reverse endianness of filesystem\n"
 		" -s         sort directory entries (old option, ignored)\n"
 		" -v         be more verbose\n"
 		" -z         make explicit holes (requires >= 2.3.39)\n"
@@ -372,6 +374,58 @@
 	return totalsize;
 }

+#define wswap(x)	(((x)>>24) | (((x)>>8)&0xff00) | \
+			(((x)&0xff00)<<8) | (((x)&0xff)<<24))
+
+/* routines to swap endianness/bitfields in inode/superblock block data */
+static void fix_inode(struct cramfs_inode *inode)
+{
+	if (!swap_endian) return;
+	inode->mode = (inode->mode >> 8) | ((inode->mode&0xff)<<8);
+	inode->uid = (inode->uid >> 8) | ((inode->uid&0xff)<<8);
+	inode->size = (inode->size >> 16) | (inode->size&0xff00) |
+			((inode->size&0xff)<<16);
+	((u32*)inode)[2] = wswap(inode->offset | (inode->namelen<<26));
+}
+
+static void fix_offset(struct cramfs_inode *inode, u32 offset)
+{
+	u32 tmp;
+	if (!swap_endian) return;
+	tmp = wswap(((u32*)inode)[2]);
+	((u32*)inode)[2] = wswap((offset >> 2) | (tmp&0xfc000000));
+}
+
+static void fix_block_pointer(u32 *p)
+{
+	if (!swap_endian) return;
+	*p = wswap(*p);
+}
+
+static void fix_super(struct cramfs_super *super)
+{
+	u32 *p = (u32*)super;
+
+	if (!swap_endian) return;
+
+	/* fix superblock fields */
+	p[0] = wswap(p[0]); /* magic */
+	p[1] = wswap(p[1]); /* size */
+	p[2] = wswap(p[2]); /* flags */
+	p[3] = wswap(p[3]); /* future */
+
+	/* fix filesystem info fields */
+	p = (u32*)&super->fsid;
+	p[0] = wswap(p[0]); /* crc */
+	p[1] = wswap(p[1]); /* edition */
+	p[2] = wswap(p[2]); /* blocks */
+	p[3] = wswap(p[3]); /* files */
+
+	fix_inode(&super->root);
+}
+
+#undef wswap
+
 /* Returns sizeof(struct cramfs_super), which includes the root inode. */
 static unsigned int write_superblock(struct entry *root, char *base, int size)
 {
@@ -405,7 +459,9 @@
 	super->root.uid = CRAMFS_16(root->uid);
 	super->root.gid = root->gid;
 	super->root.size = CRAMFS_24(root->size);
+	fix_super(super);
 	CRAMFS_SET_OFFSET(&(super->root), offset >> 2);
+	fix_offset(&(super->root), offset);

 	return offset;
 }
@@ -421,6 +477,7 @@
 		die(MKFS_ERROR, 0, "filesystem too big");
 	}
 	CRAMFS_SET_OFFSET(inode, offset >> 2);
+	fix_offset(inode, offset);
 }

 /*
@@ -610,6 +667,7 @@
 		}

 		*(u32 *) (base + offset) = CRAMFS_32(curr);
+		fix_block_pointer((u32*)(base + offset));
 		offset += 4;
 	} while (size);

@@ -700,7 +758,7 @@
 		progname = argv[0];

 	/* command line options */
-	while ((c = getopt(argc, argv, "hEe:i:n:psvz")) != EOF) {
+	while ((c = getopt(argc, argv, "hEe:i:n:prsvz")) != EOF) {
 		switch (c) {
 		case 'h':
 			usage(MKFS_OK);
@@ -727,6 +785,10 @@
 		case 'p':
 			opt_pad = PAD_SIZE;
 			fslen_ub += PAD_SIZE;
+			break;
+		case 'r':
+			swap_endian = 1;
+			fprintf(stderr, "Swapping filesystem endianness.\n");
 			break;
 		case 's':
 			/* old option, ignored */

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
