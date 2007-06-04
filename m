Return-Path: <jk@ozlabs.org>
To: <paulus@samba.org>
From: Jeremy Kerr <jk@ozlabs.org>
Date: Mon, 04 Jun 2007 21:26:51 +0800
Subject: [PATCH 3/6] spufs: Fix gang destroy leaks.
Message-Id: <1180963611.845382.800380556938.qpush@pokey>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Previously, closing a SPE gang that still has contexts would trigger
a WARN_ON, and leak the allocated gang.

This change fixes the problem by using the gang's reference counts to
destroy the gang instead. The gangs will persist until their last
reference (be it context or open file handle) is gone.

Also, avoid using statements with side-effects in a WARN_ON().

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

---

 arch/powerpc/platforms/cell/spufs/inode.c |   40 +++---------------------------
 1 file changed, 5 insertions(+), 35 deletions(-)

Index: linux-2.6-spufs/arch/powerpc/platforms/cell/spufs/inode.c
===================================================================
--- linux-2.6-spufs.orig/arch/powerpc/platforms/cell/spufs/inode.c
+++ linux-2.6-spufs/arch/powerpc/platforms/cell/spufs/inode.c
@@ -349,37 +349,6 @@ out:
 	return ret;
 }
 
-static int spufs_rmgang(struct inode *root, struct dentry *dir)
-{
-	/* FIXME: this fails if the dir is not empty,
-	          which causes a leak of gangs. */
-	return simple_rmdir(root, dir);
-}
-
-static int spufs_gang_close(struct inode *inode, struct file *file)
-{
-	struct inode *parent;
-	struct dentry *dir;
-	int ret;
-
-	dir = file->f_path.dentry;
-	parent = dir->d_parent->d_inode;
-
-	ret = spufs_rmgang(parent, dir);
-	WARN_ON(ret);
-
-	return dcache_dir_close(inode, file);
-}
-
-const struct file_operations spufs_gang_fops = {
-	.open		= dcache_dir_open,
-	.release	= spufs_gang_close,
-	.llseek		= dcache_dir_lseek,
-	.read		= generic_read_dir,
-	.readdir	= dcache_readdir,
-	.fsync		= simple_sync_file,
-};
-
 static int
 spufs_mkgang(struct inode *dir, struct dentry *dentry, int mode)
 {
@@ -407,7 +376,6 @@ spufs_mkgang(struct inode *dir, struct d
 	inode->i_fop = &simple_dir_operations;
 
 	d_instantiate(dentry, inode);
-	dget(dentry);
 	dir->i_nlink++;
 	dentry->d_inode->i_nlink++;
 	return ret;
@@ -437,7 +405,7 @@ static int spufs_gang_open(struct dentry
 		goto out;
 	}
 
-	filp->f_op = &spufs_gang_fops;
+	filp->f_op = &simple_dir_operations;
 	fd_install(ret, filp);
 out:
 	return ret;
@@ -458,8 +426,10 @@ static int spufs_create_gang(struct inod
 	 * in error path of *_open().
 	 */
 	ret = spufs_gang_open(dget(dentry), mntget(mnt));
-	if (ret < 0)
-		WARN_ON(spufs_rmgang(inode, dentry));
+	if (ret < 0) {
+		int err = simple_rmdir(inode, dentry);
+		WARN_ON(err);
+	}
 
 out:
 	mutex_unlock(&inode->i_mutex);
