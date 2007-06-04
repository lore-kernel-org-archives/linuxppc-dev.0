Return-Path: <jk@ozlabs.org>
To: <paulus@samba.org>
From: Jeremy Kerr <jk@ozlabs.org>
Date: Mon, 04 Jun 2007 21:26:51 +0800
Subject: [PATCH 5/6] spufs: synchronize pte invalidation vs ps close
Message-Id: <1180963611.944025.94906380768.qpush@pokey>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Christoph Hellwig <hch@lst.de>

Make sure the mapping_lock also protects access to the various address_space
pointers used for tearing down the ptes on a spu context switch.

Because unmap_mapping_range can sleep we need to turn mapping_lock from
a spinlock into a sleeping mutex.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

diff --git a/arch/powerpc/platforms/cell/spufs/context.c b/arch/powerpc/platforms/cell/spufs/context.c
index 8654749..7c51cb5 100644
--- a/arch/powerpc/platforms/cell/spufs/context.c
+++ b/arch/powerpc/platforms/cell/spufs/context.c
@@ -39,7 +39,7 @@ struct spu_context *alloc_spu_context(struct spu_gang *gang)
 	if (spu_init_csa(&ctx->csa))
 		goto out_free;
 	spin_lock_init(&ctx->mmio_lock);
-	spin_lock_init(&ctx->mapping_lock);
+	mutex_init(&ctx->mapping_lock);
 	kref_init(&ctx->kref);
 	mutex_init(&ctx->state_mutex);
 	mutex_init(&ctx->run_mutex);
