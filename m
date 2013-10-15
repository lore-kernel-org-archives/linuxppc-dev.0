Return-Path: <B40534@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0184.outbound.messaging.microsoft.com [213.199.154.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2FB772C03F5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Oct 2013 20:29:38 +1100 (EST)
Received: from mail88-db8 (localhost [127.0.0.1])	by mail88-db8-R.bigfish.com
 (Postfix) with ESMTP id DBA2D380087	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,
 15 Oct 2013 09:29:26 +0000 (UTC)
Received: from DB8EHSMHS014.bigfish.com (unknown [10.174.8.232])	by
 mail88-db8.bigfish.com (Postfix) with ESMTP id B3505BC0041	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Oct 2013 09:29:23 +0000 (UTC)
From: Dongsheng Wang <dongsheng.wang@freescale.com>
To: <scottwood@freescale.com>
Subject: [PATCH v5 4/4] powerpc/85xx: add sysfs for pw20 state and altivec idle
Date: Tue, 15 Oct 2013 17:21:11 +0800
Message-ID: <1381828871-17110-4-git-send-email-dongsheng.wang@freescale.com>
In-Reply-To: <1381828871-17110-1-git-send-email-dongsheng.wang@freescale.com>
References: <1381828871-17110-1-git-send-email-dongsheng.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: bharat.bhushan@freescale.com, linuxppc-dev@lists.ozlabs.org,
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

Add a sys interface to enable/diable pw20 state or altivec idle, and
control the wait entry time.

Enable/Disable interface:
0, disable. 1, enable.
/sys/devices/system/cpu/cpuX/pw20_state
/sys/devices/system/cpu/cpuX/altivec_idle

Set wait time interface:(Nanosecond)
/sys/devices/system/cpu/cpuX/pw20_wait_time
/sys/devices/system/cpu/cpuX/altivec_idle_wait_time
Example: Base on TBfreq is 41MHZ.
1~48(ns): TB[63]
49~97(ns): TB[62]
98~195(ns): TB[61]
196~390(ns): TB[60]
391~780(ns): TB[59]
781~1560(ns): TB[58]
...

Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
---
*v5:
Change get_idle_ticks_bit function implementation.

*v4:
Move code from 85xx/common.c to kernel/sysfs.c.

Remove has_pw20_altivec_idle function.

Change wait "entry_bit" to wait time.

diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index 27a90b9..10d1128 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -85,6 +85,284 @@ __setup("smt-snooze-delay=", setup_smt_snooze_delay);
 
 #endif /* CONFIG_PPC64 */
 
+#ifdef CONFIG_FSL_SOC
+#define MAX_BIT				63
+
+static u64 pw20_wt;
+static u64 altivec_idle_wt;
+
+static unsigned int get_idle_ticks_bit(u64 ns)
+{
+	u64 cycle;
+
+	if (ns >= 10000)
+		cycle = div_u64(ns + 500, 1000) * tb_ticks_per_usec;
+	else
+		cycle = div_u64(ns * tb_ticks_per_usec, 1000);
+
+	if (!cycle)
+		return 0;
+
+	return ilog2(cycle);
+}
+
+static void do_show_pwrmgtcr0(void *val)
+{
+	u32 *value = val;
+
+	*value = mfspr(SPRN_PWRMGTCR0);
+}
+
+static ssize_t show_pw20_state(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	u32 value;
+	unsigned int cpu = dev->id;
+
+	smp_call_function_single(cpu, do_show_pwrmgtcr0, &value, 1);
+
+	value &= PWRMGTCR0_PW20_WAIT;
+
+	return sprintf(buf, "%u\n", value ? 1 : 0);
+}
+
+static void do_store_pw20_state(void *val)
+{
+	u32 *value = val;
+	u32 pw20_state;
+
+	pw20_state = mfspr(SPRN_PWRMGTCR0);
+
+	if (*value)
+		pw20_state |= PWRMGTCR0_PW20_WAIT;
+	else
+		pw20_state &= ~PWRMGTCR0_PW20_WAIT;
+
+	mtspr(SPRN_PWRMGTCR0, pw20_state);
+}
+
+static ssize_t store_pw20_state(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	u32 value;
+	unsigned int cpu = dev->id;
+
+	if (kstrtou32(buf, 0, &value))
+		return -EINVAL;
+
+	if (value > 1)
+		return -EINVAL;
+
+	smp_call_function_single(cpu, do_store_pw20_state, &value, 1);
+
+	return count;
+}
+
+static ssize_t show_pw20_wait_time(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	u32 value;
+	u64 tb_cycle;
+	s64 time;
+
+	unsigned int cpu = dev->id;
+
+	if (!pw20_wt) {
+		smp_call_function_single(cpu, do_show_pwrmgtcr0, &value, 1);
+		value = (value & PWRMGTCR0_PW20_ENT) >>
+					PWRMGTCR0_PW20_ENT_SHIFT;
+
+		tb_cycle = (1 << (MAX_BIT - value)) * 2;
+		time = div_u64(tb_cycle * 1000, tb_ticks_per_usec) - 1;
+	} else {
+		time = pw20_wt;
+	}
+
+	return sprintf(buf, "%llu\n", time > 0 ? time : 0);
+}
+
+static void set_pw20_wait_entry_bit(void *val)
+{
+	u32 *value = val;
+	u32 pw20_idle;
+
+	pw20_idle = mfspr(SPRN_PWRMGTCR0);
+
+	/* Set Automatic PW20 Core Idle Count */
+	/* clear count */
+	pw20_idle &= ~PWRMGTCR0_PW20_ENT;
+
+	/* set count */
+	pw20_idle |= ((MAX_BIT - *value) << PWRMGTCR0_PW20_ENT_SHIFT);
+
+	mtspr(SPRN_PWRMGTCR0, pw20_idle);
+}
+
+static ssize_t store_pw20_wait_time(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	u32 entry_bit;
+	u64 value;
+
+	unsigned int cpu = dev->id;
+
+	if (kstrtou64(buf, 0, &value))
+		return -EINVAL;
+
+	if (!value)
+		return -EINVAL;
+
+	entry_bit = get_idle_ticks_bit(value);
+	if (entry_bit > MAX_BIT)
+		return -EINVAL;
+
+	pw20_wt = value;
+	smp_call_function_single(cpu, set_pw20_wait_entry_bit,
+				&entry_bit, 1);
+
+	return count;
+}
+
+static ssize_t show_altivec_idle(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	u32 value;
+	unsigned int cpu = dev->id;
+
+	smp_call_function_single(cpu, do_show_pwrmgtcr0, &value, 1);
+
+	value &= PWRMGTCR0_AV_IDLE_PD_EN;
+
+	return sprintf(buf, "%u\n", value ? 1 : 0);
+}
+
+static void do_store_altivec_idle(void *val)
+{
+	u32 *value = val;
+	u32 altivec_idle;
+
+	altivec_idle = mfspr(SPRN_PWRMGTCR0);
+
+	if (*value)
+		altivec_idle |= PWRMGTCR0_AV_IDLE_PD_EN;
+	else
+		altivec_idle &= ~PWRMGTCR0_AV_IDLE_PD_EN;
+
+	mtspr(SPRN_PWRMGTCR0, altivec_idle);
+}
+
+static ssize_t store_altivec_idle(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	u32 value;
+	unsigned int cpu = dev->id;
+
+	if (kstrtou32(buf, 0, &value))
+		return -EINVAL;
+
+	if (value > 1)
+		return -EINVAL;
+
+	smp_call_function_single(cpu, do_store_altivec_idle, &value, 1);
+
+	return count;
+}
+
+static ssize_t show_altivec_idle_wait_time(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	u32 value;
+	u64 tb_cycle;
+	s64 time;
+
+	unsigned int cpu = dev->id;
+
+	if (!altivec_idle_wt) {
+		smp_call_function_single(cpu, do_show_pwrmgtcr0, &value, 1);
+		value = (value & PWRMGTCR0_AV_IDLE_CNT) >>
+					PWRMGTCR0_AV_IDLE_CNT_SHIFT;
+
+		tb_cycle = (1 << (MAX_BIT - value)) * 2;
+		time = div_u64(tb_cycle * 1000, tb_ticks_per_usec) - 1;
+	} else {
+		time = altivec_idle_wt;
+	}
+
+	return sprintf(buf, "%llu\n", time > 0 ? time : 0);
+}
+
+static void set_altivec_idle_wait_entry_bit(void *val)
+{
+	u32 *value = val;
+	u32 altivec_idle;
+
+	altivec_idle = mfspr(SPRN_PWRMGTCR0);
+
+	/* Set Automatic AltiVec Idle Count */
+	/* clear count */
+	altivec_idle &= ~PWRMGTCR0_AV_IDLE_CNT;
+
+	/* set count */
+	altivec_idle |= ((MAX_BIT - *value) << PWRMGTCR0_AV_IDLE_CNT_SHIFT);
+
+	mtspr(SPRN_PWRMGTCR0, altivec_idle);
+}
+
+static ssize_t store_altivec_idle_wait_time(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	u32 entry_bit;
+	u64 value;
+
+	unsigned int cpu = dev->id;
+
+	if (kstrtou64(buf, 0, &value))
+		return -EINVAL;
+
+	if (!value)
+		return -EINVAL;
+
+	entry_bit = get_idle_ticks_bit(value);
+	if (entry_bit > MAX_BIT)
+		return -EINVAL;
+
+	altivec_idle_wt = value;
+	smp_call_function_single(cpu, set_altivec_idle_wait_entry_bit,
+				&entry_bit, 1);
+
+	return count;
+}
+
+/*
+ * Enable/Disable interface:
+ * 0, disable. 1, enable.
+ */
+static DEVICE_ATTR(pw20_state, 0600, show_pw20_state, store_pw20_state);
+static DEVICE_ATTR(altivec_idle, 0600, show_altivec_idle, store_altivec_idle);
+
+/*
+ * Set wait time interface:(Nanosecond)
+ * Example: Base on TBfreq is 41MHZ.
+ * 1~48(ns): TB[63]
+ * 49~97(ns): TB[62]
+ * 98~195(ns): TB[61]
+ * 196~390(ns): TB[60]
+ * 391~780(ns): TB[59]
+ * 781~1560(ns): TB[58]
+ * ...
+ */
+static DEVICE_ATTR(pw20_wait_time, 0600,
+			show_pw20_wait_time,
+			store_pw20_wait_time);
+static DEVICE_ATTR(altivec_idle_wait_time, 0600,
+			show_altivec_idle_wait_time,
+			store_altivec_idle_wait_time);
+#endif
+
 /*
  * Enabling PMCs will slow partition context switch times so we only do
  * it the first time we write to the PMCs.
@@ -407,6 +685,15 @@ static void register_cpu_online(unsigned int cpu)
 		device_create_file(s, &dev_attr_pir);
 #endif /* CONFIG_PPC64 */
 
+#ifdef CONFIG_FSL_SOC
+	if (PVR_VER(cur_cpu_spec->pvr_value) == PVR_VER_E6500) {
+		device_create_file(s, &dev_attr_pw20_state);
+		device_create_file(s, &dev_attr_pw20_wait_time);
+
+		device_create_file(s, &dev_attr_altivec_idle);
+		device_create_file(s, &dev_attr_altivec_idle_wait_time);
+	}
+#endif
 	cacheinfo_cpu_online(cpu);
 }
 
@@ -479,6 +766,15 @@ static void unregister_cpu_online(unsigned int cpu)
 		device_remove_file(s, &dev_attr_pir);
 #endif /* CONFIG_PPC64 */
 
+#ifdef CONFIG_FSL_SOC
+	if (PVR_VER(cur_cpu_spec->pvr_value) == PVR_VER_E6500) {
+		device_remove_file(s, &dev_attr_pw20_state);
+		device_remove_file(s, &dev_attr_pw20_wait_time);
+
+		device_remove_file(s, &dev_attr_altivec_idle);
+		device_remove_file(s, &dev_attr_altivec_idle_wait_time);
+	}
+#endif
 	cacheinfo_cpu_offline(cpu);
 }
 
-- 
1.8.0
