Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t0VRh40txzDt45
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 13:46:08 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9L2hqhs023765
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2016 22:46:06 -0400
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2675yfh392-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2016 22:46:06 -0400
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Fri, 21 Oct 2016 00:46:04 -0200
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.18.232.225])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id E0D493520068
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2016 22:45:36 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u9L2k3qc33357854
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 00:46:03 -0200
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u9L2k2wR005091
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 00:46:02 -0200
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: linux-security-module <linux-security-module@vger.kernel.org>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 linux-ima-devel@lists.sourceforge.net, Dave Young <dyoung@redhat.com>,
 kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 08/10] ima: support restoring multiple template formats
Date: Fri, 21 Oct 2016 00:44:56 -0200
In-Reply-To: <1477017898-10375-1-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1477017898-10375-1-git-send-email-bauerman@linux.vnet.ibm.com>
Message-Id: <1477017898-10375-9-git-send-email-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mimi Zohar <zohar@linux.vnet.ibm.com>

The configured IMA measurement list template format can be replaced at
runtime on the boot command line, including a custom template format.
This patch adds support for restoring a measuremement list containing
multiple builtin/custom template formats.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 security/integrity/ima/ima_template.c | 53 +++++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 3 deletions(-)

diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index c0d808c20c40..e57b4682ff93 100644
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
2.7.4
