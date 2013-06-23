Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp04.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0F9A22C03A2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Jun 2013 23:51:22 +1000 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Sun, 23 Jun 2013 19:15:10 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id AE3C83940057
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Jun 2013 19:21:16 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5NDpDA429098040
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Jun 2013 19:21:13 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5NDpErH017772
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Jun 2013 13:51:16 GMT
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH 44/45] sparc: Use get/put_online_cpus_atomic() to prevent CPU
 offline
To: tglx@linutronix.de, peterz@infradead.org, tj@kernel.org, oleg@redhat.com,
 paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org,
 akpm@linux-foundation.org, namhyung@kernel.org, walken@google.com,
 vincent.guittot@linaro.org, laijs@cn.fujitsu.com
Date: Sun, 23 Jun 2013 19:18:01 +0530
Message-ID: <20130623134757.19094.85879.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20130623133642.19094.16038.stgit@srivatsabhat.in.ibm.com>
References: <20130623133642.19094.16038.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-arch@vger.kernel.org, nikunj@linux.vnet.ibm.com,
 zhong@linux.vnet.ibm.com, linux-pm@vger.kernel.org, fweisbec@gmail.com,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 xiaoguangrong@linux.vnet.ibm.com, Sam Ravnborg <sam@ravnborg.org>, sbw@mit.edu,
 Dave Kleikamp <dave.kleikamp@oracle.com>, wangyun@linux.vnet.ibm.com,
 srivatsa.bhat@linux.vnet.ibm.com, netdev@vger.kernel.org,
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
