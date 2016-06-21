Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYVsZ28C6zDqm0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 11:45:06 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5L1hX9a057285
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 21:45:03 -0400
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23n25w01rw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 21:45:03 -0400
Received: from localhost
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Mon, 20 Jun 2016 22:45:01 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id DA0301DC006E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 21:44:52 -0400 (EDT)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5L1j0pU13566242
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 22:45:00 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5L1ixmh030070
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 22:44:59 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: kexec@lists.infradead.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 Eric Biederman <ebiederm@xmission.com>, Dave Young <dyoung@redhat.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Eric Richter <erichte@linux.vnet.ibm.com>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [PATCH 6/6] IMA: Demonstration code for kexec buffer passing.
Date: Mon, 20 Jun 2016 22:44:36 -0300
In-Reply-To: <1466473476-10104-1-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1466473476-10104-1-git-send-email-bauerman@linux.vnet.ibm.com>
Message-Id: <1466473476-10104-7-git-send-email-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This shows how kernel code can use the kexec buffer passing mechanism
to pass information to the next kernel.

This patch is not intended to be committed.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 include/linux/ima.h                   | 11 +++++
 kernel/kexec_file.c                   |  4 ++
 security/integrity/ima/ima.h          |  5 +++
 security/integrity/ima/ima_init.c     | 26 ++++++++++++
 security/integrity/ima/ima_template.c | 79 +++++++++++++++++++++++++++++++++++
 5 files changed, 125 insertions(+)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 0eb7c2e7f0d6..96528d007139 100644
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
 
+#ifdef CONFIG_KEXEC_FILE
+extern void ima_add_kexec_buffer(struct kimage *image);
+#endif
+
 #else
 static inline int ima_bprm_check(struct linux_binprm *bprm)
 {
@@ -60,6 +65,12 @@ static inline void ima_post_path_mknod(struct dentry *dentry)
 	return;
 }
 
+#ifdef CONFIG_KEXEC_FILE
+static inline void ima_add_kexec_buffer(struct kimage *image)
+{
+}
+#endif
+
 #endif /* CONFIG_IMA */
 
 #ifdef CONFIG_IMA_APPRAISE
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 79d09a7784d8..143c70d2ef1c 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -20,6 +20,7 @@
 #include <linux/mutex.h>
 #include <linux/list.h>
 #include <linux/fs.h>
+#include <linux/ima.h>
 #include <crypto/hash.h>
 #include <crypto/sha.h>
 #include <linux/syscalls.h>
@@ -261,6 +262,9 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 		}
 	}
 
+	/* IMA needs to pass the measurement list to the next kernel. */
+	ima_add_kexec_buffer(image);
+
 	/* Call arch image load handlers */
 	ldata = arch_kexec_kernel_image_load(image);
 
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index d3a939bf2781..940f68f3ccc9 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -101,6 +101,11 @@ struct ima_queue_entry {
 };
 extern struct list_head ima_measurements;	/* list of all measurements */
 
+#ifdef CONFIG_KEXEC_FILE
+extern void *kexec_buffer;
+extern size_t kexec_buffer_size;
+#endif
+
 /* Internal IMA function definitions */
 int ima_init(void);
 int ima_fs_init(void);
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 5d679a685616..aaa2fc536ca4 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -21,6 +21,7 @@
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
 #include <linux/err.h>
+#include <linux/kexec.h>
 
 #include "ima.h"
 
@@ -103,6 +104,29 @@ void __init ima_load_x509(void)
 }
 #endif
 
