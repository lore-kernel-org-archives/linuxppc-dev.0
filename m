Return-Path: <toshi.kani@hp.com>
Received: from g5t0008.atlanta.hp.com (g5t0008.atlanta.hp.com [15.192.0.45])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "smtp.hp.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E1CAA2C0331
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2013 11:01:16 +1100 (EST)
From: Toshi Kani <toshi.kani@hp.com>
To: rjw@sisk.pl, lenb@kernel.org, gregkh@linuxfoundation.org,
 akpm@linux-foundation.org
Subject: [RFC PATCH v2 04/12] cpu: Add cpu hotplug handlers
Date: Thu, 10 Jan 2013 16:40:22 -0700
Message-Id: <1357861230-29549-5-git-send-email-toshi.kani@hp.com>
In-Reply-To: <1357861230-29549-1-git-send-email-toshi.kani@hp.com>
References: <1357861230-29549-1-git-send-email-toshi.kani@hp.com>
Cc: linux-s390@vger.kernel.org, Toshi Kani <toshi.kani@hp.com>,
 jiang.liu@huawei.com, wency@cn.fujitsu.com, linux-mm@kvack.org,
 yinghai@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 isimatu.yasuaki@jp.fujitsu.com, srivatsa.bhat@linux.vnet.ibm.com,
 guohanjun@huawei.com, bhelgaas@google.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Added cpu hotplug handlers.  cpu_add_execute() onlines requested
cpus for hot-add & online operations, and cpu_del_execute()
offlines them for hot-delete & offline operations.  They are
also used for rollback as well.

cpu_del_validate() fails a request if cpu0 is requested to delete.

Signed-off-by: Toshi Kani <toshi.kani@hp.com>
---
 drivers/base/cpu.c |  107 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 6345294..05534ad 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -13,6 +13,8 @@
 #include <linux/gfp.h>
 #include <linux/slab.h>
 #include <linux/percpu.h>
+#include <linux/list.h>
+#include <linux/sys_hotplug.h>
 
 #include "base.h"
 
@@ -324,10 +326,115 @@ static void __init cpu_dev_register_generic(void)
 #endif
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+static int cpu_del_execute(struct shp_request *req, int rollback);
+
+static int cpu_add_execute(struct shp_request *req, int rollback)
+{
+	struct shp_device *shp_dev;
+	u32 cpu;
+	int ret;
+
+	if (rollback)
+		return cpu_del_execute(req, 0);
+
+	list_for_each_entry(shp_dev, &req->dev_list, list) {
+		if (shp_dev->class != SHP_CLS_CPU)
+			continue;
+
+		cpu = shp_dev->info.cpu.cpu_id;
+
+		if (cpu_online(cpu))
+			continue;
+
+		ret = cpu_up(cpu);
+		if (!ret) {
+			/* REVISIT: need a way to set a cpu dev for hot-plug */
+			if (shp_is_online_op(req->operation))
+				kobject_uevent(&shp_dev->device->kobj,
+							KOBJ_ONLINE);
+		} else {
+			pr_err("cpu: Failed to online cpu %d\n", cpu);
+			/* fall-thru */
+		}
+	}
+
+	return 0;
+}
+
+static int cpu_del_validate(struct shp_request *req, int rollback)
+{
+	struct shp_device *shp_dev;
+
+	if (rollback)
+		return 0;
+
+	list_for_each_entry(shp_dev, &req->dev_list, list) {
+		if (shp_dev->class != SHP_CLS_CPU)
+			continue;
+
+		/*
+		 * cpu 0 cannot be offlined.  This check can be removed when
+		 * cpu 0 offline is supported.
+		 */
+		if (shp_dev->info.cpu.cpu_id == 0)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int cpu_del_execute(struct shp_request *req, int rollback)
+{
+	struct shp_device *shp_dev;
+	u32 cpu;
+	int ret;
+
+	if (rollback)
+		return cpu_add_execute(req, 0);
+
+	list_for_each_entry(shp_dev, &req->dev_list, list) {
+		if (shp_dev->class != SHP_CLS_CPU)
+			continue;
+
+		cpu = shp_dev->info.cpu.cpu_id;
+
+		if (!cpu_online(cpu))
+			continue;
+
+		ret = cpu_down(cpu);
+		if (!ret) {
+			/* REVISIT: need a way to set a cpu dev for hot-plug */
+			if (shp_is_online_op(req->operation))
+				kobject_uevent(&shp_dev->device->kobj,
+							KOBJ_OFFLINE);
+		} else {
+			pr_err("cpu: Failed to offline cpu %d\n", cpu);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static void __init cpu_shp_init(void)
+{
+	shp_register_handler(SHP_ADD_EXECUTE, cpu_add_execute,
+				SHP_CPU_ADD_EXECUTE_ORDER);
+	shp_register_handler(SHP_DEL_VALIDATE, cpu_del_validate,
+				SHP_CPU_DEL_VALIDATE_ORDER);
+	shp_register_handler(SHP_DEL_EXECUTE, cpu_del_execute,
+				SHP_CPU_DEL_EXECUTE_ORDER);
+}
+#endif	/* CONFIG_HOTPLUG_CPU */
+
 void __init cpu_dev_init(void)
 {
 	if (subsys_system_register(&cpu_subsys, cpu_root_attr_groups))
 		panic("Failed to register CPU subsystem");
 
 	cpu_dev_register_generic();
+#ifdef CONFIG_HOTPLUG_CPU
+	cpu_shp_init();
+#endif
 }
