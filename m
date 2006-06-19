Return-Path: <arnd@arndb.de>
Message-Id: <20060619183404.966781000@klappe.arndb.de>
References: <20060619183315.653672000@klappe.arndb.de>
Date: Mon, 19 Jun 2006 20:33:22 +0200
From: arnd@arndb.de
To: paulus@samba.org
Subject: [patch 07/20] spufs: fix deadlock in spu_create error path
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Michael Ellerman <michael@ellerman.id.au>

spufs_rmdir tries to acquire the spufs root
i_mutex, which is already held by spufs_create_thread.

This was tracked as Bug #H9512.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

---

Index: powerpc.git/arch/powerpc/platforms/cell/spufs/inode.c
===================================================================
--- powerpc.git.orig/arch/powerpc/platforms/cell/spufs/inode.c
+++ powerpc.git/arch/powerpc/platforms/cell/spufs/inode.c
@@ -157,20 +157,12 @@ static void spufs_prune_dir(struct dentr
 	mutex_unlock(&dir->d_inode->i_mutex);
 }
 
+/* Caller must hold root->i_mutex */
 static int spufs_rmdir(struct inode *root, struct dentry *dir_dentry)
 {
-	struct spu_context *ctx;
-
 	/* remove all entries */
-	mutex_lock(&root->i_mutex);
 	spufs_prune_dir(dir_dentry);
-	mutex_unlock(&root->i_mutex);
 
-	/* We have to give up the mm_struct */
-	ctx = SPUFS_I(dir_dentry->d_inode)->i_ctx;
-	spu_forget(ctx);
-
-	/* XXX Do we need to hold i_mutex here ? */
 	return simple_rmdir(root, dir_dentry);
 }
 
@@ -199,16 +191,23 @@ out:
 
 static int spufs_dir_close(struct inode *inode, struct file *file)
 {
+	struct spu_context *ctx;
 	struct inode *dir;
 	struct dentry *dentry;
 	int ret;
 
 	dentry = file->f_dentry;
 	dir = dentry->d_parent->d_inode;
+	ctx = SPUFS_I(dentry->d_inode)->i_ctx;
 
+	mutex_lock(&dir->i_mutex);
 	ret = spufs_rmdir(dir, dentry);
+	mutex_unlock(&dir->i_mutex);
 	WARN_ON(ret);
 
+	/* We have to give up the mm_struct */
+	spu_forget(ctx);
+
 	return dcache_dir_close(inode, file);
 }
 
@@ -324,8 +323,13 @@ long spufs_create_thread(struct nameidat
 	 * in error path of *_open().
 	 */
 	ret = spufs_context_open(dget(dentry), mntget(nd->mnt));
-	if (ret < 0)
-		spufs_rmdir(nd->dentry->d_inode, dentry);
+	if (ret < 0) {
+		WARN_ON(spufs_rmdir(nd->dentry->d_inode, dentry));
+		mutex_unlock(&nd->dentry->d_inode->i_mutex);
+		spu_forget(SPUFS_I(dentry->d_inode)->i_ctx);
+		dput(dentry);
+		goto out;
+	}
 
 out_dput:
 	dput(dentry);

--
