Return-Path: <zohar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tTfHb5ngszDw09
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Dec 2016 12:06:19 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uB1142Vc043778
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 20:06:17 -0500
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [125.16.236.4])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2729b3hffy-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 20:06:16 -0500
Received: from localhost
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zohar@linux.vnet.ibm.com>;
 Thu, 1 Dec 2016 06:36:13 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 32026125805C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Dec 2016 06:37:15 +0530 (IST)
Received: from d28av06.in.ibm.com (d28av06.in.ibm.com [9.184.220.48])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uB116Akg29425916
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Dec 2016 06:36:10 +0530
Received: from d28av06.in.ibm.com (localhost [127.0.0.1])
 by d28av06.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uB116AoV013959
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Dec 2016 06:36:10 +0530
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-security-module <linux-security-module@vger.kernel.org>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 linux-ima-devel@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Subject: [PATCH v8 02/10] ima: on soft reboot, restore the measurement list
Date: Wed, 30 Nov 2016 20:05:38 -0500
In-Reply-To: <1480554346-29071-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1480554346-29071-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-Id: <1480554346-29071-3-git-send-email-zohar@linux.vnet.ibm.com>
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

Changelog v8:
- clearer to use the length of the entire binary_field_data struct (Dmitry)

Changelog v7:
- add and fix missing buffer length checking (reported by D. Kasatkin)
- clean up ima_restore_measurement_list() a bit

Changelog v5:
- replace CONFIG_KEXEC_FILE with architecture CONFIG_HAVE_IMA_KEXEC (Thiago)
- replace kexec_get_handover_buffer() with ima_get_kexec_buffer() (Thiago)
- replace kexec_free_handover_buffer() with ima_free_kexec_buffer() (Thiago)
- remove unnecessary includes from ima_kexec.c (Thiago)
- fix off-by-one error when checking hdr_v1->template_name_len (Colin King)

Changelog v2:
- redefined ima_kexec_hdr to use types with well defined sizes (M. Ellerman)
- defined missing ima_load_kexec_buffer() stub function

Changelog v1:
- call ima_load_kexec_buffer() (Thiago)

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Acked-by: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
---
 security/integrity/ima/Makefile       |   1 +
 security/integrity/ima/ima.h          |  21 ++++
 security/integrity/ima/ima_init.c     |   2 +
 security/integrity/ima/ima_kexec.c    |  44 +++++++++
 security/integrity/ima/ima_queue.c    |  10 ++
 security/integrity/ima/ima_template.c | 177 ++++++++++++++++++++++++++++++++++
 6 files changed, 255 insertions(+)
 create mode 100644 security/integrity/ima/ima_kexec.c

diff --git a/security/integrity/ima/Makefile b/security/integrity/ima/Makefile
index 9aeaedad1e2b..29f198bde02b 100644
--- a/security/integrity/ima/Makefile
+++ b/security/integrity/ima/Makefile
@@ -8,4 +8,5 @@ obj-$(CONFIG_IMA) += ima.o
 ima-y := ima_fs.o ima_queue.o ima_init.o ima_main.o ima_crypto.o ima_api.o \
 	 ima_policy.o ima_template.o ima_template_lib.o
 ima-$(CONFIG_IMA_APPRAISE) += ima_appraise.o
+ima-$(CONFIG_HAVE_IMA_KEXEC) += ima_kexec.o
 obj-$(CONFIG_IMA_BLACKLIST_KEYRING) += ima_mok.o
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index db25f54a04fe..51dc8d57d64d 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -28,6 +28,10 @@
 
 #include "../integrity.h"
 
+#ifdef CONFIG_HAVE_IMA_KEXEC
+#include <asm/ima.h>
+#endif
+
 enum ima_show_type { IMA_SHOW_BINARY, IMA_SHOW_BINARY_NO_FIELD_LEN,
 		     IMA_SHOW_BINARY_OLD_STRING_FMT, IMA_SHOW_ASCII };
 enum tpm_pcrs { TPM_PCR0 = 0, TPM_PCR8 = 8 };
