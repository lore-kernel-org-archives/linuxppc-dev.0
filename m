Return-Path: <clombard@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vD9Bz4wTZzDq9B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Feb 2017 04:30:51 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v11HT4iW135130
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Feb 2017 12:30:49 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28bhej09ea-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Feb 2017 12:30:49 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clombard@linux.vnet.ibm.com>;
 Wed, 1 Feb 2017 17:30:47 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 090CE1B0805F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2017 17:33:36 +0000 (GMT)
From: Christophe Lombard <clombard@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, fbarrat@linux.vnet.ibm.com,
 imunsie@au1.ibm.com, andrew.donnellan@au1.ibm.com
Subject: [PATCH 3/7] cxl: Keep track of mm struct associated with a context
Date: Wed,  1 Feb 2017 18:30:09 +0100
In-Reply-To: <1485970213-25532-1-git-send-email-clombard@linux.vnet.ibm.com>
References: <1485970213-25532-1-git-send-email-clombard@linux.vnet.ibm.com>
Message-Id: <1485970213-25532-4-git-send-email-clombard@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The mm_struct corresponding to the current task is acquired each time
an interrupt is raised. So to simplify the code, we only get the
mm_struct when attaching an AFU context to the process.
The mm_count reference is increased to ensure that the mm_struct can't
be freed. The mm_struct will be released when the context is detached.
The reference (use count) on the struct mm is not kept to avoid a
circular dependency if the process mmaps its cxl mmio and forget to
unmap before exiting.

Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
---
 drivers/misc/cxl/api.c     | 16 ++++++++--
 drivers/misc/cxl/context.c | 25 +++++++++++++--
 drivers/misc/cxl/cxl.h     | 13 ++++++--
 drivers/misc/cxl/fault.c   | 76 ++--------------------------------------------
 drivers/misc/cxl/file.c    | 14 +++++++--
 5 files changed, 61 insertions(+), 83 deletions(-)

diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
index 1b35e33..4b03433 100644
--- a/drivers/misc/cxl/api.c
+++ b/drivers/misc/cxl/api.c
@@ -322,19 +322,29 @@ int cxl_start_context(struct cxl_context *ctx, u64 wed,
 
 	if (task) {
 		ctx->pid = get_task_pid(task, PIDTYPE_PID);
-		ctx->glpid = get_task_pid(task->group_leader, PIDTYPE_PID);
 		kernel = false;
 		ctx->real_mode = false;
+
+		/* acquire a reference to the task's mm */
+		ctx->mm = get_task_mm(current);
+
+		/* ensure this mm_struct can't be freed */
+		cxl_context_mm_count_get(ctx);
+
+		/* decrement the use count */
+		if (ctx->mm)
+			mmput(ctx->mm);
 	}
 
 	cxl_ctx_get();
 
 	if ((rc = cxl_ops->attach_process(ctx, kernel, wed, 0))) {
-		put_pid(ctx->glpid);
 		put_pid(ctx->pid);
-		ctx->glpid = ctx->pid = NULL;
+		ctx->pid = NULL;
 		cxl_adapter_context_put(ctx->afu->adapter);
 		cxl_ctx_put();
+		if (task)
+			cxl_context_mm_count_put(ctx);
 		goto out;
 	}
 
diff --git a/drivers/misc/cxl/context.c b/drivers/misc/cxl/context.c
index 3907387..89242c1 100644
--- a/drivers/misc/cxl/context.c
+++ b/drivers/misc/cxl/context.c
@@ -41,7 +41,7 @@ int cxl_context_init(struct cxl_context *ctx, struct cxl_afu *afu, bool master)
 	spin_lock_init(&ctx->sste_lock);
 	ctx->afu = afu;
 	ctx->master = master;
-	ctx->pid = ctx->glpid = NULL; /* Set in start work ioctl */
+	ctx->pid = NULL; /* Set in start work ioctl */
 	mutex_init(&ctx->mapping_lock);
 	ctx->mapping = NULL;
 
@@ -241,12 +241,15 @@ int __detach_context(struct cxl_context *ctx)
 
 	/* release the reference to the group leader and mm handling pid */
 	put_pid(ctx->pid);
-	put_pid(ctx->glpid);
 
 	cxl_ctx_put();
 
 	/* Decrease the attached context count on the adapter */
 	cxl_adapter_context_put(ctx->afu->adapter);
+
+	/* Decrease the mm count on the context */
+	cxl_context_mm_count_put(ctx);
+
 	return 0;
 }
 
