Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xSYbQ6BHHzDqrx
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Aug 2017 13:32:02 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7A3TKGu125827
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Aug 2017 23:32:00 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c878w8bye-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Aug 2017 23:32:00 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Thu, 10 Aug 2017 13:31:57 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v7A3VsMd26542118
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Aug 2017 13:31:54 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v7A3Vrp7009397
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Aug 2017 13:31:54 +1000
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: stewart@linux.vnet.ibm.com, cyrilbur@gmail.com, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org, paulus@samba.org, ego@linux.vnet.ibm.com,
 svaidy@linux.vnet.ibm.com,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH V11 3/3] powernv: Add support to clear sensor groups data
Date: Thu, 10 Aug 2017 09:01:20 +0530
In-Reply-To: <1502335880-30686-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1502335880-30686-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Message-Id: <1502335880-30686-4-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Adds support for clearing different sensor groups. OCC inband sensor
groups like CSM, Profiler, Job Scheduler can be cleared using this
driver. The min/max of all sensors belonging to these sensor groups
will be cleared.

Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
 .../bindings/powerpc/opal/sensor-groups.txt        |  27 +++
 arch/powerpc/include/asm/opal-api.h                |   1 +
 arch/powerpc/include/asm/opal.h                    |   2 +
 arch/powerpc/platforms/powernv/Makefile            |   2 +-
 .../powerpc/platforms/powernv/opal-sensor-groups.c | 212 +++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal-wrappers.S     |   1 +
 arch/powerpc/platforms/powernv/opal.c              |   3 +
 7 files changed, 247 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/powerpc/opal/sensor-groups.txt
 create mode 100644 arch/powerpc/platforms/powernv/opal-sensor-groups.c

diff --git a/Documentation/devicetree/bindings/powerpc/opal/sensor-groups.txt b/Documentation/devicetree/bindings/powerpc/opal/sensor-groups.txt
new file mode 100644
index 0000000..6ad881c
--- /dev/null
+++ b/Documentation/devicetree/bindings/powerpc/opal/sensor-groups.txt
@@ -0,0 +1,27 @@
+IBM OPAL Sensor Groups Binding
+-------------------------------
+
+Node: /ibm,opal/sensor-groups
+
+Description: Contains sensor groups available in the Powernv P9
+servers. Each child node indicates a sensor group.
+
+- compatible : Should be "ibm,opal-sensor-group"
+
+Each child node contains below properties:
+
+- type : String to indicate the type of sensor-group
+
+- sensor-group-id: Abstract unique identifier provided by firmware of
+		   type <u32> which is used for sensor-group
+		   operations like clearing the min/max history of all
+		   sensors belonging to the group.
+
+- ibm,chip-id : Chip ID
+
+- sensors : Phandle array of child nodes of /ibm,opal/sensor/
+	    belonging to this group
+
+- ops : Array of opal-call numbers indicating available operations on
+	sensor groups like clearing min/max, enabling/disabling sensor
+	group.
diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 0cb7d11..450a60b 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -198,6 +198,7 @@
 #define OPAL_SET_POWERCAP			153
 #define OPAL_GET_POWER_SHIFT_RATIO		154
 #define OPAL_SET_POWER_SHIFT_RATIO		155
