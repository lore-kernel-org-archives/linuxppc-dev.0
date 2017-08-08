Return-Path: <srs0=ev05=7k=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRqmw1CStzDqrC
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Aug 2017 09:07:44 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xRqmw08Qhz8tnp
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Aug 2017 09:07:44 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xRqmv30KPz9tWp
 for <linuxppc-dev@ozlabs.org>; Wed,  9 Aug 2017 09:07:43 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v78N6dO8068990
 for <linuxppc-dev@ozlabs.org>; Tue, 8 Aug 2017 19:07:41 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c7jrecam2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 08 Aug 2017 19:07:41 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 8 Aug 2017 19:07:40 -0400
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, apopple@au1.ibm.com, hbabu@us.ibm.com,
 oohall@gmail.com, linuxppc-dev@ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 14/17] powerpc: Add support for setting SPRN_TIDR
Date: Tue,  8 Aug 2017 16:06:59 -0700
In-Reply-To: <1502233622-9330-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1502233622-9330-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1502233622-9330-15-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We need the SPRN_TIDR to bet set for use with fast thread-wakeup
(core-to-core wakeup).  Each thread in a process needs to have a
unique id within the process but as explained below, for now, we
assign globally unique thread ids to all threads in the system.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/processor.h |  4 ++
 arch/powerpc/kernel/process.c        | 74 ++++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index fab7ff8..bf6ba63 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -232,6 +232,10 @@ struct debug_reg {
 struct thread_struct {
 	unsigned long	ksp;		/* Kernel stack pointer */
 
+#ifdef CONFIG_PPC_VAS
+	unsigned long	tidr;
+#endif
+
 #ifdef CONFIG_PPC64
 	unsigned long	ksp_vsid;
 #endif
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 9f3e2c9..6123859 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1213,6 +1213,16 @@ struct task_struct *__switch_to(struct task_struct *prev,
 		hard_irq_disable();
 	}
 
+#ifdef CONFIG_PPC_VAS
+	mtspr(SPRN_TIDR, new->thread.tidr);
+#endif
+	/*
+	 * We can't take a PMU exception inside _switch() since there is a
+	 * window where the kernel stack SLB and the kernel stack are out
+	 * of sync. Hard disable here.
+	 */
+	hard_irq_disable();
+
 	/*
 	 * Call restore_sprs() before calling _switch(). If we move it after
 	 * _switch() then we miss out on calling it for new tasks. The reason
@@ -1449,9 +1459,70 @@ void flush_thread(void)
 #endif /* CONFIG_HAVE_HW_BREAKPOINT */
 }
 
+#ifdef CONFIG_PPC_VAS
+static DEFINE_SPINLOCK(vas_thread_id_lock);
+static DEFINE_IDA(vas_thread_ida);
+
+/*
+ * We need to assign an unique thread id to each thread in a process. This
+ * thread id is intended to be used with the Fast Thread-wakeup (aka Core-
+ * to-core wakeup) mechanism being implemented on top of Virtual Accelerator
+ * Switchboard (VAS).
+ *
+ * To get a unique thread-id per process we could simply use task_pid_nr()
+ * but the problem is that task_pid_nr() is not yet available for the thread
+ * when copy_thread() is called. Fixing that would require changing more
+ * intrusive arch-neutral code in code path in copy_process()?.
+ *
+ * Further, to assign unique thread ids within each process, we need an
+ * atomic field (or an IDR) in task_struct, which again intrudes into the
+ * arch-neutral code.
+ *
+ * So try to assign globally unique thraed ids for now.
+ */
+static int assign_thread_id(void)
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
+	if (index > MAX_USER_CONTEXT) {
+		spin_lock(&vas_thread_id_lock);
+		ida_remove(&vas_thread_ida, index);
+		spin_unlock(&vas_thread_id_lock);
+		return -ENOMEM;
+	}
+
+	return index;
+}
+
+static void free_thread_id(int id)
+{
+	spin_lock(&vas_thread_id_lock);
+	ida_remove(&vas_thread_ida, id);
+	spin_unlock(&vas_thread_id_lock);
+}
+#endif /* CONFIG_PPC_VAS */
+
+
 void
 release_thread(struct task_struct *t)
 {
+#ifdef CONFIG_PPC_VAS
+	free_thread_id(t->thread.tidr);
+#endif
 }
 
 /*
@@ -1587,6 +1658,9 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 #endif
 
 	setup_ksp_vsid(p, sp);
+#ifdef CONFIG_PPC_VAS
+	p->thread.tidr = assign_thread_id();
+#endif
 
 #ifdef CONFIG_PPC64 
 	if (cpu_has_feature(CPU_FTR_DSCR)) {
-- 
2.7.4
