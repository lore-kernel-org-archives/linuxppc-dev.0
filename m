Return-Path: <zohar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sZbhp042hzDsTX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 21:26:33 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8FBNGbU035415
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 07:26:32 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25fqtrh5gh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 07:26:31 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zohar@linux.vnet.ibm.com>;
 Thu, 15 Sep 2016 21:26:29 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 5F42F2CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 21:26:26 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8FBQQ4h55181468
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 21:26:26 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8FBQPlZ008021
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 21:26:26 +1000
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-security-module <linux-security-module@vger.kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>,
 linux-ima-devel@lists.sourceforge.net, Dave Young <dyoung@redhat.com>,
 kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v4 1/9] ima: on soft reboot, restore the measurement list
Date: Thu, 15 Sep 2016 07:26:03 -0400
In-Reply-To: <1473938771-2782-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1473938771-2782-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-Id: <1473938771-2782-2-git-send-email-zohar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The TPM PCRs are only reset on a hard reboot.  In order to validate a
TPM's quote after a soft reboot (eg. kexec -e), the IMA measurement list
of the running kernel must be saved and restored on boot.  This patch
restores the measurement list.

Changelog v2:
- redefined ima_kexec_hdr to use types with well defined sizes (M. Ellerman)
- defined missing ima_load_kexec_buffer() stub function

Changelog v1:
- call ima_load_kexec_buffer() (Thiago)

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 security/integrity/ima/Makefile       |   1 +
 security/integrity/ima/ima.h          |  18 ++++
 security/integrity/ima/ima_init.c     |   2 +
 security/integrity/ima/ima_kexec.c    |  55 +++++++++++
 security/integrity/ima/ima_queue.c    |  10 ++
 security/integrity/ima/ima_template.c | 170 ++++++++++++++++++++++++++++++++++
 6 files changed, 256 insertions(+)
 create mode 100644 security/integrity/ima/ima_kexec.c

diff --git a/security/integrity/ima/Makefile b/security/integrity/ima/Makefile
index 9aeaeda..56093be 100644
--- a/security/integrity/ima/Makefile
+++ b/security/integrity/ima/Makefile
@@ -8,4 +8,5 @@ obj-$(CONFIG_IMA) += ima.o
 ima-y := ima_fs.o ima_queue.o ima_init.o ima_main.o ima_crypto.o ima_api.o \
 	 ima_policy.o ima_template.o ima_template_lib.o
 ima-$(CONFIG_IMA_APPRAISE) += ima_appraise.o
+ima-$(CONFIG_KEXEC_FILE) += ima_kexec.o
 obj-$(CONFIG_IMA_BLACKLIST_KEYRING) += ima_mok.o
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index db25f54..e7b3755 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -102,6 +102,15 @@ struct ima_queue_entry {
 };
 extern struct list_head ima_measurements;	/* list of all measurements */
 
+/* Some details preceding the binary serialized measurement list */
+struct ima_kexec_hdr {
+	u16 version;
+	u16 _reserved0;
+	u32 _reserved1;
+	u64 buffer_size;
+	u64 count;
+};
+
 /* Internal IMA function definitions */
 int ima_init(void);
 int ima_fs_init(void);
@@ -122,8 +131,17 @@ int ima_init_crypto(void);
 void ima_putc(struct seq_file *m, void *data, int datalen);
 void ima_print_digest(struct seq_file *m, u8 *digest, u32 size);
 struct ima_template_desc *ima_template_desc_current(void);
+int ima_restore_measurement_entry(struct ima_template_entry *entry);
+int ima_restore_measurement_list(loff_t bufsize, void *buf);
 int ima_init_template(void);
 
+#ifdef CONFIG_KEXEC_FILE
+void ima_load_kexec_buffer(void);
+#else
+static inline void ima_load_kexec_buffer(void)
+{}
+#endif
+
 /*
  * used to protect h_table and sha_table
  */
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 32912bd..3ba0ca4 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -128,6 +128,8 @@ int __init ima_init(void)
 	if (rc != 0)
 		return rc;
 
