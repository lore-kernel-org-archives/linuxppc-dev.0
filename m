Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zmgXY1N39zF13R
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 01:55:56 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1LEtddx115310
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 09:55:54 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g95jke1pg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 09:55:52 -0500
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Wed, 21 Feb 2018 14:55:40 -0000
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH V2] powerpc/powernv : Add support to enable sensor groups
Date: Wed, 21 Feb 2018 20:25:14 +0530
Message-Id: <1519224914-24596-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Adds support to enable/disable a sensor group. This can be used to
select the sensor groups that needs to be copied to main memory by
OCC. Sensor groups like power, temperature, current, voltage,
frequency, utilization can be enabled/disabled at runtime.

Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
Changes from V1:
- Rebase on master
- Add documentation

 .../ABI/testing/sysfs-firmware-opal-sensor-groups  |  34 ++++++
 arch/powerpc/include/asm/opal-api.h                |   4 +-
 arch/powerpc/include/asm/opal.h                    |   1 +
 .../powerpc/platforms/powernv/opal-sensor-groups.c | 123 ++++++++++++++++-----
 arch/powerpc/platforms/powernv/opal-wrappers.S     |   1 +
 5 files changed, 132 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-firmware-opal-sensor-groups

diff --git a/Documentation/ABI/testing/sysfs-firmware-opal-sensor-groups b/Documentation/ABI/testing/sysfs-firmware-opal-sensor-groups
new file mode 100644
index 0000000..81081de
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-firmware-opal-sensor-groups
@@ -0,0 +1,34 @@
+What:		/sys/firmware/opal/sensor_groups
+Date:		January 2018
+Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
+Description:	Sensor groups directory for POWER9 powernv servers
+
+		Each folder in this directory contains a sensor group
+		which are classified based on type of the sensor
+		like power, temperature, frequency, current, etc. They
+		can also indicate the group of sensors belonging to
+		different owners like CSM, Profiler, Job-Scheduler
+
+What:		/sys/firmware/opal/sensor_groups/<sensor_group_name>/clear
+Date:		Januaury 2018
+Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
+Description:	Sysfs file to clear the min-max of all the sensors
+		belonging to the group.
+
+		Writing 1 to this file will clear the minimum and
+		maximum values of all the sensors in the group. The
+		min-max of a sensor is the historical minimum and
+		maximum value of the sensor cached by OCC.
+
+What:		/sys/firmware/opal/sensor_groups/<sensor_group_name>/enable
+Date:		Januaury 2018
+Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
+Description:	Sysfs file to enable/disable the sensor-group
+
+		Writing 0 value to this file will disable the copying
+		of the sensor-group to main memory by OCC. And writing
+		1 to this file will enable the sensor-group copying.
+		By default all the sensor-groups are enabled and will
+		be copied to main memory. This file can be used to
+		increase the update frequency of selective
+		sensor-groups.
diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 94bd1bf..b6bbbd8 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -204,7 +204,9 @@
 #define OPAL_NPU_SPA_SETUP			159
 #define OPAL_NPU_SPA_CLEAR_CACHE		160
 #define OPAL_NPU_TL_SET				161