+#ifdef CONFIG_KEXEC_FILE
+static void ima_load_kexec_buffer(void)
+{
+	int rc;
+
+	/* Fetch the buffer from the previous kernel, if any. */
+	rc = kexec_get_handover_buffer(&kexec_buffer, &kexec_buffer_size);
+	if (rc == 0) {
+		/* Demonstrate that buffer handover works. */
+		pr_err("kexec buffer contents: %s\n", (char *) kexec_buffer);
+		pr_err("kexec buffer contents after update: %s\n",
+		       (char *) kexec_buffer + 4 * PAGE_SIZE + 10);
+
+		kexec_free_handover_buffer();
+	} else if (rc == -ENOENT)
+		pr_debug("No kexec buffer from the previous kernel.\n");
+	else
+		pr_debug("Error restoring kexec buffer: %d\n", rc);
+}
+#else
+static void ima_load_kexec_buffer(void) { }
+#endif
+
 int __init ima_init(void)
 {
 	u8 pcr_i[TPM_DIGEST_SIZE];
@@ -133,5 +157,7 @@ int __init ima_init(void)
 
 	ima_init_policy();
 
+	ima_load_kexec_buffer();
+
 	return ima_fs_init();
 }
diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index febd12ed9b55..c5e81af8cb9c 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -15,6 +15,8 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/kexec.h>
+#include <linux/reboot.h>
 #include "ima.h"
 #include "ima_template_lib.h"
 
@@ -182,6 +184,83 @@ static int template_desc_init_fields(const char *template_fmt,
 	return 0;
 }
 
+#ifdef CONFIG_KEXEC_FILE
+void *kexec_buffer = NULL;
+size_t kexec_buffer_size = 0;
+
+/* Physical address of the measurement buffer in the next kernel. */
+unsigned long kexec_buffer_load_addr = 0;
+
+/*
+ * Called during reboot. IMA can add here new events that were generated after
+ * the kexec image was loaded.
+ */
+static int ima_update_kexec_buffer(struct notifier_block *self,
+				   unsigned long action, void *data)
+{
+	int ret;
+
+	if (!kexec_in_progress)
+		return NOTIFY_OK;
+
+	/*
+	 * Add content deep in the buffer to show that we can update
+	 * all of it.
+	 */
+	strcpy(kexec_buffer + 4 * PAGE_SIZE + 10,
+	       "Updated kexec buffer contents.");
+
+	ret = kexec_update_segment(kexec_buffer, kexec_buffer_size,
+				   kexec_buffer_load_addr, kexec_buffer_size);
+	if (ret)
+		pr_err("Error updating kexec buffer: %d\n", ret);
+
+	return NOTIFY_OK;
+}
+
+struct notifier_block update_buffer_nb = {
+	.notifier_call = ima_update_kexec_buffer,
+};
+
+/*
+ * Called during kexec_file_load so that IMA can add a segment to the kexec
+ * image with the measurement event log for the next kernel.
+ */
+void ima_add_kexec_buffer(struct kimage *image)
+{
+	int ret;
+
+	if (!kexec_can_hand_over_buffer())
+		return;
+
+	/* Create a relatively big buffer, for testing. */
+	kexec_buffer_size = 5 * PAGE_SIZE;
+	kexec_buffer = kzalloc(kexec_buffer_size, GFP_KERNEL);
+	if (!kexec_buffer) {
+		pr_err("Not enough memory for the kexec measurement buffer.\n");
+		return;
+	}
+
+	/* Add some content for demonstration purposes. */
+	strcpy(kexec_buffer, "Buffer contents at kexec load time.");
+
+	/* Ask not to checksum the segment, we may have to update it later. */
+	ret = kexec_add_handover_buffer(image, kexec_buffer, kexec_buffer_size,
+					kexec_buffer_size, PAGE_SIZE, 0,
+					ULONG_MAX, true, false,
+					&kexec_buffer_load_addr);
+	if (ret) {
+		pr_err("Error passing over kexec measurement buffer.\n");
+		return;
+	}
+
+	register_reboot_notifier(&update_buffer_nb);
+
+	pr_debug("kexec measurement buffer for the loaded kernel at 0x%lx.\n",
+		 kexec_buffer_load_addr);
+}
+#endif /* CONFIG_KEXEC_FILE */
+
 struct ima_template_desc *ima_template_desc_current(void)
 {
 	if (!ima_template)
-- 
1.9.1