@@ -103,6 +103,7 @@ void spu_forget(struct spu_context *ctx)
 
 void spu_unmap_mappings(struct spu_context *ctx)
 {
+	mutex_lock(&ctx->mapping_lock);
 	if (ctx->local_store)
 		unmap_mapping_range(ctx->local_store, 0, LS_SIZE, 1);
 	if (ctx->mfc)
@@ -117,6 +118,7 @@ void spu_unmap_mappings(struct spu_context *ctx)
 		unmap_mapping_range(ctx->mss, 0, 0x1000, 1);
 	if (ctx->psmap)
 		unmap_mapping_range(ctx->psmap, 0, 0x20000, 1);
+	mutex_unlock(&ctx->mapping_lock);
 }
 
 /**
diff --git a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/platforms/cell/spufs/file.c
index 89a5011..b1e7e2f 100644
--- a/arch/powerpc/platforms/cell/spufs/file.c
+++ b/arch/powerpc/platforms/cell/spufs/file.c
@@ -45,11 +45,11 @@ spufs_mem_open(struct inode *inode, struct file *file)
 	struct spufs_inode_info *i = SPUFS_I(inode);
 	struct spu_context *ctx = i->i_ctx;
 
-	spin_lock(&ctx->mapping_lock);
+	mutex_lock(&ctx->mapping_lock);
 	file->private_data = ctx;
 	if (!i->i_openers++)
 		ctx->local_store = inode->i_mapping;
-	spin_unlock(&ctx->mapping_lock);
+	mutex_unlock(&ctx->mapping_lock);
 	return 0;
 }
 
@@ -59,10 +59,10 @@ spufs_mem_release(struct inode *inode, struct file *file)
 	struct spufs_inode_info *i = SPUFS_I(inode);
 	struct spu_context *ctx = i->i_ctx;
 
-	spin_lock(&ctx->mapping_lock);
+	mutex_lock(&ctx->mapping_lock);
 	if (!--i->i_openers)
 		ctx->local_store = NULL;
-	spin_unlock(&ctx->mapping_lock);
+	mutex_unlock(&ctx->mapping_lock);
 	return 0;
 }
 
@@ -310,11 +310,11 @@ static int spufs_cntl_open(struct inode *inode, struct file *file)
 	struct spufs_inode_info *i = SPUFS_I(inode);
 	struct spu_context *ctx = i->i_ctx;
 
-	spin_lock(&ctx->mapping_lock);
+	mutex_lock(&ctx->mapping_lock);
 	file->private_data = ctx;
 	if (!i->i_openers++)
 		ctx->cntl = inode->i_mapping;
-	spin_unlock(&ctx->mapping_lock);
+	mutex_unlock(&ctx->mapping_lock);
 	return simple_attr_open(inode, file, spufs_cntl_get,
 					spufs_cntl_set, "0x%08lx");
 }
@@ -327,10 +327,10 @@ spufs_cntl_release(struct inode *inode, struct file *file)
 
 	simple_attr_close(inode, file);
 
-	spin_lock(&ctx->mapping_lock);
+	mutex_lock(&ctx->mapping_lock);
 	if (!--i->i_openers)
 		ctx->cntl = NULL;
-	spin_unlock(&ctx->mapping_lock);
+	mutex_unlock(&ctx->mapping_lock);
 	return 0;
 }
 
@@ -813,11 +813,11 @@ static int spufs_signal1_open(struct inode *inode, struct file *file)
 	struct spufs_inode_info *i = SPUFS_I(inode);
 	struct spu_context *ctx = i->i_ctx;
 
-	spin_lock(&ctx->mapping_lock);
+	mutex_lock(&ctx->mapping_lock);
 	file->private_data = ctx;
 	if (!i->i_openers++)
 		ctx->signal1 = inode->i_mapping;
-	spin_unlock(&ctx->mapping_lock);
+	mutex_unlock(&ctx->mapping_lock);
 	return nonseekable_open(inode, file);
 }
 
@@ -827,10 +827,10 @@ spufs_signal1_release(struct inode *inode, struct file *file)
 	struct spufs_inode_info *i = SPUFS_I(inode);
 	struct spu_context *ctx = i->i_ctx;
 
-	spin_lock(&ctx->mapping_lock);
+	mutex_lock(&ctx->mapping_lock);
 	if (!--i->i_openers)
 		ctx->signal1 = NULL;
-	spin_unlock(&ctx->mapping_lock);
+	mutex_unlock(&ctx->mapping_lock);
 	return 0;
 }
 
@@ -937,11 +937,11 @@ static int spufs_signal2_open(struct inode *inode, struct file *file)
 	struct spufs_inode_info *i = SPUFS_I(inode);
 	struct spu_context *ctx = i->i_ctx;
 
-	spin_lock(&ctx->mapping_lock);
+	mutex_lock(&ctx->mapping_lock);
 	file->private_data = ctx;
 	if (!i->i_openers++)
 		ctx->signal2 = inode->i_mapping;
-	spin_unlock(&ctx->mapping_lock);
+	mutex_unlock(&ctx->mapping_lock);
 	return nonseekable_open(inode, file);
 }
 
@@ -951,10 +951,10 @@ spufs_signal2_release(struct inode *inode, struct file *file)
 	struct spufs_inode_info *i = SPUFS_I(inode);
 	struct spu_context *ctx = i->i_ctx;
 
-	spin_lock(&ctx->mapping_lock);
+	mutex_lock(&ctx->mapping_lock);
 	if (!--i->i_openers)
 		ctx->signal2 = NULL;
-	spin_unlock(&ctx->mapping_lock);
+	mutex_unlock(&ctx->mapping_lock);
 	return 0;
 }
 
@@ -1155,10 +1155,10 @@ static int spufs_mss_open(struct inode *inode, struct file *file)
 
 	file->private_data = i->i_ctx;
 
-	spin_lock(&ctx->mapping_lock);
+	mutex_lock(&ctx->mapping_lock);
 	if (!i->i_openers++)
 		ctx->mss = inode->i_mapping;
-	spin_unlock(&ctx->mapping_lock);
+	mutex_unlock(&ctx->mapping_lock);
 	return nonseekable_open(inode, file);
 }
 
@@ -1168,10 +1168,10 @@ spufs_mss_release(struct inode *inode, struct file *file)
 	struct spufs_inode_info *i = SPUFS_I(inode);
 	struct spu_context *ctx = i->i_ctx;
 
-	spin_lock(&ctx->mapping_lock);
+	mutex_lock(&ctx->mapping_lock);
 	if (!--i->i_openers)
 		ctx->mss = NULL;
-	spin_unlock(&ctx->mapping_lock);
+	mutex_unlock(&ctx->mapping_lock);
 	return 0;
 }
 
@@ -1212,11 +1212,11 @@ static int spufs_psmap_open(struct inode *inode, struct file *file)
 	struct spufs_inode_info *i = SPUFS_I(inode);
 	struct spu_context *ctx = i->i_ctx;
 
-	spin_lock(&ctx->mapping_lock);
+	mutex_lock(&ctx->mapping_lock);
 	file->private_data = i->i_ctx;
 	if (!i->i_openers++)
 		ctx->psmap = inode->i_mapping;
-	spin_unlock(&ctx->mapping_lock);
+	mutex_unlock(&ctx->mapping_lock);
 	return nonseekable_open(inode, file);
 }
 
@@ -1226,10 +1226,10 @@ spufs_psmap_release(struct inode *inode, struct file *file)
 	struct spufs_inode_info *i = SPUFS_I(inode);
 	struct spu_context *ctx = i->i_ctx;
 
-	spin_lock(&ctx->mapping_lock);
+	mutex_lock(&ctx->mapping_lock);
 	if (!--i->i_openers)
 		ctx->psmap = NULL;
-	spin_unlock(&ctx->mapping_lock);
+	mutex_unlock(&ctx->mapping_lock);
 	return 0;
 }
 
@@ -1282,11 +1282,11 @@ static int spufs_mfc_open(struct inode *inode, struct file *file)
 	if (atomic_read(&inode->i_count) != 1)
 		return -EBUSY;
 
-	spin_lock(&ctx->mapping_lock);
+	mutex_lock(&ctx->mapping_lock);
 	file->private_data = ctx;
 	if (!i->i_openers++)
 		ctx->mfc = inode->i_mapping;
-	spin_unlock(&ctx->mapping_lock);
+	mutex_unlock(&ctx->mapping_lock);
 	return nonseekable_open(inode, file);
 }
 
@@ -1296,10 +1296,10 @@ spufs_mfc_release(struct inode *inode, struct file *file)
 	struct spufs_inode_info *i = SPUFS_I(inode);
 	struct spu_context *ctx = i->i_ctx;
 
-	spin_lock(&ctx->mapping_lock);
+	mutex_lock(&ctx->mapping_lock);
 	if (!--i->i_openers)
 		ctx->mfc = NULL;
-	spin_unlock(&ctx->mapping_lock);
+	mutex_unlock(&ctx->mapping_lock);
 	return 0;
 }
 
diff --git a/arch/powerpc/platforms/cell/spufs/spufs.h b/arch/powerpc/platforms/cell/spufs/spufs.h
index 0a947fd..47617e8 100644
--- a/arch/powerpc/platforms/cell/spufs/spufs.h
+++ b/arch/powerpc/platforms/cell/spufs/spufs.h
@@ -55,7 +55,7 @@ struct spu_context {
 	struct address_space *signal2;	   /* 'signal2' area mappings. */
 	struct address_space *mss;	   /* 'mss' area mappings. */
 	struct address_space *psmap;	   /* 'psmap' area mappings. */
-	spinlock_t mapping_lock;
+	struct mutex mapping_lock;
 	u64 object_id;		   /* user space pointer for oprofile */
 
 	enum { SPU_STATE_RUNNABLE, SPU_STATE_SAVED } state;
-- 
1.5.0.rc4.g85b1
