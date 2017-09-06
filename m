Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xnb5j68dgzDrKk
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Sep 2017 06:38:49 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v86KVTAj138315
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Sep 2017 16:38:47 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ctmy2gphp-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Sep 2017 16:38:47 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 6 Sep 2017 16:38:44 -0400
Date: Wed, 6 Sep 2017 13:38:39 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: benh@us.ibm.com, Michael Ellerman <mpe@ellerman.id.au>, mikey@neuling.org
Cc: clombard@linux.vnet.ibm.com, felix@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 1/1] powerpc: Add support for setting SPRN_TIDR
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20170906203839.GB8065@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


We need the SPRN_TIDR to be set for use with fast thread-wakeup (core-
to-core wakeup) and also with CAPI.

Each thread in a process needs to have a unique id within the process.
But as explained below, for now, we assign globally unique thread ids
to all threads in the system.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Signed-off-by: Philippe Bergheaud <felix@linux.vnet.ibm.com>
Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
---
Changelog[v3]
	- Merge changes with and address comments to Christophe's patch.
	  (i.e drop CONFIG_PPC_VAS; use CONFIG_PPC64; check CPU_ARCH_300
	  before setting TIDR). Defer following to separate patches:
	  	- emulation parts of Christophe's patch,
		- setting TIDR for tasks other than 'current'
		- setting feature bit in AT_HWCAP2

Changelog[v2]
	- Michael Ellerman: Use an interface to assign TIDR so it is
	    assigned to only threads that need it; move assignment to
	    restore_sprs(). Drop lint from rebase;
---
 arch/powerpc/include/asm/processor.h |   1 +
 arch/powerpc/include/asm/switch_to.h |   3 +
 arch/powerpc/kernel/process.c        | 120 +++++++++++++++++++++++++++++++++++
 3 files changed, 124 insertions(+)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index fab7ff8..58cc212 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -329,6 +329,7 @@ struct thread_struct {
 	 */
 	int		dscr_inherit;
 	unsigned long	ppr;	/* used to save/restore SMT priority */
+	unsigned long	tidr;
 #endif
 #ifdef CONFIG_PPC_BOOK3S_64
 	unsigned long	tar;
diff --git a/arch/powerpc/include/asm/switch_to.h b/arch/powerpc/include/asm/switch_to.h
index 17c8380..f5da32f 100644
--- a/arch/powerpc/include/asm/switch_to.h
+++ b/arch/powerpc/include/asm/switch_to.h
@@ -91,4 +91,7 @@ static inline void clear_task_ebb(struct task_struct *t)
 #endif
 }
 
+extern int set_thread_tidr(struct task_struct *t);
+extern void clear_thread_tidr(struct task_struct *t);
+
 #endif /* _ASM_POWERPC_SWITCH_TO_H */
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index a0c74bb..8e992e9 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1120,6 +1120,13 @@ static inline void restore_sprs(struct thread_struct *old_thread,
 			mtspr(SPRN_TAR, new_thread->tar);
 	}
 #endif
+#ifdef CONFIG_PPC64
+	if (old_thread->tidr != new_thread->tidr) {
+		/* TIDR should be non-zero only with ISA3.0. */
+		WARN_ON_ONCE(!cpu_has_feature(CPU_FTR_ARCH_300));
+		mtspr(SPRN_TIDR, new_thread->tidr);
+	}
+#endif
 }
 
 #ifdef CONFIG_PPC_BOOK3S_64
@@ -1434,9 +1441,117 @@ void flush_thread(void)
 #endif /* CONFIG_HAVE_HW_BREAKPOINT */
 }
 
