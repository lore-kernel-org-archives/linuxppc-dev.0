Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 839D21A0BF9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 11:58:08 +1000 (AEST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Mon, 13 Apr 2015 19:58:06 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id D756619D8040
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2015 19:49:08 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t3E1vkg530736628
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2015 18:57:46 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3E1w2nZ030476
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2015 19:58:03 -0600
From: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] powerpc/powernv: Introduce sysfs control for fastsleep
 workaround behavior
Date: Tue, 14 Apr 2015 07:26:53 +0530
Message-Id: <1428976613-13007-4-git-send-email-shreyas@linux.vnet.ibm.com>
In-Reply-To: <1428976613-13007-1-git-send-email-shreyas@linux.vnet.ibm.com>
References: <1428976613-13007-1-git-send-email-shreyas@linux.vnet.ibm.com>
Cc: preeti@linux.vnet.ibm.com, "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>,
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

By default, fastsleep_workaround_state = dynamic. In this case, workaround
is applied/undone everytime the core enters/exits fastsleep.

fastsleep_workaround_state = applyonce. In this case the workaround is
applied once on all the cores and never undone. This can be triggered by
echo applyonce > /sys/devices/system/cpu/fastsleep_workaround_state

For simplicity this attribute can be modified only once. Implying, once
fastsleep_workaround_state is changed to applyonce, it cannot be reverted
to the default state.

Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal-api.h            |   7 ++
 arch/powerpc/include/asm/opal.h                |   1 +
 arch/powerpc/platforms/powernv/idle.c          | 132 +++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal-wrappers.S |   1 +
 4 files changed, 141 insertions(+)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 0321a90..a49e5fa 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -165,6 +165,13 @@
 #define OPAL_PM_WINKLE_ENABLED		0x00040000
 #define OPAL_PM_SLEEP_ENABLED_ER1	0x00080000 /* with workaround */
 
+/*
+ * OPAL_CONFIG_CPU_IDLE_STATE parameters
+ */
+#define OPAL_CONFIG_IDLE_FASTSLEEP	1
+#define OPAL_CONFIG_IDLE_UNDO		0
+#define OPAL_CONFIG_IDLE_APPLY		1
+
 #ifndef __ASSEMBLY__
 
 /* Other enums */
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 042af1a..9a47813 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -186,6 +186,7 @@ int64_t opal_handle_hmi(void);
 int64_t opal_register_dump_region(uint32_t id, uint64_t start, uint64_t end);
 int64_t opal_unregister_dump_region(uint32_t id);
 int64_t opal_slw_set_reg(uint64_t cpu_pir, uint64_t sprn, uint64_t val);
+int64_t opal_config_cpu_idle_state(uint64_t state, uint64_t flag);
 int64_t opal_pci_set_phb_cxl_mode(uint64_t phb_id, uint64_t mode, uint64_t pe_number);
 int64_t opal_ipmi_send(uint64_t interface, struct opal_ipmi_msg *msg,
 		uint64_t msg_len);
diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index 104235a..3e0423d 100644
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
@@ -136,6 +138,127 @@ u32 pnv_get_supported_cpuidle_states(void)
 }
 EXPORT_SYMBOL_GPL(pnv_get_supported_cpuidle_states);
 