@@ -102,6 +106,21 @@ struct ima_queue_entry {
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
+#ifdef CONFIG_HAVE_IMA_KEXEC
+void ima_load_kexec_buffer(void);
+#else
+static inline void ima_load_kexec_buffer(void) {}
+#endif /* CONFIG_HAVE_IMA_KEXEC */
+
 /* Internal IMA function definitions */
 int ima_init(void);
 int ima_fs_init(void);
@@ -122,6 +141,8 @@ int ima_init_crypto(void);
 void ima_putc(struct seq_file *m, void *data, int datalen);
 void ima_print_digest(struct seq_file *m, u8 *digest, u32 size);
 struct ima_template_desc *ima_template_desc_current(void);
+int ima_restore_measurement_entry(struct ima_template_entry *entry);
+int ima_restore_measurement_list(loff_t bufsize, void *buf);
 int ima_init_template(void);
 
 /*
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 2ac1f41db5c0..2967d497a665 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -129,6 +129,8 @@ int __init ima_init(void)
 	if (rc != 0)
 		return rc;
 
+	ima_load_kexec_buffer();
+
 	rc = ima_add_boot_aggregate();	/* boot aggregate must be first entry */
 	if (rc != 0)
 		return rc;
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
new file mode 100644
index 000000000000..36afd0fe9747
--- /dev/null
+++ b/security/integrity/ima/ima_kexec.c
@@ -0,0 +1,44 @@
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
+	rc = ima_get_kexec_buffer(&kexec_buffer, &kexec_buffer_size);
+	switch (rc) {
+	case 0:
+		rc = ima_restore_measurement_list(kexec_buffer_size,
+						  kexec_buffer);
+		if (rc != 0)
+			pr_err("Failed to restore the measurement list: %d\n",
+				rc);
+
+		ima_free_kexec_buffer();
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
index 32f6ac0f96df..4b1bb7787839 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -149,3 +149,13 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
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
index febd12ed9b55..03803de4226e 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -37,6 +37,7 @@ static struct ima_template_field supported_fields[] = {
 	{.field_id = "sig", .field_init = ima_eventsig_init,
 	 .field_show = ima_show_template_sig},
 };
+#define MAX_TEMPLATE_NAME_LEN 15
 
 static struct ima_template_desc *ima_template;
 static struct ima_template_desc *lookup_template_desc(const char *name);
@@ -205,3 +206,179 @@ int __init ima_init_template(void)
 
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
+		if (offset > (template_data_size - sizeof(*field_data))) {
+			pr_err("Restoring the template field failed\n");
+			ret = -EINVAL;
+			break;
+		}
+		offset += sizeof(*field_data);
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
+		return -EINVAL;
+	}
+
+	if (khdr->count > ULONG_MAX - 1) {
+		pr_err("attempting to restore too many measurements");
+		return -EINVAL;
+	}
+
+	/*
+	 * ima kexec buffer prefix: version, buffer size, count
+	 * v1 format: pcr, digest, template-name-len, template-name,
+	 *	      template-data-size, template-data
+	 */
+	while ((bufp < bufendp) && (count++ < khdr->count)) {
+		hdr_v1 = bufp;
+		if (bufp > (bufendp - sizeof(*hdr_v1))) {
+			pr_err("attempting to restore partial measurement\n");
+			ret = -EINVAL;
+			break;
+		}
+		bufp += sizeof(*hdr_v1);
+
+		if ((hdr_v1->template_name_len >= MAX_TEMPLATE_NAME_LEN) ||
+		    (bufp > (bufendp - hdr_v1->template_name_len))) {
+			pr_err("attempting to restore a template name \
+				that is too long\n");
+			ret = -EINVAL;
+			break;
+		}
+		data_v1 = bufp += (u_int8_t)hdr_v1->template_name_len;
+
+		/* template name is not null terminated */
+		memcpy(template_name, hdr_v1->template_name,
+		       hdr_v1->template_name_len);
+		template_name[hdr_v1->template_name_len] = 0;
+
+		if (strcmp(template_name, "ima") == 0) {
+			pr_err("attempting to restore an unsupported \
+				template \"%s\" failed\n", template_name);
+			ret = -EINVAL;
+			break;
+		}
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
+		bufp += data_v1->template_data_size;
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
+	}
+	return ret;
+}
-- 
2.1.0
