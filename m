Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ylbBz50mTzDqwS
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Nov 2017 16:36:43 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAR5YDXU077705
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Nov 2017 00:36:40 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2eg0v9w9dp-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Nov 2017 00:36:40 -0500
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Mon, 27 Nov 2017 05:36:38 -0000
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, mpe@ellerman.id.au, ego@linux.vnet.ibm.com,
 akshay.adiga@linux.vnet.ibm.com, svaidy@linux.vnet.ibm.com,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/powernv : Add support to enable sensor groups
Date: Mon, 27 Nov 2017 11:06:28 +0530
Message-Id: <1511760988-10377-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
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
The skiboot patch for the opal call is posted below:
https://lists.ozlabs.org/pipermail/skiboot/2017-November/009713.html

 arch/powerpc/include/asm/opal-api.h                |  3 +-
 arch/powerpc/include/asm/opal.h                    |  1 +
 .../powerpc/platforms/powernv/opal-sensor-groups.c | 97 +++++++++++++++-------
 arch/powerpc/platforms/powernv/opal-wrappers.S     |  1 +
 4 files changed, 73 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 233c750..bdca15a 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -201,7 +201,8 @@
 #define OPAL_SET_POWER_SHIFT_RATIO		155
 #define OPAL_SENSOR_GROUP_CLEAR			156
 #define OPAL_PCI_SET_P2P			157
-#define OPAL_LAST				157
+#define OPAL_SENSOR_GROUP_ENABLE		158
+#define OPAL_LAST				158
 
 /* Device tree flags */
 
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 0c545f7..c3c7e77 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -280,6 +280,7 @@ int64_t opal_imc_counters_init(uint32_t type, uint64_t address,
 int opal_get_power_shift_ratio(u32 handle, int token, u32 *psr);
 int opal_set_power_shift_ratio(u32 handle, int token, u32 psr);
 int opal_sensor_group_clear(u32 group_hndl, int token);
+int opal_sensor_group_enable(u32 group_hndl, int token, bool enable);
 
 s64 opal_signal_system_reset(s32 cpu);
 
diff --git a/arch/powerpc/platforms/powernv/opal-sensor-groups.c b/arch/powerpc/platforms/powernv/opal-sensor-groups.c
index 7e5a235..2f95380 100644
--- a/arch/powerpc/platforms/powernv/opal-sensor-groups.c
+++ b/arch/powerpc/platforms/powernv/opal-sensor-groups.c
@@ -23,6 +23,7 @@
 
 struct sg_attr {
 	u32 handle;
+	u32 opal_no;
 	struct kobj_attribute attr;
 };
 
@@ -32,34 +33,44 @@ struct sg_attr {
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
@@ -67,20 +78,48 @@ static ssize_t sg_store(struct kobject *kobj, struct kobj_attribute *attr,
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
+		if (data == 0 || data == 1)
+			ret = sensor_group_enable(sattr->handle, data);
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
 
@@ -91,11 +130,13 @@ static ssize_t sg_store(struct kobject *kobj, struct kobj_attribute *attr,
 			const char *buf, size_t count);
 } ops_info[] = {
 	{ OPAL_SENSOR_GROUP_CLEAR, "clear", sg_store },
+	{ OPAL_SENSOR_GROUP_ENABLE, "enable", sg_store },
 };
 
 static void add_attr(int handle, struct sg_attr *attr, int index)
 {
 	attr->handle = handle;
+	attr->opal_no = ops_info[index].opal_no;
 	sysfs_attr_init(&attr->attr.attr);
 	attr->attr.attr.name = ops_info[index].attr_name;
 	attr->attr.attr.mode = 0220;
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 6f4b00a2..ee9205f 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -320,3 +320,4 @@ OPAL_CALL(opal_set_powercap,			OPAL_SET_POWERCAP);
 OPAL_CALL(opal_get_power_shift_ratio,		OPAL_GET_POWER_SHIFT_RATIO);
 OPAL_CALL(opal_set_power_shift_ratio,		OPAL_SET_POWER_SHIFT_RATIO);
 OPAL_CALL(opal_sensor_group_clear,		OPAL_SENSOR_GROUP_CLEAR);
+OPAL_CALL(opal_sensor_group_enable,		OPAL_SENSOR_GROUP_ENABLE);
-- 
1.8.3.1
