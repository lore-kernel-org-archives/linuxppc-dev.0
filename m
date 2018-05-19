Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x244.google.com (mail-pl0-x244.google.com
 [IPv6:2607:f8b0:400e:c01::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40nsgH4C1mzF0Pl
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 May 2018 14:36:11 +1000 (AEST)
Received: by mail-pl0-x244.google.com with SMTP id t12-v6so5698820plo.7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 May 2018 21:36:11 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 2/3] powerpc: smp_send_stop do not offline stopped CPUs
Date: Sat, 19 May 2018 14:35:53 +1000
Message-Id: <20180519043554.26640-3-npiggin@gmail.com>
In-Reply-To: <20180519043554.26640-1-npiggin@gmail.com>
References: <20180519043554.26640-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Marking CPUs stopped by smp_send_stop as offline can cause warnings
due to cross-CPU wakeups. This trace was noticed on a busy system
running a sysrq+c crash test, after the injected crash:

WARNING: CPU: 51 PID: 1546 at kernel/sched/core.c:1179 set_task_cpu+0x22c/0x240
CPU: 51 PID: 1546 Comm: kworker/u352:1 Tainted: G      D
Workqueue: mlx5e mlx5e_update_stats_work [mlx5_core]
[...]
NIP [c00000000017c21c] set_task_cpu+0x22c/0x240
LR [c00000000017d580] try_to_wake_up+0x230/0x720
Call Trace:
[c000000001017700] runqueues+0x0/0xb00 (unreliable)
[c00000000017d580] try_to_wake_up+0x230/0x720
[c00000000015a214] insert_work+0x104/0x140
[c00000000015adb0] __queue_work+0x230/0x690
[c000003fc5007910] [c00000000015b26c] queue_work_on+0x5c/0x90
[c0080000135fc8f8] mlx5_cmd_exec+0x538/0xcb0 [mlx5_core]
[c008000013608fd0] mlx5_core_access_reg+0x140/0x1d0 [mlx5_core]
[c00800001362777c] mlx5e_update_pport_counters.constprop.59+0x6c/0x90 [mlx5_core]
[c008000013628868] mlx5e_update_ndo_stats+0x28/0x90 [mlx5_core]
[c008000013625558] mlx5e_update_stats_work+0x68/0xb0 [mlx5_core]
[c00000000015bcec] process_one_work+0x1bc/0x5f0
[c00000000015ecac] worker_thread+0xac/0x6b0
[c000000000168338] kthread+0x168/0x1b0
[c00000000000b628] ret_from_kernel_thread+0x5c/0xb4

This happens because firstly the CPU is not really offline in the
usual sense, processes and interrupts have not been migrated away.
Secondly smp_send_stop does not happen atomically on all CPUs, so
one CPU can have marked itself offline, while another CPU is still
running processes or interrupts which can affect the first CPU.

Fix this by just not marking the CPU as offline. It's more like
frozen in time, so offline does not really reflect its state properly
anyway. There should be nothing in the crash/panic path that walks
online CPUs and synchronously waits for them, so this change should
not introduce new hangs.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/smp.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 9ca7148b5881..6d6cf14009cf 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -579,9 +579,6 @@ static void nmi_stop_this_cpu(struct pt_regs *regs)
 	nmi_ipi_busy_count--;
 	nmi_ipi_unlock();
 
-	/* Remove this CPU */
-	set_cpu_online(smp_processor_id(), false);
-
 	spin_begin();
 	while (1)
 		spin_cpu_relax();
@@ -596,9 +593,6 @@ void smp_send_stop(void)
 
 static void stop_this_cpu(void *dummy)
 {
-	/* Remove this CPU */
-	set_cpu_online(smp_processor_id(), false);
-
 	hard_irq_disable();
 	spin_begin();
 	while (1)
-- 
2.17.0
