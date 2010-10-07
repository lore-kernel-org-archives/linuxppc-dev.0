Return-Path: <vgallard@amcc.com>
Received: from denmail01.apm.COM (denmail01-v4020.amcc.com [192.195.68.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9E00AB6F10
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  8 Oct 2010 06:59:35 +1100 (EST)
From: Victor Gallardo <vgallardo@apm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/3] Powerpc/4xx: Add suspend and idle support
Date: Thu,  7 Oct 2010 12:07:16 -0700
Message-Id: <1286478436-9942-1-git-send-email-vgallardo@apm.com>
Cc: Victor Gallardo <vgallardo@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add suspend/resume support for all 4xx compatible CPUs.
See /sys/power/state for available power states configured in.

Add two different idle states (idle-wait and idle-doze)
controlled via sysfs. Default is idle-wait.
	cat /sys/devices/system/cpu/cpu0/idle
	[wait] doze

To save additional power, use idle-doze.
	echo doze > /sys/devices/system/cpu/cpu0/idle
	cat /sys/devices/system/cpu/cpu0/idle
	wait [doze]

Signed-off-by: Victor Gallardo <vgallardo@apm.com>
---
 Documentation/powerpc/dts-bindings/4xx/cpm.txt |   43 +++
 arch/powerpc/Kconfig                           |   13 +-
 arch/powerpc/platforms/44x/Makefile            |    5 +-
 arch/powerpc/sysdev/Makefile                   |    1 +
 arch/powerpc/sysdev/ppc4xx_cpm.c               |  339 ++++++++++++++++++++++++
 5 files changed, 397 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/powerpc/dts-bindings/4xx/cpm.txt
 create mode 100644 arch/powerpc/sysdev/ppc4xx_cpm.c

diff --git a/Documentation/powerpc/dts-bindings/4xx/cpm.txt b/Documentation/powerpc/dts-bindings/4xx/cpm.txt
new file mode 100644
index 0000000..9635df8
--- /dev/null
+++ b/Documentation/powerpc/dts-bindings/4xx/cpm.txt
@@ -0,0 +1,43 @@
+PPC4xx Clock Power Management (CPM) node
+
+Required properties:
+	- compatible		: compatible list, currently only "ibm,cpm"
+	- dcr-access-method	: "native"
+	- dcr-reg		: < DCR register range >
+
+Optional properties:
+	- er-offset		: All 4xx SoCs with a CPM controller have
+				  one of two different order for the CPM
+				  registers. Some have the CPM registers
+				  in the following order (ER,FR,SR). The
+				  others have them in the following order
+				  (SR,ER,FR). For the second case set
+				  er-offset = <1>.
+	- unused-units		: specifier consist of one cell. For each
+				  bit in the cell, the corresponding bit
+				  in CPM will be set to turn off unused
+				  devices.
+	- idle-doze		: specifier consist of one cell. For each
+				  bit in the cell, the corresponding bit
+				  in CPM will be set to turn off unused
+				  devices. This is usually just CPM[CPU].
+	- standby		: specifier consist of one cell. For each
+				  bit in the cell, the corresponding bit
+				  in CPM will be set on standby and
+				  restored on resume.
+	- suspend		: specifier consist of one cell. For each
+				  bit in the cell, the corresponding bit
+				  in CPM will be set on suspend (mem) and
+				  restored on resume.
+
+Example:
+        CPM0: cpm {
+                compatible = "ibm,cpm";
+                dcr-access-method = "native";
+                dcr-reg = <0x160 0x003>;
+		er-offset = <0>;
+                unused-units = <0x00000100>;
+                idle-doze = <0x02000000>;
+                standby = <0xfeff0000>;
+                standby = <0xfeff791d>;
+        };
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 631e5a0..10b2f15 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -210,7 +210,7 @@ config ARCH_HIBERNATION_POSSIBLE
 config ARCH_SUSPEND_POSSIBLE
 	def_bool y
 	depends on ADB_PMU || PPC_EFIKA || PPC_LITE5200 || PPC_83xx || \
-		   PPC_85xx || PPC_86xx || PPC_PSERIES
+		   PPC_85xx || PPC_86xx || PPC_PSERIES || 44x || 40x
 
 config PPC_DCR_NATIVE
 	bool
@@ -596,13 +596,11 @@ config EXTRA_TARGETS
 
 	  If unsure, leave blank
 
-if !44x || BROKEN
 config ARCH_WANTS_FREEZER_CONTROL
 	def_bool y
 	depends on ADB_PMU
 
 source kernel/power/Kconfig
-endif
 
 config SECCOMP
 	bool "Enable seccomp to safely compute untrusted bytecode"
@@ -683,6 +681,15 @@ config FSL_PMC
 	  Freescale MPC85xx/MPC86xx power management controller support
 	  (suspend/resume). For MPC83xx see platforms/83xx/suspend.c
 
+config PPC4xx_CPM
+	bool
+	default y
+	depends on SUSPEND && (44x || 40x)
+	help
+	  PPC4xx Clock Power Management (CPM) support (suspend/resume).
+	  It also enables support for two different idle states (idle-wait
+	  and idle-doze).
+
 config 4xx_SOC
 	bool
 
diff --git a/arch/powerpc/platforms/44x/Makefile b/arch/powerpc/platforms/44x/Makefile
index 82ff326..c04d16d 100644
--- a/arch/powerpc/platforms/44x/Makefile
+++ b/arch/powerpc/platforms/44x/Makefile
@@ -1,4 +1,7 @@
-obj-$(CONFIG_44x)	:= misc_44x.o idle.o
+obj-$(CONFIG_44x)	+= misc_44x.o
+ifneq ($(CONFIG_PPC4xx_CPM),y)
+obj-$(CONFIG_44x)	+= idle.o
+endif
 obj-$(CONFIG_PPC44x_SIMPLE) += ppc44x_simple.o
 obj-$(CONFIG_EBONY)	+= ebony.o
 obj-$(CONFIG_SAM440EP) 	+= sam440ep.o
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index 5642924..a9728d1 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -42,6 +42,7 @@ obj-$(CONFIG_OF_RTC)		+= of_rtc.o
 ifeq ($(CONFIG_PCI),y)
 obj-$(CONFIG_4xx)		+= ppc4xx_pci.o
 endif
+obj-$(CONFIG_PPC4xx_CPM)	+= ppc4xx_cpm.o
 obj-$(CONFIG_PPC4xx_GPIO)	+= ppc4xx_gpio.o
 
 obj-$(CONFIG_CPM)		+= cpm_common.o
diff --git a/arch/powerpc/sysdev/ppc4xx_cpm.c b/arch/powerpc/sysdev/ppc4xx_cpm.c
new file mode 100644
index 0000000..d47a7ed
--- /dev/null
+++ b/arch/powerpc/sysdev/ppc4xx_cpm.c
@@ -0,0 +1,339 @@
+/*
+ * PowerPC 4xx Clock and Power Management
+ *
+ * Copyright (C) 2010, Applied Micro Circuits Corporation
+ * Victor Gallardo (vgallardo@apm.com)
+ *
+ * Based on arch/powerpc/platforms/44x/idle.c:
+ * Jerone Young <jyoung5@us.ibm.com>
+ * Copyright 2008 IBM Corp.
+ *
+ * Based on arch/powerpc/sysdev/fsl_pmc.c:
+ * Anton Vorontsov <avorontsov@ru.mvista.com>
+ * Copyright 2009  MontaVista Software, Inc.
+ *
+ * See file CREDITS for list of people who contributed to this
+ * project.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+ * MA 02111-1307 USA
+ */
+
+#include <linux/kernel.h>
+#include <linux/of_platform.h>
+#include <linux/sysfs.h>
+#include <linux/cpu.h>
+#include <linux/suspend.h>
+#include <asm/dcr.h>
+#include <asm/dcr-native.h>
+#include <asm/machdep.h>
+
+#define CPM_ER	0
+#define CPM_FR	1
+#define CPM_SR	2
+
+#define CPM_IDLE_WAIT	0
+#define CPM_IDLE_DOZE	1
+
+struct cpm {
+	dcr_host_t	dcr_host;
+	unsigned int	dcr_offset[3];
+	unsigned int	powersave_off;
+	unsigned int	unused;
+	unsigned int	idle_doze;
+	unsigned int	standby;
+	unsigned int	suspend;
+};
+
+static struct cpm cpm;
+
+struct cpm_idle_mode {
+	unsigned int enabled;
+	const char  *name;
+};
+
+static struct cpm_idle_mode idle_mode[] = {
+	[CPM_IDLE_WAIT] = { 1, "wait" }, /* default */
+	[CPM_IDLE_DOZE] = { 0, "doze" },
+};
+
+static void cpm_set(unsigned int cpm_reg, unsigned int mask)
+{
+	unsigned int value;
+
+	value = dcr_read(cpm.dcr_host, cpm.dcr_offset[cpm_reg]);
+	value |= mask;
+	dcr_write(cpm.dcr_host, cpm.dcr_offset[cpm_reg], value);
+}
+
+static void cpm_idle_wait(void)
+{
+	unsigned long msr_save;
+
+	/* save off initial state */
+	msr_save = mfmsr();
+	/* sync required when CPM0_ER[CPU] is set */
+	mb();
+	/* set wait state MSR */
+	mtmsr(msr_save|MSR_WE|MSR_EE|MSR_CE|MSR_DE);
+	isync();
+	/* return to initial state */
+	mtmsr(msr_save);
+	isync();
+}
+
+static void cpm_idle_sleep(unsigned int mask)
+{
+	unsigned int er_save;
+
+	/* update CPM_ER state */
+	er_save = dcr_read(cpm.dcr_host, cpm.dcr_offset[CPM_ER]);
+	dcr_write(cpm.dcr_host, cpm.dcr_offset[CPM_ER],
+		  er_save | mask);
+
+	/* go to wait state */
+	cpm_idle_wait();
+
+	/* restore CPM_ER state */
+	dcr_write(cpm.dcr_host, cpm.dcr_offset[CPM_ER], er_save);
+}
+
+static void cpm_idle_doze(void)
+{
+	cpm_idle_sleep(cpm.idle_doze);
+}
+
+static void cpm_idle_config(int mode)
+{
+	int i;
+
+	if (idle_mode[mode].enabled)
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(idle_mode); i++)
+		idle_mode[i].enabled = 0;
+
+	idle_mode[mode].enabled = 1;
+}
+
+static ssize_t cpm_idle_show(struct kobject *kobj,
+			     struct kobj_attribute *attr, char *buf)
+{
+	char *s = buf;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(idle_mode); i++) {
+		if (idle_mode[i].enabled)
+			s += sprintf(s, "[%s] ", idle_mode[i].name);
+		else
+			s += sprintf(s, "%s ", idle_mode[i].name);
+	}
+
+	*(s-1) = '\n'; /* convert the last space to a newline */
+
+	return s - buf;
+}
+
+static ssize_t cpm_idle_store(struct kobject *kobj,
+			      struct kobj_attribute *attr,
+			      const char *buf, size_t n)
+{
+	int i;
+	char *p;
+	int len;
+
+	p = memchr(buf, '\n', n);
+	len = p ? p - buf : n;
+
+	for (i = 0; i < ARRAY_SIZE(idle_mode); i++) {
+		if (strncmp(buf, idle_mode[i].name, len) == 0) {
+			cpm_idle_config(i);
+			return n;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static struct kobj_attribute cpm_idle_attr =
+	__ATTR(idle, 0644, cpm_idle_show, cpm_idle_store);
+
+static void cpm_idle_config_sysfs(void)
+{
+	struct sys_device *sys_dev;
+	unsigned long ret;
+
+	sys_dev = get_cpu_sysdev(0);
+
+	ret = sysfs_create_file(&sys_dev->kobj,
+				&cpm_idle_attr.attr);
+	if (ret)
+		printk(KERN_WARNING
+		       "cpm: failed to create idle sysfs entry\n");
+}
+
+static void cpm_idle(void)
+{
+	if (idle_mode[CPM_IDLE_DOZE].enabled)
+		cpm_idle_doze();
+	else
+		cpm_idle_wait();
+}
+
+static int cpm_suspend_valid(suspend_state_t state)
+{
+	switch (state) {
+	case PM_SUSPEND_STANDBY:
+		return !!cpm.standby;
+	case PM_SUSPEND_MEM:
+		return !!cpm.suspend;
+	default:
+		return 0;
+	}
+}
+
+static void cpm_suspend_standby(unsigned int mask)
+{
+	unsigned long tcr_save;
+
+	/* disable decrement interrupt */
+	tcr_save = mfspr(SPRN_TCR);
+	mtspr(SPRN_TCR, tcr_save & ~TCR_DIE);
+
+	/* go to sleep state */
+	cpm_idle_sleep(mask);
+
+	/* restore decrement interrupt */
+	mtspr(SPRN_TCR, tcr_save);
+}
+
+static int cpm_suspend_enter(suspend_state_t state)
+{
+	switch (state) {
+	case PM_SUSPEND_STANDBY:
+		cpm_suspend_standby(cpm.standby);
+		break;
+	case PM_SUSPEND_MEM:
+		cpm_suspend_standby(cpm.suspend);
+		break;
+	}
+
+	return 0;
+}
+
+static struct platform_suspend_ops cpm_suspend_ops = {
+	.valid		= cpm_suspend_valid,
+	.enter		= cpm_suspend_enter,
+};
+
+static int cpm_get_uint_property(struct device_node *np,
+				 const char *name)
+{
+	int len;
+	const unsigned int *prop = of_get_property(np, name, &len);
+
+	if (prop == NULL || len < sizeof(u32))
+		return 0;
+
+	return *prop;
+}
+
+static int __init cpm_init(void)
+{
+	struct device_node *np;
+	int dcr_base, dcr_len;
+	int ret = 0;
+
+	if (!cpm.powersave_off) {
+		cpm_idle_config(CPM_IDLE_WAIT);
+		ppc_md.power_save = &cpm_idle;
+	}
+
+	np = of_find_compatible_node(NULL, NULL, "ibm,cpm");
+	if (!np) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	dcr_base = dcr_resource_start(np, 0);
+	dcr_len = dcr_resource_len(np, 0);
+
+	if (dcr_base == 0 || dcr_len == 0) {
+		printk(KERN_ERR "cpm: could not parse dcr property for %s\n",
+		       np->full_name);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	cpm.dcr_host = dcr_map(np, dcr_base, dcr_len);
+
+	if (!DCR_MAP_OK(cpm.dcr_host)) {
+		printk(KERN_ERR "cpm: failed to map dcr property for %s\n",
+		       np->full_name);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* All 4xx SoCs with a CPM controller have one of two
+	 * different order for the CPM registers. Some have the
+	 * CPM registers in the following order (ER,FR,SR). The
+	 * others have them in the following order (SR,ER,FR).
+	 */
+
+	if (cpm_get_uint_property(np, "er-offset") == 0) {
+		cpm.dcr_offset[CPM_ER] = 0;
+		cpm.dcr_offset[CPM_FR] = 1;
+		cpm.dcr_offset[CPM_SR] = 2;
+	} else {
+		cpm.dcr_offset[CPM_ER] = 1;
+		cpm.dcr_offset[CPM_FR] = 2;
+		cpm.dcr_offset[CPM_SR] = 0;
+	}
+
+	/* Now let's see what IPs to turn off for the following modes */
+
+	cpm.unused = cpm_get_uint_property(np, "unused-units");
+	cpm.idle_doze = cpm_get_uint_property(np, "idle-doze");
+	cpm.standby = cpm_get_uint_property(np, "standby");
+	cpm.suspend = cpm_get_uint_property(np, "suspend");
+
+	/* If some IPs are unused let's turn them off now */
+
+	if (cpm.unused) {
+		cpm_set(CPM_ER, cpm.unused);
+		cpm_set(CPM_FR, cpm.unused);
+	}
+
+	/* Now let's export interfaces */
+
+	if (!cpm.powersave_off && cpm.idle_doze)
+		cpm_idle_config_sysfs();
+
+	if (cpm.standby || cpm.suspend)
+		suspend_set_ops(&cpm_suspend_ops);
+out:
+	if (np)
+		of_node_put(np);
+	return ret;
+}
+
+late_initcall(cpm_init);
+
+static int __init cpm_powersave_off(char *arg)
+{
+	cpm.powersave_off = 1;
+	return 0;
+}
+__setup("powersave=off", cpm_powersave_off);
-- 
1.6.1.rc3
