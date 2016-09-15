Return-Path: <zohar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sZbj16tHKzDsXq
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 21:26:45 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8FBNM7g002136
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 07:26:44 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25f1nrs31h-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 07:26:43 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zohar@linux.vnet.ibm.com>;
 Thu, 15 Sep 2016 21:26:41 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 2F17F3578057
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 21:26:39 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8FBQdSm1507654
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 21:26:39 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8FBQcgZ008255
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 21:26:39 +1000
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-security-module <linux-security-module@vger.kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 linux-ima-devel@lists.sourceforge.net, Dave Young <dyoung@redhat.com>,
 kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH v4 5/9] ima: on soft reboot, save the measurement list
Date: Thu, 15 Sep 2016 07:26:07 -0400
In-Reply-To: <1473938771-2782-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1473938771-2782-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-Id: <1473938771-2782-6-git-send-email-zohar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>

This patch uses the kexec buffer passing mechanism to pass the
serialized IMA binary_runtime_measurements to the next kernel.

Changelog v4:
- Revert the skip_checksum change.  Instead calculate the checksum
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
---
 include/linux/ima.h                | 12 +++++
 kernel/kexec_file.c                |  4 ++
 security/integrity/ima/ima_kexec.c | 96 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 112 insertions(+)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 0eb7c2e..7f6952f 100644
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
index 3acd386..ccdcbfd 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -20,6 +20,7 @@
 #include <linux/list.h>
 #include <linux/highmem.h>
 #include <linux/fs.h>
+#include <linux/ima.h>
 #include <crypto/hash.h>
 #include <crypto/sha.h>
 #include <linux/syscalls.h>
@@ -204,6 +205,9 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 		return ret;
 	image->kernel_buf_len = size;
 
+	/* IMA needs to pass the measurement list to the next kernel. */
+	ima_add_kexec_buffer(image);
+
 	/* Call arch image probe handlers */
 	ret = arch_kexec_kernel_image_probe(image, image->kernel_buf,
 					    image->kernel_buf_len);
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index e77ca9d..0abbc8d 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -23,6 +23,11 @@
 
 #include "ima.h"
 
+#ifdef CONFIG_IMA_KEXEC
+/* Physical address of the measurement buffer in the next kernel. */
+static unsigned long kexec_buffer_load_addr;
+static size_t kexec_segment_size;
+
 static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
 				     unsigned long segment_size)
 {
@@ -75,6 +80,97 @@ out:
 }
 
 /*
+ * Called during kexec execute so that IMA can save the measurement list.
+ */
+static int ima_update_kexec_buffer(struct notifier_block *self,
+				   unsigned long action, void *data)
+{
+	void *kexec_buffer = NULL;
+	size_t kexec_buffer_size;
+	int ret;
+
+	if (!kexec_in_progress)
+		return NOTIFY_OK;
+
+	kexec_buffer_size = ima_get_binary_runtime_size();
+	if (kexec_buffer_size > kexec_segment_size) {
+		pr_err("Binary measurement list grew too large.\n");
+		goto out;
+	}
+
+	ima_dump_measurement_list(&kexec_buffer_size, &kexec_buffer,
+				  kexec_segment_size);
+	if (!kexec_buffer) {
+		pr_err("Not enough memory for the kexec measurement buffer.\n");
+		goto out;
+	}
+	ret = kexec_update_segment(kexec_buffer, kexec_buffer_size,
+				   kexec_buffer_load_addr, kexec_segment_size);
+	if (ret)
+		pr_err("Error updating kexec buffer: %d\n", ret);
+out:
+	return NOTIFY_OK;
+}
+
+struct notifier_block update_buffer_nb = {
+	.notifier_call = ima_update_kexec_buffer,
+};
+
+/*
+ * Called during kexec_file_load so that IMA can add a segment to the kexec
+ * image for the measurement list for the next kernel.
+ */
+void ima_add_kexec_buffer(struct kimage *image)
+{
+	static int registered;
+	struct kexec_buf kbuf = { .image = image, .buf_align = PAGE_SIZE,
+				  .buf_min = 0, .buf_max = ULONG_MAX,
+				  .top_down = true };
+	unsigned long binary_runtime_size;
+	int ret;
+
+	if (!kexec_can_hand_over_buffer())
+		return;
+
+	/*
+	 * Reserve at least an extra half page of memory for additional
+	 * measurements between kexec load and execute.
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
+	/* Ask not to checksum the segment, we will update it later. */
+	kbuf.buffer = NULL;
+	kbuf.bufsz = 0;
+	kbuf.memsz = kexec_segment_size;
+	ret = kexec_add_handover_buffer(&kbuf);
+	if (ret) {
+		pr_err("Error passing over kexec measurement buffer.\n");
+		return;
+	}
+	kexec_buffer_load_addr = kbuf.mem;
+
+	pr_debug("kexec measurement buffer for the loaded kernel at 0x%lx.\n",
+		 kexec_buffer_load_addr);
+
+	if (registered)
+		return;
+
+	register_reboot_notifier(&update_buffer_nb);
+	registered = 1;
+}
+#endif /* IMA_KEXEC */
+
+/*
  * Restore the measurement list from the previous kernel.
  */
 void ima_load_kexec_buffer(void)
-- 
2.1.0
