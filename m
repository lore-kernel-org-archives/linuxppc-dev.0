Date: Sun, 20 Dec 1998 13:23:43 -0800 (PST)
Message-Id: <199812202123.NAA14688@saul5.u.washington.edu>
From: a sun <asun@saul5.u.washington.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: does this solve btree corruption problems?
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



hi all,

here's a patch against 2.1.131 that should hopefully solve the
catalogue b-tree corruption problems when deleting files. at the very
least, disk first aid doesn't seem to complain anymore. however,
norton utilities has decided that it doesn't the like the root node
number. i think it's due to the hfs module not adding/deleting from
btrees in the same way that the macos does. oh yeah, i didn't bother
to separate the other hfs changes that i've already sent on, so you
also get larger volume support as well and auto-timezone adjustment if
you run a user-level daemon.

anyways, try it out and let me know if things that normally corrupt
the btree still do. needless to say, don't do this with your only copy
of that vital piece of data that you can't live without.

-a
asun@u.washington.edu


--- linux/fs/hfs/mdb.c.save	Mon Dec 14 23:56:56 1998
+++ linux/fs/hfs/mdb.c	Mon Dec 14 23:58:36 1998
@@ -118,7 +118,7 @@
 	mdb->buf = buf;
 	
 	bs = hfs_get_hl(raw->drAlBlkSiz);
