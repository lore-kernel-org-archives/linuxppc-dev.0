Return-Path: <htejun@gmail.com>
Received: from mail-yw0-x241.google.com (mail-yw0-x241.google.com
 [IPv6:2607:f8b0:4002:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sySws2WH0zDvP8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Oct 2016 06:30:53 +1100 (AEDT)
Received: by mail-yw0-x241.google.com with SMTP id e5so7224805ywc.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Oct 2016 12:30:53 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 17 Oct 2016 15:30:47 -0400
From: Tejun Heo <tj@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
 jiangshanlai@gmail.com, akpm@linux-foundation.org, kernel-team@fb.com,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Balbir Singh <bsingharora@gmail.com>
Subject: Re: Oops on Power8 (was Re: [PATCH v2 1/7] workqueue: make workqueue
 available early during boot)
Message-ID: <20161017193047.GC6248@htj.duckdns.org>
References: <1473967821-24363-1-git-send-email-tj@kernel.org>
 <1473967821-24363-2-git-send-email-tj@kernel.org>
 <20160917172314.GB10771@mtj.duckdns.org>
 <87twck5wqo.fsf@concordia.ellerman.id.au>
 <20161010130253.GB29742@mtj.duckdns.org>
 <87a8eb5dwa.fsf@concordia.ellerman.id.au>
 <20161014150757.GA11102@mtj.duckdns.org>
 <87eg3fcge5.fsf@concordia.ellerman.id.au>
 <20161017181556.GB6248@htj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161017181556.GB6248@htj.duckdns.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello, Michael.

Other NUMA archs are lazy-initializing cpu to node mapping too, so we
need to fix it from workqueue side.  This also means that we've been
getting NUMA node wrong for percpu pools on those archs.

Can you please try the following patch and if it resolves the issue,
report the workqueue part (it's at the end) of sysrq-t dump?

Thanks.

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 984f6ff..276557b 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4411,14 +4411,14 @@ void show_workqueue_state(void)
 				break;
 			}
 		}
-		if (idle)
-			continue;
+		//if (idle)
+		//	continue;
 
 		pr_info("workqueue %s: flags=0x%x\n", wq->name, wq->flags);
 
 		for_each_pwq(pwq, wq) {
 			spin_lock_irqsave(&pwq->pool->lock, flags);
-			if (pwq->nr_active || !list_empty(&pwq->delayed_works))
+			//if (pwq->nr_active || !list_empty(&pwq->delayed_works))
 				show_pwq(pwq);
 			spin_unlock_irqrestore(&pwq->pool->lock, flags);
 		}
@@ -4429,8 +4429,8 @@ void show_workqueue_state(void)
 		bool first = true;
 
 		spin_lock_irqsave(&pool->lock, flags);
-		if (pool->nr_workers == pool->nr_idle)
-			goto next_pool;
+		//if (pool->nr_workers == pool->nr_idle)
+		//	goto next_pool;
 
 		pr_info("pool %d:", pool->id);
 		pr_cont_pool_info(pool);
@@ -4649,10 +4649,12 @@ int workqueue_online_cpu(unsigned int cpu)
 	for_each_pool(pool, pi) {
 		mutex_lock(&pool->attach_mutex);
 
-		if (pool->cpu == cpu)
+		if (pool->cpu == cpu) {
+			pool->node = cpu_to_node(cpu);
 			rebind_workers(pool);
-		else if (pool->cpu < 0)
+		} else if (pool->cpu < 0) {
 			restore_unbound_workers_cpumask(pool, cpu);
+		}
 
 		mutex_unlock(&pool->attach_mutex);
 	}
@@ -5495,8 +5497,6 @@ int __init workqueue_init_early(void)
 
 	pwq_cache = KMEM_CACHE(pool_workqueue, SLAB_PANIC);
 
-	wq_numa_init();
-
 	/* initialize CPU pools */
 	for_each_possible_cpu(cpu) {
 		struct worker_pool *pool;
@@ -5571,6 +5571,9 @@ int __init workqueue_init(void)
 	struct worker_pool *pool;
 	int cpu, bkt;
 
+	wq_numa_init();
+	wq_update_unbound_numa(wq, smp_processor_id(), true);
+
 	/* create the initial workers */
 	for_each_online_cpu(cpu) {
 		for_each_cpu_worker_pool(pool, cpu) {
