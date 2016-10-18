Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sz2952sT6zDt39
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Oct 2016 04:28:24 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9IHOedZ001026
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Oct 2016 13:28:20 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 265n4dte20-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Oct 2016 13:28:20 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 18 Oct 2016 13:28:18 -0400
Subject: [PATCH v6 1/3] powerpc/pseries: Correct possible read beyond dlpar
 sysfs buffer
To: linuxppc-dev@lists.ozlabs.org
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Cc: sahilmehta17@gmail.com
Date: Tue, 18 Oct 2016 13:20:26 -0400
In-Reply-To: <20161018171803.37287.54834.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
References: <20161018171803.37287.54834.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20161018172012.37287.76194.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The pasrsing of data written to the dlpar file in sysfs does not correctly
account for the possibility of reading past the end of the buffer. Correct
this by updating the buffer parsing code to make a local copy and use the
strsep() and sysfs_streq() routines to parse the buffer. This also
separates the parsing code into subroutines to make cleaner.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/dlpar.c |  141 ++++++++++++++++++++++----------
 1 file changed, 96 insertions(+), 45 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index 423e450..ec5d677 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -418,84 +418,135 @@ void queue_hotplug_event(struct pseries_hp_errorlog *hp_errlog,
 	}
 }
 
-static ssize_t dlpar_store(struct class *class, struct class_attribute *attr,
-			   const char *buf, size_t count)
+static int dlpar_parse_resource(char **cmd, struct pseries_hp_errorlog *hp_elog)
 {
-	struct pseries_hp_errorlog *hp_elog;
-	struct completion hotplug_done;
-	const char *arg;
-	int rc;
+	char *arg;
 
-	hp_elog = kzalloc(sizeof(*hp_elog), GFP_KERNEL);
-	if (!hp_elog) {
-		rc = -ENOMEM;
-		goto dlpar_store_out;
-	}
+	arg = strsep(cmd, " ");
+	if (!arg)
+		return -EINVAL;
 
-	/* Parse out the request from the user, this will be in the form
-	 * <resource> <action> <id_type> <id>
-	 */
-	arg = buf;
-	if (!strncmp(arg, "memory", 6)) {
+	if (sysfs_streq(arg, "memory")) {
 		hp_elog->resource = PSERIES_HP_ELOG_RESOURCE_MEM;
-		arg += strlen("memory ");
-	} else if (!strncmp(arg, "cpu", 3)) {
+	} else if (sysfs_streq(arg, "cpu")) {
 		hp_elog->resource = PSERIES_HP_ELOG_RESOURCE_CPU;
-		arg += strlen("cpu ");
 	} else {
-		pr_err("Invalid resource specified: \"%s\"\n", buf);
-		rc = -EINVAL;
-		goto dlpar_store_out;
+		pr_err("Invalid resource specified.\n");
+		return -EINVAL;
 	}
 
-	if (!strncmp(arg, "add", 3)) {
+	return 0;
+}
+
+static int dlpar_parse_action(char **cmd, struct pseries_hp_errorlog *hp_elog)
+{
+	char *arg;
+
+	arg = strsep(cmd, " ");
+	if (!arg)
+		return -EINVAL;
+
+	if (sysfs_streq(arg, "add")) {
 		hp_elog->action = PSERIES_HP_ELOG_ACTION_ADD;
-		arg += strlen("add ");
-	} else if (!strncmp(arg, "remove", 6)) {
+	} else if (sysfs_streq(arg, "remove")) {
 		hp_elog->action = PSERIES_HP_ELOG_ACTION_REMOVE;
-		arg += strlen("remove ");
 	} else {
-		pr_err("Invalid action specified: \"%s\"\n", buf);
-		rc = -EINVAL;
-		goto dlpar_store_out;
+		pr_err("Invalid action specified.\n");
+		return -EINVAL;
 	}
 
-	if (!strncmp(arg, "index", 5)) {
-		u32 index;
+	return 0;
+}
 
+static int dlpar_parse_id_type(char **cmd, struct pseries_hp_errorlog *hp_elog)
+{
+	char *arg;
+	u32 count, index;
+
+	arg = strsep(cmd, " ");
+	if (!arg)
+		return -EINVAL;
+
+	if (sysfs_streq(arg, "index")) {
 		hp_elog->id_type = PSERIES_HP_ELOG_ID_DRC_INDEX;
-		arg += strlen("index ");
+		arg = strsep(cmd, " ");
+		if (!arg) {
+			pr_err("No DRC Index specified.\n");
+			return -EINVAL;
+		}
+
 		if (kstrtou32(arg, 0, &index)) {
-			rc = -EINVAL;
-			pr_err("Invalid drc_index specified: \"%s\"\n", buf);
-			goto dlpar_store_out;
+			pr_err("Invalid DRC Index specified.\n");
+			return -EINVAL;
 		}
 
 		hp_elog->_drc_u.drc_index = cpu_to_be32(index);
-	} else if (!strncmp(arg, "count", 5)) {
-		u32 count;
-
+	} else if (sysfs_streq(arg, "count")) {
 		hp_elog->id_type = PSERIES_HP_ELOG_ID_DRC_COUNT;
-		arg += strlen("count ");
+		arg = strsep(cmd, " ");
+		if (!arg) {
+			pr_err("No DRC count specified.\n");
+			return -EINVAL;
+		}
+
 		if (kstrtou32(arg, 0, &count)) {
-			rc = -EINVAL;
-			pr_err("Invalid count specified: \"%s\"\n", buf);
-			goto dlpar_store_out;
+			pr_err("Invalid DRC count specified.\n");
+			return -EINVAL;
 		}
 
 		hp_elog->_drc_u.drc_count = cpu_to_be32(count);
 	} else {
-		pr_err("Invalid id_type specified: \"%s\"\n", buf);
-		rc = -EINVAL;
-		goto dlpar_store_out;
+		pr_err("Invalid id_type specified.\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static ssize_t dlpar_store(struct class *class, struct class_attribute *attr,
+			   const char *buf, size_t count)
+{
+	struct pseries_hp_errorlog *hp_elog;
+	struct completion hotplug_done;
+	char *argbuf;
+	char *args;
+	int rc;
+
+	args = argbuf = kstrdup(buf, GFP_KERNEL);
+	hp_elog = kzalloc(sizeof(*hp_elog), GFP_KERNEL);
+	if (!hp_elog || !argbuf) {
+		pr_info("Could not allocate resources for DLPAR operation\n");
+		kfree(argbuf);
+		kfree(hp_elog);
+		return -ENOMEM;
 	}
 
+	/* Parse out the request from the user, this will be in the form
+	 * <resource> <action> <id_type> <id>
+	 */
+	rc = dlpar_parse_resource(&args, hp_elog);
+	if (rc)
+		goto dlpar_store_out;
+
+	rc = dlpar_parse_action(&args, hp_elog);
+	if (rc)
+		goto dlpar_store_out;
+
+	rc = dlpar_parse_id_type(&args, hp_elog);
+	if (rc)
+		goto dlpar_store_out;
+
 	init_completion(&hotplug_done);
 	queue_hotplug_event(hp_elog, &hotplug_done, &rc);
 	wait_for_completion(&hotplug_done);
 
 dlpar_store_out:
+	kfree(argbuf);
 	kfree(hp_elog);
+
+	if (rc)
+		pr_err("Could not handle DLPAR request \"%s\"\n", buf);
+
 	return rc ? rc : count;
 }
 
