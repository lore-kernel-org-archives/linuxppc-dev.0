Return-Path: <zohar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sjWGn57D3zDrSf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Sep 2016 03:31:29 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8QHSktn094593
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 13:31:27 -0400
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25q52917ec-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 13:31:27 -0400
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zohar@linux.vnet.ibm.com>;
 Mon, 26 Sep 2016 23:01:24 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 06011E0062
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 23:00:47 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8QHVKnM42467354
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 23:01:20 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8QHVIhh009648
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 23:01:19 +0530
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-security-module <linux-security-module@vger.kernel.org>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 linux-ima-devel@lists.sourceforge.net, Dave Young <dyoung@redhat.com>,
 kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 07/10] ima: store the builtin/custom template definitions
 in a list
Date: Mon, 26 Sep 2016 13:30:26 -0400
In-Reply-To: <1474911029-6372-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1474911029-6372-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-Id: <1474911029-6372-8-git-send-email-zohar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The builtin and single custom templates are currently stored in an
array.  In preparation for being able to restore a measurement list
containing multiple builtin/custom templates, this patch stores the
builtin and custom templates as a linked list.  This will permit
defining more than one custom template per boot.

Changelog v4:
- fix "spinlock bad magic" BUG - reported by Dmitry Vyukov

Changelog v3:
- initialize template format list in ima_template_desc_current(), as it
might be called during __setup before normal initialization. (kernel
test robot)
- remove __init annotation of ima_init_template_list()

Changelog v2:
- fix lookup_template_desc() preemption imbalance (kernel test robot)

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 security/integrity/ima/ima.h          |  2 ++
 security/integrity/ima/ima_main.c     |  1 +
 security/integrity/ima/ima_template.c | 52 +++++++++++++++++++++++++++--------
 3 files changed, 44 insertions(+), 11 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 139dec6..6b0540a 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -85,6 +85,7 @@ struct ima_template_field {
 
 /* IMA template descriptor definition */
 struct ima_template_desc {
+	struct list_head list;
 	char *name;
 	char *fmt;
 	int num_fields;
@@ -146,6 +147,7 @@ int ima_restore_measurement_list(loff_t bufsize, void *buf);
 int ima_measurements_show(struct seq_file *m, void *v);
 unsigned long ima_get_binary_runtime_size(void);
 int ima_init_template(void);
+void ima_init_template_list(void);
 
 /*
  * used to protect h_table and sha_table
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 596ef61..592f318 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -418,6 +418,7 @@ static int __init init_ima(void)
 {
 	int error;
 
+	ima_init_template_list();
 	hash_setup(CONFIG_IMA_DEFAULT_HASH);
 	error = ima_init();
 	if (!error) {
diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index 37f972c..c0d808c 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -15,16 +15,20 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/rculist.h>
 #include "ima.h"
 #include "ima_template_lib.h"
 
-static struct ima_template_desc defined_templates[] = {
+static struct ima_template_desc builtin_templates[] = {
 	{.name = IMA_TEMPLATE_IMA_NAME, .fmt = IMA_TEMPLATE_IMA_FMT},
 	{.name = "ima-ng", .fmt = "d-ng|n-ng"},
 	{.name = "ima-sig", .fmt = "d-ng|n-ng|sig"},
 	{.name = "", .fmt = ""},	/* placeholder for a custom format */
 };
 
+static LIST_HEAD(defined_templates);
+static DEFINE_SPINLOCK(template_list);
+
 static struct ima_template_field supported_fields[] = {
 	{.field_id = "d", .field_init = ima_eventdigest_init,
 	 .field_show = ima_show_template_digest},
@@ -53,6 +57,8 @@ static int __init ima_template_setup(char *str)
 	if (ima_template)
 		return 1;
 
+	ima_init_template_list();
+
 	/*
 	 * Verify that a template with the supplied name exists.
 	 * If not, use CONFIG_IMA_DEFAULT_TEMPLATE.
@@ -81,7 +87,7 @@ __setup("ima_template=", ima_template_setup);
 
 static int __init ima_template_fmt_setup(char *str)
 {
-	int num_templates = ARRAY_SIZE(defined_templates);
+	int num_templates = ARRAY_SIZE(builtin_templates);
 
 	if (ima_template)
 		return 1;
@@ -92,22 +98,28 @@ static int __init ima_template_fmt_setup(char *str)
 		return 1;
 	}
 
-	defined_templates[num_templates - 1].fmt = str;
-	ima_template = defined_templates + num_templates - 1;
+	builtin_templates[num_templates - 1].fmt = str;
+	ima_template = builtin_templates + num_templates - 1;
+
 	return 1;
 }
 __setup("ima_template_fmt=", ima_template_fmt_setup);
 
 static struct ima_template_desc *lookup_template_desc(const char *name)
 {
-	int i;
+	struct ima_template_desc *template_desc;
+	int found = 0;
 
-	for (i = 0; i < ARRAY_SIZE(defined_templates); i++) {
-		if (strcmp(defined_templates[i].name, name) == 0)
-			return defined_templates + i;
+	rcu_read_lock();
+	list_for_each_entry_rcu(template_desc, &defined_templates, list) {
+		if ((strcmp(template_desc->name, name) == 0) ||
+		    (strcmp(template_desc->fmt, name) == 0)) {
+			found = 1;
+			break;
+		}
 	}
-
-	return NULL;
+	rcu_read_unlock();
+	return found ? template_desc : NULL;
 }
 
 static struct ima_template_field *lookup_template_field(const char *field_id)
@@ -183,11 +195,29 @@ static int template_desc_init_fields(const char *template_fmt,
 	return 0;
 }
 
+void ima_init_template_list(void)
+{
+	int i;
+
+	if (!list_empty(&defined_templates))
+		return;
+
+	spin_lock(&template_list);
+	for (i = 0; i < ARRAY_SIZE(builtin_templates); i++) {
+		list_add_tail_rcu(&builtin_templates[i].list,
+				  &defined_templates);
+	}
+	spin_unlock(&template_list);
+	synchronize_rcu();
+}
+
 struct ima_template_desc *ima_template_desc_current(void)
 {
-	if (!ima_template)
+	if (!ima_template) {
+		ima_init_template_list();
 		ima_template =
 		    lookup_template_desc(CONFIG_IMA_DEFAULT_TEMPLATE);
+	}
 	return ima_template;
 }
 
-- 
2.1.0
