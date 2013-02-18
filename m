Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp09.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 313C52C0368
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 23:45:27 +1100 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Mon, 18 Feb 2013 18:13:36 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 53F623940057
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 18:15:23 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1ICjJkr30671068
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 18:15:19 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1ICjJYR015472
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 23:45:22 +1100
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v6 36/46] m32r: Use get/put_online_cpus_atomic() to prevent
 CPU offline
To: tglx@linutronix.de, peterz@infradead.org, tj@kernel.org, oleg@redhat.com,
 paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org,
 akpm@linux-foundation.org, namhyung@kernel.org
Date: Mon, 18 Feb 2013 18:13:23 +0530
Message-ID: <20130218124323.26245.86492.stgit@srivatsabhat.in.ibm.com>
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

Cc: Hirokazu Takata <takata@linux-m32r.org>
Cc: linux-m32r@ml.linux-m32r.org
Cc: linux-m32r-ja@ml.linux-m32r.org
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 arch/m32r/kernel/smp.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/m32r/kernel/smp.c b/arch/m32r/kernel/smp.c
index ce7aea3..0dad4d7 100644
--- a/arch/m32r/kernel/smp.c
+++ b/arch/m32r/kernel/smp.c
@@ -151,7 +151,7 @@ void smp_flush_cache_all(void)
 	cpumask_t cpumask;
 	unsigned long *mask;
 
-	preempt_disable();
+	get_online_cpus_atomic();
 	cpumask_copy(&cpumask, cpu_online_mask);
 	cpumask_clear_cpu(smp_processor_id(), &cpumask);
 	spin_lock(&flushcache_lock);
@@ -162,7 +162,7 @@ void smp_flush_cache_all(void)
 	while (flushcache_cpumask)
 		mb();
 	spin_unlock(&flushcache_lock);
-	preempt_enable();
+	put_online_cpus_atomic();
 }
 
 void smp_flush_cache_all_interrupt(void)
@@ -250,7 +250,7 @@ void smp_flush_tlb_mm(struct mm_struct *mm)
 	unsigned long *mmc;
 	unsigned long flags;
 
-	preempt_disable();
+	get_online_cpus_atomic();
 	cpu_id = smp_processor_id();
 	mmc = &mm->context[cpu_id];
 	cpumask_copy(&cpu_mask, mm_cpumask(mm));
@@ -268,7 +268,7 @@ void smp_flush_tlb_mm(struct mm_struct *mm)
 	if (!cpumask_empty(&cpu_mask))
 		flush_tlb_others(cpu_mask, mm, NULL, FLUSH_ALL);
 
-	preempt_enable();
+	put_online_cpus_atomic();
 }
 
 /*==========================================================================*
@@ -715,10 +715,12 @@ static void send_IPI_allbutself(int ipi_num, int try)
 {
 	cpumask_t cpumask;
 
+	get_online_cpus_atomic();
 	cpumask_copy(&cpumask, cpu_online_mask);
 	cpumask_clear_cpu(smp_processor_id(), &cpumask);
 
 	send_IPI_mask(&cpumask, ipi_num, try);
+	put_online_cpus_atomic();
 }
 
 /*==========================================================================*
@@ -750,6 +752,7 @@ static void send_IPI_mask(const struct cpumask *cpumask, int ipi_num, int try)
 	if (num_cpus <= 1)	/* NO MP */
 		return;
 
+	get_online_cpus_atomic();
 	cpumask_and(&tmp, cpumask, cpu_online_mask);
 	BUG_ON(!cpumask_equal(cpumask, &tmp));
 
@@ -760,6 +763,7 @@ static void send_IPI_mask(const struct cpumask *cpumask, int ipi_num, int try)
 	}
 
 	send_IPI_mask_phys(&physid_mask, ipi_num, try);
+	put_online_cpus_atomic();
 }
 
 /*==========================================================================*
