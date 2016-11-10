Return-Path: <zohar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tF5jq0r33zDvkf
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2016 01:57:02 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAAEs595022267
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2016 09:57:01 -0500
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26msct81h9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2016 09:57:00 -0500
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zohar@linux.vnet.ibm.com>;
 Fri, 11 Nov 2016 00:56:57 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 2F8F42BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2016 01:56:54 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAAEushT31457392
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2016 01:56:54 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAAEurfR025839
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2016 01:56:53 +1100
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-security-module <linux-security-module@vger.kernel.org>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
 linux-ima-devel@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Subject: [PATCHC v7 06/10] ima: on soft reboot, save the measurement list
Date: Thu, 10 Nov 2016 09:56:16 -0500
In-Reply-To: <1478789780-17719-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1478789780-17719-1-git-send-email-zohar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1478789780-17719-7-git-send-email-zohar@linux.vnet.ibm.com>
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
of the running kernel must be saved and restored on boot.

This patch uses the kexec buffer passing mechanism to pass the
serialized IMA binary_runtime_measurements to the next kernel.

Changelog v5:
- move writing the IMA measurement list to kexec load and remove
  from kexec execute.
- remove registering notifier to call update on kexec execute
- add includes needed by code in this patch to ima_kexec.c (Thiago)
- fold patch "ima: serialize the binary_runtime_measurements"
into this patch.

Changelog v4:
- Revert the skip_checksum change.  Instead calculate the checksum
with the measurement list segment, on update validate the existing
checksum before re-calulating a new checksum with the updated
measurement list.

Changelog v3:
- Request a kexec segment for storing the measurement list a half page,
not a full page, more than needed for additional measurements.
- Added binary_runtime_size overflow test
- Limit maximum number of pages needed for kexec_segment_size to half
of totalram_pages. (Dave Young)

Changelog v2:
- Fix build issue by defining a stub ima_add_kexec_buffer and stub
  struct kimage when CONFIG_IMA=n and CONFIG_IMA_KEXEC=n. (Fenguang Wu)
- removed kexec_add_handover_buffer() checksum argument.
- added skip_checksum member to kexec_buf
- only register reboot notifier once

Changelog v1:
- updated to call IMA functions  (Mimi)
- move code from ima_template.c to ima_kexec.c (Mimi)

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/ima.h                |  12 ++++
 kernel/kexec_file.c                |   4 ++
 security/integrity/ima/ima.h       |   1 +
 security/integrity/ima/ima_fs.c    |   2 +-
 security/integrity/ima/ima_kexec.c | 117 +++++++++++++++++++++++++++++++++++++
 5 files changed, 135 insertions(+), 1 deletion(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 0eb7c2e7f0d6..7f6952f8d6aa 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -11,6 +11,7 @@
 #define _LINUX_IMA_H
 
 #include <linux/fs.h>
+#include <linux/kexec.h>
 struct linux_binprm;
 
 #ifdef CONFIG_IMA
@@ -23,6 +24,10 @@ extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
 			      enum kernel_read_file_id id);
 extern void ima_post_path_mknod(struct dentry *dentry);
 
