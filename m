Return-Path: <Yuantian.Tang@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0105.outbound.protection.outlook.com [65.55.169.105])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DEAEF1A094B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2015 18:32:34 +1000 (AEST)
From: <b29983@freescale.com>
To: <b07421@freescale.com>
CC: <linuxppc-dev@lists.ozlabs.org>, Tang Yuantian
 <Yuantian.Tang@freescale.com>, Chenhui Zhao <chenhui.zhao@freescale.com>
Subject: [PATCH] PowerPC: Add CPU hot plug feature to RCPM driver
Date: Mon, 20 Jul 2015 16:12:51 +0800
Message-ID: <1437379971-26938-1-git-send-email-b29983@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Tang Yuantian <Yuantian.Tang@freescale.com>

PowerPC E500MC serial SoCs, like T2080 T1040 and T4240, use RCPM
to manage power consumption. This patch adds hot plug feature to
RCPM driver.

Signed-off-by: Chenhui Zhao <chenhui.zhao@freescale.com>
Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
---
 arch/powerpc/include/asm/fsl_pm.h |  2 ++
 arch/powerpc/sysdev/fsl_rcpm.c    | 56 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/arch/powerpc/include/asm/fsl_pm.h b/arch/powerpc/include/asm/fsl_pm.h
index 4b09f09..0b03b03 100644
--- a/arch/powerpc/include/asm/fsl_pm.h
+++ b/arch/powerpc/include/asm/fsl_pm.h
@@ -33,6 +33,8 @@ struct fsl_pm_ops {
 	void (*irq_unmask)(int cpu);
 	void (*cpu_enter_state)(int cpu, int state);
 	void (*cpu_exit_state)(int cpu, int state);
+	void (*cpu_up)(int cpu);
+	void (*cpu_die)(int cpu);
 	int (*plat_enter_sleep)(void);
 	void (*freeze_time_base)(bool freeze);
 
diff --git a/arch/powerpc/sysdev/fsl_rcpm.c b/arch/powerpc/sysdev/fsl_rcpm.c
index 4bd2d64..acf3f94 100644
--- a/arch/powerpc/sysdev/fsl_rcpm.c
+++ b/arch/powerpc/sysdev/fsl_rcpm.c
@@ -128,6 +128,46 @@ static void rcpm_v2_cpu_enter_state(int cpu, int state)
 	}
 }
 
+static void rcpm_v1_cpu_die(int cpu)
+{
+	rcpm_v1_cpu_enter_state(cpu, E500_PM_PH15);
+}
+
+static void qoriq_disable_thread(void *info)
+{
+	int hw_cpu = get_hard_smp_processor_id(*(const int *)info);
+	int thread = cpu_thread_in_core(hw_cpu);
+
+	mtspr(SPRN_TENC, TEN_THREAD(thread));
+}
+
+static void rcpm_v2_cpu_die(int cpu)
+{
+	int primary;
+
+	if (threads_per_core == 1) {
+		rcpm_v2_cpu_enter_state(cpu, E500_PM_PH20);
+		return;
+	}
+
+	primary = cpu_first_thread_sibling(cpu);
+	if (cpu_is_offline(primary) && cpu_is_offline(primary + 1)) {
+		/* when two threads are all offline, put core in PH20 */
+		rcpm_v2_cpu_enter_state(cpu, E500_PM_PH20);
+	} else {
+		/*
+		 * When one thread is offline, disable the thread
+		 * by running qoriq_disable_thread() on the other thread.
+		 */
+		if (cpu_online(primary))
+			smp_call_function_single(primary,
+					qoriq_disable_thread, &cpu, 1);
+		else
+			smp_call_function_single(primary + 1,
+					qoriq_disable_thread, &cpu, 1);
+	}
+}
+
 static void rcpm_v1_cpu_exit_state(int cpu, int state)
 {
 	int hw_cpu = get_hard_smp_processor_id(cpu);
@@ -146,6 +186,12 @@ static void rcpm_v1_cpu_exit_state(int cpu, int state)
 	}
 }
 
+static void rcpm_v1_cpu_up(int cpu)
+{
+	rcpm_v1_cpu_exit_state(cpu, E500_PM_PH15);
+	rcpm_v1_irq_unmask(cpu);
+}
+
 static void rcpm_v2_cpu_exit_state(int cpu, int state)
 {
 	int hw_cpu = get_hard_smp_processor_id(cpu);
@@ -169,6 +215,12 @@ static void rcpm_v2_cpu_exit_state(int cpu, int state)
 	}
 }
 
+static void rcpm_v2_cpu_up(int cpu)
+{
+	rcpm_v2_cpu_exit_state(cpu, E500_PM_PH20);
+	rcpm_v2_irq_unmask(cpu);
+}
+
 static int rcpm_v1_plat_enter_state(int state)
 {
 	u32 *pmcsr_reg = &rcpm_v1_regs->powmgtcsr;
@@ -275,6 +327,8 @@ static const struct fsl_pm_ops qoriq_rcpm_v1_ops = {
 	.irq_unmask = rcpm_v1_irq_unmask,
 	.cpu_enter_state = rcpm_v1_cpu_enter_state,
 	.cpu_exit_state = rcpm_v1_cpu_exit_state,
+	.cpu_up = rcpm_v1_cpu_up,
+	.cpu_die = rcpm_v1_cpu_die,
 	.plat_enter_sleep = rcpm_v1_plat_enter_sleep,
 	.set_ip_power = rcpm_v1_set_ip_power,
 	.freeze_time_base = rcpm_v1_freeze_time_base,
@@ -286,6 +340,8 @@ static const struct fsl_pm_ops qoriq_rcpm_v2_ops = {
 	.irq_unmask = rcpm_v2_irq_unmask,
 	.cpu_enter_state = rcpm_v2_cpu_enter_state,
 	.cpu_exit_state = rcpm_v2_cpu_exit_state,
+	.cpu_up = rcpm_v2_cpu_up,
+	.cpu_die = rcpm_v2_cpu_die,
 	.plat_enter_sleep = rcpm_v2_plat_enter_sleep,
 	.set_ip_power = rcpm_v2_set_ip_power,
 	.freeze_time_base = rcpm_v2_freeze_time_base,
-- 
2.1.0.27.g96db324