+#define OPAL_SENSOR_GROUP_CLEAR			156
 #define OPAL_PCI_SET_P2P			157
 #define OPAL_LAST				157
 
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index d87ffcb..97ff192 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -279,6 +279,7 @@ int64_t opal_imc_counters_init(uint32_t type, uint64_t address,
 int opal_set_powercap(u32 handle, int token, u32 pcap);
 int opal_get_power_shift_ratio(u32 handle, int token, u32 *psr);
 int opal_set_power_shift_ratio(u32 handle, int token, u32 psr);
+int opal_sensor_group_clear(u32 group_hndl, int token);
 
 /* Internal functions */
 extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
@@ -359,6 +360,7 @@ static inline int opal_get_async_rc(struct opal_msg msg)
 
 void opal_powercap_init(void);
 void opal_psr_init(void);
+void opal_sensor_groups_init(void);
 
 #endif /* __ASSEMBLY__ */
 
diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index 674ed1e..177b3d4 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -2,7 +2,7 @@ obj-y			+= setup.o opal-wrappers.o opal.o opal-async.o idle.o
 obj-y			+= opal-rtc.o opal-nvram.o opal-lpc.o opal-flash.o
 obj-y			+= rng.o opal-elog.o opal-dump.o opal-sysparam.o opal-sensor.o
 obj-y			+= opal-msglog.o opal-hmi.o opal-power.o opal-irqchip.o
-obj-y			+= opal-kmsg.o opal-powercap.o opal-psr.o
+obj-y			+= opal-kmsg.o opal-powercap.o opal-psr.o opal-sensor-groups.o
 
 obj-$(CONFIG_SMP)	+= smp.o subcore.o subcore-asm.o
 obj-$(CONFIG_PCI)	+= pci.o pci-ioda.o npu-dma.o
diff --git a/arch/powerpc/platforms/powernv/opal-sensor-groups.c b/arch/powerpc/platforms/powernv/opal-sensor-groups.c
new file mode 100644
index 0000000..7e5a235
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/opal-sensor-groups.c
@@ -0,0 +1,212 @@
+/*
+ * PowerNV OPAL Sensor-groups interface
+ *
+ * Copyright 2017 IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#define pr_fmt(fmt)     "opal-sensor-groups: " fmt
+
+#include <linux/of.h>
+#include <linux/kobject.h>
+#include <linux/slab.h>
+
+#include <asm/opal.h>
+
+DEFINE_MUTEX(sg_mutex);
+
+static struct kobject *sg_kobj;
+
+struct sg_attr {
+	u32 handle;
+	struct kobj_attribute attr;
+};
+
+static struct sensor_group {
+	char name[20];
+	struct attribute_group sg;
+	struct sg_attr *sgattrs;
+} *sgs;
+
+static ssize_t sg_store(struct kobject *kobj, struct kobj_attribute *attr,
+			const char *buf, size_t count)
+{
+	struct sg_attr *sattr = container_of(attr, struct sg_attr, attr);
+	struct opal_msg msg;
+	u32 data;
+	int ret, token;
+
+	ret = kstrtoint(buf, 0, &data);
+	if (ret)
+		return ret;
+
+	if (data != 1)
+		return -EINVAL;
+
+	token = opal_async_get_token_interruptible();
+	if (token < 0) {
+		pr_devel("Failed to get token\n");
+		return token;
+	}
+
+	ret = mutex_lock_interruptible(&sg_mutex);
+	if (ret)
+		goto out_token;
+
+	ret = opal_sensor_group_clear(sattr->handle, token);
+	switch (ret) {
+	case OPAL_ASYNC_COMPLETION:
+		ret = opal_async_wait_response(token, &msg);
+		if (ret) {
+			pr_devel("Failed to wait for the async response\n");
+			ret = -EIO;
+			goto out;
+		}
+		ret = opal_error_code(opal_get_async_rc(msg));
+		if (!ret)
+			ret = count;
+		break;
+	case OPAL_SUCCESS:
+		ret = count;
+		break;
+	default:
+		ret = opal_error_code(ret);
+	}
+
+out:
+	mutex_unlock(&sg_mutex);
+out_token:
+	opal_async_release_token(token);
+	return ret;
+}
+
+static struct sg_ops_info {
+	int opal_no;
+	const char *attr_name;
+	ssize_t (*store)(struct kobject *kobj, struct kobj_attribute *attr,
+			const char *buf, size_t count);
+} ops_info[] = {
+	{ OPAL_SENSOR_GROUP_CLEAR, "clear", sg_store },
+};
+
+static void add_attr(int handle, struct sg_attr *attr, int index)
+{
+	attr->handle = handle;
+	sysfs_attr_init(&attr->attr.attr);
+	attr->attr.attr.name = ops_info[index].attr_name;
+	attr->attr.attr.mode = 0220;
+	attr->attr.store = ops_info[index].store;
+}
+
+static int add_attr_group(const __be32 *ops, int len, struct sensor_group *sg,
+			   u32 handle)
+{
+	int i, j;
+	int count = 0;
+
+	for (i = 0; i < len; i++)
+		for (j = 0; j < ARRAY_SIZE(ops_info); j++)
+			if (be32_to_cpu(ops[i]) == ops_info[j].opal_no) {
+				add_attr(handle, &sg->sgattrs[count], j);
+				sg->sg.attrs[count] =
+					&sg->sgattrs[count].attr.attr;
+				count++;
+			}
+
+	return sysfs_create_group(sg_kobj, &sg->sg);
+}
+
+static int get_nr_attrs(const __be32 *ops, int len)
+{
+	int i, j;
+	int nr_attrs = 0;
+
+	for (i = 0; i < len; i++)
+		for (j = 0; j < ARRAY_SIZE(ops_info); j++)
+			if (be32_to_cpu(ops[i]) == ops_info[j].opal_no)
+				nr_attrs++;
+
+	return nr_attrs;
+}
+
+void __init opal_sensor_groups_init(void)
+{
+	struct device_node *sg, *node;
+	int i = 0;
+
+	sg = of_find_compatible_node(NULL, NULL, "ibm,opal-sensor-group");
+	if (!sg) {
+		pr_devel("Sensor groups node not found\n");
+		return;
+	}
+
+	sgs = kcalloc(of_get_child_count(sg), sizeof(*sgs), GFP_KERNEL);
+	if (!sgs)
+		return;
+
+	sg_kobj = kobject_create_and_add("sensor_groups", opal_kobj);
+	if (!sg_kobj) {
+		pr_warn("Failed to create sensor group kobject\n");
+		goto out_sgs;
+	}
+
+	for_each_child_of_node(sg, node) {
+		const __be32 *ops;
+		u32 sgid, len, nr_attrs, chipid;
+
+		ops = of_get_property(node, "ops", &len);
+		if (!ops)
+			continue;
+
+		nr_attrs = get_nr_attrs(ops, len);
+		if (!nr_attrs)
+			continue;
+
+		sgs[i].sgattrs = kcalloc(nr_attrs, sizeof(struct sg_attr),
+					 GFP_KERNEL);
+		if (!sgs[i].sgattrs)
+			goto out_sgs_sgattrs;
+
+		sgs[i].sg.attrs = kcalloc(nr_attrs + 1,
+					  sizeof(struct attribute *),
+					  GFP_KERNEL);
+
+		if (!sgs[i].sg.attrs) {
+			kfree(sgs[i].sgattrs);
+			goto out_sgs_sgattrs;
+		}
+
+		if (of_property_read_u32(node, "sensor-group-id", &sgid)) {
+			pr_warn("sensor-group-id property not found\n");
+			goto out_sgs_sgattrs;
+		}
+
+		if (!of_property_read_u32(node, "ibm,chip-id", &chipid))
+			sprintf(sgs[i].name, "%s%d", node->name, chipid);
+		else
+			sprintf(sgs[i].name, "%s", node->name);
+
+		sgs[i].sg.name = sgs[i].name;
+		if (add_attr_group(ops, len, &sgs[i], sgid)) {
+			pr_warn("Failed to create sensor attribute group %s\n",
+				sgs[i].sg.name);
+			goto out_sgs_sgattrs;
+		}
+		i++;
+	}
+
+	return;
+
+out_sgs_sgattrs:
+	while (--i >= 0) {
+		kfree(sgs[i].sgattrs);
+		kfree(sgs[i].sg.attrs);
+	}
+	kobject_put(sg_kobj);
+out_sgs:
+	kfree(sgs);
+}
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 09cc6ec..951fa93 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -318,3 +318,4 @@ OPAL_CALL(opal_get_powercap,			OPAL_GET_POWERCAP);
 OPAL_CALL(opal_set_powercap,			OPAL_SET_POWERCAP);
 OPAL_CALL(opal_get_power_shift_ratio,		OPAL_GET_POWER_SHIFT_RATIO);
 OPAL_CALL(opal_set_power_shift_ratio,		OPAL_SET_POWER_SHIFT_RATIO);
+OPAL_CALL(opal_sensor_group_clear,		OPAL_SENSOR_GROUP_CLEAR);
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index f659edb..3c122d0 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -856,6 +856,9 @@ static int __init opal_init(void)
 	/* Initialise OPAL Power-Shifting-Ratio interface */
 	opal_psr_init();
 
+	/* Initialise OPAL sensor groups */
+	opal_sensor_groups_init();
+
 	return 0;
 }
 machine_subsys_initcall(powernv, opal_init);
-- 
1.8.3.1
