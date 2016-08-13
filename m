Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sB6S73tkdzDr3T
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Aug 2016 13:19:35 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7D3IpHg097560
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 23:19:33 -0400
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24r5ujnr6m-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 23:19:33 -0400
Received: from localhost
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Sat, 13 Aug 2016 00:19:31 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 38CBC3520070
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 23:19:08 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7D3JSRd4481208
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Aug 2016 00:19:28 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7D3JRnK014411
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Aug 2016 00:19:28 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: kexec@lists.infradead.org
Cc: linux-security-module@vger.kernel.org,
 linux-ima-devel@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, x86@kernel.org,
 Eric Biederman <ebiederm@xmission.com>, Dave Young <dyoung@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>, Baoquan He <bhe@redhat.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Samuel Mendoza-Jonas <sam@mendozajonas.com>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Eric Richter <erichte@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Petko Manolov <petkan@mip-labs.com>,
 David Laight <David.Laight@ACULAB.COM>,
 Balbir Singh <bsingharora@gmail.com>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [PATCH v2 6/6] IMA: Demonstration code for kexec buffer passing.
Date: Sat, 13 Aug 2016 00:18:25 -0300
In-Reply-To: <1471058305-30198-1-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1471058305-30198-1-git-send-email-bauerman@linux.vnet.ibm.com>
Message-Id: <1471058305-30198-7-git-send-email-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch is not intended to be committed.

It shows how kernel code can use the kexec buffer passing mechanism
to pass information to the next kernel.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 include/linux/ima.h                   | 11 +++++
 kernel/kexec_file.c                   |  4 ++
 security/integrity/ima/ima.h          |  5 +++
 security/integrity/ima/ima_init.c     | 26 +++++++++++
 security/integrity/ima/ima_template.c | 85 +++++++++++++++++++++++++++++++++++
 5 files changed, 131 insertions(+)

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
index aed51175915f..bf8f61c20c11 100644
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
@@ -321,6 +322,9 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 		}
 	}
 
+	/* IMA needs to pass the measurement list to the next kernel. */
+	ima_add_kexec_buffer(image);
+
 	/* Call arch image load handlers */
 	ldata = arch_kexec_kernel_image_load(image);
 
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index db25f54a04fe..0334001055d7 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -102,6 +102,11 @@ struct ima_queue_entry {
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
index 32912bd54ead..a1924d0f3b2b 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -21,6 +21,7 @@
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
 #include <linux/err.h>
+#include <linux/kexec.h>
 
 #include "ima.h"
 
@@ -104,6 +105,29 @@ void __init ima_load_x509(void)
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
@@ -134,5 +158,7 @@ int __init ima_init(void)
 
 	ima_init_policy();
 
+	ima_load_kexec_buffer();
+
 	return ima_fs_init();
 }
diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index febd12ed9b55..a8609f3a13d2 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -15,6 +15,8 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/kexec.h>
+#include <linux/reboot.h>
 #include "ima.h"
 #include "ima_template_lib.h"
 
@@ -182,6 +184,89 @@ static int template_desc_init_fields(const char *template_fmt,
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
+	struct kexec_buf kbuf = { .image = image, .buf_align = PAGE_SIZE,
+				  .buf_min = 0, .buf_max = ULONG_MAX,
+				  .top_down = true };
+	bool first_kexec_load = kexec_buffer_load_addr == 0;
+	int ret;
+
+	if (!kexec_can_hand_over_buffer())
+		return;
+
+	if (!first_kexec_load)
+		kfree(kexec_buffer);
+
+	/* Create a relatively big buffer, for testing. */
+	kexec_buffer_size = kbuf.bufsz = kbuf.memsz = 5 * PAGE_SIZE;
+	kexec_buffer = kbuf.buffer = kzalloc(kexec_buffer_size, GFP_KERNEL);
+	if (!kexec_buffer) {
+		pr_err("Not enough memory for the kexec measurement buffer.\n");
+		return;
+	}
+
+	/* Add some content for demonstration purposes. */
+	strcpy(kexec_buffer, "Buffer contents at kexec load time.");
+
+	/* Ask not to checksum the segment, we may have to update it later. */
+	ret = kexec_add_handover_buffer(&kbuf, false);
+	if (ret) {
+		pr_err("Error passing over kexec measurement buffer.\n");
+		return;
+	}
+	kexec_buffer_load_addr = kbuf.mem;
+
+	if (first_kexec_load)
+		register_reboot_notifier(&update_buffer_nb);
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
