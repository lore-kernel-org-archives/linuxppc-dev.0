Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp03.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 693BF2C09C4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 06:03:01 +1000 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Fri, 28 Jun 2013 05:53:30 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id D4F192CE804A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 06:02:58 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5RK2nPR4391394
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 06:02:49 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5RK2uYp017294
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 06:02:58 +1000
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v3 39/45] mn10300: Use get/put_online_cpus_atomic() to prevent
 CPU offline
To: tglx@linutronix.de, peterz@infradead.org, tj@kernel.org, oleg@redhat.com,
 paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org,
 akpm@linux-foundation.org, namhyung@kernel.org, walken@google.com,
 vincent.guittot@linaro.org, laijs@cn.fujitsu.com, David.Laight@aculab.com
Date: Fri, 28 Jun 2013 01:29:35 +0530
Message-ID: <20130627195935.29830.37304.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20130627195136.29830.10445.stgit@srivatsabhat.in.ibm.com>
References: <20130627195136.29830.10445.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-arch@vger.kernel.org, linux-am33-list@redhat.com,
 nikunj@linux.vnet.ibm.com, zhong@linux.vnet.ibm.com, linux-pm@vger.kernel.org,
 fweisbec@gmail.com, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 xiaoguangrong@linux.vnet.ibm.com, David Howells <dhowells@redhat.com>,
 sbw@mit.edu, wangyun@linux.vnet.ibm.com,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, netdev@vger.kernel.org,
 Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Once stop_machine() is gone from the CPU offline path, we won't be able
to depend on disabling preemption to prevent CPUs from going offline
from under us.

Use the get/put_online_cpus_atomic() APIs to prevent CPUs from going
offline, while invoking from atomic context.

Cc: David Howells <dhowells@redhat.com>
Cc: Koichi Yasutake <yasutake.koichi@jp.panasonic.com>
Cc: linux-am33-list@redhat.com
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 arch/mn10300/mm/cache-smp.c |    3 +++
 arch/mn10300/mm/tlb-smp.c   |   17 +++++++++--------
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/mn10300/mm/cache-smp.c b/arch/mn10300/mm/cache-smp.c
index 2d23b9e..406357d 100644
--- a/arch/mn10300/mm/cache-smp.c
+++ b/arch/mn10300/mm/cache-smp.c
@@ -13,6 +13,7 @@
 #include <linux/mman.h>
 #include <linux/threads.h>
 #include <linux/interrupt.h>
+#include <linux/cpu.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/processor.h>
@@ -91,6 +92,7 @@ void smp_cache_interrupt(void)
 void smp_cache_call(unsigned long opr_mask,
 		    unsigned long start, unsigned long end)
 {
+	get_online_cpus_atomic();
 	smp_cache_mask = opr_mask;
 	smp_cache_start = start;
 	smp_cache_end = end;
@@ -102,4 +104,5 @@ void smp_cache_call(unsigned long opr_mask,
 	while (!cpumask_empty(&smp_cache_ipi_map))
 		/* nothing. lockup detection does not belong here */
 		mb();
+	put_online_cpus_atomic();
 }
diff --git a/arch/mn10300/mm/tlb-smp.c b/arch/mn10300/mm/tlb-smp.c
index 3e57faf..8856fd3 100644
--- a/arch/mn10300/mm/tlb-smp.c
+++ b/arch/mn10300/mm/tlb-smp.c
@@ -23,6 +23,7 @@
 #include <linux/sched.h>
 #include <linux/profile.h>
 #include <linux/smp.h>
+#include <linux/cpu.h>
 #include <asm/tlbflush.h>
 #include <asm/bitops.h>
 #include <asm/processor.h>
@@ -61,7 +62,7 @@ void smp_flush_tlb(void *unused)
 {
 	unsigned long cpu_id;
 
-	cpu_id = get_cpu();
+	cpu_id = get_online_cpus_atomic();
 
 	if (!cpumask_test_cpu(cpu_id, &flush_cpumask))
 		/* This was a BUG() but until someone can quote me the line
@@ -82,7 +83,7 @@ void smp_flush_tlb(void *unused)
 	cpumask_clear_cpu(cpu_id, &flush_cpumask);
 	smp_mb__after_clear_bit();
 out:
-	put_cpu();
+	put_online_cpus_atomic();
 }
 
 /**
@@ -144,7 +145,7 @@ void flush_tlb_mm(struct mm_struct *mm)
 {
 	cpumask_t cpu_mask;
 
-	preempt_disable();
+	get_online_cpus_atomic();
 	cpumask_copy(&cpu_mask, mm_cpumask(mm));
 	cpumask_clear_cpu(smp_processor_id(), &cpu_mask);
 
@@ -152,7 +153,7 @@ void flush_tlb_mm(struct mm_struct *mm)
 	if (!cpumask_empty(&cpu_mask))
 		flush_tlb_others(cpu_mask, mm, FLUSH_ALL);
 
-	preempt_enable();
+	put_online_cpus_atomic();
 }
 
 /**
@@ -163,7 +164,7 @@ void flush_tlb_current_task(void)
 	struct mm_struct *mm = current->mm;
 	cpumask_t cpu_mask;
 
-	preempt_disable();
+	get_online_cpus_atomic();
 	cpumask_copy(&cpu_mask, mm_cpumask(mm));
 	cpumask_clear_cpu(smp_processor_id(), &cpu_mask);
 
@@ -171,7 +172,7 @@ void flush_tlb_current_task(void)
 	if (!cpumask_empty(&cpu_mask))
 		flush_tlb_others(cpu_mask, mm, FLUSH_ALL);
 
-	preempt_enable();
+	put_online_cpus_atomic();
 }
 
 /**
@@ -184,7 +185,7 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigned long va)
 	struct mm_struct *mm = vma->vm_mm;
 	cpumask_t cpu_mask;
 
-	preempt_disable();
+	get_online_cpus_atomic();
 	cpumask_copy(&cpu_mask, mm_cpumask(mm));
 	cpumask_clear_cpu(smp_processor_id(), &cpu_mask);
 
@@ -192,7 +193,7 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigned long va)
 	if (!cpumask_empty(&cpu_mask))
 		flush_tlb_others(cpu_mask, mm, va);
 
-	preempt_enable();
+	put_online_cpus_atomic();
 }
 
 /**
