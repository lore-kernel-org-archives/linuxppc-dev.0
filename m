Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xHNN93jl6zDqmV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 15:05:29 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6Q53WRp032348
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 01:05:27 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bxgqfgw3g-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 01:05:27 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Wed, 26 Jul 2017 15:05:25 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6Q55NZW32047156
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 15:05:23 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6Q55D8q031923
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 15:05:14 +1000
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: stewart@linux.vnet.ibm.com, cyrilbur@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 ego@linux.vnet.ibm.com, svaidy@linux.vnet.ibm.com,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH V8 2/3] powernv: Add support to set power-shifting-ratio
Date: Wed, 26 Jul 2017 10:35:08 +0530
In-Reply-To: <1501045509-21732-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1501045509-21732-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Message-Id: <1501045509-21732-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds support to set power-shifting-ratio for CPU-GPU which
is used by OCC power capping algorithm.

Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
Changes from V7:
- Replaced sscanf with kstrtoint

 arch/powerpc/include/asm/opal-api.h            |   4 +-
 arch/powerpc/include/asm/opal.h                |   3 +
 arch/powerpc/platforms/powernv/Makefile        |   2 +-
 arch/powerpc/platforms/powernv/opal-psr.c      | 169 +++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal-wrappers.S |   2 +
 arch/powerpc/platforms/powernv/opal.c          |   3 +
 6 files changed, 181 insertions(+), 2 deletions(-)
 create mode 100644 arch/powerpc/platforms/powernv/opal-psr.c

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index c3e0c4a..0d37315 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -193,7 +193,9 @@
 #define OPAL_NPU_MAP_LPAR			148
 #define OPAL_GET_POWERCAP			152
 #define OPAL_SET_POWERCAP			153
