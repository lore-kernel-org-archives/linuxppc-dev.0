Return-Path: <jk@ozlabs.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH 1/4] spufs: fix state_mutex leaks
Message-Id: <1202446241.800976.527038701148.1.gpush@pokey>
In-Reply-To: <1202446241.799868.442184577655.0.gpush@pokey>
To: Paul Mackerras <paulus@samba.org>
From: Jeremy Kerr <jk@ozlabs.org>
Date: Fri, 08 Feb 2008 15:50:41 +1100
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

Fix various state_mutex leaks. The worst one was introduced by the
interrutible state_mutex conversion but there've been a few before
too. Notably spufs_wait now returns without the state_mutex held
when returning an error, which actually cleans up some code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Luke Browning <lukebrowning@us.ibm.com>
Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

---
 arch/powerpc/platforms/cell/spufs/fault.c |   12 ++-----
 arch/powerpc/platforms/cell/spufs/file.c  |   49 +++++++++++++++++-------------
 arch/powerpc/platforms/cell/spufs/run.c   |    9 ++++-
 arch/powerpc/platforms/cell/spufs/spufs.h |    5 ++-
 4 files changed, 45 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/fault.c b/arch/powerpc/platforms/cell/spufs/fault.c
index eff4d29..e46d300 100644
--- a/arch/powerpc/platforms/cell/spufs/fault.c
+++ b/arch/powerpc/platforms/cell/spufs/fault.c
@@ -108,7 +108,7 @@ int spufs_handle_class1(struct spu_context *ctx)
 	u64 ea, dsisr, access;
 	unsigned long flags;
 	unsigned flt = 0;
-	int ret, ret2;
+	int ret;
 
 	/*
 	 * dar and dsisr get passed from the registers
@@ -148,13 +148,10 @@ int spufs_handle_class1(struct spu_context *ctx)
 		ret = spu_handle_mm_fault(current->mm, ea, dsisr, &flt);
 
 	/*
-	 * If spu_acquire fails due to a pending signal we just want to return
-	 * EINTR to userspace even if that means missing the dma restart or
-	 * updating the page fault statistics.
+	 * This is nasty: we need the state_mutex for all the bookkeeping even
+	 * if the syscall was interrupted by a signal. ewww.
 	 */
-	ret2 = spu_acquire(ctx);
-	if (ret2)
-		goto out;
+	mutex_lock(&ctx->state_mutex);
 
 	/*
 	 * Clear dsisr under ctxt lock after handling the fault, so that
@@ -185,7 +182,6 @@ int spufs_handle_class1(struct spu_context *ctx)
 	} else
 		spufs_handle_event(ctx, ea, SPE_EVENT_SPE_DATA_STORAGE);
 
- out:
 	spuctx_switch_state(ctx, SPU_UTIL_SYSTEM);
 	return ret;
 }
diff --git a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/platforms/cell/spufs/file.c
index 1018acd..e4ab9d5 100644
--- a/arch/powerpc/platforms/cell/spufs/file.c
+++ b/arch/powerpc/platforms/cell/spufs/file.c
@@ -358,6 +358,7 @@ static unsigned long spufs_ps_nopfn(struct vm_area_struct *vma,
 {
 	struct spu_context *ctx = vma->vm_file->private_data;
 	unsigned long area, offset = address - vma->vm_start;
+	int ret = 0;
 
 	spu_context_nospu_trace(spufs_ps_nopfn__enter, ctx);
 
@@ -379,7 +380,7 @@ static unsigned long spufs_ps_nopfn(struct vm_area_struct *vma,
 	if (ctx->state == SPU_STATE_SAVED) {
 		up_read(&current->mm->mmap_sem);
 		spu_context_nospu_trace(spufs_ps_nopfn__sleep, ctx);
-		spufs_wait(ctx->run_wq, ctx->state == SPU_STATE_RUNNABLE);
+		ret = spufs_wait(ctx->run_wq, ctx->state == SPU_STATE_RUNNABLE);
 		spu_context_trace(spufs_ps_nopfn__wake, ctx, ctx->spu);
 		down_read(&current->mm->mmap_sem);
 	} else {
@@ -388,7 +389,8 @@ static unsigned long spufs_ps_nopfn(struct vm_area_struct *vma,
 		spu_context_trace(spufs_ps_nopfn__insert, ctx, ctx->spu);
 	}
 
-	spu_release(ctx);
+	if (!ret)
+		spu_release(ctx);
 	return NOPFN_REFAULT;
 }
 
@@ -755,23 +757,25 @@ static ssize_t spufs_ibox_read(struct file *file, char __user *buf,
 
 	count = spu_acquire(ctx);
 	if (count)
-		return count;
+		goto out;
 
 	/* wait only for the first element */
 	count = 0;
 	if (file->f_flags & O_NONBLOCK) {
-		if (!spu_ibox_read(ctx, &ibox_data))
+		if (!spu_ibox_read(ctx, &ibox_data)) {
 			count = -EAGAIN;
+			goto out_unlock;
+		}
 	} else {
 		count = spufs_wait(ctx->ibox_wq, spu_ibox_read(ctx, &ibox_data));
+		if (count)
+			goto out;
 	}
-	if (count)
-		goto out;
 
 	/* if we can't write at all, return -EFAULT */
 	count = __put_user(ibox_data, udata);
 	if (count)
