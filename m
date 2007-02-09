Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>,
	<cbe-oss-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 09 Feb 2007 15:58:43 +1100
Subject: [PATCH 2/2] spufs: Fix bitrot of the SPU mmap facility
In-Reply-To: <1170997122.766016.961490108548.qpush@grosgo>
Message-Id: <20070209045848.6304FDDE37@ozlabs.org>
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It looks like we've had some serious bitrot there mostly due to tracking
of address_space's of mmap'ed files getting out of sync with the actual
mmap code. The mfc, mss and psmap were not tracked properly and thus
not invalidated on context switches (oops !)

Note that I kept the various file->f_mapping = inode->i_mapping;
assignments that were done in the other open() routines though it's
unclear to me wether those are really necessary as I think the generic
open code already does that but then, I'm not that familiar with
filesystem foo. Another improvement we might want to do is assign
those to the varioux ctx-> fields at mmap time instead of file open/close
time.

I also added some smp_wmb's after assigning the ctx-> fields to make sure
they are visible to other CPUs. I don't think this is really necessary as
I suspect locking in the fs layer will make that happen anyway but better
safe than sorry.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

 arch/powerpc/platforms/cell/spufs/context.c |   12 ++++++++----
 arch/powerpc/platforms/cell/spufs/file.c    |   15 +++++++++++++++
 arch/powerpc/platforms/cell/spufs/spufs.h   |    2 ++
 3 files changed, 25 insertions(+), 4 deletions(-)

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
+++ linux-cell/arch/powerpc/platforms/cell/spufs/file.c	2007-02-09 15:53:54.000000000 +1100
@@ -47,6 +47,7 @@ spufs_mem_open(struct inode *inode, stru
 	file->private_data = ctx;
 	file->f_mapping = inode->i_mapping;
 	ctx->local_store = inode->i_mapping;
+	smp_wmb();
 	return 0;
 }
 
@@ -234,6 +235,7 @@ static int spufs_cntl_open(struct inode 
 	file->private_data = ctx;
 	file->f_mapping = inode->i_mapping;
 	ctx->cntl = inode->i_mapping;
+	smp_wmb();
 	return simple_attr_open(inode, file, spufs_cntl_get,
 					spufs_cntl_set, "0x%08lx");
 }
@@ -719,6 +721,7 @@ static int spufs_signal1_open(struct ino
 	file->private_data = ctx;
 	file->f_mapping = inode->i_mapping;
 	ctx->signal1 = inode->i_mapping;
+	smp_wmb();
 	return nonseekable_open(inode, file);
 }
 
@@ -826,6 +829,7 @@ static int spufs_signal2_open(struct ino
 	file->private_data = ctx;
 	file->f_mapping = inode->i_mapping;
 	ctx->signal2 = inode->i_mapping;
+	smp_wmb();
 	return nonseekable_open(inode, file);
 }
 
@@ -1021,8 +1025,12 @@ static int spufs_mss_mmap(struct file *f
 static int spufs_mss_open(struct inode *inode, struct file *file)
 {
 	struct spufs_inode_info *i = SPUFS_I(inode);
+	struct spu_context *ctx = i->i_ctx;
 
 	file->private_data = i->i_ctx;
+	file->f_mapping = inode->i_mapping;
+	ctx->mss = inode->i_mapping;
+	smp_wmb();
 	return nonseekable_open(inode, file);
 }
 
@@ -1060,8 +1068,12 @@ static int spufs_psmap_mmap(struct file 
 static int spufs_psmap_open(struct inode *inode, struct file *file)
 {
 	struct spufs_inode_info *i = SPUFS_I(inode);
+	struct spu_context *ctx = i->i_ctx;
 
 	file->private_data = i->i_ctx;
+	file->f_mapping = inode->i_mapping;
+	ctx->psmap = inode->i_mapping;
+	smp_wmb();
 	return nonseekable_open(inode, file);
 }
 
@@ -1114,6 +1126,9 @@ static int spufs_mfc_open(struct inode *
 		return -EBUSY;
 
 	file->private_data = ctx;
+	file->f_mapping = inode->i_mapping;
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
