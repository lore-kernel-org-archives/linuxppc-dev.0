Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp01.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0F74E2C0FF2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Jun 2013 23:48:41 +1000 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Sun, 23 Jun 2013 19:11:46 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 141003940053
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Jun 2013 19:18:35 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5NDmUCJ15794184
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Jun 2013 19:18:30 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5NDmX1t029750
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Jun 2013 23:48:35 +1000
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH 31/45] alpha/smp: Use get/put_online_cpus_atomic() to prevent
 CPU offline
To: tglx@linutronix.de, peterz@infradead.org, tj@kernel.org, oleg@redhat.com,
 paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org,
 akpm@linux-foundation.org, namhyung@kernel.org, walken@google.com,
 vincent.guittot@linaro.org, laijs@cn.fujitsu.com
Date: Sun, 23 Jun 2013 19:15:20 +0530
Message-ID: <20130623134516.19094.57189.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20130623133642.19094.16038.stgit@srivatsabhat.in.ibm.com>
References: <20130623133642.19094.16038.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-arch@vger.kernel.org, nikunj@linux.vnet.ibm.com,
 zhong@linux.vnet.ibm.com, linux-pm@vger.kernel.org, fweisbec@gmail.com,
 linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 xiaoguangrong@linux.vnet.ibm.com, sbw@mit.edu,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, wangyun@linux.vnet.ibm.com,
 srivatsa.bhat@linux.vnet.ibm.com, netdev@vger.kernel.org,
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

Also, remove the non-ASCII character present in this file!

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
