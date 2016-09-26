Return-Path: <zohar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sjWGt6fbrzDrSX
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Sep 2016 03:31:34 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8QHSksN127849
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 13:31:32 -0400
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25q674dn1d-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 13:31:32 -0400
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zohar@linux.vnet.ibm.com>;
 Mon, 26 Sep 2016 23:01:28 +0530
Received: from d28relay10.in.ibm.com (d28relay10.in.ibm.com [9.184.220.161])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id F1B97E0024
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 23:00:52 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay10.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8QHVGSI17498206
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 23:01:16 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8QHVPuV009696
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 23:01:26 +0530
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-security-module <linux-security-module@vger.kernel.org>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 linux-ima-devel@lists.sourceforge.net, Dave Young <dyoung@redhat.com>,
 kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 09/10] ima: define a canonical binary_runtime_measurements
 list format
Date: Mon, 26 Sep 2016 13:30:28 -0400
In-Reply-To: <1474911029-6372-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1474911029-6372-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-Id: <1474911029-6372-10-git-send-email-zohar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The IMA binary_runtime_measurements list is currently in platform native
format.

To allow restoring a measurement list carried across kexec with a
different endianness than the targeted kernel, this patch defines
little-endian as the canonical format.  For big endian systems wanting
to save/restore the measurement list from a system with a different
endianness, a new boot command line parameter named "ima_canonical_fmt"
is defined.

Considerations: use of the "ima_canonical_fmt" boot command line
option will break existing userspace applications on big endian systems
expecting the binary_runtime_measurements list to be in platform native
format.

Changelog v3:
- restore PCR value properly

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 Documentation/kernel-parameters.txt       |  4 ++++
 security/integrity/ima/ima.h              |  6 ++++++
 security/integrity/ima/ima_fs.c           | 28 +++++++++++++++++++++-------
 security/integrity/ima/ima_kexec.c        | 11 +++++++++--
 security/integrity/ima/ima_template.c     | 24 ++++++++++++++++++++++--
 security/integrity/ima/ima_template_lib.c |  7 +++++--
 6 files changed, 67 insertions(+), 13 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index a4f4d69..8be3ac8 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1580,6 +1580,10 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			The builtin appraise policy appraises all files
 			owned by uid=0.
 
+	ima_canonical_fmt [IMA]
+			Use the canonical format for the binary runtime
+			measurements, instead of host native format.
+
 	ima_hash=	[IMA]
 			Format: { md5 | sha1 | rmd160 | sha256 | sha384
 				   | sha512 | ... }
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 6b0540a..5e6180a 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -122,6 +122,12 @@ void ima_load_kexec_buffer(void);
 static inline void ima_load_kexec_buffer(void) {}
 #endif /* CONFIG_HAVE_IMA_KEXEC */
 
+/*
+ * The default binary_runtime_measurements list format is defined as the
+ * platform native format.  The canonical format is defined as little-endian.
+ */
+extern bool ima_canonical_fmt;
+
 /* Internal IMA function definitions */
 int ima_init(void);
 int ima_fs_init(void);
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 66e5dd5..2bcad99 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -28,6 +28,16 @@
 
 static DEFINE_MUTEX(ima_write_mutex);
 
