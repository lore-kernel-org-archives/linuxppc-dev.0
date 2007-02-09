Return-Path: <benh@kernel.crashing.org>
Subject: [PATCH] spufs: Fix bitrot of the SPU mmap facility (#2)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <20070209045848.6304FDDE37@ozlabs.org>
References: <20070209045848.6304FDDE37@ozlabs.org>
Content-Type: text/plain
Date: Fri, 09 Feb 2007 16:52:10 +1100
Message-Id: <1171000330.2620.425.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: cbe-oss-dev@ozlabs.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

spufs: Fix bitrot of the SPU mmap facility

It looks like we've had some serious bitrot there mostly due to tracking
of address_space's of mmap'ed files getting out of sync with the actual
mmap code. The mfc, mss and psmap were not tracked properly and thus
not invalidated on context switches (oops !)

I also removed the various file->f_mapping = inode->i_mapping;
assignments that were done in the other open() routines since that
is already done for us by __dentry_open.

One improvement we might want to do later is to assign the various
ctx-> fields at mmap time instead of file open/close time so that we
don't call unmap_mapping_range() on thing that have not been mmap'ed

Finally, I added some smp_wmb's after assigning the ctx-> fields to make
sure they are visible to other CPUs. I don't think this is really
necessary as I suspect locking in the fs layer will make that happen
anyway but better safe than sorry.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

New version of that patch removing the f_mapping assignment.

Index: linux-cell/arch/powerpc/platforms/cell/spufs/context.c
===================================================================
--- linux-cell.orig/arch/powerpc/platforms/cell/spufs/context.c	2007-02-09 15:47:28.000000000 +1100
+++ linux-cell/arch/powerpc/platforms/cell/spufs/context.c	2007-02-09 15:48:27.000000000 +1100
@@ -111,13 +111,17 @@ void spu_unmap_mappings(struct spu_conte
 	if (ctx->local_store)
 		unmap_mapping_range(ctx->local_store, 0, LS_SIZE, 1);
 	if (ctx->mfc)
-		unmap_mapping_range(ctx->mfc, 0, 0x4000, 1);
+		unmap_mapping_range(ctx->mfc, 0, 0x1000, 1);
 	if (ctx->cntl)
-		unmap_mapping_range(ctx->cntl, 0, 0x4000, 1);
+		unmap_mapping_range(ctx->cntl, 0, 0x1000, 1);
 	if (ctx->signal1)
-		unmap_mapping_range(ctx->signal1, 0, 0x4000, 1);
+		unmap_mapping_range(ctx->signal1, 0, PAGE_SIZE, 1);
 	if (ctx->signal2)
-		unmap_mapping_range(ctx->signal2, 0, 0x4000, 1);
+		unmap_mapping_range(ctx->signal2, 0, PAGE_SIZE, 1);
+	if (ctx->mss)
+		unmap_mapping_range(ctx->mss, 0, 0x1000, 1);
+	if (ctx->psmap)
+		unmap_mapping_range(ctx->psmap, 0, 0x20000, 1);
 }
 
 int spu_acquire_exclusive(struct spu_context *ctx)
Index: linux-cell/arch/powerpc/platforms/cell/spufs/file.c
===================================================================
--- linux-cell.orig/arch/powerpc/platforms/cell/spufs/file.c	2007-02-09 15:47:28.000000000 +1100
+++ linux-cell/arch/powerpc/platforms/cell/spufs/file.c	2007-02-09 16:29:33.000000000 +1100
@@ -45,8 +45,8 @@ spufs_mem_open(struct inode *inode, stru
 	struct spufs_inode_info *i = SPUFS_I(inode);
 	struct spu_context *ctx = i->i_ctx;
 	file->private_data = ctx;
-	file->f_mapping = inode->i_mapping;
 	ctx->local_store = inode->i_mapping;
+	smp_wmb();
 	return 0;
 }
 
@@ -232,8 +232,8 @@ static int spufs_cntl_open(struct inode 
 	struct spu_context *ctx = i->i_ctx;
 
 	file->private_data = ctx;
-	file->f_mapping = inode->i_mapping;
 	ctx->cntl = inode->i_mapping;
+	smp_wmb();
 	return simple_attr_open(inode, file, spufs_cntl_get,
 					spufs_cntl_set, "0x%08lx");
 }
@@ -717,8 +717,8 @@ static int spufs_signal1_open(struct ino
 	struct spufs_inode_info *i = SPUFS_I(inode);
 	struct spu_context *ctx = i->i_ctx;
 	file->private_data = ctx;
-	file->f_mapping = inode->i_mapping;
 	ctx->signal1 = inode->i_mapping;
+	smp_wmb();
 	return nonseekable_open(inode, file);
 }
 
@@ -824,8 +824,8 @@ static int spufs_signal2_open(struct ino
 	struct spufs_inode_info *i = SPUFS_I(inode);
 	struct spu_context *ctx = i->i_ctx;
 	file->private_data = ctx;
-	file->f_mapping = inode->i_mapping;
 	ctx->signal2 = inode->i_mapping;
+	smp_wmb();
 	return nonseekable_open(inode, file);
 }
 
@@ -1021,8 +1021,11 @@ static int spufs_mss_mmap(struct file *f
 static int spufs_mss_open(struct inode *inode, struct file *file)
 {
 	struct spufs_inode_info *i = SPUFS_I(inode);
+	struct spu_context *ctx = i->i_ctx;
 
 	file->private_data = i->i_ctx;
+	ctx->mss = inode->i_mapping;
+	smp_wmb();
 	return nonseekable_open(inode, file);
 }
 
@@ -1060,8 +1063,11 @@ static int spufs_psmap_mmap(struct file 
 static int spufs_psmap_open(struct inode *inode, struct file *file)
 {
 	struct spufs_inode_info *i = SPUFS_I(inode);
+	struct spu_context *ctx = i->i_ctx;
 
 	file->private_data = i->i_ctx;
+	ctx->psmap = inode->i_mapping;
+	smp_wmb();
 	return nonseekable_open(inode, file);
 }
 
@@ -1114,6 +1120,8 @@ static int spufs_mfc_open(struct inode *
 		return -EBUSY;
 
 	file->private_data = ctx;
+	ctx->mfc = inode->i_mapping;
+	smp_wmb();
 	return nonseekable_open(inode, file);
 }
 
Index: linux-cell/arch/powerpc/platforms/cell/spufs/spufs.h
===================================================================
--- linux-cell.orig/arch/powerpc/platforms/cell/spufs/spufs.h	2007-02-09 15:47:28.000000000 +1100
+++ linux-cell/arch/powerpc/platforms/cell/spufs/spufs.h	2007-02-09 15:48:15.000000000 +1100
@@ -51,6 +51,8 @@ struct spu_context {
 	struct address_space *cntl; 	   /* 'control' area mappings. */
 	struct address_space *signal1; 	   /* 'signal1' area mappings. */
 	struct address_space *signal2; 	   /* 'signal2' area mappings. */
+	struct address_space *mss; 	   /* 'mss' area mappings. */
+	struct address_space *psmap; 	   /* 'psmap' area mappings. */
 	u64 object_id;		   /* user space pointer for oprofile */
 
 	enum { SPU_STATE_RUNNABLE, SPU_STATE_SAVED } state;
