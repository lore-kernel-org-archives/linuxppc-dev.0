Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xLNZB5M7HzDrLX
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 12:24:34 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6V2NpdG090777
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Jul 2017 22:24:32 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c1bt129dq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Jul 2017 22:24:32 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Mon, 31 Jul 2017 12:24:29 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6V2OSRr21561498
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 12:24:28 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6V2ORCJ013482
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 12:24:28 +1000
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: stewart@linux.vnet.ibm.com, cyrilbur@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 ego@linux.vnet.ibm.com, svaidy@linux.vnet.ibm.com,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH V9 1/3] powernv: powercap: Add support for powercap framework
Date: Mon, 31 Jul 2017 07:54:16 +0530
In-Reply-To: <1501467858-8887-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1501467858-8887-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Message-Id: <1501467858-8887-2-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Adds a generic powercap framework to change the system powercap
inband through OPAL-OCC command/response interface.

Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
Changes from V8:
- Use __pa() while passing pointer in opal call
- Use mutex_lock_interruptible()
- Fix error codes returned to user
- Allocate and add sysfs attributes in a single loop

 arch/powerpc/include/asm/opal-api.h            |   5 +-
 arch/powerpc/include/asm/opal.h                |   4 +
 arch/powerpc/platforms/powernv/Makefile        |   2 +-
 arch/powerpc/platforms/powernv/opal-powercap.c | 243 +++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal-wrappers.S |   2 +
 arch/powerpc/platforms/powernv/opal.c          |   4 +
 6 files changed, 258 insertions(+), 2 deletions(-)
 create mode 100644 arch/powerpc/platforms/powernv/opal-powercap.c

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 3130a73..c3e0c4a 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -42,6 +42,7 @@
 #define OPAL_I2C_STOP_ERR	-24
 #define OPAL_XIVE_PROVISIONING	-31
 #define OPAL_XIVE_FREE_ACTIVE	-32
+#define OPAL_TIMEOUT		-33
 
 /* API Tokens (in r0) */
 #define OPAL_INVALID_CALL		       -1
@@ -190,7 +191,9 @@
 #define OPAL_NPU_INIT_CONTEXT			146
 #define OPAL_NPU_DESTROY_CONTEXT		147
 #define OPAL_NPU_MAP_LPAR			148