-	if (!bs || bs > HFS_USHRT_MAX || (bs & (HFS_SECTOR_SIZE-1))) {
+	if (!bs || (bs & (HFS_SECTOR_SIZE-1))) {
 		hfs_warn("hfs_fs: bad allocation block size %d != 512\n", bs);
 		hfs_buffer_put(buf);
 		HFS_DELETE(mdb);
--- linux/fs/hfs/hfs.h.save	Tue Dec 15 00:14:10 1998
+++ linux/fs/hfs/hfs.h	Wed Dec 16 10:39:47 1998
@@ -252,7 +252,7 @@
 	hfs_u16			free_ablocks;	/* The number of unused
 						   allocation blocks
 						   in the filesystem */
-	hfs_u16			alloc_blksz;	/* The number of
+	hfs_u32			alloc_blksz;	/* The number of
 						   512-byte blocks per
 						   "allocation block" */
 	hfs_u16			attrib;		/* Attribute word */
--- linux/fs/hfs/ChangeLog.save	Tue Dec 15 00:14:16 1998
+++ linux/fs/hfs/ChangeLog	Sun Dec 20 12:53:10 1998
@@ -1,3 +1,24 @@
+1998-12-20  a sun  <asun@hecate.darksunrising.blah>
+
+	* bdelete.c (del_root): assign bthLNode and bthFNode only if the
+	root node becomes a leaf node. Disk First Aid no longer
+	complains. Norton Utilities, of course, has decided that it
+	doesn't like the root node number. bleah. i think that it might be
+	due to Norton Utilities not expecting the root node to have moved.
+
+1998-12-16  a sun  <asun@hecate.darksunrising.blah>
+
+	* sysdep.c (hfs_revalidate_dentry): fix inode dates when there's a
+	timezone change.
+
+1998-12-15  root  <root@hecate.darksunrising.blah>
+
+	* extent.c (new_extent): expand block size variables to handle
+	u32. 
+
+	* mdb.c (hfs_mdb_get): AlBlkSiz shouldn't be capped at 65535. we
+	should be able to handle much larger volumes now.
+
 1998-11-21  a sun  <asun@hecate.darksunrising.blah>
 
 	* hfs_sysdep.h, hfs_fs.h: added hfs_from_utc/to_utc to deal with
--- linux/fs/hfs/extent.c.save	Tue Dec 15 00:14:36 1998
+++ linux/fs/hfs/extent.c	Tue Dec 15 00:10:32 1998
@@ -354,7 +354,7 @@
  *   hfs_u16 ablock: the number of allocation blocks in 'fork'.
  *   hfs_u16 start: first allocation block to add to 'fork'.
  *   hfs_u16 len: the number of allocation blocks to add to 'fork'.
- *   hfs_u16 ablksz: number of sectors in an allocation block.
+ *   hfs_u32 ablksz: number of sectors in an allocation block.
  * Output Variable(s):
  *   NONE
  * Returns:
@@ -471,7 +471,7 @@
 	struct hfs_mdb *mdb = fork->entry->mdb;
 	struct hfs_extent *ext;
 	int i, error, next, count;
-	hfs_u16 ablksz = mdb->alloc_blksz;
+	hfs_u32 ablksz = mdb->alloc_blksz;
 
 	next =  (fork->psize / ablksz) - 1;
 	ext = find_ext(fork, next);
@@ -530,7 +530,7 @@
 	struct hfs_extent *ext;
 	int i, start, err;
 	hfs_u16 need, len=0;
-	hfs_u16 ablksz = mdb->alloc_blksz;
+	hfs_u32 ablksz = mdb->alloc_blksz;
 	hfs_u32 blocks, clumpablks;
 
 	blocks = fork->psize;
@@ -681,8 +681,7 @@
 void hfs_extent_adj(struct hfs_fork *fork)
 {
 	if (fork) {
-		hfs_u32 blks, ablocks;
-		hfs_u16 ablksz;
+		hfs_u32 blks, ablocks, ablksz;
 
 		if (fork->lsize > HFS_FORK_MAX) {
 			fork->lsize = HFS_FORK_MAX;
--- linux/fs/hfs/inode.c.save	Wed Dec 16 10:17:55 1998
+++ linux/fs/hfs/inode.c	Wed Dec 16 00:10:25 1998
@@ -260,6 +260,7 @@
 		memset(HFS_I(inode), 0, sizeof(struct hfs_inode_info));
 		HFS_I(inode)->magic = HFS_INO_MAGIC;
 		HFS_I(inode)->entry = entry;
+		HFS_I(inode)->tz_secondswest = hfs_to_utc(0);
 
 		hsb->s_ifill(inode, type);
 		if (!hsb->s_afpd && (entry->type == HFS_CDR_FIL) &&
--- linux/fs/hfs/sysdep.c.save	Wed Dec 16 10:25:16 1998
+++ linux/fs/hfs/sysdep.c	Wed Dec 16 14:59:35 1998
@@ -18,12 +18,13 @@
 #include <linux/hfs_fs_i.h>
 #include <linux/hfs_fs.h>
 
+static int hfs_revalidate_dentry(struct dentry *);
 static int hfs_hash_dentry(struct dentry *, struct qstr *);
 static int hfs_compare_dentry(struct dentry *, struct qstr *, struct qstr *);
 static void hfs_dentry_iput(struct dentry *, struct inode *);
 struct dentry_operations hfs_dentry_operations =
 {
-	NULL,	                /* d_validate(struct dentry *) */
+	hfs_revalidate_dentry,	/* d_revalidate(struct dentry *) */
 	hfs_hash_dentry,	/* d_hash */
 	hfs_compare_dentry,    	/* d_compare */
 	NULL,	                /* d_delete(struct dentry *) */
@@ -86,4 +87,20 @@
 
 	entry->sys_entry[HFS_ITYPE_TO_INT(HFS_ITYPE(inode->i_ino))] = NULL;
 	iput(inode);
+}
+
+static int hfs_revalidate_dentry(struct dentry *dentry)
+{
+	struct inode *inode = dentry->d_inode;
+	int diff;
+
+	/* fix up inode on a timezone change */
+	if (inode && 
+	    (diff = (hfs_to_utc(0) - HFS_I(inode)->tz_secondswest))) {
+		inode->i_ctime += diff;
+		inode->i_atime += diff;
+		inode->i_mtime += diff;
+		HFS_I(inode)->tz_secondswest += diff;
+	}
+	return 1;
 }
--- linux/fs/hfs/bdelete.c.save	Sun Dec 20 12:48:56 1998
+++ linux/fs/hfs/bdelete.c	Sun Dec 20 12:51:24 1998
@@ -135,11 +135,16 @@
 
 		tree->bthRoot = child.bn->node;
 		tree->root = child.bn;
+
+		/* re-assign bthFNode and bthLNode if the new root is
+                   a leaf node. */
+		if (child.bn->ndType == ndLeafNode) {
+			tree->bthFNode = node;
+			tree->bthLNode = node;
+		}
 		hfs_bnode_relse(&child);
 
 		tree->bthRoot = node;
-		tree->bthFNode = node;
-		tree->bthLNode = node;
 		--tree->bthDepth;
 		tree->dirt = 1;
 		if (!tree->bthDepth) {
--- linux/include/linux/hfs_fs_i.h.save	Wed Dec 16 10:24:56 1998
+++ linux/include/linux/hfs_fs_i.h	Wed Dec 16 00:09:53 1998
@@ -33,6 +33,9 @@
 	const struct hfs_hdr_layout	*default_layout;
 	struct hfs_hdr_layout		*layout;
 
+	/* to deal with localtime ugliness */
+	int                             tz_secondswest;
+
         /* for dentry cleanup */
         void (*d_drop_op)(struct dentry *, const ino_t);
 };

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
