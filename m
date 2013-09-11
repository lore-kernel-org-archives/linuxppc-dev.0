Return-Path: <B40534@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe002.messaging.microsoft.com [65.55.88.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7B8922C03A0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Sep 2013 16:00:48 +1000 (EST)
From: Dongsheng Wang <dongsheng.wang@freescale.com>
To: <scottwood@freescale.com>
Subject: [PATCH v3 4/4] powerpc/85xx: add sysfs for pw20 state and altivec idle
Date: Wed, 11 Sep 2013 13:56:44 +0800
Message-ID: <1378879004-2446-4-git-send-email-dongsheng.wang@freescale.com>
In-Reply-To: <1378879004-2446-1-git-send-email-dongsheng.wang@freescale.com>
References: <1378879004-2446-1-git-send-email-dongsheng.wang@freescale.com>
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

Add a sys interface to enable/diable pw20 state or altivec idle, and
control the wait entry time.

Enable/Disable interface:
0, disable. 1, enable.
/sys/devices/system/cpu/cpuX/pw20_state
/sys/devices/system/cpu/cpuX/altivec_idle

Set wait entry bit interface:
bit value range 0~63, 0 bit is Mintime, 63 bit is Maxtime.
/sys/devices/system/cpu/cpuX/pw20_wait_entry_bit
/sys/devices/system/cpu/cpuX/altivec_idle_wait_entry_bit

Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
---
diff --git a/arch/powerpc/kernel/cpu_setup_fsl_booke.S b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
index 7389d49..7395d79 100644
--- a/arch/powerpc/kernel/cpu_setup_fsl_booke.S
+++ b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
@@ -53,6 +53,21 @@ _GLOBAL(__e500_dcache_setup)
 	isync
 	blr

+_GLOBAL(has_pw20_altivec_idle)
+	/* 0 false, 1 true */
+	li	r3, 0
+
+	/* PW20 & AltiVec idle feature only exists for E6500 */
+	mfspr	r0, SPRN_PVR
+	rlwinm	r4, r0, 16, 16, 31
+	lis	r12, 0
+	ori	r12, r12, PVR_VER_E6500@l
+	cmpw	r4, r12
+	bne	2f
+	li	r3, 1
+2:
+	blr
+
 /*
  * FIXME - We don't know, what time should we let the core into PW20 state.
  * because we don't know the current state of the cpu load. And threads are
diff --git a/arch/powerpc/platforms/85xx/common.c b/arch/powerpc/platforms/85xx/common.c
index d0861a0..fe4d3a7 100644
--- a/arch/powerpc/platforms/85xx/common.c
+++ b/arch/powerpc/platforms/85xx/common.c
@@ -5,12 +5,16 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+
+#include <linux/cpu.h>
 #include <linux/of_platform.h>

 #include <sysdev/cpm2_pic.h>

 #include "mpc85xx.h"

+#define MAX_BIT		63
+
 static struct of_device_id __initdata mpc85xx_common_ids[] = {
 	{ .type = "soc", },
 	{ .compatible = "soc", },
@@ -80,3 +84,234 @@ void __init mpc85xx_cpm2_pic_init(void)
 	irq_set_chained_handler(irq, cpm2_cascade);
 }
 #endif
+
+static void query_pwrmgtcr0(void *val)
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
+	smp_call_function_single(cpu, query_pwrmgtcr0, &value, 1);
+
+	value &= PWRMGTCR0_PW20_WAIT;
+
+	return sprintf(buf, "%u\n", value ? 1 : 0);
+}
+
+static void control_pw20_state(void *val)
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
+	smp_call_function_single(cpu, control_pw20_state, &value, 1);
+
+	return count;
+}
+
+static ssize_t show_pw20_wait_entry_bit(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	u32 value;
+	unsigned int cpu = dev->id;
+
+	smp_call_function_single(cpu, query_pwrmgtcr0, &value, 1);
+
+	value = MAX_BIT - ((value & PWRMGTCR0_PW20_ENT) >>
+				PWRMGTCR0_PW20_ENT_SHIFT);
+
+	return sprintf(buf, "wait entry bit is %u\n", value);
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
+static ssize_t store_pw20_wait_entry_bit(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	u32 value;
+	unsigned int cpu = dev->id;
+
+	if (kstrtou32(buf, 0, &value))
+		return -EINVAL;
+
+	if (value > MAX_BIT)
+		return -EINVAL;
+
+	smp_call_function_single(cpu, set_pw20_wait_entry_bit,
+				&value, 1);
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
+	smp_call_function_single(cpu, query_pwrmgtcr0, &value, 1);
+
+	value &= PWRMGTCR0_AV_IDLE_PD_EN;
+
+	return sprintf(buf, "%u\n", value ? 1 : 0);
+}
+
+static void control_altivec_idle(void *val)
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
+	smp_call_function_single(cpu, control_altivec_idle, &value, 1);
+
+	return count;
+}
+
+static ssize_t show_altivec_idle_wait_entry_bit(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	u32 value;
+	unsigned int cpu = dev->id;
+
+	smp_call_function_single(cpu, query_pwrmgtcr0, &value, 1);
+
+	value = MAX_BIT - ((value & PWRMGTCR0_AV_IDLE_CNT) >>
+				PWRMGTCR0_AV_IDLE_CNT_SHIFT);
+
+	return sprintf(buf, "wait entry bit is %u\n", value);
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
+	altivec_idle |=
+		((MAX_BIT - *value) << PWRMGTCR0_AV_IDLE_CNT_SHIFT);
+
+	mtspr(SPRN_PWRMGTCR0, altivec_idle);
+}
+
+static ssize_t store_altivec_idle_wait_entry_bit(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	u32 value;
+	unsigned int cpu = dev->id;
+
+	if (kstrtou32(buf, 0, &value))
+		return -EINVAL;
+
+	if (value > MAX_BIT)
+		return -EINVAL;
+
+	smp_call_function_single(cpu, set_altivec_idle_wait_entry_bit,
+				&value, 1);
+
+	return count;
+}
+
+static DEVICE_ATTR(pw20_state, 0644, show_pw20_state, store_pw20_state);
+static DEVICE_ATTR(pw20_wait_entry_bit, 0644, show_pw20_wait_entry_bit,
+						store_pw20_wait_entry_bit);
+
+static DEVICE_ATTR(altivec_idle, 0644, show_altivec_idle, store_altivec_idle);
+static DEVICE_ATTR(altivec_idle_wait_entry_bit, 0644,
+			show_altivec_idle_wait_entry_bit,
+			store_altivec_idle_wait_entry_bit);
+
+static int __init create_pw20_altivec_sysfs(void)
+{
+	int i;
+	struct device *cpu_dev;
+
+	if (!has_pw20_altivec_idle())
+		return -ENODEV;
+
+	for_each_possible_cpu(i) {
+		cpu_dev = get_cpu_device(i);
+		device_create_file(cpu_dev, &dev_attr_pw20_state);
+		device_create_file(cpu_dev, &dev_attr_pw20_wait_entry_bit);
+
+		device_create_file(cpu_dev, &dev_attr_altivec_idle);
+		device_create_file(cpu_dev,
+					&dev_attr_altivec_idle_wait_entry_bit);
+	}
+
+	return 0;
+}
+device_initcall(create_pw20_altivec_sysfs);
diff --git a/arch/powerpc/platforms/85xx/mpc85xx.h b/arch/powerpc/platforms/85xx/mpc85xx.h
index 2aa7c5d..e454d4d 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx.h
+++ b/arch/powerpc/platforms/85xx/mpc85xx.h
@@ -1,6 +1,7 @@
 #ifndef MPC85xx_H
 #define MPC85xx_H
 extern int mpc85xx_common_publish_devices(void);
+extern bool has_pw20_altivec_idle(void);

 #ifdef CONFIG_CPM2
 extern void mpc85xx_cpm2_pic_init(void);
--
1.8.0
