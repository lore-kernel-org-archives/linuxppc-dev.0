Return-Path: <neelegup@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 432C12C0082
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Mar 2014 16:33:57 +1100 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <neelegup@linux.vnet.ibm.com>;
 Fri, 7 Mar 2014 11:03:53 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 2C0871258048
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Mar 2014 11:06:03 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s275XucG7799186
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Mar 2014 11:03:56 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s275Xp4S024294
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Mar 2014 11:03:52 +0530
Received: from neelegup-tp-t420.in.ibm.com ([9.124.88.165])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 s275XoQ9024250
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Mar 2014 11:03:51 +0530
Subject: [PATCH] powerpc/powernv: Enable reading and updating of system
 parameters
To: linuxppc-dev@lists.ozlabs.org
From: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
Date: Fri, 07 Mar 2014 11:02:09 +0530
Message-ID: <20140307053200.3507.913.stgit@neelegup-tp-t420.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch enables reading and updating of system parameters through
OPAL call.

Signed-off-by: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/opal.h                |   14 +
 arch/powerpc/platforms/powernv/Makefile        |    2 
 arch/powerpc/platforms/powernv/opal-sysparam.c |  290 ++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal-wrappers.S |    2 
 arch/powerpc/platforms/powernv/opal.c          |    2 
 5 files changed, 309 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/platforms/powernv/opal-sysparam.c

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 90fad59..60b3edc 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -159,6 +159,8 @@ extern int opal_enter_rtas(struct rtas_args *args,
 #define OPAL_GET_MSG				85
 #define OPAL_CHECK_ASYNC_COMPLETION		86
 #define OPAL_SYNC_HOST_REBOOT			87
+#define OPAL_GET_PARAM				89
+#define OPAL_SET_PARAM				90
 
 #ifndef __ASSEMBLY__
 
@@ -398,6 +400,13 @@ enum OpalLPCAddressType {
 	OPAL_LPC_FW	= 2,
 };
 
+/* System parameter permission */
+enum OpalSysparamPerm {
+	OPAL_SYSPARAM_READ      = 0x1,
+	OPAL_SYSPARAM_WRITE     = 0x2,
+	OPAL_SYSPARAM_RW        = (OPAL_SYSPARAM_READ | OPAL_SYSPARAM_WRITE),
+};
+
 struct opal_msg {
 	uint32_t msg_type;
 	uint32_t reserved;
@@ -834,6 +843,10 @@ int64_t opal_update_flash(uint64_t blk_list);
 int64_t opal_get_msg(uint64_t buffer, size_t size);
 int64_t opal_check_completion(uint64_t buffer, size_t size, uint64_t token);
 int64_t opal_sync_host_reboot(void);
+int64_t opal_get_param(uint64_t token, uint32_t param_id, uint64_t buffer,
+		size_t length);
+int64_t opal_set_param(uint64_t token, uint32_t param_id, uint64_t buffer,
+		size_t length);
 
 /* Internal functions */
 extern int early_init_dt_scan_opal(unsigned long node, const char *uname, int depth, void *data);
@@ -871,6 +884,7 @@ extern void opal_get_rtc_time(struct rtc_time *tm);
 extern unsigned long opal_get_boot_time(void);
 extern void opal_nvram_init(void);
 extern void opal_flash_init(void);
+extern void opal_sys_param_init(void);
 
 extern int opal_machine_check(struct pt_regs *regs);
 
diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index c0f85ea..e6166d3 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -1,5 +1,5 @@
 obj-y			+= setup.o opal-takeover.o opal-wrappers.o opal.o opal-async.o
-obj-y			+= opal-rtc.o opal-nvram.o opal-lpc.o opal-flash.o
+obj-y			+= opal-rtc.o opal-nvram.o opal-lpc.o opal-flash.o opal-sysparam.o
 obj-y			+= rng.o
 
 obj-$(CONFIG_SMP)	+= smp.o
diff --git a/arch/powerpc/platforms/powernv/opal-sysparam.c b/arch/powerpc/platforms/powernv/opal-sysparam.c
new file mode 100644
index 0000000..0bd249a
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/opal-sysparam.c
@@ -0,0 +1,290 @@
+/*
+ * PowerNV system parameter code
+ *
+ * Copyright (C) 2013 IBM
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/kobject.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/gfp.h>
+#include <linux/stat.h>
+#include <asm/opal.h>
+
+#define MAX_PARAM_DATA_LEN	64
+
+static DEFINE_MUTEX(opal_sysparam_mutex);
+static struct kobject *sysparam_kobj;
+static void *param_data_buf;
+
+struct param_attr {
+	struct list_head list;
+	u32 param_id;
+	u32 param_size;
+	struct kobj_attribute kobj_attr;
+};
+
+static int opal_get_sys_param(u32 param_id, u32 length, void *buffer)
+{
+	struct opal_msg msg;
+	int ret, token;
+
+	token = opal_async_get_token_interruptible();
+	if (token < 0) {
+		if (token != -ERESTARTSYS)
+			pr_err("%s: Couldn't get the token, returning\n",
+					__func__);
+		ret = token;
+		goto out;
+	}
+
+	ret = opal_get_param(token, param_id, (u64)buffer, length);
+	if (ret != OPAL_ASYNC_COMPLETION)
+		goto out_token;
+
+	ret = opal_async_wait_response(token, &msg);
+	if (ret) {
+		pr_err("%s: Failed to wait for the async response, %d\n",
+				__func__, ret);
+		goto out_token;
+	}
+
+	ret = msg.params[1];
+
+out_token:
+	opal_async_release_token(token);
+out:
+	return ret;
+}
+
+static int opal_set_sys_param(u32 param_id, u32 length, void *buffer)
+{
+	struct opal_msg msg;
+	int ret, token;
+
+	token = opal_async_get_token_interruptible();
+	if (token < 0) {
+		if (token != -ERESTARTSYS)
+			pr_err("%s: Couldn't get the token, returning\n",
+					__func__);
+		ret = token;
+		goto out;
+	}
+
+	ret = opal_set_param(token, param_id, (u64)buffer, length);
+
+	if (ret != OPAL_ASYNC_COMPLETION)
+		goto out_token;
+
+	ret = opal_async_wait_response(token, &msg);
+	if (ret) {
+		pr_err("%s: Failed to wait for the async response, %d\n",
+				__func__, ret);
+		goto out_token;
+	}
+
+	ret = msg.params[1];
+
+out_token:
+	opal_async_release_token(token);
+out:
+	return ret;
+}
+
+static ssize_t sys_param_show(struct kobject *kobj,
+		struct kobj_attribute *kobj_attr, char *buf)
+{
+	struct param_attr *attr = container_of(kobj_attr, struct param_attr,
+			kobj_attr);
+	int ret;
+
+	mutex_lock(&opal_sysparam_mutex);
+	ret = opal_get_sys_param(attr->param_id, attr->param_size,
+			param_data_buf);
+	if (ret)
+		goto out;
+
+	memcpy(buf, param_data_buf, attr->param_size);
+
+out:
+	mutex_unlock(&opal_sysparam_mutex);
+	return ret ? ret : attr->param_size;
+}
+
+static ssize_t sys_param_store(struct kobject *kobj,
+		struct kobj_attribute *kobj_attr, const char *buf, size_t count)
+{
+	struct param_attr *attr = container_of(kobj_attr, struct param_attr,
+			kobj_attr);
+	int ret;
+
+	mutex_lock(&opal_sysparam_mutex);
+	memcpy(param_data_buf, buf, count);
+	ret = opal_set_sys_param(attr->param_id, attr->param_size,
+			param_data_buf);
+	mutex_unlock(&opal_sysparam_mutex);
+	return ret ? ret : count;
+}
+
+void __init opal_sys_param_init(void)
+{
+	struct device_node *sysparam;
+	struct param_attr *attr;
+	u32 *id, *size;
+	int count, i;
+	u8 *perm;
+
+	if (!opal_kobj) {
+		pr_warn("SYSPARAM: opal kobject is not available\n");
+		goto out;
+	}
+
+	sysparam_kobj = kobject_create_and_add("sysparams", opal_kobj);
+	if (!sysparam_kobj) {
+		pr_err("SYSPARAM: Failed to create sysparam kobject\n");
+		goto out;
+	}
+
+	/* Allocate big enough buffer for any get/set transactions */
+	param_data_buf = kzalloc(MAX_PARAM_DATA_LEN, GFP_KERNEL);
+	if (!param_data_buf) {
+		pr_err("SYSPARAM: Failed to allocate memory for param data "
+				"buf\n");
+		goto out_kobj_put;
+	}
+
+	sysparam = of_find_node_by_path("/ibm,opal/sysparams");
+	if (!sysparam) {
+		pr_err("SYSPARAM: Opal sysparam node not found\n");
+		goto out_param_buf;
+	}
+
+	if (!of_device_is_compatible(sysparam, "ibm,opal-sysparams")) {
+		pr_err("SYSPARAM: Opal sysparam node not compatible\n");
+		goto out_node_put;
+	}
+
+	/* Number of parameters exposed through DT */
+	count = of_property_count_strings(sysparam, "param-name");
+	if (count < 0) {
+		pr_err("SYSPARAM: No string found of property param-name in "
+				"the node %s\n", sysparam->name);
+		goto out_node_put;
+	}
+
+	id = kzalloc(sizeof(*id) * count, GFP_KERNEL);
+	if (!id) {
+		pr_err("SYSPARAM: Failed to allocate memory to read parameter "
+				"id\n");
+		goto out_node_put;
+	}
+
+	size = kzalloc(sizeof(*size) * count, GFP_KERNEL);
+	if (!size) {
+		pr_err("SYSPARAM: Failed to allocate memory to read parameter "
+				"size\n");
+		goto out_free_id;
+	}
+
+	perm = kzalloc(sizeof(*perm) * count, GFP_KERNEL);
+	if (!perm) {
+		pr_err("SYSPARAM: Failed to allocate memory to read supported "
+				"action on the parameter");
+		goto out_free_size;
+	}
+
+	if (of_property_read_u32_array(sysparam, "param-id", id, count)) {
+		pr_err("SYSPARAM: Missing property param-id in the DT\n");
+		goto out_free_perm;
+	}
+
+	if (of_property_read_u32_array(sysparam, "param-len", size, count)) {
+		pr_err("SYSPARAM: Missing propery param-len in the DT\n");
+		goto out_free_perm;
+	}
+
+
+	if (of_property_read_u8_array(sysparam, "param-perm", perm, count)) {
+		pr_err("SYSPARAM: Missing propery param-perm in the DT\n");
+		goto out_free_perm;
+	}
+
+	attr = kzalloc(sizeof(*attr) * count, GFP_KERNEL);
+	if (!attr) {
+		pr_err("SYSPARAM: Failed to allocate memory for parameter "
+				"attributes\n");
+		goto out_free_perm;
+	}
+
+	/* For each of the parameters, populate the parameter attributes */
+	for (i = 0; i < count; i++) {
+		sysfs_attr_init(&attr[i].kobj_attr.attr);
+		attr[i].param_id = id[i];
+		attr[i].param_size = size[i];
+		if (of_property_read_string_index(sysparam, "param-name", i,
+				&attr[i].kobj_attr.attr.name))
+			continue;
+
+		/* If the parameter is read-only or read-write */
+		switch (perm[i] & 3) {
+		case OPAL_SYSPARAM_READ:
+			attr[i].kobj_attr.attr.mode = S_IRUGO;
+			break;
+		case OPAL_SYSPARAM_WRITE:
+			attr[i].kobj_attr.attr.mode = S_IWUGO;
+			break;
+		case OPAL_SYSPARAM_RW:
+			attr[i].kobj_attr.attr.mode = S_IRUGO | S_IWUGO;
+			break;
+		default:
+			break;
+		}
+
+		attr[i].kobj_attr.show = sys_param_show;
+		attr[i].kobj_attr.store = sys_param_store;
+
+		if (sysfs_create_file(sysparam_kobj, &attr[i].kobj_attr.attr)) {
+			pr_err("SYSPARAM: Failed to create sysfs file %s\n",
+					attr[i].kobj_attr.attr.name);
+			goto out_free_attr;
+		}
+	}
+
+	kfree(perm);
+	kfree(size);
+	kfree(id);
+	of_node_put(sysparam);
+	return;
+
+out_free_attr:
+	kfree(attr);
+out_free_perm:
+	kfree(perm);
+out_free_size:
+	kfree(size);
+out_free_id:
+	kfree(id);
+out_node_put:
+	of_node_put(sysparam);
+out_param_buf:
+	kfree(param_data_buf);
+out_kobj_put:
+	kobject_put(sysparam_kobj);
+out:
+	return;
+}
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 3e8829c..0afdeca 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -129,3 +129,5 @@ OPAL_CALL(opal_update_flash,			OPAL_FLASH_UPDATE);
 OPAL_CALL(opal_get_msg,				OPAL_GET_MSG);
 OPAL_CALL(opal_check_completion,		OPAL_CHECK_ASYNC_COMPLETION);
 OPAL_CALL(opal_sync_host_reboot,		OPAL_SYNC_HOST_REBOOT);
+OPAL_CALL(opal_get_param,			OPAL_GET_PARAM);
+OPAL_CALL(opal_set_param,			OPAL_SET_PARAM);
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 65499ad..4fad36a 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -474,6 +474,8 @@ static int __init opal_init(void)
 	if (rc == 0) {
 		/* Setup code update interface */
 		opal_flash_init();
+		/* Setup system parameters interface */
+		opal_sys_param_init();
 	}
 
 	return 0;
