From: Oliver.Neukum@lrz.uni-muenchen.de
Date: Thu, 13 May 1999 23:58:46 +0200 (MET DST)
To: linuxppc-dev@lists.linuxppc.org
Subject: preliminary patch for littleendian minixfs on bigendian system
Message-Id: <Pine.GSO.4.03.9905132354010.27966-100000@sun4.lrz-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

here i have the first, preliminary version of a patch that allows
the use of non-native minixfs. I am looking forward to your comments.
DO NOT USE ON IMPORTANT FILESYSTEMS. The patch has caused corruption.

Oliver Neukum

diff -u --recursive /usr/src/linux/fs/minix/inode.c tree/fs/minix/inode.c
--- /usr/src/linux/fs/minix/inode.c	Thu Apr 29 22:43:28 1999
+++ tree/fs/minix/inode.c	Thu May 13 22:34:45 1999
@@ -7,6 +7,9 @@
  *	Minix V2 fs support.
  *
  *  Modified for 680x0 by Andreas Schwab
+ *
+ *  Modified for foreign endianness by Oliver Neukum
+ *
  */
 
 #include <linux/module.h>
@@ -19,6 +22,7 @@
 #include <linux/stat.h>
 #include <linux/locks.h>
 #include <linux/init.h>
+#include <linux/byteorder/generic.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -26,6 +30,8 @@
 
 #include <linux/minix_fs.h>
 
+#define MINIX_ENDIAN_DEBUG
+
 static void minix_read_inode(struct inode * inode);
 static void minix_write_inode(struct inode * inode);
 static int minix_statfs(struct super_block *sb, struct statfs *buf, int bufsiz);