+#ifdef CONFIG_IMA_KEXEC
+extern void ima_add_kexec_buffer(struct kimage *image);
+#endif
+
 #else
 static inline int ima_bprm_check(struct linux_binprm *bprm)
 {
@@ -62,6 +67,13 @@ static inline void ima_post_path_mknod(struct dentry *dentry)
 
 #endif /* CONFIG_IMA */
 
+#ifndef CONFIG_IMA_KEXEC
+struct kimage;
+
+static inline void ima_add_kexec_buffer(struct kimage *image)
+{}
+#endif
+
 #ifdef CONFIG_IMA_APPRAISE
 extern void ima_inode_post_setattr(struct dentry *dentry);
 extern int ima_inode_setxattr(struct dentry *dentry, const char *xattr_name,
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 0c2df7f73792..b56a558e406d 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -19,6 +19,7 @@
 #include <linux/mutex.h>
 #include <linux/list.h>
 #include <linux/fs.h>
+#include <linux/ima.h>
 #include <crypto/hash.h>
 #include <crypto/sha.h>
 #include <linux/syscalls.h>
@@ -132,6 +133,9 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 		return ret;
 	image->kernel_buf_len = size;
 
+	/* IMA needs to pass the measurement list to the next kernel. */
+	ima_add_kexec_buffer(image);
+
 	/* Call arch image probe handlers */
 	ret = arch_kexec_kernel_image_probe(image, image->kernel_buf,
 					    image->kernel_buf_len);
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index ea1dcc452911..139dec67dcbf 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -143,6 +143,7 @@ void ima_print_digest(struct seq_file *m, u8 *digest, u32 size);
 struct ima_template_desc *ima_template_desc_current(void);
 int ima_restore_measurement_entry(struct ima_template_entry *entry);
 int ima_restore_measurement_list(loff_t bufsize, void *buf);
+int ima_measurements_show(struct seq_file *m, void *v);
 unsigned long ima_get_binary_runtime_size(void);
 int ima_init_template(void);
 
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 3df46906492d..10bea0125fa1 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -116,7 +116,7 @@ void ima_putc(struct seq_file *m, void *data, int datalen)
  *       [eventdata length]
  *       eventdata[n]=template specific data
  */
-static int ima_measurements_show(struct seq_file *m, void *v)
+int ima_measurements_show(struct seq_file *m, void *v)
 {
 	/* the list never shrinks, so we don't need a lock here */
 	struct ima_queue_entry *qe = v;
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 36afd0fe9747..2c4824ac1ce1 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -10,8 +10,125 @@
  * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
  */
+#include <linux/seq_file.h>
+#include <linux/vmalloc.h>
+#include <linux/kexec.h>
 #include "ima.h"
 
+#ifdef CONFIG_IMA_KEXEC
+static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
+				     unsigned long segment_size)
+{
+	struct ima_queue_entry *qe;
+	struct seq_file file;
+	struct ima_kexec_hdr khdr = {
+		.version = 1, .buffer_size = 0, .count = 0};
+	int ret = 0;
+
+	/* segment size can't change between kexec load and execute */
+	file.buf = vmalloc(segment_size);
+	if (!file.buf) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	file.size = segment_size;
+	file.read_pos = 0;
+	file.count = sizeof(khdr);	/* reserved space */
+
+	list_for_each_entry_rcu(qe, &ima_measurements, later) {
+		if (file.count < file.size) {
+			khdr.count++;
+			ima_measurements_show(&file, qe);
+		} else {
+			ret = -EINVAL;
+			break;
+		}
+	}
+
+	if (ret < 0)
+		goto out;
+
+	/*
+	 * fill in reserved space with some buffer details
+	 * (eg. version, buffer size, number of measurements)
+	 */
+	khdr.buffer_size = file.count;
+	memcpy(file.buf, &khdr, sizeof(khdr));
+	print_hex_dump(KERN_DEBUG, "ima dump: ", DUMP_PREFIX_NONE,
+			16, 1, file.buf,
+			file.count < 100 ? file.count : 100, true);
+
+	*buffer_size = file.count;
+	*buffer = file.buf;
+out:
+	if (ret == -EINVAL)
+		vfree(file.buf);
+	return ret;
+}
+
+/*
+ * Called during kexec_file_load so that IMA can add a segment to the kexec
+ * image for the measurement list for the next kernel.
+ *
+ * This function assumes that kexec_mutex is held.
+ */
+void ima_add_kexec_buffer(struct kimage *image)
+{
+	struct kexec_buf kbuf = { .image = image, .buf_align = PAGE_SIZE,
+				  .buf_min = 0, .buf_max = ULONG_MAX,
+				  .top_down = true };
+	unsigned long binary_runtime_size;
+
+	/* use more understandable variable names than defined in kbuf */
+	void *kexec_buffer = NULL;
+	size_t kexec_buffer_size;
+	size_t kexec_segment_size;
+	int ret;
+
+	/*
+	 * Reserve an extra half page of memory for additional measurements
+	 * added during the kexec load.
+	 */
+	binary_runtime_size = ima_get_binary_runtime_size();
+	if (binary_runtime_size >= ULONG_MAX - PAGE_SIZE)
+		kexec_segment_size = ULONG_MAX;
+	else
+		kexec_segment_size = ALIGN(ima_get_binary_runtime_size() +
+					   PAGE_SIZE / 2, PAGE_SIZE);
+	if ((kexec_segment_size == ULONG_MAX) ||
+	    ((kexec_segment_size >> PAGE_SHIFT) > totalram_pages / 2)) {
+		pr_err("Binary measurement list too large.\n");
+		return;
+	}
+
+	ima_dump_measurement_list(&kexec_buffer_size, &kexec_buffer,
+				  kexec_segment_size);
+	if (!kexec_buffer) {
+		pr_err("Not enough memory for the kexec measurement buffer.\n");
+		return;
+	}
+
+	kbuf.buffer = kexec_buffer;
+	kbuf.bufsz = kexec_buffer_size;
+	kbuf.memsz = kexec_segment_size;
+	ret = kexec_add_buffer(&kbuf);
+	if (ret) {
+		pr_err("Error passing over kexec measurement buffer.\n");
+		return;
+	}
+
+	ret = arch_ima_add_kexec_buffer(image, kbuf.mem, kexec_segment_size);
+	if (ret) {
+		pr_err("Error passing over kexec measurement buffer.\n");
+		return;
+	}
+
+	pr_debug("kexec measurement buffer for the loaded kernel at 0x%lx.\n",
+		 kbuf.mem);
+}
+#endif /* IMA_KEXEC */
+
 /*
  * Restore the measurement list from the previous kernel.
  */
-- 
2.1.0
