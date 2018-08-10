Return-Path: <srikar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41nBGK1JNhzDrYj
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Aug 2018 03:00:56 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7AGxISG110394
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Aug 2018 13:00:55 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kscgdw5x8-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Aug 2018 13:00:54 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srikar@linux.vnet.ibm.com>;
 Fri, 10 Aug 2018 18:00:49 +0100
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Mel Gorman <mgorman@techsingularity.net>,
 Rik van Riel <riel@surriel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Andre Wild <wild@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 2/2] sched/topology: Expose numa_mask set/clear functions to
 arch
Date: Fri, 10 Aug 2018 22:30:19 +0530
In-Reply-To: <1533920419-17410-1-git-send-email-srikar@linux.vnet.ibm.com>
References: <reply-to=<20180808081942.GA37418@linux.vnet.ibm.com>
 <1533920419-17410-1-git-send-email-srikar@linux.vnet.ibm.com>
Message-Id: <1533920419-17410-2-git-send-email-srikar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With commit 051f3ca02e46 ("sched/topology: Introduce NUMA identity node
sched domain") scheduler introduces an new numa level. However on shared
lpars like powerpc, this extra sched domain creation can lead to
repeated rcu stalls, sometimes even causing unresponsive systems on
boot. On such stalls, it was noticed that init_sched_groups_capacity()
(sg != sd->groups is always true).

INFO: rcu_sched self-detected stall on CPU
 1-....: (240039 ticks this GP) idle=c32/1/4611686018427387906 softirq=782/782 fqs=80012
  (t=240039 jiffies g=6272 c=6271 q=263040)
NMI backtrace for cpu 1
CPU: 1 PID: 1576 Comm: kworker/1:1 Kdump: loaded Tainted: G            E     4.18.0-rc7-master+ #42
Workqueue: events topology_work_fn
Call Trace:
[c00000832132f190] [c0000000009557ac] dump_stack+0xb0/0xf4 (unreliable)
[c00000832132f1d0] [c00000000095ed54] nmi_cpu_backtrace+0x1b4/0x230
[c00000832132f270] [c00000000095efac] nmi_trigger_cpumask_backtrace+0x1dc/0x220
[c00000832132f310] [c00000000005f77c] arch_trigger_cpumask_backtrace+0x2c/0x40
[c00000832132f330] [c0000000001a32d4] rcu_dump_cpu_stacks+0x100/0x15c
[c00000832132f380] [c0000000001a2024] rcu_check_callbacks+0x894/0xaa0
[c00000832132f4a0] [c0000000001ace9c] update_process_times+0x4c/0xa0
[c00000832132f4d0] [c0000000001c5400] tick_sched_handle.isra.13+0x50/0x80
[c00000832132f4f0] [c0000000001c549c] tick_sched_timer+0x6c/0xd0
[c00000832132f530] [c0000000001ae044] __hrtimer_run_queues+0x134/0x360
[c00000832132f5b0] [c0000000001aeea4] hrtimer_interrupt+0x124/0x300
[c00000832132f660] [c000000000024a04] timer_interrupt+0x114/0x2f0
[c00000832132f6c0] [c0000000000090f4] decrementer_common+0x114/0x120
--- interrupt: 901 at __bitmap_weight+0x70/0x100
    LR = __bitmap_weight+0x78/0x100
[c00000832132f9b0] [c0000000009bb738] __func__.61127+0x0/0x20 (unreliable)
[c00000832132fa00] [c00000000016c178] build_sched_domains+0xf98/0x13f0
[c00000832132fb30] [c00000000016d73c] partition_sched_domains+0x26c/0x440
[c00000832132fc20] [c0000000001ee284] rebuild_sched_domains_locked+0x64/0x80
[c00000832132fc50] [c0000000001f11ec] rebuild_sched_domains+0x3c/0x60
[c00000832132fc80] [c00000000007e1c4] topology_work_fn+0x24/0x40
[c00000832132fca0] [c000000000126704] process_one_work+0x1a4/0x470
[c00000832132fd30] [c000000000126a68] worker_thread+0x98/0x540
[c00000832132fdc0] [c00000000012f078] kthread+0x168/0x1b0
[c00000832132fe30] [c00000000000b65c]
ret_from_kernel_thread+0x5c/0x80

Similar problem was earlier also reported at
https://lwn.net/ml/linux-kernel/20180512100233.GB3738@osiris/

Allow arch to set and clear masks corresponding to numa sched domain.

Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Fixes: 051f3ca02e46 "Introduce NUMA identity node sched domain"
Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
 include/linux/sched/topology.h | 6 ++++++
 kernel/sched/sched.h           | 4 ----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 26347741ba50..13c7baeb7789 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -52,6 +52,12 @@ static inline int cpu_numa_flags(void)
 {
 	return SD_NUMA;
 }
+
+extern void sched_domains_numa_masks_set(unsigned int cpu);
+extern void sched_domains_numa_masks_clear(unsigned int cpu);
+#else
+static inline void sched_domains_numa_masks_set(unsigned int cpu) { }
+static inline void sched_domains_numa_masks_clear(unsigned int cpu) { }
 #endif
 
 extern int arch_asym_cpu_priority(int cpu);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c7742dcc136c..1028f3df8777 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1057,12 +1057,8 @@ extern bool find_numa_distance(int distance);
 
 #ifdef CONFIG_NUMA
 extern void sched_init_numa(void);
-extern void sched_domains_numa_masks_set(unsigned int cpu);
-extern void sched_domains_numa_masks_clear(unsigned int cpu);
 #else
 static inline void sched_init_numa(void) { }
-static inline void sched_domains_numa_masks_set(unsigned int cpu) { }
-static inline void sched_domains_numa_masks_clear(unsigned int cpu) { }
 #endif
 
 #ifdef CONFIG_NUMA_BALANCING
-- 
2.12.3