-#define OPAL_LAST				161
+#define OPAL_SENSOR_READ_U64			162
+#define OPAL_SENSOR_GROUP_ENABLE		163
+#define OPAL_LAST				163
 
 /* Device tree flags */
 
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 12e70fb..e708c41 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -286,6 +286,7 @@ int64_t opal_imc_counters_init(uint32_t type, uint64_t address,
 int opal_get_power_shift_ratio(u32 handle, int token, u32 *psr);
 int opal_set_power_shift_ratio(u32 handle, int token, u32 psr);
 int opal_sensor_group_clear(u32 group_hndl, int token);
+int opal_sensor_group_enable(u32 group_hndl, int token, bool enable);
 
 s64 opal_signal_system_reset(s32 cpu);
 
diff --git a/arch/powerpc/platforms/powernv/opal-sensor-groups.c b/arch/powerpc/platforms/powernv/opal-sensor-groups.c
index 7e5a235..1a3359d 100644
--- a/arch/powerpc/platforms/powernv/opal-sensor-groups.c
+++ b/arch/powerpc/platforms/powernv/opal-sensor-groups.c
@@ -24,6 +24,8 @@
 struct sg_attr {
 	u32 handle;
 	struct kobj_attribute attr;
+	u32 opal_no;
+	int enable;
 };
 
 static struct sensor_group {
@@ -32,34 +34,44 @@ struct sg_attr {
 	struct sg_attr *sgattrs;
 } *sgs;
 
-static ssize_t sg_store(struct kobject *kobj, struct kobj_attribute *attr,
-			const char *buf, size_t count)
+static int sensor_group_clear(u32 handle)
 {
-	struct sg_attr *sattr = container_of(attr, struct sg_attr, attr);
 	struct opal_msg msg;
-	u32 data;
-	int ret, token;
-
-	ret = kstrtoint(buf, 0, &data);
-	if (ret)
-		return ret;
-
-	if (data != 1)
-		return -EINVAL;
+	int token, ret;
 
 	token = opal_async_get_token_interruptible();
-	if (token < 0) {
-		pr_devel("Failed to get token\n");
+	if (token < 0)
 		return token;
+
+	ret = opal_sensor_group_clear(handle, token);
+	if (ret == OPAL_ASYNC_COMPLETION) {
+		ret = opal_async_wait_response(token, &msg);
+		if (ret) {
+			pr_devel("Failed to wait for the async response\n");
+			ret = -EIO;
+			goto out;
+		}
+		ret = opal_error_code(opal_get_async_rc(msg));
+	} else {
+		ret = opal_error_code(ret);
 	}
 
-	ret = mutex_lock_interruptible(&sg_mutex);
-	if (ret)
-		goto out_token;
+out:
+	opal_async_release_token(token);
+	return ret;
+}
+
+static int sensor_group_enable(u32 handle, int enable)
+{
+	struct opal_msg msg;
+	int token, ret;
+
+	token = opal_async_get_token_interruptible();
+	if (token < 0)
+		return token;
 
-	ret = opal_sensor_group_clear(sattr->handle, token);
-	switch (ret) {
-	case OPAL_ASYNC_COMPLETION:
+	ret = opal_sensor_group_enable(handle, token, enable);
+	if (ret == OPAL_ASYNC_COMPLETION) {
 		ret = opal_async_wait_response(token, &msg);
 		if (ret) {
 			pr_devel("Failed to wait for the async response\n");
@@ -67,39 +79,90 @@ static ssize_t sg_store(struct kobject *kobj, struct kobj_attribute *attr,
 			goto out;
 		}
 		ret = opal_error_code(opal_get_async_rc(msg));
-		if (!ret)
-			ret = count;
+	} else {
+		ret = opal_error_code(ret);
+	}
+
+out:
+	opal_async_release_token(token);
+	return ret;
+}
+
+static ssize_t sg_store(struct kobject *kobj, struct kobj_attribute *attr,
+			const char *buf, size_t count)
+{
+	struct sg_attr *sattr = container_of(attr, struct sg_attr, attr);
+	u32 data;
+	int ret;
+
+	ret = kstrtoint(buf, 0, &data);
+	if (ret)
+		return ret;
+
+	ret = mutex_lock_interruptible(&sg_mutex);
+	if (ret)
+		return ret;
+
+	ret = -EINVAL;
+	switch (sattr->opal_no) {
+	case OPAL_SENSOR_GROUP_CLEAR:
+		if (data == 1)
+			ret = sensor_group_clear(sattr->handle);
 		break;
-	case OPAL_SUCCESS:
-		ret = count;
+	case OPAL_SENSOR_GROUP_ENABLE:
+		if (data == 0 || data == 1) {
+			if (data != sattr->enable) {
+				ret = sensor_group_enable(sattr->handle, data);
+				if (!ret)
+					sattr->enable = data;
+			} else {
+				ret = 0;
+			}
+		}
 		break;
 	default:
-		ret = opal_error_code(ret);
+		break;
 	}
 
-out:
+	if (!ret)
+		ret = count;
+
 	mutex_unlock(&sg_mutex);
-out_token:
-	opal_async_release_token(token);
 	return ret;
 }
 
+static ssize_t sg_show(struct kobject *kobj, struct kobj_attribute *attr,
+		       char *buf)
+{
+	struct sg_attr *sattr = container_of(attr, struct sg_attr, attr);
+
+	return sprintf(buf, "%d\n", sattr->enable);
+}
+
 static struct sg_ops_info {
 	int opal_no;
 	const char *attr_name;
 	ssize_t (*store)(struct kobject *kobj, struct kobj_attribute *attr,
 			const char *buf, size_t count);
+	ssize_t (*show)(struct kobject *kobj, struct kobj_attribute *attr,
+			char *buf);
+	umode_t mode;
 } ops_info[] = {
-	{ OPAL_SENSOR_GROUP_CLEAR, "clear", sg_store },
+	{ OPAL_SENSOR_GROUP_CLEAR, "clear", sg_store, NULL, 0220 },
+	{ OPAL_SENSOR_GROUP_ENABLE, "enable", sg_store, sg_show, 0660 },
 };
 
 static void add_attr(int handle, struct sg_attr *attr, int index)
 {
 	attr->handle = handle;
+	attr->opal_no = ops_info[index].opal_no;
 	sysfs_attr_init(&attr->attr.attr);
 	attr->attr.attr.name = ops_info[index].attr_name;
-	attr->attr.attr.mode = 0220;
+	attr->attr.attr.mode = ops_info[index].mode;
 	attr->attr.store = ops_info[index].store;
+	attr->attr.show = ops_info[index].show;
+	if (attr->opal_no == OPAL_SENSOR_GROUP_ENABLE)
+		attr->enable = 1;
 }
 
 static int add_attr_group(const __be32 *ops, int len, struct sensor_group *sg,
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 1b2936b..90c2b40 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -323,3 +323,4 @@ OPAL_CALL(opal_sensor_group_clear,		OPAL_SENSOR_GROUP_CLEAR);
 OPAL_CALL(opal_npu_spa_setup,			OPAL_NPU_SPA_SETUP);
 OPAL_CALL(opal_npu_spa_clear_cache,		OPAL_NPU_SPA_CLEAR_CACHE);
 OPAL_CALL(opal_npu_tl_set,			OPAL_NPU_TL_SET);
+OPAL_CALL(opal_sensor_group_enable,		OPAL_SENSOR_GROUP_ENABLE);
-- 
1.8.3.1
