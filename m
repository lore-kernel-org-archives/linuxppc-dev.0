Date: Thu, 4 May 2000 20:46:48 -0700 (PDT)
From: Ani Joshi <ajoshi@shell.unixbox.com>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
cc: Martin Costabel <costabel@wanadoo.fr>, Steven Hanley <sjh@wibble.net>,
        Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.3.99-pre6 sound hfs
In-Reply-To: <Pine.LNX.4.10.10005041754250.30927-100000@opal.biophys.uni-duesseldorf.de>
Message-ID: <Pine.LNX.4.10.10005042042280.19981-100000@shell.unixbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


As some of you have said before, the HFS issue in 2.3 is due to all the
VFS changes, page cache stuff being a big one.  anyhow, i poked around a
bit last nite and have stabalized it a bit more (though not perfect yet),
mounting and reads work fine, writes work sometimes and not, very strange.

below is a patch which makes hfs use generic file read/writes, obviously
more needs to be done then this, hopefully i'll post some more patches
soon...


ani


--- linux.orig/fs/hfs/file.c	Wed May  3 22:21:05 2000
+++ linux/fs/hfs/hfs/file.c	Thu May  4 23:24:04 2000
@@ -23,17 +23,14 @@

 /*================ Forward declarations ================*/

-static hfs_rwret_t hfs_file_read(struct file *, char *, hfs_rwarg_t,
-				 loff_t *);
-static hfs_rwret_t hfs_file_write(struct file *, const char *, hfs_rwarg_t,
-				  loff_t *);
+
 static void hfs_file_truncate(struct inode *);

 /*================ Global variables ================*/

 struct file_operations hfs_file_operations = {
-	read:		hfs_file_read,
-	write:		hfs_file_write,
+	read:		generic_file_read,
+	write:		generic_file_write,
 	mmap:		generic_file_mmap,
 	fsync:		file_fsync,
 };
@@ -174,46 +171,6 @@
 	return read;
 }

-/*
- * hfs_file_write()
- *
- * This is the write() entry in the file_operations structure for
- * "regular" files.  The purpose is to transfer up to 'count' bytes
- * to the file corresponding to 'inode' beginning at offset
- * 'file->f_pos' from user-space at the address 'buf'.  The return
- * value is the number of bytes actually transferred.
- */
-static hfs_rwret_t hfs_file_write(struct file * filp, const char * buf,
-				  hfs_rwarg_t count, loff_t *ppos)
-{
-        struct inode    *inode = filp->f_dentry->d_inode;
-	struct hfs_fork *fork = HFS_I(inode)->fork;
-	hfs_s32 written, pos;
-
-	if (!S_ISREG(inode->i_mode)) {
-		hfs_warn("hfs_file_write: mode = %07o\n", inode->i_mode);
-		return -EINVAL;
-	}
-
-	pos = (filp->f_flags & O_APPEND) ? inode->i_size : *ppos;
-
-	if (pos >= HFS_FORK_MAX) {
-		return 0;
-	}
-	if (count > HFS_FORK_MAX) {
-		count = HFS_FORK_MAX;
-	}
-	if ((written = hfs_do_write(inode, fork, pos, buf, count)) > 0)
-	        pos += written;
-
-	*ppos = pos;
-	if (*ppos > inode->i_size) {
-	        inode->i_size = *ppos;
-		mark_inode_dirty(inode);
-	}
-
-	return written;
-}

 /*
  * hfs_file_truncate()


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
