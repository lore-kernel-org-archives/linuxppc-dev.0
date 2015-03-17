Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2DF9B1A0299
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2015 15:14:57 +1100 (AEDT)
Received: from /spool/local
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Mon, 16 Mar 2015 22:14:55 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 0978419D8026
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2015 22:06:00 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2H4D4fn34013224
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2015 21:13:12 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2H4EJFs012212
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2015 22:14:20 -0600
From: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH RFC v2] powerpc/powernv: Introduce kernel param to control
 fastsleep workaround behavior
Date: Tue, 17 Mar 2015 09:43:53 +0530
Message-Id: <1426565633-7415-1-git-send-email-shreyas@linux.vnet.ibm.com>
Cc: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fastsleep is one of the idle state which cpuidle subsystem currently
uses on power8 machines. In this state L2 cache is brought down to a
threshold voltage. Therefore when the core is in fastsleep, the
communication between L2 and L3 needs to be fenced. But there is a bug
in the current power8 chips surrounding this fencing. OPAL provides an
interface to workaround this bug, and in the current implementation,
every time before a core enters fastsleep OPAL call is made to 'apply'
the workarond and when the core wakes up from fastsleep OPAL call is
made to 'undo' the workaround. These OPAL calls account for roughly
4000 cycles everytime the core has to enter or wakeup from fastsleep.
The other alternative is to apply this workaround once at boot, and not
undo it at all. While this would quicken fastsleep entry/wakeup path,
downside is, any correctable error detected in L2 directory will result
in a checkstop.

This patch adds a new kernel paramerter
pnv_fastsleep_workaround_once, which can be used to override
the default behavior and apply the workaround once at boot and not undo
it.

Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
CC: Michael Ellerman <mpe@ellerman.id.au>
CC: Paul Mackerras <paulus@samba.org>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: linuxppc-dev@lists.ozlabs.org
---
Changes in v2:
--------------
Accurately describes the downside of running workaround always applied.

 Documentation/kernel-parameters.txt            |  4 +++
 arch/powerpc/include/asm/opal.h                |  8 +++++
 arch/powerpc/platforms/powernv/opal-wrappers.S |  1 +
 arch/powerpc/platforms/powernv/setup.c         | 45 +++++++++++++++++++++++++-
 4 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index bfcb1a6..006863b 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -2857,6 +2857,10 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			autoconfiguration.
 			Ranges are in pairs (memory base and size).
 
+	pnv_fastsleep_workaround_once=
+			[BUGS=ppc64] Tells kernel to apply fastsleep workaround
+			once at boot.
+
 	ports=		[IP_VS_FTP] IPVS ftp helper module
 			Default is 21.
 			Up to 8 (IP_VS_APP_MAX_PORTS) ports
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 9ee0a30..8bea8fc 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -180,6 +180,13 @@ struct opal_sg_list {
 #define OPAL_PM_WINKLE_ENABLED	0x00040000
 #define OPAL_PM_SLEEP_ENABLED_ER1	0x00080000
 
+/*
+ * OPAL_CONFIG_CPU_IDLE_STATE parameters
+ */
+#define OPAL_CONFIG_IDLE_FASTSLEEP	1
+#define OPAL_CONFIG_IDLE_UNDO		0
+#define OPAL_CONFIG_IDLE_APPLY		1
+
 #ifndef __ASSEMBLY__
 
 #include <linux/notifier.h>
@@ -924,6 +931,7 @@ int64_t opal_handle_hmi(void);
 int64_t opal_register_dump_region(uint32_t id, uint64_t start, uint64_t end);
 int64_t opal_unregister_dump_region(uint32_t id);
 int64_t opal_slw_set_reg(uint64_t cpu_pir, uint64_t sprn, uint64_t val);
+int64_t opal_config_cpu_idle_state(uint64_t state, uint64_t flag);
 int64_t opal_pci_set_phb_cxl_mode(uint64_t phb_id, uint64_t mode, uint64_t pe_number);
 int64_t opal_ipmi_send(uint64_t interface, struct opal_ipmi_msg *msg,
 		uint64_t msg_len);
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 0509bca..84a20bb 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -283,6 +283,7 @@ OPAL_CALL(opal_sensor_read,			OPAL_SENSOR_READ);
 OPAL_CALL(opal_get_param,			OPAL_GET_PARAM);
 OPAL_CALL(opal_set_param,			OPAL_SET_PARAM);
 OPAL_CALL(opal_handle_hmi,			OPAL_HANDLE_HMI);
+OPAL_CALL(opal_config_cpu_idle_state,		OPAL_CONFIG_CPU_IDLE_STATE);
 OPAL_CALL(opal_slw_set_reg,			OPAL_SLW_SET_REG);
 OPAL_CALL(opal_register_dump_region,		OPAL_REGISTER_DUMP_REGION);
 OPAL_CALL(opal_unregister_dump_region,		OPAL_UNREGISTER_DUMP_REGION);
diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index d2de7d5..21dde6c 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -28,6 +28,7 @@
 #include <linux/bug.h>
 #include <linux/pci.h>
 #include <linux/cpufreq.h>
+#include <linux/cpumask.h>
 
 #include <asm/machdep.h>
 #include <asm/firmware.h>
@@ -405,6 +406,20 @@ u32 pnv_get_supported_cpuidle_states(void)
 }
 EXPORT_SYMBOL_GPL(pnv_get_supported_cpuidle_states);
 
