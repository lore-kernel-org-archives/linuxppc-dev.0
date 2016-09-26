Return-Path: <zohar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sjWGr731DzDrSp
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Sep 2016 03:31:32 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8QHSk2L095515
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 13:31:30 -0400
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25q5enyq6p-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 13:31:30 -0400
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zohar@linux.vnet.ibm.com>;
 Mon, 26 Sep 2016 23:01:27 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id D2AFEE005A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 23:00:49 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8QHVNVM37159116
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 23:01:23 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8QHVMPQ009677
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 23:01:23 +0530
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-security-module <linux-security-module@vger.kernel.org>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 linux-ima-devel@lists.sourceforge.net, Dave Young <dyoung@redhat.com>,
 kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 08/10] ima: support restoring multiple template formats
Date: Mon, 26 Sep 2016 13:30:27 -0400
In-Reply-To: <1474911029-6372-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1474911029-6372-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-Id: <1474911029-6372-9-git-send-email-zohar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The configured IMA measurement list template format can be replaced at
runtime on the boot command line, including a custom template format.
This patch adds support for restoring a measuremement list containing
multiple builtin/custom template formats.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 security/integrity/ima/ima_template.c | 53 +++++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 3 deletions(-)

diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index c0d808c..e57b468 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -155,9 +155,14 @@ static int template_desc_init_fields(const char *template_fmt,
 {
 	const char *template_fmt_ptr;
 	struct ima_template_field *found_fields[IMA_TEMPLATE_NUM_FIELDS_MAX];
-	int template_num_fields = template_fmt_size(template_fmt);
+	int template_num_fields;
 	int i, len;
 
+	if (num_fields && *num_fields > 0) /* already initialized? */
+		return 0;
+
+	template_num_fields = template_fmt_size(template_fmt);
+
 	if (template_num_fields > IMA_TEMPLATE_NUM_FIELDS_MAX) {
 		pr_err("format string '%s' contains too many fields\n",
 		       template_fmt);
@@ -237,6 +242,35 @@ int __init ima_init_template(void)
 	return result;
 }
 
+static struct ima_template_desc *restore_template_fmt(char *template_name)
+{
+	struct ima_template_desc *template_desc = NULL;
+	int ret;
+
+	ret = template_desc_init_fields(template_name, NULL, NULL);
+	if (ret < 0) {
+		pr_err("attempting to initialize the template \"%s\" failed\n",
+			template_name);
+		goto out;
+	}
+
+	template_desc = kzalloc(sizeof(*template_desc), GFP_KERNEL);
+	if (!template_desc)
+		goto out;
+
+	template_desc->name = "";
+	template_desc->fmt = kstrdup(template_name, GFP_KERNEL);
+	if (!template_desc->fmt)
+		goto out;
+
+	spin_lock(&template_list);
+	list_add_tail_rcu(&template_desc->list, &defined_templates);
+	spin_unlock(&template_list);
+	synchronize_rcu();
+out:
+	return template_desc;
+}
+
 static int ima_restore_template_data(struct ima_template_desc *template_desc,
 				     void *template_data,
 				     int template_data_size,
@@ -367,10 +401,23 @@ int ima_restore_measurement_list(loff_t size, void *buf)
 		}
 		data_v1 = bufp += (u_int8_t)hdr_v1->template_name_len;
 
-		/* get template format */
 		template_desc = lookup_template_desc(template_name);
 		if (!template_desc) {
-			pr_err("template \"%s\" not found\n", template_name);
+			template_desc = restore_template_fmt(template_name);
+			if (!template_desc)
+				break;
+		}
+
+		/*
+		 * Only the running system's template format is initialized
+		 * on boot.  As needed, initialize the other template formats.
+		 */
+		ret = template_desc_init_fields(template_desc->fmt,
+						&(template_desc->fields),
+						&(template_desc->num_fields));
+		if (ret < 0) {
+			pr_err("attempting to restore the template fmt \"%s\" \
+				failed\n", template_desc->fmt);
 			ret = -EINVAL;
 			break;
 		}
-- 
2.1.0
