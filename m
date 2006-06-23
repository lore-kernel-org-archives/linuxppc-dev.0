Return-Path: <arnd.bergmann@de.ibm.com>
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
To: cbe-oss-dev@ozlabs.org
Subject: [RFC] implement error event delivery to user space
Date: Fri, 23 Jun 2006 21:12:58 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200606232112.58558.arnd.bergmann@de.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Christoph Hellwig <hch@infradead.org>

This tries to fix spufs so we have an interface closer
to what is specified in the man page for events
returned in the third argument of spu_run.

Fortunately, libspe has never been using the returned
contents of that register, as they were the same
as the return code of spu_run (duh!).

This returns what we need from libspe, but only
when a flag was set on spu_create. Now that flag
was previously not documented, so we're actually
extending the semantics here.

One big question that keeps nagging me is whether
we want to actually allow a thread to run on after
it has hit a critical error like invalid DMA addresses
or illegal opcodes. I can't really think of an example
where we would want to do that, so I tend to go down
the easy route of not supporting that, but there may
be scenarios that I haven't thought of.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: linus-2.6/arch/powerpc/platforms/cell/spu_base.c
===================================================================
--- linus-2.6.orig/arch/powerpc/platforms/cell/spu_base.c
+++ linus-2.6/arch/powerpc/platforms/cell/spu_base.c
@@ -46,21 +46,21 @@ EXPORT_SYMBOL_GPL(spu_priv1_ops);
 static int __spu_trap_invalid_dma(struct spu *spu)
 {
 	pr_debug("%s\n", __FUNCTION__);
-	force_sig(SIGBUS, /* info, */ current);
+	spu->dma_callback(spu, SPE_EVENT_INVALID_DMA);
 	return 0;
 }
 
 static int __spu_trap_dma_align(struct spu *spu)
 {
 	pr_debug("%s\n", __FUNCTION__);
-	force_sig(SIGBUS, /* info, */ current);
+	spu->dma_callback(spu, SPE_EVENT_DMA_ALIGNMENT);
 	return 0;
 }
 
 static int __spu_trap_error(struct spu *spu)
 {
 	pr_debug("%s\n", __FUNCTION__);
-	force_sig(SIGILL, /* info, */ current);
+	spu->dma_callback(spu, SPE_EVENT_SPE_ERROR);
 	return 0;
 }
 
Index: linus-2.6/arch/powerpc/platforms/cell/spufs/inode.c
===================================================================
--- linus-2.6.orig/arch/powerpc/platforms/cell/spufs/inode.c
+++ linus-2.6/arch/powerpc/platforms/cell/spufs/inode.c
@@ -225,7 +225,8 @@ struct file_operations spufs_context_fop
 };
 
 static int
