Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp01.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4F8B62C0336
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 23:44:41 +1100 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Mon, 18 Feb 2013 18:11:56 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id EFA32125805A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 18:15:20 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1ICiVTN31195268
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 18:14:31 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1ICiXuu031271
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 23:44:35 +1100
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v6 31/46] alpha/smp: Use get/put_online_cpus_atomic() to
 prevent CPU offline
To: tglx@linutronix.de, peterz@infradead.org, tj@kernel.org, oleg@redhat.com,
 paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org,
 akpm@linux-foundation.org, namhyung@kernel.org
Date: Mon, 18 Feb 2013 18:12:37 +0530
Message-ID: <20130218124237.26245.20750.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com>
References: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-arch@vger.kernel.org, linux@arm.linux.org.uk,
 nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, fweisbec@gmail.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 xiaoguangrong@linux.vnet.ibm.com, rjw@sisk.pl, sbw@mit.edu,
 wangyun@linux.vnet.ibm.com, srivatsa.bhat@linux.vnet.ibm.com,
 netdev@vger.kernel.org, vincent.guittot@linaro.org, walken@google.com,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Once stop_machine() is gone from the CPU offline path, we won't be able to
depend on preempt_disable() or local_irq_disable() to prevent CPUs from
going offline from under us.

Use the get/put_online_cpus_atomic() APIs to prevent CPUs from going offline,
while invoking from atomic context.

Also, remove the non-ASCII character present in this file!

Cc: linux-alpha@vger.kernel.org
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 arch/alpha/kernel/smp.c |   19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/alpha/kernel/smp.c b/arch/alpha/kernel/smp.c
index 9603bc2..9213d5d 100644
--- a/arch/alpha/kernel/smp.c
+++ b/arch/alpha/kernel/smp.c
@@ -498,7 +498,6 @@ smp_cpus_done(unsigned int max_cpus)
 	       ((bogosum + 2500) / (5000/HZ)) % 100);
 }
 
-
 void
 smp_percpu_timer_interrupt(struct pt_regs *regs)
 {
@@ -682,7 +681,7 @@ ipi_flush_tlb_mm(void *x)
 void
 flush_tlb_mm(struct mm_struct *mm)
 {
-	preempt_disable();
+	get_online_cpus_atomic();
 
 	if (mm == current->active_mm) {
 		flush_tlb_current(mm);
@@ -694,7 +693,7 @@ flush_tlb_mm(struct mm_struct *mm)
 				if (mm->context[cpu])
 					mm->context[cpu] = 0;
 			}
-			preempt_enable();
+			put_online_cpus_atomic();
 			return;
 		}
 	}
@@ -703,7 +702,7 @@ flush_tlb_mm(struct mm_struct *mm)
 		printk(KERN_CRIT "flush_tlb_mm: timed out\n");
 	}
 
-	preempt_enable();
+	put_online_cpus_atomic();
 }
 EXPORT_SYMBOL(flush_tlb_mm);
 
@@ -731,7 +730,7 @@ flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
 	struct flush_tlb_page_struct data;
 	struct mm_struct *mm = vma->vm_mm;
 
-	preempt_disable();
+	get_online_cpus_atomic();
 
 	if (mm == current->active_mm) {
 		flush_tlb_current_page(mm, vma, addr);
@@ -743,7 +742,7 @@ flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
 				if (mm->context[cpu])
 					mm->context[cpu] = 0;
 			}
-			preempt_enable();
+			put_online_cpus_atomic();
 			return;
 		}
 	}
@@ -756,7 +755,7 @@ flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
 		printk(KERN_CRIT "flush_tlb_page: timed out\n");
 	}
 
-	preempt_enable();
+	put_online_cpus_atomic();
 }
 EXPORT_SYMBOL(flush_tlb_page);
 
@@ -787,7 +786,7 @@ flush_icache_user_range(struct vm_area_struct *vma, struct page *page,
 	if ((vma->vm_flags & VM_EXEC) == 0)
 		return;
 
-	preempt_disable();
+	get_online_cpus_atomic();
 
 	if (mm == current->active_mm) {
 		__load_new_mm_context(mm);
@@ -799,7 +798,7 @@ flush_icache_user_range(struct vm_area_struct *vma, struct page *page,
 				if (mm->context[cpu])
 					mm->context[cpu] = 0;
 			}
-			preempt_enable();
+			put_online_cpus_atomic();
 			return;
 		}
 	}
@@ -808,5 +807,5 @@ flush_icache_user_range(struct vm_area_struct *vma, struct page *page,
 		printk(KERN_CRIT "flush_icache_page: timed out\n");
 	}
 
-	preempt_enable();
+	put_online_cpus_atomic();
 }
