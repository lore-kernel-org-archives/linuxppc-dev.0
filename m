Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 406821A004C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 21:57:48 +1100 (AEDT)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Tue, 24 Nov 2015 16:27:45 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 4A26F1258059
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 16:27:55 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAOAvO0E62914786
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 16:27:25 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAOAvNnP008646
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 16:27:23 +0530
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: imunsie@au1.ibm.com, "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 Frank Haverkamp <HAVERKAM@de.ibm.com>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Subject: [PATCH] cxl: Fix DSI misses when the context owning task exits
Date: Tue, 24 Nov 2015 16:26:18 +0530
Message-Id: <1448362578-32456-1-git-send-email-vaibhav@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Presently when a user-space process issues CXL_IOCTL_START_WORK ioctl we
store the pid of the current task_struct and use it to get pointer to
the mm_struct of the process, while processing page or segment faults
from the capi card. However this causes issues when the thread that had
originally issued the start-work ioctl exits in which case the stored
pid is no more valid and the cxl driver is unable to handle faults as
the mm_struct corresponding to process is no more accessible.

This patch fixes this issue by using the mm_struct of the next alive
task in the thread group. This is done by iterating over all the tasks
in the thread group starting from thread group leader and calling
get_task_mm on each one of them. When a valid mm_struct is obtained the
pid of the associated task is stored in the context replacing the
exiting one for handling future faults.

The patch introduces a new function named get_mem_context that checks if
the current task pointed to by ctx->pid is dead? If yes it performs the
steps described above. Also a new variable cxl_context.glpid is
introduced which stores the pid of the thread group leader associated
with the context owning task.

Reported-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
Reported-by: Frank Haverkamp <HAVERKAM@de.ibm.com>
Suggested-by: Ian Munsie <imunsie@au1.ibm.com>
Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
---
 drivers/misc/cxl/api.c     |   2 +-
 drivers/misc/cxl/context.c |   6 ++-
 drivers/misc/cxl/cxl.h     |   3 ++
 drivers/misc/cxl/fault.c   | 129 +++++++++++++++++++++++++++++++++------------
 drivers/misc/cxl/file.c    |   6 ++-
 5 files changed, 109 insertions(+), 37 deletions(-)

diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
index 103baf0..befac57 100644
--- a/drivers/misc/cxl/api.c
+++ b/drivers/misc/cxl/api.c
@@ -176,7 +176,7 @@ int cxl_start_context(struct cxl_context *ctx, u64 wed,
 
 	if (task) {
 		ctx->pid = get_task_pid(task, PIDTYPE_PID);
-		get_pid(ctx->pid);
+		ctx->glpid = get_task_pid(task->group_leader, PIDTYPE_PID);
 		kernel = false;
 	}
 
diff --git a/drivers/misc/cxl/context.c b/drivers/misc/cxl/context.c
index 2faa127..7b37ad9 100644
--- a/drivers/misc/cxl/context.c
+++ b/drivers/misc/cxl/context.c
@@ -42,7 +42,7 @@ int cxl_context_init(struct cxl_context *ctx, struct cxl_afu *afu, bool master,
 	spin_lock_init(&ctx->sste_lock);
 	ctx->afu = afu;
 	ctx->master = master;
-	ctx->pid = NULL; /* Set in start work ioctl */
+	ctx->pid = ctx->glpid = NULL; /* Set in start work ioctl */
 	mutex_init(&ctx->mapping_lock);
 	ctx->mapping = mapping;
 
@@ -211,7 +211,11 @@ int __detach_context(struct cxl_context *ctx)
 	WARN_ON(cxl_detach_process(ctx) &&
 		cxl_adapter_link_ok(ctx->afu->adapter));
 	flush_work(&ctx->fault_work); /* Only needed for dedicated process */
+
+	/* release the reference to the group leader and mm handling pid */
 	put_pid(ctx->pid);
+	put_pid(ctx->glpid);
+
 	cxl_ctx_put();
 	return 0;
 }
diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index 0cfb9c1..a312cd4 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -433,6 +433,9 @@ struct cxl_context {
 	unsigned int sst_size, sst_lru;
 
 	wait_queue_head_t wq;
+	/* pid of the group leader associated with the pid */
+	struct pid *glpid;
+	/* use mm context associated with this pid for ds faults */
 	struct pid *pid;
 	spinlock_t lock; /* Protects pending_irq_mask, pending_fault and fault_addr */
 	/* Only used in PR mode */
diff --git a/drivers/misc/cxl/fault.c b/drivers/misc/cxl/fault.c
index 25a5418..81c3f75 100644
--- a/drivers/misc/cxl/fault.c
+++ b/drivers/misc/cxl/fault.c
@@ -166,13 +166,92 @@ static void cxl_handle_page_fault(struct cxl_context *ctx,
 	cxl_ack_irq(ctx, CXL_PSL_TFC_An_R, 0);
 }
 
+/*
+ * Returns the mm_struct corresponding to the context ctx via ctx->pid
+ * In case the task has exited we use the task group leader accessible
+ * via ctx->glpid to find the next task in the thread group that has a
+ * valid  mm_struct associated with it. If a task with valid mm_struct
+ * is found the ctx->pid is updated to use the task struct for subsequent
+ * translations. In case no valid mm_struct is found in the task group to
+ * service the fault a NULL is returned.
+ */
+static struct mm_struct *get_mem_context(struct cxl_context *ctx)
+{
+	struct task_struct *task = NULL;
+	struct mm_struct *mm = NULL;
+	struct pid *old_pid = ctx->pid;
+
+	if (old_pid == NULL) {
+		pr_warn("%s: Invalid context for pe=%d\n",
+			 __func__, ctx->pe);
+		return NULL;
+	}
+
+	task = get_pid_task(old_pid, PIDTYPE_PID);
+
+	/*
+	 * pid_alive may look racy but this saves us from costly
+	 * get_task_mm when the task is a zombie. In worst case
+	 * we may think a task is alive, which is about to die
+	 * but get_task_mm will return NULL.
+	 */
+	if (task != NULL && pid_alive(task))
+		mm = get_task_mm(task);
+
+	/* release the task struct that was taken earlier */
+	if (task)
+		put_task_struct(task);
+	else
+		pr_devel("%s: Context owning pid=%i for pe=%i dead\n",
+			__func__, pid_nr(old_pid), ctx->pe);
+
+	/*
+	 * If we couldn't find the mm context then use the group
+	 * leader to iterate over the task group and find a task
+	 * that gives us mm_struct.
+	 */
+	if (unlikely(mm == NULL && ctx->glpid != NULL)) {
+
+		rcu_read_lock();
+		task = pid_task(ctx->glpid, PIDTYPE_PID);
+		if (task)
+			do {
+				mm = get_task_mm(task);
+				if (mm) {
+					ctx->pid = get_task_pid(task,
+								PIDTYPE_PID);
+					break;
+				}
+				task = next_thread(task);
+			} while (task && !thread_group_leader(task));
+		rcu_read_unlock();
+
+		/* check if we switched pid */
+		if (ctx->pid != old_pid) {
+			if (mm)
+				pr_devel("%s:pe=%i switch pid %i->%i\n",
+					 __func__, ctx->pe, pid_nr(old_pid),
+					 pid_nr(ctx->pid));
+			else
+				pr_devel("%s:Cannot find mm for pid=%i\n",
+					 __func__, pid_nr(old_pid));
+
+			/* drop the reference to older pid */
+			put_pid(old_pid);
+		}
+	}
+
+	return mm;
+}
+
+
+
 void cxl_handle_fault(struct work_struct *fault_work)
 {
 	struct cxl_context *ctx =
 		container_of(fault_work, struct cxl_context, fault_work);
 	u64 dsisr = ctx->dsisr;
 	u64 dar = ctx->dar;
-	struct task_struct *task = NULL;
 	struct mm_struct *mm = NULL;
 
 	if (cxl_p2n_read(ctx->afu, CXL_PSL_DSISR_An) != dsisr ||
@@ -195,17 +274,17 @@ void cxl_handle_fault(struct work_struct *fault_work)
 		"DSISR: %#llx DAR: %#llx\n", ctx->pe, dsisr, dar);
 
 	if (!ctx->kernel) {
-		if (!(task = get_pid_task(ctx->pid, PIDTYPE_PID))) {
-			pr_devel("cxl_handle_fault unable to get task %i\n",
-				 pid_nr(ctx->pid));
+
+		mm = get_mem_context(ctx);
+		/* indicates all the thread in task group have exited */
+		if (mm == NULL) {
+			pr_devel("%s: unable to get mm for pe=%d pid=%i\n",
+				 __func__, ctx->pe, pid_nr(ctx->pid));
 			cxl_ack_ae(ctx);
 			return;
-		}
-		if (!(mm = get_task_mm(task))) {
-			pr_devel("cxl_handle_fault unable to get mm %i\n",
-				 pid_nr(ctx->pid));
-			cxl_ack_ae(ctx);
-			goto out;
+		} else {
+			pr_devel("Handling page fault for pe=%d pid=%i\n",
+				 ctx->pe, pid_nr(ctx->pid));
 		}
 	}
 
@@ -218,33 +297,22 @@ void cxl_handle_fault(struct work_struct *fault_work)
 
 	if (mm)
 		mmput(mm);
-out:
-	if (task)
-		put_task_struct(task);
 }
 
 static void cxl_prefault_one(struct cxl_context *ctx, u64 ea)
 {
-	int rc;
-	struct task_struct *task;
 	struct mm_struct *mm;
 
-	if (!(task = get_pid_task(ctx->pid, PIDTYPE_PID))) {
-		pr_devel("cxl_prefault_one unable to get task %i\n",
-			 pid_nr(ctx->pid));
-		return;
-	}
-	if (!(mm = get_task_mm(task))) {
+	mm = get_mem_context(ctx);
+	if (mm == NULL) {
 		pr_devel("cxl_prefault_one unable to get mm %i\n",
 			 pid_nr(ctx->pid));
-		put_task_struct(task);
 		return;
 	}
 
-	rc = cxl_fault_segment(ctx, mm, ea);
+	cxl_fault_segment(ctx, mm, ea);
 
 	mmput(mm);
-	put_task_struct(task);
 }
 
 static u64 next_segment(u64 ea, u64 vsid)
@@ -263,18 +331,13 @@ static void cxl_prefault_vma(struct cxl_context *ctx)
 	struct copro_slb slb;
 	struct vm_area_struct *vma;
 	int rc;
-	struct task_struct *task;
 	struct mm_struct *mm;
 
-	if (!(task = get_pid_task(ctx->pid, PIDTYPE_PID))) {
-		pr_devel("cxl_prefault_vma unable to get task %i\n",
-			 pid_nr(ctx->pid));
-		return;
-	}
-	if (!(mm = get_task_mm(task))) {
+	mm = get_mem_context(ctx);
+	if (mm == NULL) {
 		pr_devel("cxl_prefault_vm unable to get mm %i\n",
 			 pid_nr(ctx->pid));
-		goto out1;
+		return;
 	}
 
 	down_read(&mm->mmap_sem);
@@ -295,8 +358,6 @@ static void cxl_prefault_vma(struct cxl_context *ctx)
 	up_read(&mm->mmap_sem);
 
 	mmput(mm);
-out1:
-	put_task_struct(task);
 }
 
 void cxl_prefault(struct cxl_context *ctx, u64 wed)
diff --git a/drivers/misc/cxl/file.c b/drivers/misc/cxl/file.c
index 7ccd299..7305104 100644
--- a/drivers/misc/cxl/file.c
+++ b/drivers/misc/cxl/file.c
@@ -198,8 +198,12 @@ static long afu_ioctl_start_work(struct cxl_context *ctx,
 	 * where a process (master, some daemon, etc) has opened the chardev on
 	 * behalf of another process, so the AFU's mm gets bound to the process
 	 * that performs this ioctl and not the process that opened the file.
+	 * Also we grab the PID of the group leader so that if the task that
+	 * has performed the attach operation exits the mm context of the
+	 * process is still accessible.
 	 */
-	ctx->pid = get_pid(get_task_pid(current, PIDTYPE_PID));
+	ctx->pid = get_task_pid(current, PIDTYPE_PID);
+	ctx->glpid = get_task_pid(current->group_leader, PIDTYPE_PID);
 
 	trace_cxl_attach(ctx, work.work_element_descriptor, work.num_interrupts, amr);
 
-- 
2.2.1
