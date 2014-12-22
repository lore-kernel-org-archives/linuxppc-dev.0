Return-Path: <Dongsheng.Wang@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0137.outbound.protection.outlook.com [207.46.100.137])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 266B81A0D4B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Dec 2014 20:14:44 +1100 (AEDT)
From: Dongsheng Wang <dongsheng.wang@freescale.com>
To: <benh@kernel.crashing.org>, <scottwood@freescale.com>, <anton@samba.org>
Subject: [PATCH] powerpc/smp: Fix Non-boot cpus cannot be bring up.
Date: Mon, 22 Dec 2014 14:38:40 +0800
Message-ID: <1419230320-37558-1-git-send-email-dongsheng.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org,
 Wang Dongsheng <dongsheng.wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wang Dongsheng <dongsheng.wang@freescale.com>

Kernel cannot bring up Non-boot cpus always get "Processor xx is stuck".
this issue bring by http://patchwork.ozlabs.org/patch/418912/ (powerpc:
Secondary CPUs must set cpu_callin_map after setting active and online)
We need to take timebase after bootup cpu give the timebase firstly.

When start_secondary, non-boot cpus set cpu_callin_map for boot cpu
after that boot cpu will give the timebase for non-boot cpu. Otherwise
non-boot cpus will fall in dead loop to waiting bootup cpu to give
imebase.

Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 8ec017c..9e29836 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -703,10 +703,6 @@ void start_secondary(void *unused)
 
 	if (smp_ops->setup_cpu)
 		smp_ops->setup_cpu(cpu);
-	if (smp_ops->take_timebase)
-		smp_ops->take_timebase();
-
-	secondary_cpu_time_init();
 
 #ifdef CONFIG_PPC64
 	if (system_state == SYSTEM_RUNNING)
@@ -746,6 +742,16 @@ void start_secondary(void *unused)
 	smp_wmb();
 	cpu_callin_map[cpu] = 1;
 
+	/*
+	 * We need to take timebase after bootup cpu give the timebase.
+	 * Base on cpu_callin_map move to here, so we also need move
+	 * take_timebase. Because bootup cpu waiting for cpu_callin_map
+	 * be set after that give_timebase can be executed.
+	 */
+	if (smp_ops->take_timebase)
+		smp_ops->take_timebase();
+	secondary_cpu_time_init();
+
 	local_irq_enable();
 
 	cpu_startup_entry(CPUHP_ONLINE);
-- 
2.1.0.27.g96db324