@@ -47,12 +53,26 @@
 static void minix_write_super(struct super_block * sb)
 {
 	struct minix_super_block * ms;
-
+	int state;
+	char endian;
 	if (!(sb->s_flags & MS_RDONLY)) {
 		ms = sb->u.minix_sb.s_ms;
-
-		if (ms->s_state & MINIX_VALID_FS)
-			ms->s_state &= ~MINIX_VALID_FS;
+		endian = sb->u.minix_sb.s_endianness;
+		if (endian == MINIX_BIGENDIAN) {
+			state = be16_to_cpu(ms->s_state);
+		} else if (endian == MINIX_LITTLEENDIAN) {
+			state = le16_to_cpu(ms->s_state);
+		}
+		
+		if (state & MINIX_VALID_FS)
+			state &= ~MINIX_VALID_FS;
+			
+		if (endian == MINIX_BIGENDIAN) {
+			ms->s_state = cpu_to_be16(state);
+		} else if (endian == MINIX_BIGENDIAN) {
+			ms->s_state = cpu_to_le16(state);
+		}
+		
 		minix_commit_super(sb);
 	}
 	sb->s_dirt = 0;
@@ -62,11 +82,20 @@
 static void minix_put_super(struct super_block *sb)
 {
 	int i;
-
+	char endian;
+	
 	if (!(sb->s_flags & MS_RDONLY)) {
-		sb->u.minix_sb.s_ms->s_state = sb->u.minix_sb.s_mount_state;
-		mark_buffer_dirty(sb->u.minix_sb.s_sbh, 1);
-	}
+		endian = sb->u.minix_sb.s_endianness;
+		if (endian == MINIX_BIGENDIAN) {
+			sb->u.minix_sb.s_ms->s_state =
+				cpu_to_be16(sb->u.minix_sb.s_mount_state);
+			mark_buffer_dirty(sb->u.minix_sb.s_sbh, 1);
+		} else if (endian == MINIX_LITTLEENDIAN) {
+			sb->u.minix_sb.s_ms->s_state =
+				cpu_to_le16(sb->u.minix_sb.s_mount_state);
+			mark_buffer_dirty(sb->u.minix_sb.s_sbh, 1);
+		}
+	}	
 	for (i = 0; i < sb->u.minix_sb.s_imap_blocks; i++)
 		brelse(sb->u.minix_sb.s_imap[i]);
 	for (i = 0; i < sb->u.minix_sb.s_zmap_blocks; i++)
@@ -129,10 +158,12 @@
  * it really _is_ a Minix filesystem, and to check the size
  * of the directory entry.
  */
-static const char * minix_checkroot(struct super_block *s, struct inode *dir)
+static const char * minix_checkroot(struct super_block *s, struct inode *dir,
+								char endian)
 {
 	struct buffer_head *bh;
 	struct minix_dir_entry *de;
+	u16 inumber;
 	const char * errmsg;
 	int dirsize;
 
@@ -146,14 +177,22 @@
 	de = (struct minix_dir_entry *) bh->b_data;
 	errmsg = "bad root directory '.' entry";
 	dirsize = BLOCK_SIZE;
-	if (de->inode == MINIX_ROOT_INO && strcmp(de->name, ".") == 0) {
+	if (endian == MINIX_BIGENDIAN)
+		inumber = be16_to_cpu(de->inode);
+	else
+		inumber = le16_to_cpu(de->inode);
+	if (inumber == MINIX_ROOT_INO && strcmp(de->name, ".") == 0) {
 		errmsg = "bad root directory '..' entry";
 		dirsize = 8;
 	}
 
 	while ((dirsize <<= 1) < BLOCK_SIZE) {
 		de = (struct minix_dir_entry *) (bh->b_data + dirsize);
-		if (de->inode != MINIX_ROOT_INO)
+		if (endian == MINIX_BIGENDIAN)
+			inumber = be16_to_cpu(de->inode);
+		else
+			inumber = le16_to_cpu(de->inode);
+		if (inumber != MINIX_ROOT_INO)
 			continue;
 		if (strcmp(de->name, ".."))
 			continue;
@@ -176,58 +215,124 @@
 	kdev_t dev = s->s_dev;
 	const char * errmsg;
 	struct inode *root_inode;
-	
-	/* N.B. These should be compile-time tests.
-	   Unfortunately that is impossible. */
-	if (32 != sizeof (struct minix_inode))
-		panic("bad V1 i-node size");
-	if (64 != sizeof(struct minix2_inode))
-		panic("bad V2 i-node size");
+	short state;
+	char endian;
 
 	MOD_INC_USE_COUNT;
 	lock_super(s);
 	set_blocksize(dev, BLOCK_SIZE);
 	if (!(bh = bread(dev,1,BLOCK_SIZE)))
 		goto out_bad_sb;
-
 	ms = (struct minix_super_block *) bh->b_data;
+#ifdef MINIX_ENDIAN_DEBUG
+	printk("%04x",ms->s_magic);
+#endif
+	switch (ntohs(ms->s_magic)) {
+		case MINIX_SUPER_MAGIC :
+			s->u.minix_sb.s_version = MINIX_V1;
+			s->u.minix_sb.s_dirsize = 16;
+			s->u.minix_sb.s_namelen = 14;
+			s->u.minix_sb.s_link_max = MINIX_LINK_MAX;
+			endian = MINIX_BIGENDIAN;
+			break;
+		case MINIX_SUPER_MAGIC2 :
+			s->u.minix_sb.s_version = MINIX_V1;
+			s->u.minix_sb.s_dirsize = 32;
+			s->u.minix_sb.s_namelen = 30;
+			s->u.minix_sb.s_link_max = MINIX_LINK_MAX;
+			endian = MINIX_BIGENDIAN;
+			break;
+		case MINIX2_SUPER_MAGIC :
+			s->u.minix_sb.s_version = MINIX_V2;
+			s->u.minix_sb.s_nzones = ms->s_zones;
+			s->u.minix_sb.s_dirsize = 16;
+			s->u.minix_sb.s_namelen = 14;
+			s->u.minix_sb.s_link_max = MINIX2_LINK_MAX;
+			endian = MINIX_BIGENDIAN;
+			break;
+		case MINIX2_SUPER_MAGIC2 :
+			s->u.minix_sb.s_version = MINIX_V2;
+			s->u.minix_sb.s_nzones = ms->s_zones;
+			s->u.minix_sb.s_dirsize = 32;
+			s->u.minix_sb.s_namelen = 30;
+			s->u.minix_sb.s_link_max = MINIX2_LINK_MAX;
+			endian = MINIX_BIGENDIAN;
+			break;
+		case MINIX_SUPER_MAGIC_REVERSED :
+			s->u.minix_sb.s_version = MINIX_V1;
+			s->u.minix_sb.s_dirsize = 16;
+			s->u.minix_sb.s_namelen = 14;
+			s->u.minix_sb.s_link_max = MINIX_LINK_MAX;
+			endian = MINIX_LITTLEENDIAN;
+			break;
+		case MINIX_SUPER_MAGIC2_REVERSED :
+			s->u.minix_sb.s_version = MINIX_V1;
+			s->u.minix_sb.s_dirsize = 32;
+			s->u.minix_sb.s_namelen = 30;
+			s->u.minix_sb.s_link_max = MINIX_LINK_MAX;
+			endian = MINIX_LITTLEENDIAN;
+			break;
+		case MINIX2_SUPER_MAGIC_REVERSED :
+			s->u.minix_sb.s_version = MINIX_V2;
+			s->u.minix_sb.s_nzones = ms->s_zones;
+			s->u.minix_sb.s_dirsize = 16;
+			s->u.minix_sb.s_namelen = 14;
+			s->u.minix_sb.s_link_max = MINIX2_LINK_MAX;
+			endian = MINIX_LITTLEENDIAN;
+			break;
+		case MINIX2_SUPER_MAGIC2_REVERSED :
+			s->u.minix_sb.s_version = MINIX_V2;
+			s->u.minix_sb.s_nzones = ms->s_zones;
+			s->u.minix_sb.s_dirsize = 32;
+			s->u.minix_sb.s_namelen = 30;
+			s->u.minix_sb.s_link_max = MINIX2_LINK_MAX;
+			endian = MINIX_LITTLEENDIAN;
+			break;
+		default :
+#ifdef MINIX_ENDIAN_DEBUG
+			printk("Magic not recognized.\n");
+#endif
+			goto out_no_fs;
+	}
+#ifdef MINIX_ENDIAN_DEBUG
+	if (!(endian)) printk("bigendian minixfs.\n"); else
+	printk("littleendian minixfs.\n");
+#endif
+	s->u.minix_sb.s_endianness = endian;
+	
+	switch (endian) {
+	  case MINIX_BIGENDIAN :
+		s->u.minix_sb.s_mount_state = be16_to_cpu(ms->s_state);
+		s->u.minix_sb.s_ninodes = be16_to_cpu(ms->s_ninodes);
+		s->u.minix_sb.s_nzones = be16_to_cpu(ms->s_nzones);
+		s->u.minix_sb.s_imap_blocks = be16_to_cpu(ms->s_imap_blocks);
+		s->u.minix_sb.s_zmap_blocks = be16_to_cpu(ms->s_zmap_blocks);
+		s->u.minix_sb.s_firstdatazone = be16_to_cpu(ms->s_firstdatazone);
+		s->u.minix_sb.s_log_zone_size = be16_to_cpu(ms->s_log_zone_size);
+		s->u.minix_sb.s_max_size = be16_to_cpu(ms->s_max_size);
+		s->s_magic = be16_to_cpu(ms->s_magic);
+		break;
+	  case MINIX_LITTLEENDIAN :
+		s->u.minix_sb.s_mount_state = le16_to_cpu(ms->s_state);
+		s->u.minix_sb.s_ninodes = le16_to_cpu(ms->s_ninodes);
+		s->u.minix_sb.s_nzones = le16_to_cpu(ms->s_nzones);
+		s->u.minix_sb.s_imap_blocks = le16_to_cpu(ms->s_imap_blocks);
+		s->u.minix_sb.s_zmap_blocks = le16_to_cpu(ms->s_zmap_blocks);
+		s->u.minix_sb.s_firstdatazone = le16_to_cpu(ms->s_firstdatazone);
+		s->u.minix_sb.s_log_zone_size = le16_to_cpu(ms->s_log_zone_size);
+		s->u.minix_sb.s_max_size = le16_to_cpu(ms->s_max_size);
+		s->s_magic = le16_to_cpu(ms->s_magic);
+		break;
+	  default :
+		printk("Minixfs:Strange endianness.\n");
+		goto out_unlock;
+	}
+	
 	s->u.minix_sb.s_ms = ms;
-	s->u.minix_sb.s_sbh = bh;
-	s->u.minix_sb.s_mount_state = ms->s_state;
+	s->u.minix_sb.s_sbh = bh;		
 	s->s_blocksize = BLOCK_SIZE;
 	s->s_blocksize_bits = BLOCK_SIZE_BITS;
-	s->u.minix_sb.s_ninodes = ms->s_ninodes;
-	s->u.minix_sb.s_nzones = ms->s_nzones;
-	s->u.minix_sb.s_imap_blocks = ms->s_imap_blocks;
-	s->u.minix_sb.s_zmap_blocks = ms->s_zmap_blocks;
-	s->u.minix_sb.s_firstdatazone = ms->s_firstdatazone;
-	s->u.minix_sb.s_log_zone_size = ms->s_log_zone_size;
-	s->u.minix_sb.s_max_size = ms->s_max_size;
-	s->s_magic = ms->s_magic;
-	if (s->s_magic == MINIX_SUPER_MAGIC) {
-		s->u.minix_sb.s_version = MINIX_V1;
-		s->u.minix_sb.s_dirsize = 16;
-		s->u.minix_sb.s_namelen = 14;
-		s->u.minix_sb.s_link_max = MINIX_LINK_MAX;
-	} else if (s->s_magic == MINIX_SUPER_MAGIC2) {
-		s->u.minix_sb.s_version = MINIX_V1;
-		s->u.minix_sb.s_dirsize = 32;
-		s->u.minix_sb.s_namelen = 30;
-		s->u.minix_sb.s_link_max = MINIX_LINK_MAX;
-	} else if (s->s_magic == MINIX2_SUPER_MAGIC) {
-		s->u.minix_sb.s_version = MINIX_V2;
-		s->u.minix_sb.s_nzones = ms->s_zones;
-		s->u.minix_sb.s_dirsize = 16;
-		s->u.minix_sb.s_namelen = 14;
-		s->u.minix_sb.s_link_max = MINIX2_LINK_MAX;
-	} else if (s->s_magic == MINIX2_SUPER_MAGIC2) {
-		s->u.minix_sb.s_version = MINIX_V2;
-		s->u.minix_sb.s_nzones = ms->s_zones;
-		s->u.minix_sb.s_dirsize = 32;
-		s->u.minix_sb.s_namelen = 30;
-		s->u.minix_sb.s_link_max = MINIX2_LINK_MAX;
-	} else
-		goto out_no_fs;
+	
 
 	/*
 	 * Allocate the buffer map to keep the superblock small.
@@ -262,7 +367,7 @@
 	/*
 	 * Check the fs before we get the root dentry ...
 	 */
-	errmsg = minix_checkroot(s, root_inode);
+	errmsg = minix_checkroot(s, root_inode, endian);
 	if (errmsg)
 		goto out_bad_root;
 
@@ -273,7 +378,15 @@
 	s->s_root->d_op = &minix_dentry_operations;
 
 	if (!(s->s_flags & MS_RDONLY)) {
-		ms->s_state &= ~MINIX_VALID_FS;
+		if (endian == MINIX_BIGENDIAN) 
+			state =	be16_to_cpu(ms->s_state);
+		else
+			state = le16_to_cpu(ms->s_state);
+		state &= ~MINIX_VALID_FS;
+		if (endian == MINIX_BIGENDIAN)
+			ms->s_state = cpu_to_be16(state);
+		else
+			ms->s_state = cpu_to_le16(state);
 		mark_buffer_dirty(bh, 1);
 		s->s_dirt = 1;
 	}
@@ -323,7 +436,7 @@
 
 out_bad_sb:
 	printk("MINIX-fs: unable to read superblock\n");
-    out_unlock:
+out_unlock:
 	s->s_dev = 0;
 	unlock_super(s);
 	MOD_DEC_USE_COUNT;
@@ -729,7 +842,9 @@
 	struct buffer_head * bh;
 	struct minix_inode * raw_inode;
 	int block, ino;
-
+	char endian;
+	
+	
 	ino = inode->i_ino;
 	inode->i_op = NULL;
 	inode->i_mode = 0;
@@ -739,6 +854,7 @@
 			kdevname(inode->i_dev), ino);
 		return;
 	}
+	endian = inode->i_sb->u.minix_sb.s_endianness;
 	block = 2 + inode->i_sb->u.minix_sb.s_imap_blocks +
 		    inode->i_sb->u.minix_sb.s_zmap_blocks +
 		    (ino-1)/MINIX_INODES_PER_BLOCK;
@@ -749,17 +865,39 @@
 	}
 	raw_inode = ((struct minix_inode *) bh->b_data) +
 		    (ino-1)%MINIX_INODES_PER_BLOCK;
-	inode->i_mode = raw_inode->i_mode;
-	inode->i_uid = raw_inode->i_uid;
-	inode->i_gid = raw_inode->i_gid;
-	inode->i_nlink = raw_inode->i_nlinks;
-	inode->i_size = raw_inode->i_size;
-	inode->i_mtime = inode->i_atime = inode->i_ctime = raw_inode->i_time;
-	inode->i_blocks = inode->i_blksize = 0;
-	if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode))
-		inode->i_rdev = to_kdev_t(raw_inode->i_zone[0]);
-	else for (block = 0; block < 9; block++)
-		inode->u.minix_i.u.i1_data[block] = raw_inode->i_zone[block];
+	
+	if (endian == MINIX_BIGENDIAN) {
+		inode->i_mode = be16_to_cpu(raw_inode->i_mode);
+		inode->i_uid = be16_to_cpu(raw_inode->i_uid);
+		inode->i_gid = raw_inode->i_gid;
+		inode->i_nlink = raw_inode->i_nlinks;
+		inode->i_size = be32_to_cpu(raw_inode->i_size);
+		inode->i_mtime = inode->i_atime = inode->i_ctime =
+			be32_to_cpu(raw_inode->i_time);
+		inode->i_blocks = inode->i_blksize = 0;
+		if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode))
+			inode->i_rdev = 
+				to_kdev_t(be16_to_cpu(raw_inode->i_zone[0]));
+		else for (block = 0; block < 9; block++)
+			inode->u.minix_i.u.i1_data[block] = 
+				be16_to_cpu(raw_inode->i_zone[block]);
+	} else {
+		inode->i_mode = le16_to_cpu(raw_inode->i_mode);
+		inode->i_uid = le16_to_cpu(raw_inode->i_uid);
+		inode->i_gid = raw_inode->i_gid;
+		inode->i_nlink = raw_inode->i_nlinks;
+		inode->i_size = le32_to_cpu(raw_inode->i_size);
+		inode->i_mtime = inode->i_atime = inode->i_ctime = 
+			le32_to_cpu(raw_inode->i_time);
+		inode->i_blocks = inode->i_blksize = 0;
+		if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode))
+			inode->i_rdev = 
+				to_kdev_t(le16_to_cpu(raw_inode->i_zone[0]));
+		else for (block = 0; block < 9; block++)
+			inode->u.minix_i.u.i1_data[block] = 
+				le16_to_cpu(raw_inode->i_zone[block]);	
+	}
+			
 	brelse(bh);
 	if (S_ISREG(inode->i_mode))
 		inode->i_op = &minix_file_inode_operations;