-spufs_mkdir(struct inode *dir, struct dentry *dentry, int mode)
+spufs_mkdir(struct inode *dir, struct dentry *dentry, unsigned int flags,
+		int mode)
 {
 	int ret;
 	struct inode *inode;
@@ -245,6 +246,8 @@ spufs_mkdir(struct inode *dir, struct de
 	if (!ctx)
 		goto out_iput;
 
+	ctx->flags = flags;
+
 	inode->i_op = &spufs_dir_inode_operations;
 	inode->i_fop = &simple_dir_operations;
 	ret = spufs_fill_dir(dentry, spufs_dir_contents, mode, ctx);
@@ -305,7 +308,7 @@ long spufs_create_thread(struct nameidat
 		goto out;
 
 	/* all flags are reserved */
-	if (flags)
+	if (flags & (~SPU_CREATE_FLAG_ALL))
 		goto out;
 
 	dentry = lookup_create(nd, 1);
@@ -318,7 +321,7 @@ long spufs_create_thread(struct nameidat
 		goto out_dput;
 
 	mode &= ~current->fs->umask;
-	ret = spufs_mkdir(nd->dentry->d_inode, dentry, mode & S_IRWXUGO);
+	ret = spufs_mkdir(nd->dentry->d_inode, dentry, flags, mode & S_IRWXUGO);
 	if (ret)
 		goto out_dput;
 
Index: linus-2.6/arch/powerpc/platforms/cell/spufs/run.c
===================================================================
--- linus-2.6.orig/arch/powerpc/platforms/cell/spufs/run.c
+++ linus-2.6/arch/powerpc/platforms/cell/spufs/run.c
@@ -14,6 +14,26 @@ void spufs_stop_callback(struct spu *spu
 	wake_up_all(&ctx->stop_wq);
 }
 
+void spufs_dma_callback(struct spu *spu, int type)
+{
+	struct spu_context *ctx = spu->ctx;
+
+	if (ctx->flags & SPU_CREATE_EVENTS_ENABLED) {
+		ctx->event_return |= type;
+		wake_up_all(&ctx->stop_wq);
+	} else {
+		switch (type) {
+		case SPE_EVENT_DMA_ALIGNMENT:
+		case SPE_EVENT_INVALID_DMA:
+			force_sig(SIGBUS, /* info, */ current);
+			break;
+		case SPE_EVENT_SPE_ERROR:
+			force_sig(SIGILL, /* info */ current);
+			break;
+		}
+	}
+}
+
 static inline int spu_stopped(struct spu_context *ctx, u32 * stat)
 {
 	struct spu *spu;
@@ -28,8 +48,7 @@ static inline int spu_stopped(struct spu
 	return (!(*stat & 0x1) || pte_fault || spu->class_0_pending) ? 1 : 0;
 }
 
-static inline int spu_run_init(struct spu_context *ctx, u32 * npc,
-			       u32 * status)
+static inline int spu_run_init(struct spu_context *ctx, u32 * npc)
 {
 	int ret;
 
@@ -72,7 +91,7 @@ static inline int spu_reacquire_runnable
 		       SPU_STATUS_STOPPED_BY_HALT)) {
 		return *status;
 	}
-	if ((ret = spu_run_init(ctx, npc, status)) != 0)
+	if ((ret = spu_run_init(ctx, npc)) != 0)
 		return ret;
 	return 0;
 }
@@ -177,46 +196,49 @@ static inline int spu_process_events(str
 }
 
 long spufs_run_spu(struct file *file, struct spu_context *ctx,
-		   u32 * npc, u32 * status)
+		   u32 *npc, u32 *event)
 {
 	int ret;
+	u32 status;
 
 	if (down_interruptible(&ctx->run_sema))
 		return -ERESTARTSYS;
 
-	ret = spu_run_init(ctx, npc, status);
+	ctx->event_return = 0;
+	ret = spu_run_init(ctx, npc);
 	if (ret)
 		goto out;
 
 	do {
-		ret = spufs_wait(ctx->stop_wq, spu_stopped(ctx, status));
+		ret = spufs_wait(ctx->stop_wq, spu_stopped(ctx, &status));
 		if (unlikely(ret))
 			break;
-		if ((*status & SPU_STATUS_STOPPED_BY_STOP) &&
-		    (*status >> SPU_STOP_STATUS_SHIFT == 0x2104)) {
+		if ((status & SPU_STATUS_STOPPED_BY_STOP) &&
+		    (status >> SPU_STOP_STATUS_SHIFT == 0x2104)) {
 			ret = spu_process_callback(ctx);
 			if (ret)
 				break;
-			*status &= ~SPU_STATUS_STOPPED_BY_STOP;
+			status &= ~SPU_STATUS_STOPPED_BY_STOP;
 		}
 		if (unlikely(ctx->state != SPU_STATE_RUNNABLE)) {
-			ret = spu_reacquire_runnable(ctx, npc, status);
+			ret = spu_reacquire_runnable(ctx, npc, &status);
 			if (ret)
 				goto out;
 			continue;
 		}
 		ret = spu_process_events(ctx);
 
-	} while (!ret && !(*status & (SPU_STATUS_STOPPED_BY_STOP |
+	} while (!ret && !(status & (SPU_STATUS_STOPPED_BY_STOP |
 				      SPU_STATUS_STOPPED_BY_HALT)));
 
 	ctx->ops->runcntl_stop(ctx);
-	ret = spu_run_fini(ctx, npc, status);
+	ret = spu_run_fini(ctx, npc, &status);
 	if (!ret)
-		ret = *status;
+		ret = status;
 	spu_yield(ctx);
 
 out:
+	*event = ctx->event_return;
 	up(&ctx->run_sema);
 	return ret;
 }
Index: linus-2.6/arch/powerpc/platforms/cell/spufs/sched.c
===================================================================
--- linus-2.6.orig/arch/powerpc/platforms/cell/spufs/sched.c
+++ linus-2.6/arch/powerpc/platforms/cell/spufs/sched.c
@@ -102,7 +102,6 @@ static inline void bind_context(struct s
 		 spu->number, spu->node);
 	spu->ctx = ctx;
 	spu->flags = 0;
-	ctx->flags = 0;
 	ctx->spu = spu;
 	ctx->ops = &spu_hw_ops;
 	spu->pid = current->pid;
@@ -113,6 +112,7 @@ static inline void bind_context(struct s
 	spu->wbox_callback = spufs_wbox_callback;
 	spu->stop_callback = spufs_stop_callback;
 	spu->mfc_callback = spufs_mfc_callback;
+	spu->dma_callback = spufs_dma_callback;
 	mb();
 	spu_unmap_mappings(ctx);
 	spu_restore(&ctx->csa, spu);
@@ -134,12 +134,12 @@ static inline void unbind_context(struct
 	spu->wbox_callback = NULL;
 	spu->stop_callback = NULL;
 	spu->mfc_callback = NULL;
+	spu->dma_callback = NULL;
 	spu->mm = NULL;
 	spu->pid = 0;
 	spu->prio = MAX_PRIO;
 	ctx->ops = &spu_backing_ops;
 	ctx->spu = NULL;
-	ctx->flags = 0;
 	spu->flags = 0;
 	spu->ctx = NULL;
 }
Index: linus-2.6/arch/powerpc/platforms/cell/spufs/spufs.h
===================================================================
--- linus-2.6.orig/arch/powerpc/platforms/cell/spufs/spufs.h
+++ linus-2.6/arch/powerpc/platforms/cell/spufs/spufs.h
@@ -67,7 +67,8 @@ struct spu_context {
 	u32 tagwait;
 	struct spu_context_ops *ops;
 	struct work_struct reap_work;
-	u64 flags;
+	unsigned long flags;
+	unsigned long event_return;
 };
 
 struct mfc_dma_command {
@@ -184,5 +185,6 @@ void spufs_ibox_callback(struct spu *spu
 void spufs_wbox_callback(struct spu *spu);
 void spufs_stop_callback(struct spu *spu);
 void spufs_mfc_callback(struct spu *spu);
+void spufs_dma_callback(struct spu *spu, int type);
 
 #endif
Index: linus-2.6/include/asm-powerpc/spu.h
===================================================================
--- linus-2.6.orig/include/asm-powerpc/spu.h
+++ linus-2.6/include/asm-powerpc/spu.h
@@ -138,6 +138,7 @@ struct spu {
 	void (* ibox_callback)(struct spu *spu);
 	void (* stop_callback)(struct spu *spu);
 	void (* mfc_callback)(struct spu *spu);
+	void (* dma_callback)(struct spu *spu, int type);
 
 	char irq_c0[8];
 	char irq_c1[8];
@@ -169,6 +170,19 @@ extern struct spufs_calls {
 	struct module *owner;
 } spufs_calls;
 
+/* return status from spu_run, same as in libspe */
+#define SPE_EVENT_DMA_ALIGNMENT		0x0008	/*A DMA alignment error */
+#define SPE_EVENT_SPE_ERROR		0x0010	/*An illegal instruction error*/
+#define SPE_EVENT_SPE_DATA_SEGMENT	0x0020	/*A DMA segmentation error    */
+#define SPE_EVENT_SPE_DATA_STORAGE	0x0040	/*A DMA storage error */
+#define SPE_EVENT_INVALID_DMA		0x0800	/* Invalid MFC DMA */
+
+/*
+ * Flags for sys_spu_create.
+ */
+#define SPU_CREATE_EVENTS_ENABLED	0x0001
+#define SPU_CREATE_FLAG_ALL		0x0001 /* mask of all valid flags */
+
 #ifdef CONFIG_SPU_FS_MODULE
 int register_spu_syscalls(struct spufs_calls *calls);
 void unregister_spu_syscalls(struct spufs_calls *calls);
Index: linus-2.6/arch/powerpc/platforms/cell/spufs/syscalls.c
===================================================================
--- linus-2.6.orig/arch/powerpc/platforms/cell/spufs/syscalls.c
+++ linus-2.6/arch/powerpc/platforms/cell/spufs/syscalls.c
@@ -38,7 +38,7 @@ static long do_spu_run(struct file *filp
 	u32 npc, status;
 
 	ret = -EFAULT;
-	if (get_user(npc, unpc) || get_user(status, ustatus))
+	if (get_user(npc, unpc))
 		goto out;
 
 	/* check if this file was created by spu_create */
@@ -49,7 +49,10 @@ static long do_spu_run(struct file *filp
 	i = SPUFS_I(filp->f_dentry->d_inode);
 	ret = spufs_run_spu(filp, i->i_ctx, &npc, &status);
 
-	if (put_user(npc, unpc) || put_user(status, ustatus))
+	if (put_user(npc, unpc))
+		ret = -EFAULT;
+
+	if (ustatus && put_user(status, ustatus))
 		ret = -EFAULT;
 out:
 	return ret;