-		goto out;
+		goto out_unlock;
 
 	for (count = 4, udata++; (count + 4) <= len; count += 4, udata++) {
 		int ret;
@@ -788,9 +792,9 @@ static ssize_t spufs_ibox_read(struct file *file, char __user *buf,
 			break;
 	}
 
-out:
+out_unlock:
 	spu_release(ctx);
-
+out:
 	return count;
 }
 
@@ -905,7 +909,7 @@ static ssize_t spufs_wbox_write(struct file *file, const char __user *buf,
 
 	count = spu_acquire(ctx);
 	if (count)
-		return count;
+		goto out;
 
 	/*
 	 * make sure we can at least write one element, by waiting
@@ -913,14 +917,16 @@ static ssize_t spufs_wbox_write(struct file *file, const char __user *buf,
 	 */
 	count = 0;
 	if (file->f_flags & O_NONBLOCK) {
-		if (!spu_wbox_write(ctx, wbox_data))
+		if (!spu_wbox_write(ctx, wbox_data)) {
 			count = -EAGAIN;
+			goto out_unlock;
+		}
 	} else {
 		count = spufs_wait(ctx->wbox_wq, spu_wbox_write(ctx, wbox_data));
+		if (count)
+			goto out;
 	}
 
-	if (count)
-		goto out;
 
 	/* write as much as possible */
 	for (count = 4, udata++; (count + 4) <= len; count += 4, udata++) {
@@ -934,8 +940,9 @@ static ssize_t spufs_wbox_write(struct file *file, const char __user *buf,
 			break;
 	}
 
-out:
+out_unlock:
 	spu_release(ctx);
+out:
 	return count;
 }
 
@@ -1598,12 +1605,11 @@ static ssize_t spufs_mfc_read(struct file *file, char __user *buffer,
 	} else {
 		ret = spufs_wait(ctx->mfc_wq,
 			   spufs_read_mfc_tagstatus(ctx, &status));
+		if (ret)
+			goto out;
 	}
 	spu_release(ctx);
 
-	if (ret)
-		goto out;
-
 	ret = 4;
 	if (copy_to_user(buffer, &status, 4))
 		ret = -EFAULT;
@@ -1732,6 +1738,8 @@ static ssize_t spufs_mfc_write(struct file *file, const char __user *buffer,
 		int status;
 		ret = spufs_wait(ctx->mfc_wq,
 				 spu_send_mfc_command(ctx, cmd, &status));
+		if (ret)
+			goto out;
 		if (status)
 			ret = status;
 	}
@@ -1785,7 +1793,7 @@ static int spufs_mfc_flush(struct file *file, fl_owner_t id)
 
 	ret = spu_acquire(ctx);
 	if (ret)
-		return ret;
+		goto out;
 #if 0
 /* this currently hangs */
 	ret = spufs_wait(ctx->mfc_wq,
@@ -1794,12 +1802,13 @@ static int spufs_mfc_flush(struct file *file, fl_owner_t id)
 		goto out;
 	ret = spufs_wait(ctx->mfc_wq,
 			 ctx->ops->read_mfc_tagstatus(ctx) == ctx->tagwait);
-out:
+	if (ret)
+		goto out;
 #else
 	ret = 0;
 #endif
 	spu_release(ctx);
-
+out:
 	return ret;
 }
 
diff --git a/arch/powerpc/platforms/cell/spufs/run.c b/arch/powerpc/platforms/cell/spufs/run.c
index b4814c7..e9c61a1 100644
--- a/arch/powerpc/platforms/cell/spufs/run.c
+++ b/arch/powerpc/platforms/cell/spufs/run.c
@@ -354,8 +354,15 @@ long spufs_run_spu(struct spu_context *ctx, u32 *npc, u32 *event)
 
 	do {
 		ret = spufs_wait(ctx->stop_wq, spu_stopped(ctx, &status));
-		if (unlikely(ret))
+		if (unlikely(ret)) {
+			/*
+			 * This is nasty: we need the state_mutex for all the
+			 * bookkeeping even if the syscall was interrupted by
+			 * a signal. ewww.
+			 */
+			mutex_lock(&ctx->state_mutex);
 			break;
+		}
 		spu = ctx->spu;
 		if (unlikely(test_and_clear_bit(SPU_SCHED_NOTIFY_ACTIVE,
 						&ctx->sched_flags))) {
diff --git a/arch/powerpc/platforms/cell/spufs/spufs.h b/arch/powerpc/platforms/cell/spufs/spufs.h
index 795a1b5..2c2fe3c 100644
--- a/arch/powerpc/platforms/cell/spufs/spufs.h
+++ b/arch/powerpc/platforms/cell/spufs/spufs.h
@@ -268,6 +268,9 @@ extern char *isolated_loader;
  *	Same as wait_event_interruptible(), except that here
  *	we need to call spu_release(ctx) before sleeping, and
  *	then spu_acquire(ctx) when awoken.
+ *
+ * 	Returns with state_mutex re-acquired when successfull or
+ * 	with -ERESTARTSYS and the state_mutex dropped when interrupted.
  */
 
 #define spufs_wait(wq, condition)					\
@@ -278,11 +281,11 @@ extern char *isolated_loader;
 		prepare_to_wait(&(wq), &__wait, TASK_INTERRUPTIBLE);	\
 		if (condition)						\
 			break;						\
+		spu_release(ctx);					\
 		if (signal_pending(current)) {				\
 			__ret = -ERESTARTSYS;				\
 			break;						\
 		}							\
-		spu_release(ctx);					\
 		schedule();						\
 		__ret = spu_acquire(ctx);				\
 		if (__ret)						\