+
+static void pnv_fastsleep_workaround_apply(void *info)
+
+{
+	int rc;
+	int *err = info;
+
+	rc = opal_config_cpu_idle_state(OPAL_CONFIG_IDLE_FASTSLEEP,
+					OPAL_CONFIG_IDLE_APPLY);
+	if (rc)
+		*err = 1;
+}
+
+/*
+ * Used to store fastsleep workaround state
+ * 0 - Workaround applied/undone at fastsleep entry/exit path (Default)
+ * 1 - Workaround applied once, never undone.
+ */
+static u8 fastsleep_workaround_state;
+
+static const char * const fastsleep_workaround_avail_states[] = {
+	"dynamic", "applyonce"
+};
+
+/*
+ * fastsleep_workaround_avail_states values
+ */
+enum {
+	WORKAROUND_DYNAMIC,
+	WORKAROUND_APPLYONCE
+};
+static ssize_t show_fastsleep_workaround_state(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	char *s = buf;
+
+	if (fastsleep_workaround_state == 0) {
+		s += sprintf(s, "[%s] ",
+			fastsleep_workaround_avail_states[WORKAROUND_DYNAMIC]);
+		s += sprintf(s, "%s\n",
+			fastsleep_workaround_avail_states[WORKAROUND_APPLYONCE]);
+	} else {
+		s += sprintf(s, "%s ",
+			fastsleep_workaround_avail_states[WORKAROUND_DYNAMIC]);
+		s += sprintf(s, "[%s]\n",
+			fastsleep_workaround_avail_states[WORKAROUND_APPLYONCE]);
+	}
+	return (s - buf);
+}
+
+static ssize_t store_fastsleep_workaround_state(struct device *dev,
+		struct device_attribute *attr, const char *buf,
+		size_t count)
+{
+	cpumask_t primary_thread_mask;
+	int err;
+	int len;
+	char *p;
+	const char * const *s;
+
+	p = memchr(buf, '\n', count);
+	len = p ? p - buf : count;
+	s = &fastsleep_workaround_avail_states[WORKAROUND_APPLYONCE];
+	if (len != strlen(*s) || strncmp(buf, *s, len))
+		return -EINVAL;
+
+	/*
+	 * If fastsleep_workaround_state already equals WORKAROUND_APPLYONCE,
+	 * there is nothing to do.
+	 */
+	if (fastsleep_workaround_state == WORKAROUND_APPLYONCE)
+		return count;
+
+	/*
+	 * fastsleep_workaround_state = WORKAROUND_APPLYONCE implies
+	 * fastsleep workaround needs to be left in 'applied' state on all
+	 * the cores. Do this by-
+	 * 1. Patching out the call to 'undo' workaround in fastsleep exit path
+	 * 2. Sending ipi to all the cores which have atleast one online thread
+	 * 3. Patching out the call to 'apply' workaround in fastsleep entry
+	 * path
+	 * There is no need to send ipi to cores which have all threads
+	 * offlined, as last thread of the core entering fastsleep or deeper
+	 * state would have applied workaround.
+	 */
+	err = patch_instruction(
+		(unsigned int *)pnv_fastsleep_workaround_at_exit,
+		PPC_INST_NOP);
+	if (err) {
+		pr_err("fastsleep_workaround_state change failed while patching pnv_fastsleep_workaround_at_exit");
+		goto fail;
+	}
+
+	primary_thread_mask = cpu_online_cores_map();
+	on_each_cpu_mask(&primary_thread_mask,
+				pnv_fastsleep_workaround_apply,
+				&err, 1);
+	if (err) {
+		pr_err("fastsleep_workaround_state change failed while running pnv_fastsleep_workaround_apply");
+		goto fail;
+	}
+
+	err = patch_instruction(
+		(unsigned int *)pnv_fastsleep_workaround_at_entry,
+		PPC_INST_NOP);
+	if (err) {
+		pr_err("fastsleep_workaround_state change failed while patching pnv_fastsleep_workaround_at_entry");
+		goto fail;
+	}
+
+	fastsleep_workaround_state = WORKAROUND_APPLYONCE;
+
+	return count;
+fail:
+	return -EIO;
+}
+
+static DEVICE_ATTR(fastsleep_workaround_state, 0600,
+			show_fastsleep_workaround_state,
+			store_fastsleep_workaround_state);
+
 static int __init pnv_init_idle_states(void)
 {
 	struct device_node *power_mgt;
@@ -180,7 +303,16 @@ static int __init pnv_init_idle_states(void)
 		patch_instruction(
 			(unsigned int *)pnv_fastsleep_workaround_at_exit,
 			PPC_INST_NOP);
+	} else {
+		/*
+		 * OPAL_PM_SLEEP_ENABLED_ER1 is set. It indicates that
+		 * workaround is needed to use fastsleep. Provide sysfs
+		 * control to choose how this workaround has to be applied.
+		 */
+		device_create_file(cpu_subsys.dev_root,
+					&dev_attr_fastsleep_workaround_state);
 	}
+
 	pnv_alloc_idle_core_states();
 out_free:
 	kfree(flags);
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index a7ade94..bf15ead 100644
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
