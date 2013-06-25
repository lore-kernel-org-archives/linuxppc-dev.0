Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp09.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A12D92C0BB7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 06:37:14 +1000 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Wed, 26 Jun 2013 02:02:33 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id BD0471258043
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 02:06:13 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5PKb6YG14287096
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 02:07:06 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5PKb8Us026313
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 06:37:10 +1000
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v2 44/45] sparc: Use get/put_online_cpus_atomic() to prevent
 CPU offline
To: tglx@linutronix.de, peterz@infradead.org, tj@kernel.org, oleg@redhat.com,
 paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org,
 akpm@linux-foundation.org, namhyung@kernel.org, walken@google.com,
 vincent.guittot@linaro.org, laijs@cn.fujitsu.com
Date: Wed, 26 Jun 2013 02:03:53 +0530
Message-ID: <20130625203353.16593.20506.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20130625202452.16593.22810.stgit@srivatsabhat.in.ibm.com>
References: <20130625202452.16593.22810.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-arch@vger.kernel.org, nikunj@linux.vnet.ibm.com,
 zhong@linux.vnet.ibm.com, linux-pm@vger.kernel.org, fweisbec@gmail.com,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 xiaoguangrong@linux.vnet.ibm.com, Sam Ravnborg <sam@ravnborg.org>, sbw@mit.edu,
 Dave Kleikamp <dave.kleikamp@oracle.com>, wangyun@linux.vnet.ibm.com,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, netdev@vger.kernel.org,
 sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
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

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Kleikamp <dave.kleikamp@oracle.com>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 arch/sparc/kernel/smp_64.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index 77539ed..4f71a95 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -792,7 +792,9 @@ static void smp_cross_call_masked(unsigned long *func, u32 ctx, u64 data1, u64 d
 /* Send cross call to all processors except self. */
 static void smp_cross_call(unsigned long *func, u32 ctx, u64 data1, u64 data2)
 {
+	get_online_cpus_atomic();
 	smp_cross_call_masked(func, ctx, data1, data2, cpu_online_mask);
+	put_online_cpus_atomic();
 }
 
 extern unsigned long xcall_sync_tick;
@@ -896,7 +898,7 @@ void smp_flush_dcache_page_impl(struct page *page, int cpu)
 	atomic_inc(&dcpage_flushes);
 #endif
 
-	this_cpu = get_cpu();
+	this_cpu = get_online_cpus_atomic();
 
 	if (cpu == this_cpu) {
 		__local_flush_dcache_page(page);
@@ -922,7 +924,7 @@ void smp_flush_dcache_page_impl(struct page *page, int cpu)
 		}
 	}
 
-	put_cpu();
+	put_online_cpus_atomic();
 }
 
 void flush_dcache_page_all(struct mm_struct *mm, struct page *page)
@@ -933,7 +935,7 @@ void flush_dcache_page_all(struct mm_struct *mm, struct page *page)
 	if (tlb_type == hypervisor)
 		return;
 
-	preempt_disable();
+	get_online_cpus_atomic();
 
 #ifdef CONFIG_DEBUG_DCFLUSH
 	atomic_inc(&dcpage_flushes);
@@ -958,7 +960,7 @@ void flush_dcache_page_all(struct mm_struct *mm, struct page *page)
 	}
 	__local_flush_dcache_page(page);
 
-	preempt_enable();
+	put_online_cpus_atomic();
 }
 
 void __irq_entry smp_new_mmu_context_version_client(int irq, struct pt_regs *regs)
@@ -1150,6 +1152,7 @@ void smp_capture(void)
 {
 	int result = atomic_add_ret(1, &smp_capture_depth);
 
+	get_online_cpus_atomic();
 	if (result == 1) {
 		int ncpus = num_online_cpus();
 
@@ -1166,6 +1169,7 @@ void smp_capture(void)
 		printk("done\n");
 #endif
 	}
+	put_online_cpus_atomic();
 }
 
 void smp_release(void)