diff -u --recursive /usr/src/linux/include/linux/minix_fs.h tree/include/linux/minix_fs.h
--- /usr/src/linux/include/linux/minix_fs.h	Thu Apr 29 22:43:31 1999
+++ tree/include/linux/minix_fs.h	Thu May 13 21:11:03 1999
@@ -19,10 +19,22 @@
 
 #define MINIX_I_MAP_SLOTS	8
 #define MINIX_Z_MAP_SLOTS	64
+
+/*
+minixfs exists in both endiannesses, for this purposes network byte
+order is considered primary
+*/
+
 #define MINIX_SUPER_MAGIC	0x137F		/* original minix fs */
 #define MINIX_SUPER_MAGIC2	0x138F		/* minix fs, 30 char names */
 #define MINIX2_SUPER_MAGIC	0x2468		/* minix V2 fs */
 #define MINIX2_SUPER_MAGIC2	0x2478		/* minix V2 fs, 30 char names */
+
+#define MINIX_SUPER_MAGIC_REVERSED	0x7F13
+#define MINIX_SUPER_MAGIC2_REVERSED	0x8F13
+#define MINIX2_SUPER_MAGIC_REVERSED	0x6824
+#define MINIX2_SUPER_MAGIC2_REVERSED	0x7824
+
 #define MINIX_VALID_FS		0x0001		/* Clean fs. */
 #define MINIX_ERROR_FS		0x0002		/* fs has errors. */
 
@@ -31,6 +43,10 @@
 
 #define MINIX_V1		0x0001		/* original minix fs */
 #define MINIX_V2		0x0002		/* minix V2 fs */
+
+#define MINIX_BIGENDIAN		0x00		/* indicate endianess */
+#define MINIX_LITTLEENDIAN	0x01		/* on disk */
+#define MINIX_PDP11ENDIAN	0x02		/* not implemented */
 
 #define INODE_VERSION(inode)	inode->i_sb->u.minix_sb.s_version
 
diff -u --recursive /usr/src/linux/include/linux/minix_fs_sb.h tree/include/linux/minix_fs_sb.h
--- /usr/src/linux/include/linux/minix_fs_sb.h	Sat Jun 13 22:25:12 1998
+++ tree/include/linux/minix_fs_sb.h	Thu May 13 12:40:47 1999
@@ -21,6 +21,7 @@
 			struct minix_super_block * s_ms;
 			unsigned short s_mount_state;
 			unsigned short s_version;
+			char s_endianness;
 };
 
 #endif


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