+u8 pnv_apply_fastsleep_workaround_once;
+
+static int __init pnv_fastsleep_workaround_once(char *str)
+{
+	pnv_apply_fastsleep_workaround_once = 1;
+	return 0;
+}
+early_param("pnv_fastsleep_workaround_once", pnv_fastsleep_workaround_once);
+
+static void __init pnv_fastsleep_workaround_apply(void *info)
+{
+	opal_config_cpu_idle_state(OPAL_CONFIG_IDLE_FASTSLEEP,
+					OPAL_CONFIG_IDLE_APPLY);
+}
 static int __init pnv_init_idle_states(void)
 {
 	struct device_node *power_mgt;
@@ -440,7 +455,35 @@ static int __init pnv_init_idle_states(void)
 		flags = be32_to_cpu(idle_state_flags[i]);
 		supported_cpuidle_states |= flags;
 	}
-	if (!(supported_cpuidle_states & OPAL_PM_SLEEP_ENABLED_ER1)) {
+
+	/*
+	 * If OPAL_PM_SLEEP_ENABLED_ER1 is set, it indicates that workaround is
+	 * needed to use fastsleep. Check whether the workaround has to be
+	 * applied only once.
+	 */
+	if ((supported_cpuidle_states & OPAL_PM_SLEEP_ENABLED_ER1)
+			&& pnv_apply_fastsleep_workaround_once) {
+		/*
+		 * Workaround needs to be applied by one thread in each core
+		 */
+		cpumask_t primary_thread_mask = cpu_thread_mask_to_cores(cpu_online_mask);
+
+		on_each_cpu_mask(&primary_thread_mask,
+					pnv_fastsleep_workaround_apply,
+					NULL, 1);
+	}
+
+	/*
+	 * In the fastsleep entry/exit path, calls to workaround are always
+	 * made with an expectation that they will be patched out when not
+	 * needed.
+	 * Patch out these calls in following scenarios-
+	 * 1. OPAL_PM_SLEEP_ENABLED_ER1 is not set. Indicating the underlying
+	 * hardware does not have the bug.
+	 * 2. Kernel is running with workaround always applied.
+	 */
+	if (!(supported_cpuidle_states & OPAL_PM_SLEEP_ENABLED_ER1)
+			|| pnv_apply_fastsleep_workaround_once) {
 		patch_instruction(
 			(unsigned int *)pnv_fastsleep_workaround_at_entry,
 			PPC_INST_NOP);
-- 
1.9.3
