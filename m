Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp01.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 73A142C0880
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 06:01:14 +1000 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Fri, 28 Jun 2013 05:52:17 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 780852BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 06:01:11 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5RJkJFK32047346
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 05:46:19 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5RK19RP014057
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 06:01:11 +1000
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v3 31/45] alpha/smp: Use get/put_online_cpus_atomic() to
 prevent CPU offline
To: tglx@linutronix.de, peterz@infradead.org, tj@kernel.org, oleg@redhat.com,
 paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org,
 akpm@linux-foundation.org, namhyung@kernel.org, walken@google.com,
 vincent.guittot@linaro.org, laijs@cn.fujitsu.com, David.Laight@aculab.com
Date: Fri, 28 Jun 2013 01:27:47 +0530
Message-ID: <20130627195747.29830.13668.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20130627195136.29830.10445.stgit@srivatsabhat.in.ibm.com>
References: <20130627195136.29830.10445.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-arch@vger.kernel.org, nikunj@linux.vnet.ibm.com,
 zhong@linux.vnet.ibm.com, linux-pm@vger.kernel.org, fweisbec@gmail.com,
 linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 xiaoguangrong@linux.vnet.ibm.com, sbw@mit.edu,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, wangyun@linux.vnet.ibm.com,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, netdev@vger.kernel.org,
 Matt Turner <mattst88@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Thomas Gleixner <tglx@linutronix.de>, Richard Henderson <rth@twiddle.net>
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

Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-alpha@vger.kernel.org
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 arch/alpha/kernel/smp.c |   19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/alpha/kernel/smp.c b/arch/alpha/kernel/smp.c
index 7b60834..e147268 100644
--- a/arch/alpha/kernel/smp.c
+++ b/arch/alpha/kernel/smp.c
@@ -497,7 +497,6 @@ smp_cpus_done(unsigned int max_cpus)
 	       ((bogosum + 2500) / (5000/HZ)) % 100);
 }
 
-
 void
 smp_percpu_timer_interrupt(struct pt_regs *regs)
 {
@@ -681,7 +680,7 @@ ipi_flush_tlb_mm(void *x)
 void
 flush_tlb_mm(struct mm_struct *mm)
 {
-	preempt_disable();
+	get_online_cpus_atomic();
 
 	if (mm == current->active_mm) {
 		flush_tlb_current(mm);
@@ -693,7 +692,7 @@ flush_tlb_mm(struct mm_struct *mm)
 				if (mm->context[cpu])
 					mm->context[cpu] = 0;
 			}
-			preempt_enable();
+			put_online_cpus_atomic();
 			return;
 		}
 	}
@@ -702,7 +701,7 @@ flush_tlb_mm(struct mm_struct *mm)
 		printk(KERN_CRIT "flush_tlb_mm: timed out\n");
 	}
 
-	preempt_enable();
+	put_online_cpus_atomic();
 }
 EXPORT_SYMBOL(flush_tlb_mm);
 
@@ -730,7 +729,7 @@ flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
 	struct flush_tlb_page_struct data;
 	struct mm_struct *mm = vma->vm_mm;
 
-	preempt_disable();
+	get_online_cpus_atomic();
 
 	if (mm == current->active_mm) {
 		flush_tlb_current_page(mm, vma, addr);
@@ -742,7 +741,7 @@ flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
 				if (mm->context[cpu])
 					mm->context[cpu] = 0;
 			}
-			preempt_enable();
+			put_online_cpus_atomic();
 			return;
 		}
 	}
@@ -755,7 +754,7 @@ flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
 		printk(KERN_CRIT "flush_tlb_page: timed out\n");
 	}
 
-	preempt_enable();
+	put_online_cpus_atomic();
 }
 EXPORT_SYMBOL(flush_tlb_page);
 
@@ -786,7 +785,7 @@ flush_icache_user_range(struct vm_area_struct *vma, struct page *page,
 	if ((vma->vm_flags & VM_EXEC) == 0)
 		return;
 
-	preempt_disable();
+	get_online_cpus_atomic();
 
 	if (mm == current->active_mm) {
 		__load_new_mm_context(mm);
@@ -798,7 +797,7 @@ flush_icache_user_range(struct vm_area_struct *vma, struct page *page,
 				if (mm->context[cpu])
 					mm->context[cpu] = 0;
 			}
-			preempt_enable();
+			put_online_cpus_atomic();
 			return;
 		}
 	}
@@ -807,5 +806,5 @@ flush_icache_user_range(struct vm_area_struct *vma, struct page *page,
 		printk(KERN_CRIT "flush_icache_page: timed out\n");
 	}
 
-	preempt_enable();
+	put_online_cpus_atomic();
 }
