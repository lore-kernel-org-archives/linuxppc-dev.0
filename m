Return-Path: <jk@ozlabs.org>
To: <paulus@samba.org>
From: Jeremy Kerr <jk@ozlabs.org>
Date: Wed, 06 Jun 2007 12:03:58 +0800
Subject: [PATCH] spufs: fix error handling in spufs_fill_dir()
Message-Id: <1181102638.489591.614145175771.qpush@pokey>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Sebastian Siewior <bigeasy@linux.vnet.ibm.com>

The error path in spufs_fill_dir() is broken. If d_alloc_name() or
spufs_new_file() fails, spufs_prune_dir() is getting called. At this time
dir->inode is not set and a NULL pointer is dereferenced by mutex_lock().
This bugfix replaces spufs_prune_dir() with a shorter version that does
not touch dir->inode but simply removes all children.

Signed-off-by: Sebastian Siewior <bigeasy@linux.vnet.ibm.com>
Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

---

Paulus - another bugfix for 2.6.22.

---

 arch/powerpc/platforms/cell/spufs/inode.c |   17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

Index: linux-2.6-spufs/arch/powerpc/platforms/cell/spufs/inode.c
===================================================================
--- linux-2.6-spufs.orig/arch/powerpc/platforms/cell/spufs/inode.c
+++ linux-2.6-spufs/arch/powerpc/platforms/cell/spufs/inode.c
@@ -177,7 +177,7 @@ static int spufs_rmdir(struct inode *par
 static int spufs_fill_dir(struct dentry *dir, struct tree_descr *files,
 			  int mode, struct spu_context *ctx)
 {
-	struct dentry *dentry;
+	struct dentry *dentry, *tmp;
 	int ret;
 
 	while (files->name && files->name[0]) {
@@ -193,7 +193,20 @@ static int spufs_fill_dir(struct dentry 
 	}
 	return 0;
 out:
-	spufs_prune_dir(dir);
+	/*
+	 * remove all children from dir. dir->inode is not set so don't
+	 * just simply use spufs_prune_dir() and panic afterwards :)
+	 * dput() looks like it will do the right thing:
+	 * - dec parent's ref counter
+	 * - remove child from parent's child list
+	 * - free child's inode if possible
+	 * - free child
+	 */
+	list_for_each_entry_safe(dentry, tmp, &dir->d_subdirs, d_u.d_child) {
+		dput(dentry);
+	}
+
+	shrink_dcache_parent(dir);
 	return ret;
 }
 