-#define OPAL_LAST				153
+#define OPAL_GET_PSR				154
+#define OPAL_SET_PSR				155
+#define OPAL_LAST				155
 
 /* Device tree flags */
 
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index ec2087c..58b30a4 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -269,6 +269,8 @@ int64_t opal_xive_set_vp_info(uint64_t vp,
 int64_t opal_xive_dump(uint32_t type, uint32_t id);
 int opal_get_powercap(u32 handle, int token, u32 *pcap);
 int opal_set_powercap(u32 handle, int token, u32 pcap);
+int opal_get_power_shifting_ratio(u32 handle, int token, u32 *psr);
+int opal_set_power_shifting_ratio(u32 handle, int token, u32 psr);
 
 /* Internal functions */
 extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
@@ -348,6 +350,7 @@ static inline int opal_get_async_rc(struct opal_msg msg)
 void opal_wake_poller(void);
 
 void opal_powercap_init(void);
+void opal_psr_init(void);
 
 #endif /* __ASSEMBLY__ */
 
diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index e79f806..9ed7d33 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -2,7 +2,7 @@ obj-y			+= setup.o opal-wrappers.o opal.o opal-async.o idle.o
 obj-y			+= opal-rtc.o opal-nvram.o opal-lpc.o opal-flash.o
 obj-y			+= rng.o opal-elog.o opal-dump.o opal-sysparam.o opal-sensor.o
 obj-y			+= opal-msglog.o opal-hmi.o opal-power.o opal-irqchip.o
-obj-y			+= opal-kmsg.o opal-powercap.o
+obj-y			+= opal-kmsg.o opal-powercap.o opal-psr.o
 
 obj-$(CONFIG_SMP)	+= smp.o subcore.o subcore-asm.o
 obj-$(CONFIG_PCI)	+= pci.o pci-ioda.o npu-dma.o
diff --git a/arch/powerpc/platforms/powernv/opal-psr.c b/arch/powerpc/platforms/powernv/opal-psr.c
new file mode 100644
index 0000000..07e3f78
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/opal-psr.c
@@ -0,0 +1,169 @@
+/*
+ * PowerNV OPAL Power-Shifting-Ratio interface
+ *
+ * Copyright 2017 IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#define pr_fmt(fmt)     "opal-psr: " fmt
+
+#include <linux/of.h>
+#include <linux/kobject.h>
+#include <linux/slab.h>
+
+#include <asm/opal.h>
+
+DEFINE_MUTEX(psr_mutex);
+
+static struct kobject *psr_kobj;
+
+struct psr_attr {
+	u32 handle;
+	struct kobj_attribute attr;
+};
+
+static struct psr_attr *psr_attrs;
+static struct kobject *psr_kobj;
+
+static ssize_t psr_show(struct kobject *kobj, struct kobj_attribute *attr,
+			char *buf)
+{
+	struct psr_attr *psr_attr = container_of(attr, struct psr_attr, attr);
+	struct opal_msg msg;
+	int psr, ret, token;
+
+	token = opal_async_get_token_interruptible();
+	if (token < 0) {
+		pr_devel("Failed to get token\n");
+		return token;
+	}
+
+	mutex_lock(&psr_mutex);
+	ret = opal_get_power_shifting_ratio(psr_attr->handle, token, &psr);
+	switch (ret) {
+	case OPAL_ASYNC_COMPLETION:
+		ret = opal_async_wait_response(token, &msg);
+		if (ret) {
+			pr_devel("Failed to wait for the async response %d\n",
+				 ret);
+			goto out;
+		}
+		ret = opal_error_code(opal_get_async_rc(msg));
+		if (!ret)
+			ret = sprintf(buf, "%u\n", be32_to_cpu(psr));
+		break;
+	case OPAL_SUCCESS:
+		ret = sprintf(buf, "%u\n", be32_to_cpu(psr));
+		break;
+	default:
+		ret = opal_error_code(ret);
+	}
+
+out:
+	mutex_unlock(&psr_mutex);
+	opal_async_release_token(token);
+	return ret;
+}
+
+static ssize_t psr_store(struct kobject *kobj, struct kobj_attribute *attr,
+			 const char *buf, size_t count)
+{
+	struct psr_attr *psr_attr = container_of(attr, struct psr_attr, attr);
+	struct opal_msg msg;
+	int psr, ret, token;
+
+	ret = kstrtoint(buf, 0, &psr);
+	if (ret)
+		return ret;
+
+	token = opal_async_get_token_interruptible();
+	if (token < 0) {
+		pr_devel("Failed to get token\n");
+		return token;
+	}
+
+	mutex_lock(&psr_mutex);
+	ret = opal_set_power_shifting_ratio(psr_attr->handle, token, psr);
+	switch (ret) {
+	case OPAL_ASYNC_COMPLETION:
+		ret = opal_async_wait_response(token, &msg);
+		if (ret) {
+			pr_devel("Failed to wait for the async response %d\n",
+				 ret);
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
+	mutex_unlock(&psr_mutex);
+	opal_async_release_token(token);
+
+	return ret;
+}
+
+void __init opal_psr_init(void)
+{
+	struct device_node *psr, *node;
+	int psr_attr_count = 0, i = 0;
+
+	psr = of_find_node_by_path("/ibm,opal/power-mgt/psr");
+	if (!psr) {
+		pr_devel("/ibm,opal/power-mgt/psr node not found\n");
+		return;
+	}
+
+	for_each_child_of_node(psr, node)
+		psr_attr_count++;
+
+	psr_attrs = kcalloc(psr_attr_count, sizeof(struct psr_attr),
+			    GFP_KERNEL);
+	if (!psr_attrs)
+		return;
+
+	for_each_child_of_node(psr, node) {
+		if (of_property_read_u32(node, "handle",
+					 &psr_attrs[i].handle))
+			goto out;
+
+		sysfs_attr_init(&psr_attrs[i].attr.attr);
+		if (of_property_read_string(node, "label",
+					    &psr_attrs[i].attr.attr.name))
+			goto out;
+		psr_attrs[i].attr.attr.mode = 0664;
+		psr_attrs[i].attr.show = psr_show;
+		psr_attrs[i].attr.store = psr_store;
+		i++;
+	}
+
+	psr_kobj = kobject_create_and_add("psr", opal_kobj);
+	if (!psr_kobj) {
+		pr_warn("Failed to create psr kobkect\n");
+		goto out;
+	}
+
+	for (i = 0; i < psr_attr_count; i++)
+		if (sysfs_create_file(psr_kobj, &psr_attrs[i].attr.attr)) {
+			pr_devel("Failed to create sysfs file %s\n",
+				 psr_attrs[i].attr.attr.name);
+			goto out_kobj;
+		}
+
+	return;
+out_kobj:
+	kobject_put(psr_kobj);
+out:
+	kfree(psr_attrs);
+}
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index eff5fe7..9867726 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -312,3 +312,5 @@ OPAL_CALL(opal_npu_destroy_context,		OPAL_NPU_DESTROY_CONTEXT);
 OPAL_CALL(opal_npu_map_lpar,			OPAL_NPU_MAP_LPAR);
 OPAL_CALL(opal_get_powercap,			OPAL_GET_POWERCAP);
 OPAL_CALL(opal_set_powercap,			OPAL_SET_POWERCAP);
+OPAL_CALL(opal_get_power_shifting_ratio,	OPAL_GET_PSR);
+OPAL_CALL(opal_set_power_shifting_ratio,	OPAL_SET_PSR);
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 889da97..280a736 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -839,6 +839,9 @@ static int __init opal_init(void)
 	/* Initialise OPAL powercap interface */
 	opal_powercap_init();
 
+	/* Initialise OPAL Power-Shifting-Ratio interface */
+	opal_psr_init();
+
 	return 0;
 }
 machine_subsys_initcall(powernv, opal_init);
-- 
1.8.3.1
