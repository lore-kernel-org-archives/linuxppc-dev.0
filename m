Message-ID: <3AF09E93.80A5B92B@routefree.com>
Date: Wed, 02 May 2001 16:56:03 -0700
From: David Blythe <blythe@routefree.com>
MIME-Version: 1.0
To: Steven Hein <ssh@sgi.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: mkcramfs changes to switch endianness
References: <3AF07046.3827B997@sgi.com>
Content-Type: multipart/mixed;
 boundary="------------B23253D3584DAF58A2AB7B8D"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------B23253D3584DAF58A2AB7B8D
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Steven Hein wrote:
>
> I'm getting ready to try using cramfs in the 2.4.4 kernel.
> Anybody done the work to make 'mkcramfs' create a big-endian
> image on a little-endian PC?   Before I reinvent the wheel,
> I'd like to find out if anybody as done it (and would like
> to share   :)

I have the changes for the pre-midori mkcramfs.  works fine but it
is very ugly because of the use of bit fields.  Have been running it for
a few months and it does work fine :)  We are in the process of
integrating the latest changes from transmeta, but here is the patch for
the old version.

>
> Steve
>
--------------B23253D3584DAF58A2AB7B8D
Content-Type: text/plain; charset=us-ascii;
 name="mkcramfs.patch"
Content-Disposition: inline;
 filename="mkcramfs.patch"
Content-Transfer-Encoding: 7bit

diff -u -r1.1 -r1.2
--- scripts/cramfs/mkcramfs.c	2000/07/28 19:02:52	1.1
+++ scripts/cramfs/mkcramfs.c	2001/03/09 19:55:28	1.2
@@ -25,7 +25,7 @@

 static void usage(void)
 {
-	fprintf(stderr, "Usage: '%s dirname outfile'\n"
+	fprintf(stderr, "Usage: '%s [-e] dirname outfile'\n"
 		" where <dirname> is the root of the\n"
 		" filesystem to be compressed.\n", progname);
 	exit(1);
@@ -46,6 +46,7 @@
 static unsigned int blksize = PAGE_CACHE_SIZE;

 static int warn_dev, warn_gid, warn_namelen, warn_size, warn_uid;
+static int swap_endian;

 #ifndef MIN
 # define MIN(_a,_b) ((_a) < (_b) ? (_a) : (_b))
@@ -273,6 +274,39 @@
 	memset(area, 0x00, size);
 }

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
+	p[0] = wswap(p[0]);	/* magic */
+	p[1] = wswap(p[1]);	/* size */
+	p[2] = wswap(p[2]);	/* flags */
+	p[3] = wswap(p[3]);	/* future */
+	fix_inode(&super->root);
+#undef wswap
+}
+
 /* Returns sizeof(struct cramfs_super), which includes the root inode. */
 static unsigned int write_superblock(struct entry *root, char *base)
 {
@@ -293,6 +327,7 @@
 	super->root.gid = root->gid;
 	super->root.size = root->size;
 	super->root.offset = offset >> 2;
+	if (swap_endian) fix_super(super);

 	return offset;
 }
@@ -305,7 +340,10 @@
 		fprintf(stderr, "filesystem too big.  Exiting.\n");
 		exit(1);
 	}
-	inode->offset = (offset >> 2);
+	if (swap_endian)
+		fix_offset(inode, offset);
+	else
+		inode->offset = (offset >> 2);
 }


@@ -360,6 +398,7 @@
 				stack_entries++;
 			}
 			entry = entry->next;
+			if (swap_endian) fix_inode(inode);
 		}

 		/*
@@ -452,6 +491,7 @@
 		}

 		*(u32 *) (base + offset) = curr;
+		if (swap_endian) fix_block_pointer((u32*)(base + offset));
 		offset += 4;
 	} while (size);

@@ -529,6 +569,18 @@

 	if (argc)
 		progname = argv[0];
+	while(argc > 1 && argv[1][0] == '-') {
+		switch(argv[1][1]) {
+		case 'e':
+			swap_endian = 1;
+			break;
+		default:
+			usage();
+			break;
+		}
+		argv++; argc--;
+	}
+
 	if (argc != 3)
 		usage();


--------------B23253D3584DAF58A2AB7B8D--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
