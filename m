Return-Path: <SRS0=HNI+=SN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88758C10F13
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 03:57:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B14CD2133D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 03:57:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B14CD2133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fnKk5q3KzDqPK
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 13:57:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=shilpa.bhat@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fnJ422kpzDqKN
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 13:55:57 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3B3sYxF016690
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 23:55:54 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2rsx3c01qk-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 23:55:54 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Thu, 11 Apr 2019 04:55:52 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 11 Apr 2019 04:55:51 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x3B3toqt20119574
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 11 Apr 2019 03:55:50 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ED5CA11C04C;
 Thu, 11 Apr 2019 03:55:49 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 64F2211C04A;
 Thu, 11 Apr 2019 03:55:48 +0000 (GMT)
Received: from oc4502181600.ibm.com (unknown [9.199.36.192])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 11 Apr 2019 03:55:48 +0000 (GMT)
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Subject: [PATCH V3] powernv: sensor-groups: Add debugfs file to enable/disable
 sensor groups
Date: Thu, 11 Apr 2019 09:24:46 +0530
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 19041103-0020-0000-0000-0000032E8D53
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041103-0021-0000-0000-00002180BB19
Message-Id: <1554954886-24460-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-11_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904110027
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: ego@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This patch provides support to disable and enable platform specific
sensor groups like performance, utilization and frequency which are
not supported in hwmon.

Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
Changes from V2:
- Rebase on master

Changes from V1:
- As per Michael Ellerman's suggestion, adding the "enable" files to debugfs.
  The original code had been written in mind to accomodate the "enable" file
  in the same path as "clear" attribute. As this is not required anymore
  the code is cleaned up to bifurcate the functions adding "enable" and
  "clear" attribute.

 .../powerpc/platforms/powernv/opal-sensor-groups.c | 292 ++++++++++++++-------
 1 file changed, 194 insertions(+), 98 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-sensor-groups.c b/arch/powerpc/platforms/powernv/opal-sensor-groups.c
index 1796092..1208538 100644
--- a/arch/powerpc/platforms/powernv/opal-sensor-groups.c
+++ b/arch/powerpc/platforms/powernv/opal-sensor-groups.c
@@ -15,22 +15,21 @@
 #include <linux/kobject.h>
 #include <linux/slab.h>
 
+#include <asm/debugfs.h>
 #include <asm/opal.h>
 
-DEFINE_MUTEX(sg_mutex);
+#define SENSOR_GROUPS_DIR_STR	"sensor_groups"
 
 static struct kobject *sg_kobj;
 
-struct sg_attr {
-	u32 handle;
-	struct kobj_attribute attr;
-};
-
 static struct sensor_group {
-	char name[20];
+	struct kobj_attribute sattr;
 	struct attribute_group sg;
-	struct sg_attr *sgattrs;
-} *sgs;
+	struct mutex mutex;
+	char name[20];
+	u32 handle;
+	u32 enable;
+} *sgroups;
 
 int sensor_group_enable(u32 handle, bool enable)
 {
@@ -60,10 +59,12 @@ int sensor_group_enable(u32 handle, bool enable)
 }
 EXPORT_SYMBOL_GPL(sensor_group_enable);
 