@@ -324,3 +327,21 @@ void cxl_context_free(struct cxl_context *ctx)
 	mutex_unlock(&ctx->afu->contexts_lock);
 	call_rcu(&ctx->rcu, reclaim_ctx);
 }
+
+void cxl_context_mm_count_get(struct cxl_context *ctx)
+{
+	if (ctx->mm)
+		atomic_inc(&ctx->mm->mm_count);
+}
+
+void cxl_context_mm_count_put(struct cxl_context *ctx)
+{
+	if (ctx->mm)
+		mmdrop(ctx->mm);
+}
+
+void cxl_context_mm_users_get(struct cxl_context *ctx)
+{
+	if (ctx->mm)
+		atomic_inc(&ctx->mm->mm_users);
+}
diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index b24d767..e53ce9d 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -479,8 +479,6 @@ struct cxl_context {
 	unsigned int sst_size, sst_lru;
 
 	wait_queue_head_t wq;
-	/* pid of the group leader associated with the pid */
-	struct pid *glpid;
 	/* use mm context associated with this pid for ds faults */
 	struct pid *pid;
 	spinlock_t lock; /* Protects pending_irq_mask, pending_fault and fault_addr */
@@ -548,6 +546,8 @@ struct cxl_context {
 	 * CX4 only:
 	 */
 	struct list_head extra_irq_contexts;
+
+	struct mm_struct *mm;
 };
 
 struct cxl_service_layer_ops {
@@ -970,4 +970,13 @@ int cxl_adapter_context_lock(struct cxl *adapter);
 /* Unlock the contexts-lock if taken. Warn and force unlock otherwise */
 void cxl_adapter_context_unlock(struct cxl *adapter);
 
+/* Increases the reference count to "struct mm_struct" */
+void cxl_context_mm_count_get(struct cxl_context *ctx);
+
+/* Decrements the reference count to "struct mm_struct" */
+void cxl_context_mm_count_put(struct cxl_context *ctx);
+
+/* Increases the reference users to "struct mm_struct" */
+void cxl_context_mm_users_get(struct cxl_context *ctx);
+
 #endif
diff --git a/drivers/misc/cxl/fault.c b/drivers/misc/cxl/fault.c
index 377e650..ece7ea3 100644
--- a/drivers/misc/cxl/fault.c
+++ b/drivers/misc/cxl/fault.c
@@ -169,81 +169,12 @@ static void cxl_handle_page_fault(struct cxl_context *ctx,
 }
 
 /*
- * Returns the mm_struct corresponding to the context ctx via ctx->pid
- * In case the task has exited we use the task group leader accessible
- * via ctx->glpid to find the next task in the thread group that has a
- * valid  mm_struct associated with it. If a task with valid mm_struct
- * is found the ctx->pid is updated to use the task struct for subsequent
- * translations. In case no valid mm_struct is found in the task group to
- * service the fault a NULL is returned.
+ * Returns the mm_struct corresponding to the context ctx.
  */
 static struct mm_struct *get_mem_context(struct cxl_context *ctx)
 {
-	struct task_struct *task = NULL;
-	struct mm_struct *mm = NULL;
-	struct pid *old_pid = ctx->pid;
-
-	if (old_pid == NULL) {
-		pr_warn("%s: Invalid context for pe=%d\n",
-			 __func__, ctx->pe);
-		return NULL;
-	}
-
-	task = get_pid_task(old_pid, PIDTYPE_PID);
-
-	/*
-	 * pid_alive may look racy but this saves us from costly
-	 * get_task_mm when the task is a zombie. In worst case
-	 * we may think a task is alive, which is about to die
-	 * but get_task_mm will return NULL.
-	 */
-	if (task != NULL && pid_alive(task))
-		mm = get_task_mm(task);
-
-	/* release the task struct that was taken earlier */
-	if (task)
-		put_task_struct(task);
-	else
-		pr_devel("%s: Context owning pid=%i for pe=%i dead\n",
-			__func__, pid_nr(old_pid), ctx->pe);
-
-	/*
-	 * If we couldn't find the mm context then use the group
-	 * leader to iterate over the task group and find a task
-	 * that gives us mm_struct.
-	 */
-	if (unlikely(mm == NULL && ctx->glpid != NULL)) {
-
-		rcu_read_lock();
-		task = pid_task(ctx->glpid, PIDTYPE_PID);
-		if (task)
-			do {
-				mm = get_task_mm(task);
-				if (mm) {
-					ctx->pid = get_task_pid(task,
-								PIDTYPE_PID);
-					break;
-				}
-				task = next_thread(task);
-			} while (task && !thread_group_leader(task));
-		rcu_read_unlock();
-
-		/* check if we switched pid */
-		if (ctx->pid != old_pid) {
-			if (mm)
-				pr_devel("%s:pe=%i switch pid %i->%i\n",
-					 __func__, ctx->pe, pid_nr(old_pid),
-					 pid_nr(ctx->pid));
-			else
-				pr_devel("%s:Cannot find mm for pid=%i\n",
-					 __func__, pid_nr(old_pid));
-
-			/* drop the reference to older pid */
-			put_pid(old_pid);
-		}
-	}
-
-	return mm;
+	cxl_context_mm_users_get(ctx);
+	return ctx->mm;
 }
 
 
@@ -281,7 +212,6 @@ void cxl_handle_fault(struct work_struct *fault_work)
 	if (!ctx->kernel) {
 
 		mm = get_mem_context(ctx);
-		/* indicates all the thread in task group have exited */
 		if (mm == NULL) {
 			pr_devel("%s: unable to get mm for pe=%d pid=%i\n",
 				 __func__, ctx->pe, pid_nr(ctx->pid));
diff --git a/drivers/misc/cxl/file.c b/drivers/misc/cxl/file.c
index 859959f..af6bd0e 100644
--- a/drivers/misc/cxl/file.c
+++ b/drivers/misc/cxl/file.c
@@ -216,8 +216,16 @@ static long afu_ioctl_start_work(struct cxl_context *ctx,
 	 * process is still accessible.
 	 */
 	ctx->pid = get_task_pid(current, PIDTYPE_PID);
-	ctx->glpid = get_task_pid(current->group_leader, PIDTYPE_PID);
 
+	/* acquire a reference to the task's mm */
+	ctx->mm = get_task_mm(current);
+
+	/* ensure this mm_struct can't be freed */
+	cxl_context_mm_count_get(ctx);
+
+	/* decrement the use count */
+	if (ctx->mm)
+		mmput(ctx->mm);
 
 	trace_cxl_attach(ctx, work.work_element_descriptor, work.num_interrupts, amr);
 
@@ -225,9 +233,9 @@ static long afu_ioctl_start_work(struct cxl_context *ctx,
 							amr))) {
 		afu_release_irqs(ctx, ctx);
 		cxl_adapter_context_put(ctx->afu->adapter);
-		put_pid(ctx->glpid);
 		put_pid(ctx->pid);
-		ctx->glpid = ctx->pid = NULL;
+		ctx->pid = NULL;
+		cxl_context_mm_count_put(ctx);
 		goto out;
 	}
 
-- 
2.7.4
