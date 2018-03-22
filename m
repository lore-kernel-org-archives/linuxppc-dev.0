Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 406NqH47Q3zF1xS
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 21:55:07 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2MAsved005542
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 06:55:05 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gva67ampy-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 06:55:05 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Thu, 22 Mar 2018 10:54:59 -0000
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, linux@roeck-us.net
Cc: linuxppc-dev@lists.ozlabs.org, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, stewart@linux.vnet.ibm.com,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH 3/3] powernv: opal-sensor-groups: Add attributes to
 disable/enable sensors
Date: Thu, 22 Mar 2018 16:24:35 +0530
In-Reply-To: <1521716075-807-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1521716075-807-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Message-Id: <1521716075-807-4-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch provides support to disable and enable plaform specific
sensor groups like performance, utilization and frequency.

Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
 .../ABI/testing/sysfs-firmware-opal-sensor-groups  | 34 +++++++++
 .../powerpc/platforms/powernv/opal-sensor-groups.c | 80 +++++++++++++---------
 2 files changed, 83 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-firmware-opal-sensor-groups

diff --git a/Documentation/ABI/testing/sysfs-firmware-opal-sensor-groups b/Documentation/ABI/testing/sysfs-firmware-opal-sensor-groups
new file mode 100644
index 0000000..484ff1c
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-firmware-opal-sensor-groups
@@ -0,0 +1,34 @@
+What:		/sys/firmware/opal/sensor_groups
+Date:		March 2018
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
+Date:		March 2018
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
+Date:		March 2018
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
diff --git a/arch/powerpc/platforms/powernv/opal-sensor-groups.c b/arch/powerpc/platforms/powernv/opal-sensor-groups.c
index 5b53f58..67f28b2 100644
--- a/arch/powerpc/platforms/powernv/opal-sensor-groups.c
+++ b/arch/powerpc/platforms/powernv/opal-sensor-groups.c
@@ -24,6 +24,7 @@
 struct sg_attr {
 	u32 handle;
 	struct kobj_attribute attr;
+	u32 opal_no;
 };
 
 static struct sensor_group {
@@ -60,34 +61,17 @@ int sensor_group_enable(u32 handle, bool enable)
 }
 EXPORT_SYMBOL_GPL(sensor_group_enable);
 
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
-	}
 
-	ret = mutex_lock_interruptible(&sg_mutex);
-	if (ret)
-		goto out_token;
-
-	ret = opal_sensor_group_clear(sattr->handle, token);
-	switch (ret) {
-	case OPAL_ASYNC_COMPLETION:
+	ret = opal_sensor_group_clear(handle, token);
+	if (ret == OPAL_ASYNC_COMPLETION) {
 		ret = opal_async_wait_response(token, &msg);
 		if (ret) {
 			pr_devel("Failed to wait for the async response\n");
@@ -95,20 +79,48 @@ static ssize_t sg_store(struct kobject *kobj, struct kobj_attribute *attr,
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
 
@@ -118,12 +130,14 @@ static ssize_t sg_store(struct kobject *kobj, struct kobj_attribute *attr,
 	ssize_t (*store)(struct kobject *kobj, struct kobj_attribute *attr,
 			const char *buf, size_t count);
 } ops_info[] = {
-	{ OPAL_SENSOR_GROUP_CLEAR, "clear", sg_store },
+	{ OPAL_SENSOR_GROUP_CLEAR, "clear", sg_store},
+	{ OPAL_SENSOR_GROUP_ENABLE, "enable", sg_store},
 };
 
 static void add_attr(int handle, struct sg_attr *attr, int index)
 {
 	attr->handle = handle;
+	attr->opal_no = ops_info[index].opal_no;
 	sysfs_attr_init(&attr->attr.attr);
 	attr->attr.attr.name = ops_info[index].attr_name;
 	attr->attr.attr.mode = 0220;
@@ -186,6 +200,10 @@ void __init opal_sensor_groups_init(void)
 		const __be32 *ops;
 		u32 sgid, len, nr_attrs, chipid;
 
+		/* Skip sensor groups that are handled in HWMON */
+		if (of_device_is_compatible(node, "ibm,opal-sensor"))
+			continue;
+
 		ops = of_get_property(node, "ops", &len);
 		if (!ops)
 			continue;
-- 
1.8.3.1