-static ssize_t sg_store(struct kobject *kobj, struct kobj_attribute *attr,
-			const char *buf, size_t count)
+static ssize_t sgroup_clear_store(struct kobject *kobj,
+				  struct kobj_attribute *attr,
+				  const char *buf, size_t count)
 {
-	struct sg_attr *sattr = container_of(attr, struct sg_attr, attr);
+	struct sensor_group *sgroup = container_of(attr, struct sensor_group,
+						   sattr);
 	struct opal_msg msg;
 	u32 data;
 	int ret, token;
@@ -81,11 +82,11 @@ static ssize_t sg_store(struct kobject *kobj, struct kobj_attribute *attr,
 		return token;
 	}
 
-	ret = mutex_lock_interruptible(&sg_mutex);
+	ret = mutex_lock_interruptible(&sgroup->mutex);
 	if (ret)
 		goto out_token;
 
-	ret = opal_sensor_group_clear(sattr->handle, token);
+	ret = opal_sensor_group_clear(sgroup->handle, token);
 	switch (ret) {
 	case OPAL_ASYNC_COMPLETION:
 		ret = opal_async_wait_response(token, &msg);
@@ -106,135 +107,230 @@ static ssize_t sg_store(struct kobject *kobj, struct kobj_attribute *attr,
 	}
 
 out:
-	mutex_unlock(&sg_mutex);
+	mutex_unlock(&sgroup->mutex);
 out_token:
 	opal_async_release_token(token);
 	return ret;
 }
 
-static struct sg_ops_info {
-	int opal_no;
-	const char *attr_name;
-	ssize_t (*store)(struct kobject *kobj, struct kobj_attribute *attr,
-			const char *buf, size_t count);
-} ops_info[] = {
-	{ OPAL_SENSOR_GROUP_CLEAR, "clear", sg_store },
-};
+static int find_nr_groups(struct device_node *sensor_group_node, int opal_no)
+{
+	struct device_node *node;
+	int count = 0;
+
+	for_each_child_of_node(sensor_group_node, node) {
+		u32 sgid, op;
+
+		if (of_device_is_compatible(node, "ibm,opal-sensor"))
+			continue;
+
+		if (of_property_read_u32(node, "ops", &op))
+			continue;
+
+		if (op != opal_no)
+			continue;
+
+		if (of_property_read_u32(node, "sensor-group-id", &sgid))
+			continue;
+		count++;
+	}
 
-static void add_attr(int handle, struct sg_attr *attr, int index)
+	return count;
+}
+
+#ifdef CONFIG_DEBUG_FS
+static int sgroup_enable_get(void *data, u64 *val)
 {
-	attr->handle = handle;
-	sysfs_attr_init(&attr->attr.attr);
-	attr->attr.attr.name = ops_info[index].attr_name;
-	attr->attr.attr.mode = 0220;
-	attr->attr.store = ops_info[index].store;
+	struct sensor_group *sgroup = (struct sensor_group *)data;
+	int rc;
+
+	rc = mutex_lock_interruptible(&sgroup->mutex);
+	if (rc)
+		return rc;
+
+	*val = sgroup->enable;
+	mutex_unlock(&sgroup->mutex);
+
+	return 0;
 }
 
-static int add_attr_group(const __be32 *ops, int len, struct sensor_group *sg,
-			   u32 handle)
+static int sgroup_enable_set(void *data, u64 val)
 {
-	int i, j;
-	int count = 0;
+	struct sensor_group *sgroup = (struct sensor_group *)data;
+	int rc;
+
+	if (val != 0 && val != 1)
+		return -EINVAL;
 
-	for (i = 0; i < len; i++)
-		for (j = 0; j < ARRAY_SIZE(ops_info); j++)
-			if (be32_to_cpu(ops[i]) == ops_info[j].opal_no) {
-				add_attr(handle, &sg->sgattrs[count], j);
-				sg->sg.attrs[count] =
-					&sg->sgattrs[count].attr.attr;
-				count++;
-			}
+	rc = mutex_lock_interruptible(&sgroup->mutex);
+	if (rc)
+		return rc;
 
-	return sysfs_create_group(sg_kobj, &sg->sg);
+	if (val != sgroup->enable) {
+		rc = sensor_group_enable(sgroup->handle, val);
+		if (!rc)
+			sgroup->enable = val;
+	}
+
+	mutex_unlock(&sgroup->mutex);
+	return rc;
 }
 
-static int get_nr_attrs(const __be32 *ops, int len)
+DEFINE_DEBUGFS_ATTRIBUTE(sensor_debugfs_ops, sgroup_enable_get,
+			 sgroup_enable_set, "%llx\n");
+static struct dentry *sensor_debugfs_parent;
+static struct sensor_group *dgroups;
+
+static void add_debugfs_attrs(struct device_node *sensor_group_node)
 {
-	int i, j;
-	int nr_attrs = 0;
+	struct device_node *node;
+	int i = 0, count;
+
+	count = find_nr_groups(sensor_group_node, OPAL_SENSOR_GROUP_ENABLE);
+	if (!count)
+		return;
+
+	dgroups = kcalloc(count, sizeof(*dgroups), GFP_KERNEL);
+	if (!dgroups)
+		return;
+
+	sensor_debugfs_parent = debugfs_create_dir(SENSOR_GROUPS_DIR_STR,
+						   powerpc_debugfs_root);
 
-	for (i = 0; i < len; i++)
-		for (j = 0; j < ARRAY_SIZE(ops_info); j++)
-			if (be32_to_cpu(ops[i]) == ops_info[j].opal_no)
-				nr_attrs++;
+	if (!sensor_debugfs_parent)
+		goto out_dgroups;
 
-	return nr_attrs;
+	for_each_child_of_node(sensor_group_node, node) {
+		struct dentry *group;
+		u32 op, sgid, chipid;
+
+		if (of_device_is_compatible(node, "ibm,opal-sensor"))
+			continue;
+
+		if (of_property_read_u32(node, "ops", &op))
+			continue;
+
+		if (op != OPAL_SENSOR_GROUP_ENABLE)
+			continue;
+
+		if (of_property_read_u32(node, "sensor-group-id", &sgid))
+			continue;
+
+		if (!of_property_read_u32(node, "ibm,chip-id", &chipid))
+			sprintf(dgroups[i].name, "%s%d", node->name, chipid);
+		else
+			sprintf(dgroups[i].name, "%s", node->name);
+
+		dgroups[i].handle = sgid;
+		dgroups[i].enable = 1;
+		mutex_init(&dgroups[i].mutex);
+		group = debugfs_create_dir(dgroups[i].name,
+					   sensor_debugfs_parent);
+		if (!group) {
+			of_node_put(node);
+			goto out_debugfs;
+		}
+
+		if (!debugfs_create_file("enable", 0664, group, &dgroups[i],
+					 &sensor_debugfs_ops)) {
+			of_node_put(node);
+			goto out_debugfs;
+		}
+		i++;
+	}
+
+	return;
+
+out_debugfs:
+	debugfs_remove_recursive(sensor_debugfs_parent);
+out_dgroups:
+	kfree(dgroups);
 }
+#endif /* CONFIG_DEBUG_FS */
 
 void __init opal_sensor_groups_init(void)
 {
-	struct device_node *sg, *node;
-	int i = 0;
+	struct device_node *sensor_group_node, *node;
+	int i = 0, count;
 
-	sg = of_find_compatible_node(NULL, NULL, "ibm,opal-sensor-group");
-	if (!sg) {
+	sensor_group_node = of_find_compatible_node(NULL, NULL,
+						    "ibm,opal-sensor-group");
+	if (!sensor_group_node) {
 		pr_devel("Sensor groups node not found\n");
 		return;
 	}
 
-	sgs = kcalloc(of_get_child_count(sg), sizeof(*sgs), GFP_KERNEL);
-	if (!sgs)
-		return;
+	count = find_nr_groups(sensor_group_node, OPAL_SENSOR_GROUP_CLEAR);
+	if (!count)
+		goto out_node_put;
+
+	sgroups = kcalloc(count, sizeof(*sgroups), GFP_KERNEL);
+	if (!sgroups)
+		goto out_node_put;
 
-	sg_kobj = kobject_create_and_add("sensor_groups", opal_kobj);
+	sg_kobj = kobject_create_and_add(SENSOR_GROUPS_DIR_STR, opal_kobj);
 	if (!sg_kobj) {
 		pr_warn("Failed to create sensor group kobject\n");
-		goto out_sgs;
+		goto out_sgroups;
 	}
 
-	for_each_child_of_node(sg, node) {
-		const __be32 *ops;
-		u32 sgid, len, nr_attrs, chipid;
+	for_each_child_of_node(sensor_group_node, node) {
+		u32 sgid, chipid, op;
 
-		ops = of_get_property(node, "ops", &len);
-		if (!ops)
+		if (of_property_read_u32(node, "ops", &op))
 			continue;
 
-		nr_attrs = get_nr_attrs(ops, len);
-		if (!nr_attrs)
+		if (op != OPAL_SENSOR_GROUP_CLEAR)
 			continue;
 
-		sgs[i].sgattrs = kcalloc(nr_attrs, sizeof(*sgs[i].sgattrs),
-					 GFP_KERNEL);
-		if (!sgs[i].sgattrs)
-			goto out_sgs_sgattrs;
-
-		sgs[i].sg.attrs = kcalloc(nr_attrs + 1,
-					  sizeof(*sgs[i].sg.attrs),
-					  GFP_KERNEL);
-
-		if (!sgs[i].sg.attrs) {
-			kfree(sgs[i].sgattrs);
-			goto out_sgs_sgattrs;
-		}
-
-		if (of_property_read_u32(node, "sensor-group-id", &sgid)) {
-			pr_warn("sensor-group-id property not found\n");
-			goto out_sgs_sgattrs;
-		}
+		if (of_property_read_u32(node, "sensor-group-id", &sgid))
+			continue;
 
 		if (!of_property_read_u32(node, "ibm,chip-id", &chipid))
-			sprintf(sgs[i].name, "%pOFn%d", node, chipid);
+			sprintf(sgroups[i].name, "%pOFn%d", node, chipid);
 		else
-			sprintf(sgs[i].name, "%pOFn", node);
+			sprintf(sgroups[i].name, "%pOFn", node);
+
+		sgroups[i].sg.attrs = kzalloc(sizeof(struct attribute *) * 2,
+					      GFP_KERNEL);
+		if (!sgroups[i].sg.attrs) {
+			of_node_put(node);
+			goto out_sg_attrs;
+		}
 
-		sgs[i].sg.name = sgs[i].name;
-		if (add_attr_group(ops, len, &sgs[i], sgid)) {
+		sgroups[i].sg.name = sgroups[i].name;
+		sgroups[i].handle = sgid;
+		sysfs_attr_init(sgroups[i].sattr.attr);
+		sgroups[i].sattr.attr.name = "clear";
+		sgroups[i].sattr.attr.mode = 0220;
+		sgroups[i].sattr.store = sgroup_clear_store;
+		sgroups[i].sg.attrs[0] = &sgroups[i].sattr.attr;
+		sgroups[i].sg.attrs[1] = NULL;
+		mutex_init(&sgroups[i].mutex);
+
+		if (sysfs_create_group(sg_kobj, &sgroups[i].sg)) {
 			pr_warn("Failed to create sensor attribute group %s\n",
-				sgs[i].sg.name);
-			goto out_sgs_sgattrs;
+				sgroups[i].sg.name);
+			kfree(sgroups[i].sg.attrs);
+			of_node_put(node);
+			goto out_sg_attrs;
 		}
+
 		i++;
 	}
 
-	return;
+#ifdef CONFIG_DEBUG_FS
+	add_debugfs_attrs(sensor_group_node);
+#endif /* CONFIG_DEBUG_FS */
 
-out_sgs_sgattrs:
-	while (--i >= 0) {
-		kfree(sgs[i].sgattrs);
-		kfree(sgs[i].sg.attrs);
-	}
+	goto out_node_put;
+
+out_sg_attrs:
+	while (i-- > 0)
+		kfree(sgroups[i].sg.attrs);
 	kobject_put(sg_kobj);
-out_sgs:
-	kfree(sgs);
+out_sgroups:
+	kfree(sgroups);
+out_node_put:
+	of_node_put(sensor_group_node);
 }
-- 
1.8.3.1