+	ima_load_kexec_buffer();
+
 	rc = ima_add_boot_aggregate();	/* boot aggregate must be first entry */
 	if (rc != 0)
 		return rc;
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
new file mode 100644
index 0000000..6a046ad
--- /dev/null
+++ b/security/integrity/ima/ima_kexec.c
@@ -0,0 +1,55 @@
+/*
+ * Copyright (C) 2016 IBM Corporation
+ *
+ * Authors:
+ * Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
+ * Mimi Zohar <zohar@linux.vnet.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+#include <linux/fcntl.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/seq_file.h>
+#include <linux/rculist.h>
+#include <linux/rcupdate.h>
+#include <linux/parser.h>
+#include <linux/vmalloc.h>
+#include <linux/kexec.h>
+#include <linux/reboot.h>
+
+#include "ima.h"
+
+/*
+ * Restore the measurement list from the previous kernel.
+ */
+void ima_load_kexec_buffer(void)
+{
+	void *kexec_buffer = NULL;
+	size_t kexec_buffer_size = 0;
+	int rc;
+
+	rc = kexec_get_handover_buffer(&kexec_buffer, &kexec_buffer_size);
+	switch (rc) {
+	case 0:
+		rc = ima_restore_measurement_list(kexec_buffer_size,
+						  kexec_buffer);
+		if (rc != 0)
+			pr_err("Failed to restore the measurement list: %d\n",
+				rc);
+
+		kexec_free_handover_buffer();
+		break;
+	case -ENOTSUPP:
+		pr_debug("Restoring the measurement list not supported\n");
+		break;
+	case -ENOENT:
+		pr_debug("No measurement list to restore\n");
+		break;
+	default:
+		pr_debug("Error restoring the measurement list: %d\n", rc);
+	}
+}
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 32f6ac0..4b1bb77 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -149,3 +149,13 @@ out:
 			    op, audit_cause, result, audit_info);
 	return result;
 }
+
+int ima_restore_measurement_entry(struct ima_template_entry *entry)
+{
+	int result = 0;
+
+	mutex_lock(&ima_extend_list_mutex);
+	result = ima_add_digest_entry(entry);
+	mutex_unlock(&ima_extend_list_mutex);
+	return result;
+}
diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index febd12e..7c90075 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -37,6 +37,7 @@ static struct ima_template_field supported_fields[] = {
 	{.field_id = "sig", .field_init = ima_eventsig_init,
 	 .field_show = ima_show_template_sig},
 };
+#define MAX_TEMPLATE_NAME_LEN 15
 
 static struct ima_template_desc *ima_template;
 static struct ima_template_desc *lookup_template_desc(const char *name);
@@ -205,3 +206,172 @@ int __init ima_init_template(void)
 
 	return result;
 }
