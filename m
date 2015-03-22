Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E8B621A02AC
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Mar 2015 15:43:28 +1100 (AEDT)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Sat, 21 Mar 2015 22:43:26 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 676BB1FF001E
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Mar 2015 22:34:35 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2M4hEtn30212138
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Mar 2015 21:43:14 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2M4hNCY019023
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Mar 2015 22:43:23 -0600
From: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] powerpc/powernv: Introduce sysfs control for fastsleep
 workaround behavior
Date: Sun, 22 Mar 2015 10:12:59 +0530
Message-Id: <1426999379-20542-3-git-send-email-shreyas@linux.vnet.ibm.com>
In-Reply-To: <1426999379-20542-1-git-send-email-shreyas@linux.vnet.ibm.com>
References: <1426999379-20542-1-git-send-email-shreyas@linux.vnet.ibm.com>
Cc: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
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
in the current power8 chips surrounding this fencing.

OPAL provides a workaround which precludes the possibility of hitting
this bug. But running with this workaround applied causes checkstop
if any correctable error in L2 cache directory is detected. Hence OPAL
also provides a way to undo the workaround.

In the existing implementation, workaround is applied by the last thread
of the core entering fastsleep and undone by the first thread waking up.
But this has a performance cost. These OPAL calls account for roughly
4000 cycles everytime the core has to enter or wakeup from fastsleep.

This patch introduces a sysfs attribute (fastsleep_workaround_state)
to choose the behavior of this workaround.

By default, fastsleep_workaround_state = 0. In this case, workaround
is applied/undone everytime the core enters/exits fastsleep.

fastsleep_workaround_state = 1. In this case the workaround is applied
once on all the cores and never undone. This can be triggered by
echo 1 > /sys/devices/system/cpu/fastsleep_workaround_state

For simplicity this attribute can be modified only once. Implying, once
fastsleep_workaround_state is changed to 1, it cannot be reverted to
the default state.

Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
---
Changes in V3-
Kernel parameter changed to sysfs attribute
Modified commmit message

 arch/powerpc/include/asm/opal.h                |  8 +++
 arch/powerpc/platforms/powernv/idle.c          | 83 +++++++++++++++++++++++++-
 arch/powerpc/platforms/powernv/opal-wrappers.S |  1 +
 3 files changed, 91 insertions(+), 1 deletion(-)

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
diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index 77992f6..79157b9 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -13,6 +13,8 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/of.h>
+#include <linux/device.h>
+#include <linux/cpu.h>
 
 #include <asm/firmware.h>
 #include <asm/opal.h>
@@ -136,6 +138,77 @@ u32 pnv_get_supported_cpuidle_states(void)
 }
 EXPORT_SYMBOL_GPL(pnv_get_supported_cpuidle_states);
 
+static void pnv_fastsleep_workaround_apply(void *info)
+{
+	opal_config_cpu_idle_state(OPAL_CONFIG_IDLE_FASTSLEEP,
+					OPAL_CONFIG_IDLE_APPLY);
+}
+
+/*
+ * Used to store fastsleep workaround state
+ * 0 - Workaround applied/undone at fastsleep entry/exit path (Default)
+ * 1 - Workaround applied once, never undone.
+ */
+static u8 fastsleep_workaround_state;
+
+static ssize_t show_fastsleep_workaround_state(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%u\n", fastsleep_workaround_state);
+}
+
+static ssize_t store_fastsleep_workaround_state(struct device *dev,
+		struct device_attribute *attr, const char *buf,
+		size_t count)
+{
+	u32 val;
+	cpumask_t primary_thread_mask;
+
+	/*
+	 * fastsleep_workaround_state is write-once parameter.
+	 * Once it has been set to 1, it cannot be undone.
+	 */
+	if (fastsleep_workaround_state == 1)
+		return -EINVAL;
+
+	if (kstrtou32(buf, 0, &val))
+		return -EINVAL;
+
+	if (val > 1)
+		return -EINVAL;
+
+	fastsleep_workaround_state = 1;
+	/*
+	 * fastsleep_workaround_state = 1 implies fastsleep workaround needs to
+	 * be left in 'applied' state on all the cores. Do this by-
+	 * 1. Patching out the call to 'undo' workaround in fastsleep exit path
+	 * 2. Sending ipi to all the cores which have atleast one online thread
+	 * 3. Patching out the call to 'apply' workaround in fastsleep entry
+	 * path
+	 * There is no need to send ipi to cores which have all threads
+	 * offlined, as last thread of the core entering fastsleep or deeper
+	 * state would have applied workaround.
+	 */
+	patch_instruction(
+		(unsigned int *)pnv_fastsleep_workaround_at_exit,
+		PPC_INST_NOP);
+
+	primary_thread_mask = cpu_online_cores_map();
+	on_each_cpu_mask(&primary_thread_mask,
+				pnv_fastsleep_workaround_apply,
+				NULL, 1);
+
+	patch_instruction(
+		(unsigned int *)pnv_fastsleep_workaround_at_entry,
+		PPC_INST_NOP);
+
+	return count;
+}
+
+static DEVICE_ATTR(fastsleep_workaround_state, 0600,
+			show_fastsleep_workaround_state,
+			store_fastsleep_workaround_state);
+
 static int __init pnv_init_idle_states(void)
 {
 	struct device_node *power_mgt;
@@ -178,7 +251,15 @@ static int __init pnv_init_idle_states(void)
 		patch_instruction(
 			(unsigned int *)pnv_fastsleep_workaround_at_exit,
 			PPC_INST_NOP);
-	}
+	} else
+	/*
+	 * OPAL_PM_SLEEP_ENABLED_ER1 is set. It indicates that workaround is
+	 * needed to use fastsleep. Provide sysfs control to choose how this
+	 * workaround has to be applied.
+	 */
+		device_create_file(cpu_subsys.dev_root,
+					&dev_attr_fastsleep_workaround_state);
+
 	pnv_alloc_idle_core_states();
 	return 0;
 }
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
-- 
1.9.3
