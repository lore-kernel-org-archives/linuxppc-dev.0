Return-Path: <zohar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s4pzs5YFRzDqV1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Aug 2016 22:25:13 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u74COGbW073315
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Aug 2016 08:25:11 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24kkak1gyb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Aug 2016 08:25:11 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zohar@linux.vnet.ibm.com>;
 Thu, 4 Aug 2016 22:25:07 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id A40EA2CE8056
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Aug 2016 22:25:04 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u74CP4aW32178212
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Aug 2016 22:25:04 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u74CP40m019661
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Aug 2016 22:25:04 +1000
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 linux-ima-devel@lists.sourceforge.net, Dave Young <dyoung@redhat.com>,
 kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH 5/7] ima: on soft reboot, save the measurement list
Date: Thu,  4 Aug 2016 08:24:33 -0400
In-Reply-To: <1470313475-20090-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1470313475-20090-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-Id: <1470313475-20090-6-git-send-email-zohar@linux.vnet.ibm.com>
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

Changelog:
- updated to call IMA functions  (Mimi)
- move code from ima_template.c to ima_kexec.c (Mimi)

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 include/linux/ima.h                | 15 +++++++
 kernel/kexec_file.c                |  3 ++
 security/integrity/ima/ima_kexec.c | 83 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 101 insertions(+)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index b553367..ba484ed 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -11,6 +11,7 @@
 #define _LINUX_IMA_H
 
 #include <linux/fs.h>
+#include <linux/kexec.h>
 struct linux_binprm;
 
 enum ima_buffer_id {
@@ -35,6 +36,14 @@ extern int ima_add_measurement_check(const char *hashname, u8 *digest,
 				     loff_t size, enum ima_buffer_id buffer_id,
 				     char *hint);
 
+#ifdef CONFIG_IMA_KEXEC
+extern void ima_add_kexec_buffer(struct kimage *image);
+#else
+static inline void ima_add_kexec_buffer(struct kimage *image)
+{
+}
+#endif
+
 #else
 static inline int ima_bprm_check(struct linux_binprm *bprm)
 {
@@ -85,6 +94,12 @@ static inline int ima_add_measurement_check(const char *hashname, u8 *digest,
 {
 	return 0;
 }
+
+#ifdef CONFIG_IMA_KEXEC
+static inline void ima_add_kexec_buffer(struct kimage *image)
+{
+}
+#endif
 #endif /* CONFIG_IMA */
 
 #ifdef CONFIG_IMA_APPRAISE
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 852adb2..622c126 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -202,6 +202,9 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 		return ret;
 	image->kernel_buf_len = size;
 
+	/* IMA needs to pass the measurement list to the next kernel. */
+	ima_add_kexec_buffer(image);
+
 	/* Call arch image probe handlers */
 	ret = arch_kexec_kernel_image_probe(image, image->kernel_buf,
 					    image->kernel_buf_len);
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index e77ca9d..3fed417 100644
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
@@ -75,6 +80,84 @@ out:
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
+	if (kexec_buffer_size >
+	    (kexec_segment_size - sizeof(struct ima_kexec_hdr))) {
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
+	struct kexec_buf kbuf = { .image = image, .buf_align = PAGE_SIZE,
+				  .buf_min = 0, .buf_max = ULONG_MAX,
+				  .top_down = true };
+	int ret;
+
+	if (!kexec_can_hand_over_buffer())
+		return;
+
+	kexec_segment_size = ALIGN(ima_get_binary_runtime_size() + PAGE_SIZE,
+				   PAGE_SIZE);
+
+	if (kexec_segment_size >= (ULONG_MAX - sizeof(long))) {
+		pr_err("Binary measurement list too large.\n");
+		return;
+	}
+
+	/* Ask not to checksum the segment, we will update it later. */
+	kbuf.buffer = NULL;
+	kbuf.bufsz = 0;
+	kbuf.memsz = kexec_segment_size;
+	ret = kexec_add_handover_buffer(&kbuf, false);
+	if (ret) {
+		pr_err("Error passing over kexec measurement buffer.\n");
+		return;
+	}
+	kexec_buffer_load_addr = kbuf.mem;
+
+	register_reboot_notifier(&update_buffer_nb);
+
+	pr_debug("kexec measurement buffer for the loaded kernel at 0x%lx.\n",
+		 kexec_buffer_load_addr);
+}
+#endif /* IMA_KEXEC */
+
+/*
  * Restore the measurement list from the previous kernel.
  */
 void ima_load_kexec_buffer(void)
-- 
2.1.0