+#ifdef CONFIG_PPC64
+static DEFINE_SPINLOCK(vas_thread_id_lock);
+static DEFINE_IDA(vas_thread_ida);
+
+/*
+ * We need to assign a unique thread id to each thread in a process.
+ *
+ * This thread id, referred to as TIDR, and separate from the Linux's tgid,
+ * is intended to be used to direct an ASB_Notify from the hardware to the
+ * thread, when a suitable event occurs in the system.
+ *
+ * One such event is a "paste" instruction in the context of Fast Thread
+ * Wakeup (aka Core-to-core wake up in the Virtual Accelerator Switchboard
+ * (VAS) in POWER9.
+ *
+ * To get a unique TIDR per process we could simply reuse task_pid_nr() but
+ * the problem is that task_pid_nr() is not yet available copy_thread() is
+ * called. Fixing that would require changing more intrusive arch-neutral
+ * code in code path in copy_process()?.
+ *
+ * Further, to assign unique TIDRs within each process, we need an atomic
+ * field (or an IDR) in task_struct, which again intrudes into the arch-
+ * neutral code. So try to assign globally unique TIDRs for now.
+ *
+ * NOTE: TIDR 0 indicates that the thread does not need a TIDR value.
+ * 	 For now, only threads that expect to be notified by the VAS
+ * 	 hardware need a TIDR value and we assign values > 0 for those.
+ */
+#define MAX_THREAD_CONTEXT	((1 << 16) - 1)
+static int assign_thread_tidr(void)
+{
+	int index;
+	int err;
+
+again:
+	if (!ida_pre_get(&vas_thread_ida, GFP_KERNEL))
+		return -ENOMEM;
+
+	spin_lock(&vas_thread_id_lock);
+	err = ida_get_new_above(&vas_thread_ida, 1, &index);
+	spin_unlock(&vas_thread_id_lock);
+
+	if (err == -EAGAIN)
+		goto again;
+	else if (err)
+		return err;
+
+	if (index > MAX_THREAD_CONTEXT) {
+		spin_lock(&vas_thread_id_lock);
+		ida_remove(&vas_thread_ida, index);
+		spin_unlock(&vas_thread_id_lock);
+		return -ENOMEM;
+	}
+
+	return index;
+}
+
+static void free_thread_tidr(int id)
+{
+	spin_lock(&vas_thread_id_lock);
+	ida_remove(&vas_thread_ida, id);
+	spin_unlock(&vas_thread_id_lock);
+}
+
+/*
+ * Clear any TIDR value assigned to this thread.
+ */
+void clear_thread_tidr(struct task_struct *t)
+{
+	if (!t->thread.tidr)
+		return;
+
+	if (!cpu_has_feature(CPU_FTR_ARCH_300)) {
+		WARN_ON_ONCE(1);
+		return;
+	}
+
+	mtspr(SPRN_TIDR, 0);
+	free_thread_tidr(t->thread.tidr);
+	t->thread.tidr = 0;
+}
+
+/*
+ * Assign a unique TIDR (thread id) for task @t and set it in the thread
+ * structure. For now, we only support setting TIDR for 'current' task.
+ */
+int set_thread_tidr(struct task_struct *t)
+{
+	if (!cpu_has_feature(CPU_FTR_ARCH_300))
+		return -EINVAL;
+
+	if (t != current)
+		return -EINVAL;
+
+	t->thread.tidr = assign_thread_tidr();
+	if (t->thread.tidr < 0)
+		return t->thread.tidr;
+
+	mtspr(SPRN_TIDR, t->thread.tidr);
+
+	return 0;
+}
+
+#endif /* CONFIG_PPC64 */
+
 void
 release_thread(struct task_struct *t)
 {
+#ifdef CONFIG_PPC64
+	clear_thread_tidr(t);
+#endif
 }
 
 /*
@@ -1462,6 +1577,8 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 
 	clear_task_ebb(dst);
 
+	dst->thread.tidr = 0;
+
 	return 0;
 }
 
@@ -1572,6 +1689,9 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 #endif
 
 	setup_ksp_vsid(p, sp);
+#ifdef CONFIG_PPC64
+	p->thread.tidr = 0;
+#endif
 
 #ifdef CONFIG_PPC64 
 	if (cpu_has_feature(CPU_FTR_DSCR)) {
-- 
2.7.4