+bool ima_canonical_fmt;
+static int __init default_canonical_fmt_setup(char *str)
+{
+#ifdef __BIG_ENDIAN
+	ima_canonical_fmt = 1;
+#endif
+	return 1;
+}
+__setup("ima_canonical_fmt", default_canonical_fmt_setup);
+
 static int valid_policy = 1;
 #define TMPBUFLEN 12
 static ssize_t ima_show_htable_value(char __user *buf, size_t count,
@@ -122,7 +132,7 @@ int ima_measurements_show(struct seq_file *m, void *v)
 	struct ima_queue_entry *qe = v;
 	struct ima_template_entry *e;
 	char *template_name;
-	int namelen;
+	u32 pcr, namelen, template_data_len; /* temporary fields */
 	bool is_ima_template = false;
 	int i;
 
@@ -139,25 +149,29 @@ int ima_measurements_show(struct seq_file *m, void *v)
 	 * PCR used defaults to the same (config option) in
 	 * little-endian format, unless set in policy
 	 */
-	ima_putc(m, &e->pcr, sizeof(e->pcr));
+	pcr = !ima_canonical_fmt ? e->pcr : cpu_to_le32(e->pcr);
+	ima_putc(m, &pcr, sizeof(e->pcr));
 
 	/* 2nd: template digest */
 	ima_putc(m, e->digest, TPM_DIGEST_SIZE);
 
 	/* 3rd: template name size */
-	namelen = strlen(template_name);
+	namelen = !ima_canonical_fmt ? strlen(template_name) :
+		cpu_to_le32(strlen(template_name));
 	ima_putc(m, &namelen, sizeof(namelen));
 
 	/* 4th:  template name */
-	ima_putc(m, template_name, namelen);
+	ima_putc(m, template_name, strlen(template_name));
 
 	/* 5th:  template length (except for 'ima' template) */
 	if (strcmp(template_name, IMA_TEMPLATE_IMA_NAME) == 0)
 		is_ima_template = true;
 
-	if (!is_ima_template)
-		ima_putc(m, &e->template_data_len,
-			 sizeof(e->template_data_len));
+	if (!is_ima_template) {
+		template_data_len = !ima_canonical_fmt ? e->template_data_len :
+			cpu_to_le32(e->template_data_len);
+		ima_putc(m, &template_data_len, sizeof(e->template_data_len));
+	}
 
 	/* 6th:  template specific data */
 	for (i = 0; i < e->template_desc->num_fields; i++) {
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 2c4824a..e473eee 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -21,8 +21,7 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
 {
 	struct ima_queue_entry *qe;
 	struct seq_file file;
-	struct ima_kexec_hdr khdr = {
-		.version = 1, .buffer_size = 0, .count = 0};
+	struct ima_kexec_hdr khdr;
 	int ret = 0;
 
 	/* segment size can't change between kexec load and execute */
@@ -36,6 +35,8 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
 	file.read_pos = 0;
 	file.count = sizeof(khdr);	/* reserved space */
 
+	memset(&khdr, 0, sizeof(khdr));
+	khdr.version = 1;
 	list_for_each_entry_rcu(qe, &ima_measurements, later) {
 		if (file.count < file.size) {
 			khdr.count++;
@@ -54,7 +55,13 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
 	 * (eg. version, buffer size, number of measurements)
 	 */
 	khdr.buffer_size = file.count;
+	if (ima_canonical_fmt) {
+		khdr.version = cpu_to_le16(khdr.version);
+		khdr.count = cpu_to_le64(khdr.count);
+		khdr.buffer_size = cpu_to_le64(khdr.buffer_size);
+	}
 	memcpy(file.buf, &khdr, sizeof(khdr));
+
 	print_hex_dump(KERN_DEBUG, "ima dump: ", DUMP_PREFIX_NONE,
 			16, 1, file.buf,
 			file.count < 100 ? file.count : 100, true);
diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index e57b468..004723c 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -304,6 +304,9 @@ static int ima_restore_template_data(struct ima_template_desc *template_desc,
 		}
 		offset += sizeof(field_data->len);
 
+		if (ima_canonical_fmt)
+			field_data->len = le32_to_cpu(field_data->len);
+
 		if (offset > (template_data_size - field_data->len)) {
 			pr_err("Restoring the template field data failed\n");
 			ret = -EINVAL;
@@ -354,7 +357,7 @@ int ima_restore_measurement_list(loff_t size, void *buf)
 	struct binary_data_v1 *data_v1;
 
 	void *bufp = buf + sizeof(*khdr);
-	void *bufendp = buf + khdr->buffer_size;
+	void *bufendp;
 	struct ima_template_entry *entry;
 	struct ima_template_desc *template_desc;
 	unsigned long count = 0;
@@ -363,6 +366,12 @@ int ima_restore_measurement_list(loff_t size, void *buf)
 	if (!buf || size < sizeof(*khdr))
 		return 0;
 
+	if (ima_canonical_fmt) {
+		khdr->version = le16_to_cpu(khdr->version);
+		khdr->count = le64_to_cpu(khdr->count);
+		khdr->buffer_size = le64_to_cpu(khdr->buffer_size);
+	}
+
 	if (khdr->version != 1) {
 		pr_err("attempting to restore a incompatible measurement list");
 		return 0;
@@ -373,6 +382,7 @@ int ima_restore_measurement_list(loff_t size, void *buf)
 	 * v1 format: pcr, digest, template-name-len, template-name,
 	 *	      template-data-size, template-data
 	 */
+	bufendp = buf + khdr->buffer_size;
 	while ((bufp < bufendp) && (count++ < khdr->count)) {
 		if (count > ULONG_MAX - 1) {
 			pr_err("attempting to restore too many measurements");
@@ -380,6 +390,11 @@ int ima_restore_measurement_list(loff_t size, void *buf)
 		}
 
 		hdr_v1 = bufp;
+
+		if (ima_canonical_fmt)
+			hdr_v1->template_name_len =
+			    le32_to_cpu(hdr_v1->template_name_len);
+
 		if ((hdr_v1->template_name_len >= MAX_TEMPLATE_NAME_LEN) ||
 		    ((bufp + hdr_v1->template_name_len) > bufendp)) {
 			pr_err("attempting to restore a template name \
@@ -429,6 +444,10 @@ int ima_restore_measurement_list(loff_t size, void *buf)
 		}
 		bufp += (u_int8_t) sizeof(data_v1->template_data_size);
 
+		if (ima_canonical_fmt)
+			data_v1->template_data_size =
+			    le32_to_cpu(data_v1->template_data_size);
+
 		if (bufp > (bufendp - data_v1->template_data_size)) {
 			pr_err("restoring the template data failed\n");
 			ret = -EINVAL;
@@ -443,7 +462,8 @@ int ima_restore_measurement_list(loff_t size, void *buf)
 			break;
 
 		memcpy(entry->digest, hdr_v1->digest, TPM_DIGEST_SIZE);
-		entry->pcr = hdr_v1->pcr;
+		entry->pcr =
+		    !ima_canonical_fmt ? hdr_v1->pcr : le32_to_cpu(hdr_v1->pcr);
 		ret = ima_restore_measurement_entry(entry);
 		if (ret < 0)
 			break;
diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index f9bae04..f9ba37b 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -103,8 +103,11 @@ static void ima_show_template_data_binary(struct seq_file *m,
 	u32 len = (show == IMA_SHOW_BINARY_OLD_STRING_FMT) ?
 	    strlen(field_data->data) : field_data->len;
 
-	if (show != IMA_SHOW_BINARY_NO_FIELD_LEN)
-		ima_putc(m, &len, sizeof(len));
+	if (show != IMA_SHOW_BINARY_NO_FIELD_LEN) {
+		u32 field_len = !ima_canonical_fmt ? len : cpu_to_le32(len);
+
+		ima_putc(m, &field_len, sizeof(field_len));
+	}
 
 	if (!len)
 		return;
-- 
2.1.0
