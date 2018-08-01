Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41gMd83r8czF1PN
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2018 15:42:04 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w715dITC100980
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Aug 2018 01:42:02 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kk2wuqm2m-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Aug 2018 01:42:01 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Wed, 1 Aug 2018 06:41:59 +0100
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 ego@linux.vnet.ibm.com, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH] powernv: opal-sensor-groups: Add attributes to disable/enable
 sensors
Date: Wed,  1 Aug 2018 11:11:53 +0530
Message-Id: <1533102113-27487-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch provides support to disable and enable plaform specific
sensor groups like performance, utilization and frequency which are
currently not supported in hwmon.

Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
This patch is based on 
https://git.kernel.org/powerpc/c/04baaf28f40c68c35a413cd9d0db71

 .../ABI/testing/sysfs-firmware-opal-sensor-groups  | 33 ++++++++
 .../powerpc/platforms/powernv/opal-sensor-groups.c | 99 +++++++++++++++-------
 2 files changed, 100 insertions(+), 32 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-firmware-opal-sensor-groups

diff --git a/Documentation/ABI/testing/sysfs-firmware-opal-sensor-groups b/Documentation/ABI/testing/sysfs-firmware-opal-sensor-groups
new file mode 100644
index 0000000..a236686
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-firmware-opal-sensor-groups
@@ -0,0 +1,33 @@
+What:		/sys/firmware/opal/sensor_groups
+Date:		August 2017
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
+Date:		August 2017
+Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
+Description:	Sysfs file to clear the min-max of all the sensors
+		belonging to the group.
+
+		Writing 1 to this file will clear the minimum and
+		maximum values of all the sensors in the group.
+		In POWER9, the min-max of a sensor is the historical minimum
+		and maximum value of the sensor cached by OCC.
+
+What:		/sys/firmware/opal/sensor_groups/<sensor_group_name>/enable
+Date:		August 2018
+Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
+Description:	Sysfs file to enable/disable the sensor-group
+
+		Writing 0 to this file will disable all the sensors
+		belonging to the group and writing 1 will enable the
+		sensors.
+		In POWER9, by default all the sensor-groups are enabled and
+		will be copied to main memory by OCC. This file can be used
+		to increase the update frequency of selective sensor-groups.
diff --git a/arch/powerpc/platforms/powernv/opal-sensor-groups.c b/arch/powerpc/platforms/powernv/opal-sensor-groups.c
index f7d04b6..8bf6c86 100644
--- a/arch/powerpc/platforms/powernv/opal-sensor-groups.c
+++ b/arch/powerpc/platforms/powernv/opal-sensor-groups.c
@@ -24,6 +24,8 @@
 struct sg_attr {
 	u32 handle;
 	struct kobj_attribute attr;
+	u32 opal_no;
+	bool enable;
 };
 
 static struct sensor_group {
@@ -60,34 +62,17 @@ int sensor_group_enable(u32 handle, bool enable)
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
-
-	ret = mutex_lock_interruptible(&sg_mutex);
-	if (ret)
-		goto out_token;
 
-	ret = opal_sensor_group_clear(sattr->handle, token);
-	switch (ret) {
-	case OPAL_ASYNC_COMPLETION:
+	ret = opal_sensor_group_clear(handle, token);
+	if (ret == OPAL_ASYNC_COMPLETION) {
 		ret = opal_async_wait_response(token, &msg);
 		if (ret) {
 			pr_devel("Failed to wait for the async response\n");
@@ -95,20 +80,57 @@ static ssize_t sg_store(struct kobject *kobj, struct kobj_attribute *attr,
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
+static ssize_t sgroup_show(struct kobject *kobj, struct kobj_attribute *attr,
+			   char *buf)
+{
+	struct sg_attr *sattr = container_of(attr, struct sg_attr, attr);
+
+	return sprintf(buf, "%u\n", sattr->enable);
+}
+
+static ssize_t sgroup_store(struct kobject *kobj, struct kobj_attribute *attr,
+			    const char *buf, size_t count)
+{
+	struct sg_attr *sattr = container_of(attr, struct sg_attr, attr);
+	bool data;
+	int ret;
+
+	ret = kstrtobool(buf, &data);
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
+		if (data)
+			ret = sensor_group_clear(sattr->handle);
 		break;
-	case OPAL_SUCCESS:
-		ret = count;
+	case OPAL_SENSOR_GROUP_ENABLE:
+		ret = sensor_group_enable(sattr->handle, data);
+		if (!ret)
+			sattr->enable = data;
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
 
@@ -117,17 +139,25 @@ static ssize_t sg_store(struct kobject *kobj, struct kobj_attribute *attr,
 	const char *attr_name;
 	ssize_t (*store)(struct kobject *kobj, struct kobj_attribute *attr,
 			const char *buf, size_t count);
+	ssize_t (*show)(struct kobject *kobj, struct kobj_attribute *attr,
+			char *buf);
 } ops_info[] = {
-	{ OPAL_SENSOR_GROUP_CLEAR, "clear", sg_store },
+	{ OPAL_SENSOR_GROUP_CLEAR, "clear", sgroup_store, NULL},
+	{ OPAL_SENSOR_GROUP_ENABLE, "enable", sgroup_store, sgroup_show},
 };
 
 static void add_attr(int handle, struct sg_attr *attr, int index)
 {
 	attr->handle = handle;
+	attr->opal_no = ops_info[index].opal_no;
 	sysfs_attr_init(&attr->attr.attr);
 	attr->attr.attr.name = ops_info[index].attr_name;
-	attr->attr.attr.mode = 0220;
+	if (ops_info[index].show)
+		attr->attr.attr.mode = 0664;
+	else
+		attr->attr.attr.mode = 0220;
 	attr->attr.store = ops_info[index].store;
+	attr->attr.show = ops_info[index].show;
 }
 
 static int add_attr_group(const __be32 *ops, int len, struct sensor_group *sg,
@@ -142,6 +172,7 @@ static int add_attr_group(const __be32 *ops, int len, struct sensor_group *sg,
 				add_attr(handle, &sg->sgattrs[count], j);
 				sg->sg.attrs[count] =
 					&sg->sgattrs[count].attr.attr;
+				sg->sgattrs[count].enable = true;
 				count++;
 			}
 
@@ -186,6 +217,10 @@ void __init opal_sensor_groups_init(void)
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
