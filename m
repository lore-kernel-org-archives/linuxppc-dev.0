Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 381291A058C
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 May 2015 00:21:49 +1000 (AEST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 7 May 2015 19:51:46 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id B5CEEE0057
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 May 2015 19:54:37 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t47ELiJj54788294
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 May 2015 19:51:44 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t47DlPqG013774
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 May 2015 19:17:25 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Subject: [RFC PATCH] powerpc/mm: Use a non-idle variant of kick_all_cpus_sync
Date: Thu,  7 May 2015 19:51:37 +0530
Message-Id: <1431008497-11089-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

What we really need is the ability to wait for other cpus to
finish local_irq_save/local_irq_restore region. We don't need to send
IPI to idle cpus in that case. Add a vairant of kick_all_cpus_sync
to do that. If idle_cpu_mask change during the call, we should be
ok because:
1) new cpus got added. In this case when they enter the critical path
   they would have seen the new values i modified before smp_wmb();

2) cpus got removed: In this case we are ok, because we send stray IPI
   to them

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
NOTE: 
This need closer review, because I am new to the area of cpu mask.

 arch/powerpc/mm/pgtable_64.c |  6 +++---
 include/linux/smp.h          |  9 +++++++++
 kernel/sched/fair.c          | 19 +++++++++++++++++++
 3 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 049d961802aa..e54b111f8737 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -590,7 +590,7 @@ pmd_t pmdp_collapse_flush(struct vm_area_struct *vma, unsigned long address,
 	 * by sending an IPI to all the cpus and executing a dummy
 	 * function there.
 	 */
-	kick_all_cpus_sync();
+	poke_nonidle_cpus_sync();
 	/*
 	 * Now invalidate the hpte entries in the range
 	 * covered by pmd. This make sure we take a
@@ -670,7 +670,7 @@ void pmdp_splitting_flush(struct vm_area_struct *vma,
 	 * This ensures that generic code that rely on IRQ disabling
 	 * to prevent a parallel THP split work as expected.
 	 */
-	kick_all_cpus_sync();
+	poke_nonidle_cpus_sync();
 }
 
 /*
@@ -855,7 +855,7 @@ pmd_t pmdp_get_and_clear(struct mm_struct *mm,
 	 * different code paths. So make sure we wait for the parallel
 	 * find_linux_pte_or_hugepage to finish.
 	 */
-	kick_all_cpus_sync();
+	poke_nonidle_cpus_sync();
 	return old_pmd;
 }
 
diff --git a/include/linux/smp.h b/include/linux/smp.h
index c4414074bd88..16d539b94c31 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -101,6 +101,14 @@ int smp_call_function_any(const struct cpumask *mask,
 
 void kick_all_cpus_sync(void);
 void wake_up_all_idle_cpus(void);
+#ifdef CONFIG_NO_HZ_COMMON
+void poke_nonidle_cpus_sync(void);
+#else
+static inline void poke_nonidle_cpus_sync(void)
+{
+	return kick_all_cpus_sync();
+}
+#endif
 
 /*
  * Generic and arch helpers
@@ -150,6 +158,7 @@ smp_call_function_any(const struct cpumask *mask, smp_call_func_t func,
 
 static inline void kick_all_cpus_sync(void) {  }
 static inline void wake_up_all_idle_cpus(void) {  }
+static inline void poke_nonidle_cpus_sync(void) {  }
 
 #ifdef CONFIG_UP_LATE_INIT
 extern void __init up_late_init(void);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ffeaa4105e48..00abc6ae077b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7513,6 +7513,25 @@ static int sched_ilb_notifier(struct notifier_block *nfb,
 		return NOTIFY_DONE;
 	}
 }
+
+static void do_nothing(void *unused)
+{
+}
+
+void poke_nonidle_cpus_sync(void)
+{
+	struct cpumask mask;
+
+	/*
+	 * Make sure the change is visible before we poke the cpus
+	 */
+	smp_mb();
+	preempt_disable();
+	cpumask_andnot(&mask, cpu_online_mask, nohz.idle_cpus_mask);
+	smp_call_function_many(&mask, do_nothing, NULL, 1);
+	preempt_enable();
+}
+EXPORT_SYMBOL_GPL(poke_nonidle_cpus_sync);
 #endif
 
 static DEFINE_SPINLOCK(balancing);
-- 
2.1.4
