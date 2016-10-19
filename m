Return-Path: <htejun@gmail.com>
Received: from mail-yw0-x241.google.com (mail-yw0-x241.google.com
 [IPv6:2607:f8b0:4002:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3szcVj6pGjzDt3P
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2016 03:15:41 +1100 (AEDT)
Received: by mail-yw0-x241.google.com with SMTP id u124so1000934ywg.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Oct 2016 09:15:41 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 19 Oct 2016 12:15:38 -0400
From: Tejun Heo <tj@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
 jiangshanlai@gmail.com, akpm@linux-foundation.org, kernel-team@fb.com,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH wq/for-4.10] workqueue: move wq_numa_init() to workqueue_init()
Message-ID: <20161019161538.GB18532@htj.duckdns.org>
References: <87twck5wqo.fsf@concordia.ellerman.id.au>
 <20161010130253.GB29742@mtj.duckdns.org>
 <87a8eb5dwa.fsf@concordia.ellerman.id.au>
 <20161014150757.GA11102@mtj.duckdns.org>
 <87eg3fcge5.fsf@concordia.ellerman.id.au>
 <20161017181556.GB6248@htj.duckdns.org>
 <20161017193047.GC6248@htj.duckdns.org>
 <87y41mb7c9.fsf@concordia.ellerman.id.au>
 <20161018185858.GA2761@htj.duckdns.org>
 <87r37c4mhn.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87r37c4mhn.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello, Michael.

I simplified the patch a bit and applied the following to for-4.10 and
updated for-next accordingly.  The coming next snapshot should be
fine.

Thanks!

------ 8< ------
>From 2186d9f940b6a04f263a3bacd48f2a7ba96df4cf Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Wed, 19 Oct 2016 12:01:27 -0400

While splitting up workqueue initialization into two parts,
ac8f73400782 ("workqueue: make workqueue available early during boot")
put wq_numa_init() into workqueue_init_early().  Unfortunately, on
some archs including power and arm64, cpu to node mapping isn't yet
established by the time the early init is called leading to incorrect
NUMA initialization and subsequently the following oops due to zero
cpumask on node-specific unbound pools.

  Unable to handle kernel paging request for data at address 0x00000038
  Faulting instruction address: 0xc0000000000fc0cc
  Oops: Kernel access of bad area, sig: 11 [#1]
  SMP NR_CPUS=2048 NUMA PowerNV
  Modules linked in:
  CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.8.0-compiler_gcc-6.2.0-next-20161005 #94
  task: c0000007f5400000 task.stack: c000001ffc084000
  NIP: c0000000000fc0cc LR: c0000000000ed928 CTR: c0000000000fbfd0
  REGS: c000001ffc087780 TRAP: 0300   Not tainted  (4.8.0-compiler_gcc-6.2.0-next-20161005)
  MSR: 9000000002009033 <SF,HV,VEC,EE,ME,IR,DR,RI,LE>  CR: 48000424  XER: 00000000
  CFAR: c0000000000089dc DAR: 0000000000000038 DSISR: 40000000 SOFTE: 0
  GPR00: c0000000000ed928 c000001ffc087a00 c000000000e63200 c000000010d6d600
  GPR04: c0000007f5409200 0000000000000021 000000000748e08c 000000000000001f
  GPR08: 0000000000000000 0000000000000021 000000000748f1f8 0000000000000000
  GPR12: 0000000028000422 c00000000fb80000 c00000000000e0c8 0000000000000000
  GPR16: 0000000000000000 0000000000000000 0000000000000021 0000000000000001
  GPR20: ffffffffafb50401 0000000000000000 c000000010d6d600 000000000000ba7e
  GPR24: 000000000000ba7e c000000000d8bc58 afb504000afb5041 0000000000000001
  GPR28: 0000000000000000 0000000000000004 c0000007f5409280 0000000000000000
  NIP [c0000000000fc0cc] enqueue_task_fair+0xfc/0x18b0
  LR [c0000000000ed928] activate_task+0x78/0xe0
  Call Trace:
  [c000001ffc087a00] [c0000007f5409200] 0xc0000007f5409200 (unreliable)
  [c000001ffc087b10] [c0000000000ed928] activate_task+0x78/0xe0
  [c000001ffc087b50] [c0000000000ede58] ttwu_do_activate+0x68/0xc0
  [c000001ffc087b90] [c0000000000ef1b8] try_to_wake_up+0x208/0x4f0
  [c000001ffc087c10] [c0000000000d3484] create_worker+0x144/0x250
  [c000001ffc087cb0] [c000000000cd72d0] workqueue_init+0x124/0x150
  [c000001ffc087d00] [c000000000cc0e74] kernel_init_freeable+0x158/0x360
  [c000001ffc087dc0] [c00000000000e0e4] kernel_init+0x24/0x160
  [c000001ffc087e30] [c00000000000bfa0] ret_from_kernel_thread+0x5c/0xbc
  Instruction dump:
  62940401 3b800000 3aa00000 7f17c378 3a600001 3b600001 60000000 60000000
  60420000 72490021 ebfe0150 2f890001 <ebbf0038> 419e0de0 7fbee840 419e0e58
  ---[ end trace 0000000000000000 ]---

Fix it by moving wq_numa_init() to workqueue_init().  As this means
that the early intialization may not have full NUMA info for per-cpu
pools and ignores NUMA affinity for unbound pools, fix them up from
workqueue_init() after wq_numa_init().

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Link: http://lkml.kernel.org/r/87twck5wqo.fsf@concordia.ellerman.id.au
Fixes: ac8f73400782 ("workqueue: make workqueue available early during boot")
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/workqueue.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index ad0cd43..c56479b 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5495,8 +5495,6 @@ int __init workqueue_init_early(void)
 
 	pwq_cache = KMEM_CACHE(pool_workqueue, SLAB_PANIC);
 
-	wq_numa_init();
-
 	/* initialize CPU pools */
 	for_each_possible_cpu(cpu) {
 		struct worker_pool *pool;
@@ -5566,9 +5564,32 @@ int __init workqueue_init_early(void)
  */
 int __init workqueue_init(void)
 {
+	struct workqueue_struct *wq;
 	struct worker_pool *pool;
 	int cpu, bkt;
 
+	/*
+	 * It'd be simpler to initialize NUMA in workqueue_init_early() but
+	 * CPU to node mapping may not be available that early on some
+	 * archs such as power and arm64.  As per-cpu pools created
+	 * previously could be missing node hint and unbound pools NUMA
+	 * affinity, fix them up.
+	 */
+	wq_numa_init();
+
+	mutex_lock(&wq_pool_mutex);
+
+	for_each_possible_cpu(cpu) {
+		for_each_cpu_worker_pool(pool, cpu) {
+			pool->node = cpu_to_node(cpu);
+		}
+	}
+
+	list_for_each_entry(wq, &workqueues, list)
+		wq_update_unbound_numa(wq, smp_processor_id(), true);
+
+	mutex_unlock(&wq_pool_mutex);
+
 	/* create the initial workers */
 	for_each_online_cpu(cpu) {
 		for_each_cpu_worker_pool(pool, cpu) {
-- 
2.7.4