-#define OPAL_LAST				148
+#define OPAL_GET_POWERCAP			152
+#define OPAL_SET_POWERCAP			153
+#define OPAL_LAST				153
 
 /* Device tree flags */
 
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 588fb1c..ec2087c 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -267,6 +267,8 @@ int64_t opal_xive_set_vp_info(uint64_t vp,
 int64_t opal_xive_free_irq(uint32_t girq);
 int64_t opal_xive_sync(uint32_t type, uint32_t id);
 int64_t opal_xive_dump(uint32_t type, uint32_t id);
+int opal_get_powercap(u32 handle, int token, u32 *pcap);
+int opal_set_powercap(u32 handle, int token, u32 pcap);
 
 /* Internal functions */
 extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
@@ -345,6 +347,8 @@ static inline int opal_get_async_rc(struct opal_msg msg)
 
 void opal_wake_poller(void);
 
+void opal_powercap_init(void);
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_POWERPC_OPAL_H */
diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index b5d98cb..e79f806 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -2,7 +2,7 @@ obj-y			+= setup.o opal-wrappers.o opal.o opal-async.o idle.o
 obj-y			+= opal-rtc.o opal-nvram.o opal-lpc.o opal-flash.o
 obj-y			+= rng.o opal-elog.o opal-dump.o opal-sysparam.o opal-sensor.o
 obj-y			+= opal-msglog.o opal-hmi.o opal-power.o opal-irqchip.o
-obj-y			+= opal-kmsg.o
+obj-y			+= opal-kmsg.o opal-powercap.o
 
 obj-$(CONFIG_SMP)	+= smp.o subcore.o subcore-asm.o
 obj-$(CONFIG_PCI)	+= pci.o pci-ioda.o npu-dma.o
diff --git a/arch/powerpc/platforms/powernv/opal-powercap.c b/arch/powerpc/platforms/powernv/opal-powercap.c
new file mode 100644
index 0000000..9be5093
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/opal-powercap.c
@@ -0,0 +1,243 @@
+/*
+ * PowerNV OPAL Powercap interface
+ *
+ * Copyright 2017 IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#define pr_fmt(fmt)     "opal-powercap: " fmt
+
+#include <linux/of.h>
+#include <linux/kobject.h>
+#include <linux/slab.h>
+
+#include <asm/opal.h>
+
+DEFINE_MUTEX(powercap_mutex);
+
+static struct kobject *powercap_kobj;
+
+struct powercap_attr {
+	u32 handle;
+	struct kobj_attribute attr;
+};
+
+static struct pcap {
+	struct attribute_group pg;
+	struct powercap_attr *pattrs;
+} *pcaps;
+
+static ssize_t powercap_show(struct kobject *kobj, struct kobj_attribute *attr,
+			     char *buf)
+{
+	struct powercap_attr *pcap_attr = container_of(attr,
+						struct powercap_attr, attr);
+	struct opal_msg msg;
+	u32 pcap;
+	int ret, token;
+
+	token = opal_async_get_token_interruptible();
+	if (token < 0) {
+		pr_devel("Failed to get token\n");
+		return token;
+	}
+
+	ret = mutex_lock_interruptible(&powercap_mutex);
+	if (ret)
+		return ret;
+
+	ret = opal_get_powercap(pcap_attr->handle, token, (u32 *)__pa(&pcap));
+	switch (ret) {
+	case OPAL_ASYNC_COMPLETION:
+		ret = opal_async_wait_response(token, &msg);
+		if (ret) {
+			pr_devel("Failed to wait for the async response\n");
+			ret = -EIO;
+			goto out;
+		}
+		ret = opal_error_code(opal_get_async_rc(msg));
+		if (!ret) {
+			ret = sprintf(buf, "%u\n", be32_to_cpu(pcap));
+			if (ret < 0)
+				ret = -EIO;
+		}
+		break;
+	case OPAL_SUCCESS:
+		ret = sprintf(buf, "%u\n", be32_to_cpu(pcap));
+		if (ret < 0)
+			ret = -EIO;
+		break;
+	default:
+		ret = opal_error_code(ret);
+	}
+
+out:
+	mutex_unlock(&powercap_mutex);
+	opal_async_release_token(token);
+	return ret;
+}
+
+static ssize_t powercap_store(struct kobject *kobj,
+			      struct kobj_attribute *attr, const char *buf,
+			      size_t count)
+{
+	struct powercap_attr *pcap_attr = container_of(attr,
+						struct powercap_attr, attr);
+	struct opal_msg msg;
+	u32 pcap;
+	int ret, token;
+
+	ret = kstrtoint(buf, 0, &pcap);
+	if (ret)
+		return ret;
+
+	token = opal_async_get_token_interruptible();
+	if (token < 0) {
+		pr_devel("Failed to get token\n");
+		return token;
+	}
+
+	ret = mutex_lock_interruptible(&powercap_mutex);
+	if (ret)
+		return ret;
+
+	ret = opal_set_powercap(pcap_attr->handle, token, pcap);
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
+	mutex_unlock(&powercap_mutex);
+	opal_async_release_token(token);
+
+	return ret;
+}
+
+static void powercap_add_attr(int handle, const char *name,
+			      struct powercap_attr *attr)
+{
+	attr->handle = handle;
+	sysfs_attr_init(&attr->attr.attr);
+	attr->attr.attr.name = name;
+	attr->attr.attr.mode = 0444;
+	attr->attr.show = powercap_show;
+}
+
+void __init opal_powercap_init(void)
+{
+	struct device_node *powercap, *node;
+	int i = 0;
+
+	powercap = of_find_compatible_node(NULL, NULL, "ibm,opal-powercap");
+	if (!powercap) {
+		pr_devel("Powercap node not found\n");
+		return;
+	}
+
+	pcaps = kcalloc(of_get_child_count(powercap), sizeof(*pcaps),
+			GFP_KERNEL);
+	if (!pcaps)
+		return;
+
+	powercap_kobj = kobject_create_and_add("powercap", opal_kobj);
+	if (!powercap_kobj) {
+		pr_warn("Failed to create powercap kobject\n");
+		goto out_pcaps;
+	}
+
+	i = 0;
+	for_each_child_of_node(powercap, node) {
+		u32 cur, min, max;
+		int j = 0;
+		bool has_cur = false, has_min = false, has_max = false;
+
+		if (!of_property_read_u32(node, "powercap-min", &min)) {
+			j++;
+			has_min = true;
+		}
+
+		if (!of_property_read_u32(node, "powercap-max", &max)) {
+			j++;
+			has_max = true;
+		}
+
+		if (!of_property_read_u32(node, "powercap-current", &cur)) {
+			j++;
+			has_cur = true;
+		}
+
+		pcaps[i].pattrs = kcalloc(j, sizeof(struct powercap_attr),
+					  GFP_KERNEL);
+		if (!pcaps[i].pattrs)
+			goto out_pcaps_pattrs;
+
+		pcaps[i].pg.attrs = kcalloc(j + 1, sizeof(struct attribute *),
+					    GFP_KERNEL);
+		if (!pcaps[i].pg.attrs) {
+			kfree(pcaps[i].pattrs);
+			goto out_pcaps_pattrs;
+		}
+
+		j = 0;
+		pcaps[i].pg.name = node->name;
+		if (has_min) {
+			powercap_add_attr(min, "powercap-min",
+					  &pcaps[i].pattrs[j]);
+			pcaps[i].pg.attrs[j] = &pcaps[i].pattrs[j].attr.attr;
+			j++;
+		}
+
+		if (has_max) {
+			powercap_add_attr(max, "powercap-max",
+					  &pcaps[i].pattrs[j]);
+			pcaps[i].pg.attrs[j] = &pcaps[i].pattrs[j].attr.attr;
+			j++;
+		}
+
+		if (has_cur) {
+			powercap_add_attr(cur, "powercap-current",
+					  &pcaps[i].pattrs[j]);
+			pcaps[i].pattrs[j].attr.attr.mode |= 0220;
+			pcaps[i].pattrs[j].attr.store = powercap_store;
+			pcaps[i].pg.attrs[j] = &pcaps[i].pattrs[j].attr.attr;
+			j++;
+		}
+
+		if (sysfs_create_group(powercap_kobj, &pcaps[i].pg)) {
+			pr_warn("Failed to create powercap attribute group %s\n",
+				pcaps[i].pg.name);
+			goto out_pcaps_pattrs;
+		}
+		i++;
+	}
+
+	return;
+
+out_pcaps_pattrs:
+	while (--i >= 0) {
+		kfree(pcaps[i].pattrs);
+		kfree(pcaps[i].pg.attrs);
+	}
+	kobject_put(powercap_kobj);
+out_pcaps:
+	kfree(pcaps);
+}
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 4ca6c26..eff5fe7 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -310,3 +310,5 @@ OPAL_CALL(opal_xive_dump,			OPAL_XIVE_DUMP);
 OPAL_CALL(opal_npu_init_context,		OPAL_NPU_INIT_CONTEXT);
 OPAL_CALL(opal_npu_destroy_context,		OPAL_NPU_DESTROY_CONTEXT);
 OPAL_CALL(opal_npu_map_lpar,			OPAL_NPU_MAP_LPAR);
+OPAL_CALL(opal_get_powercap,			OPAL_GET_POWERCAP);
+OPAL_CALL(opal_set_powercap,			OPAL_SET_POWERCAP);
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index cad6b57..889da97 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -836,6 +836,9 @@ static int __init opal_init(void)
 	/* Initialise OPAL kmsg dumper for flushing console on panic */
 	opal_kmsg_init();
 
+	/* Initialise OPAL powercap interface */
+	opal_powercap_init();
+
 	return 0;
 }
 machine_subsys_initcall(powernv, opal_init);
@@ -952,6 +955,7 @@ int opal_error_code(int rc)
 	case OPAL_UNSUPPORTED:		return -EIO;
 	case OPAL_HARDWARE:		return -EIO;
 	case OPAL_INTERNAL_ERROR:	return -EIO;
+	case OPAL_TIMEOUT:		return -ETIMEDOUT;
 	default:
 		pr_err("%s: unexpected OPAL error %d\n", __func__, rc);
 		return -EIO;
-- 
1.8.3.1