+
+static int ima_restore_template_data(struct ima_template_desc *template_desc,
+				     void *template_data,
+				     int template_data_size,
+				     struct ima_template_entry **entry)
+{
+	struct binary_field_data {
+		u32 len;
+		u8 data[0];
+	} __packed;
+
+	struct binary_field_data *field_data;
+	int offset = 0;
+	int ret = 0;
+	int i;
+
+	*entry = kzalloc(sizeof(**entry) +
+		    template_desc->num_fields * sizeof(struct ima_field_data),
+		    GFP_NOFS);
+	if (!*entry)
+		return -ENOMEM;
+
+	(*entry)->template_desc = template_desc;
+	for (i = 0; i < template_desc->num_fields; i++) {
+		field_data = template_data + offset;
+
+		/* Each field of the template data is prefixed with a length. */
+		if (offset > (template_data_size - sizeof(field_data->len))) {
+			pr_err("Restoring the template field failed\n");
+			ret = -EINVAL;
+			break;
+		}
+		offset += sizeof(field_data->len);
+
+		if (offset > (template_data_size - field_data->len)) {
+			pr_err("Restoring the template field data failed\n");
+			ret = -EINVAL;
+			break;
+		}
+		offset += field_data->len;
+
+		(*entry)->template_data[i].len = field_data->len;
+		(*entry)->template_data_len += sizeof(field_data->len);
+
+		(*entry)->template_data[i].data =
+			kzalloc(field_data->len + 1, GFP_KERNEL);
+		if (!(*entry)->template_data[i].data) {
+			ret = -ENOMEM;
+			break;
+		}
+		memcpy((*entry)->template_data[i].data, field_data->data,
+			field_data->len);
+		(*entry)->template_data_len += field_data->len;
+	}
+
+	if (ret < 0) {
+		ima_free_template_entry(*entry);
+		*entry = NULL;
+	}
+
+	return ret;
+}
+
+/* Restore the serialized binary measurement list without extending PCRs. */
+int ima_restore_measurement_list(loff_t size, void *buf)
+{
+	struct binary_hdr_v1 {
+		u32 pcr;
+		u8 digest[TPM_DIGEST_SIZE];
+		u32 template_name_len;
+		char template_name[0];
+	} __packed;
+	char template_name[MAX_TEMPLATE_NAME_LEN];
+
+	struct binary_data_v1 {
+		u32 template_data_size;
+		char template_data[0];
+	} __packed;
+
+	struct ima_kexec_hdr *khdr = buf;
+	struct binary_hdr_v1 *hdr_v1;
+	struct binary_data_v1 *data_v1;
+
+	void *bufp = buf + sizeof(*khdr);
+	void *bufendp = buf + khdr->buffer_size;
+	struct ima_template_entry *entry;
+	struct ima_template_desc *template_desc;
+	unsigned long count = 0;
+	int ret = 0;
+
+	if (!buf || size < sizeof(*khdr))
+		return 0;
+
+	if (khdr->version != 1) {
+		pr_err("attempting to restore a incompatible measurement list");
+		return 0;
+	}
+
+	/*
+	 * ima kexec buffer prefix: version, buffer size, count
+	 * v1 format: pcr, digest, template-name-len, template-name,
+	 *	      template-data-size, template-data
+	 */
+	while ((bufp < bufendp) && (count++ < khdr->count)) {
+		if (count > ULONG_MAX - 1) {
+			pr_err("attempting to restore too many measurements");
+			ret = -EINVAL;
+		}
+
+		hdr_v1 = bufp;
+		if ((hdr_v1->template_name_len > MAX_TEMPLATE_NAME_LEN) ||
+		    ((bufp + hdr_v1->template_name_len) > bufendp)) {
+			pr_err("attempting to restore a template name \
+				that is too long\n");
+			ret = -EINVAL;
+			break;
+		}
+		bufp += sizeof(*hdr_v1);
+
+		/* template name is not null terminated */
+		memcpy(template_name, bufp, hdr_v1->template_name_len);
+		template_name[hdr_v1->template_name_len] = 0;
+
+		if (strcmp(template_name, "ima") == 0) {
+			pr_err("attempting to restore an unsupported \
+				template \"%s\" failed\n", template_name);
+			ret = -EINVAL;
+			break;
+		}
+		data_v1 = bufp += (u_int8_t)hdr_v1->template_name_len;
+
+		/* get template format */
+		template_desc = lookup_template_desc(template_name);
+		if (!template_desc) {
+			pr_err("template \"%s\" not found\n", template_name);
+			ret = -EINVAL;
+			break;
+		}
+
+		if (bufp > (bufendp - sizeof(data_v1->template_data_size))) {
+			pr_err("restoring the template data size failed\n");
+			ret = -EINVAL;
+			break;
+		}
+		bufp += (u_int8_t) sizeof(data_v1->template_data_size);
+
+		if (bufp > (bufendp - data_v1->template_data_size)) {
+			pr_err("restoring the template data failed\n");
+			ret = -EINVAL;
+			break;
+		}
+
+		ret = ima_restore_template_data(template_desc,
+						data_v1->template_data,
+						data_v1->template_data_size,
+						&entry);
+		if (ret < 0)
+			break;
+
+		memcpy(entry->digest, hdr_v1->digest, TPM_DIGEST_SIZE);
+		entry->pcr = hdr_v1->pcr;
+		ret = ima_restore_measurement_entry(entry);
+		if (ret < 0)
+			break;
+
+		bufp += data_v1->template_data_size;
+	}
+	return ret;
+}
-- 
2.1.0
