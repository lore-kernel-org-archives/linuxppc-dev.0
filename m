Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id 32779DDFF1
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 05:46:54 +1000 (EST)
Message-Id: <20070423193912.578031620@arndb.de>
References: <20070423193538.576702568@arndb.de>
Date: Mon, 23 Apr 2007 21:35:41 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 03/10] cbe_thermal: add throttling attributes to cpu and spu
	nodes
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>,
	Christian Krafft <krafft@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Christian Krafft <krafft@de.ibm.com>
This patch adds some attributes the cpu and spu nodes:
/sys/devices/system/[c|s]pu/[c|s]pu*/thermal/throttle_begin
/sys/devices/system/[c|s]pu/[c|s]pu*/thermal/throttle_end
/sys/devices/system/[c|s]pu/[c|s]pu*/thermal/throttle_full_stop

Signed-off-by: Christian Krafft <krafft@de.ibm.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: linux-2.6/arch/powerpc/platforms/cell/cbe_thermal.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/cbe_thermal.c
+++ linux-2.6/arch/powerpc/platforms/cell/cbe_thermal.c
@@ -1,6 +1,31 @@
 /*
  * thermal support for the cell processor
  *
+ * This module adds some sysfs attributes to cpu and spu nodes.
+ * Base for measurements are the digital thermal sensors (DTS)
+ * located on the chip.
+ * The accuracy is 2 degrees, starting from 65 up to 125 degrees celsius
+ * The attributes can be found under
+ * /sys/devices/system/cpu/cpuX/thermal
+ * /sys/devices/system/spu/spuX/thermal
+ *
+ * The following attributes are added for each node:
+ * temperature:
+ *	contains the current temperature measured by the DTS
+ * throttle_begin:
+ *	throttling begins when temperature is greater or equal to
+ *	throttle_begin. Setting this value to 125 prevents throttling.
+ * throttle_end:
+ *	throttling is being ceased, if the temperature is lower than
+ *	throttle_end. Due to a delay between applying throttling and
+ *	a reduced temperature this value should be less than throttle_begin.
+ *	A value equal to throttle_begin provides only a very little hysteresis.
+ * throttle_full_stop:
+ *	If the temperatrue is greater or equal to throttle_full_stop,
+ *	full throttling is applied to the cpu or spu. This value should be
+ *	greater than throttle_begin and throttle_end. Setting this value to
+ *	65 prevents the unit from running code at all.
+ *
  * (C) Copyright IBM Deutschland Entwicklung GmbH 2005
  *
  * Author: Christian Krafft <krafft@de.ibm.com>
@@ -31,9 +56,24 @@
 #include "cbe_regs.h"
 #include "spu_priv1_mmio.h"
 
+#define TEMP_MIN 65
+#define TEMP_MAX 125
+
+#define SYSDEV_PREFIX_ATTR(_prefix,_name,_mode)			\
+struct sysdev_attribute attr_ ## _prefix ## _ ## _name = {	\
+	.attr = { .name = __stringify(_name), .mode = _mode },	\
+	.show	= _prefix ## _show_ ## _name,			\
+	.store	= _prefix ## _store_ ## _name,			\
+};
+
 static inline u8 reg_to_temp(u8 reg_value)
 {
-       return ((reg_value & 0x3f) << 1) + 65;
+	return ((reg_value & 0x3f) << 1) + TEMP_MIN;
+}
+
+static inline u8 temp_to_reg(u8 temp)
+{
+	return ((temp - TEMP_MIN) >> 1) & 0x3f;
 }
 
 static struct cbe_pmd_regs __iomem *get_pmd_regs(struct sys_device *sysdev)
@@ -73,6 +113,73 @@ static ssize_t spu_show_temp(struct sys_
 	return sprintf(buf, "%d\n", reg_to_temp(value));
 }
 
+static ssize_t show_throttle(struct cbe_pmd_regs __iomem *pmd_regs, char *buf, int pos)
+{
+	u64 value;
+
+	value = in_be64(&pmd_regs->tm_tpr.val);
+	/* access the corresponding byte */
+	value >>= pos;
+	value &= 0x3F;
+
+	return sprintf(buf, "%d\n", reg_to_temp(value));
+}
+
+static ssize_t store_throttle(struct cbe_pmd_regs __iomem *pmd_regs, const char *buf, size_t size, int pos)
+{
+	u64 reg_value;
+	int temp;
+	u64 new_value;
+	int ret;
+
+	ret = sscanf(buf, "%u", &temp);
+
+	if (ret != 1 || temp < TEMP_MIN || temp > TEMP_MAX)
+		return -EINVAL;
+
+	new_value = temp_to_reg(temp);
+
+	reg_value = in_be64(&pmd_regs->tm_tpr.val);
+
+	/* zero out bits for new value */
+	reg_value &= ~(0xffull << pos);
+	/* set bits to new value */
+	reg_value |= new_value << pos;
+
+	out_be64(&pmd_regs->tm_tpr.val, reg_value);
+	return size;
+}
+
+static ssize_t spu_show_throttle_end(struct sys_device *sysdev, char *buf)
+{
+	return show_throttle(get_pmd_regs(sysdev), buf, 0);
+}
+
+static ssize_t spu_show_throttle_begin(struct sys_device *sysdev, char *buf)
+{
+	return show_throttle(get_pmd_regs(sysdev), buf, 8);
+}
+
+static ssize_t spu_show_throttle_full_stop(struct sys_device *sysdev, char *buf)
+{
+	return show_throttle(get_pmd_regs(sysdev), buf, 16);
+}
+
+static ssize_t spu_store_throttle_end(struct sys_device *sysdev, const char *buf, size_t size)
+{
+	return store_throttle(get_pmd_regs(sysdev), buf, size, 0);
+}
+
+static ssize_t spu_store_throttle_begin(struct sys_device *sysdev, const char *buf, size_t size)
+{
+	return store_throttle(get_pmd_regs(sysdev), buf, size, 8);
+}
+
+static ssize_t spu_store_throttle_full_stop(struct sys_device *sysdev, const char *buf, size_t size)
+{
+	return store_throttle(get_pmd_regs(sysdev), buf, size, 16);
+}
+
 static ssize_t ppe_show_temp(struct sys_device *sysdev, char *buf, int pos)
 {
 	struct cbe_pmd_regs __iomem *pmd_regs;
@@ -100,13 +207,52 @@ static ssize_t ppe_show_temp1(struct sys
 	return ppe_show_temp(sysdev, buf, 0);
 }
 
+static ssize_t ppe_show_throttle_end(struct sys_device *sysdev, char *buf)
+{
+	return show_throttle(cbe_get_cpu_pmd_regs(sysdev->id), buf, 32);
+}
+
+static ssize_t ppe_show_throttle_begin(struct sys_device *sysdev, char *buf)
+{
+	return show_throttle(cbe_get_cpu_pmd_regs(sysdev->id), buf, 40);
+}
+
+static ssize_t ppe_show_throttle_full_stop(struct sys_device *sysdev, char *buf)
+{
+	return show_throttle(cbe_get_cpu_pmd_regs(sysdev->id), buf, 48);
+}
+
+static ssize_t ppe_store_throttle_end(struct sys_device *sysdev, const char *buf, size_t size)
+{
+	return store_throttle(cbe_get_cpu_pmd_regs(sysdev->id), buf, size, 32);
+}
+
+static ssize_t ppe_store_throttle_begin(struct sys_device *sysdev, const char *buf, size_t size)
+{
+	return store_throttle(cbe_get_cpu_pmd_regs(sysdev->id), buf, size, 40);
+}
+
+static ssize_t ppe_store_throttle_full_stop(struct sys_device *sysdev, const char *buf, size_t size)
+{
+	return store_throttle(cbe_get_cpu_pmd_regs(sysdev->id), buf, size, 48);
+}
+
+
 static struct sysdev_attribute attr_spu_temperature = {
 	.attr = {.name = "temperature", .mode = 0400 },
 	.show = spu_show_temp,
 };
 
+static SYSDEV_PREFIX_ATTR(spu, throttle_end, 0600);
+static SYSDEV_PREFIX_ATTR(spu, throttle_begin, 0600);
+static SYSDEV_PREFIX_ATTR(spu, throttle_full_stop, 0600);
+
+
 static struct attribute *spu_attributes[] = {
 	&attr_spu_temperature.attr,
+	&attr_spu_throttle_end.attr,
+	&attr_spu_throttle_begin.attr,
+	&attr_spu_throttle_full_stop.attr,
 	NULL,
 };
 
@@ -125,9 +271,16 @@ static struct sysdev_attribute attr_ppe_
 	.show = ppe_show_temp1,
 };
 
+static SYSDEV_PREFIX_ATTR(ppe, throttle_end, 0600);
+static SYSDEV_PREFIX_ATTR(ppe, throttle_begin, 0600);
+static SYSDEV_PREFIX_ATTR(ppe, throttle_full_stop, 0600);
+
 static struct attribute *ppe_attributes[] = {
 	&attr_ppe_temperature0.attr,
 	&attr_ppe_temperature1.attr,
+	&attr_ppe_throttle_end.attr,
+	&attr_ppe_throttle_begin.attr,
+	&attr_ppe_throttle_full_stop.attr,
 	NULL,
 };
 

--
