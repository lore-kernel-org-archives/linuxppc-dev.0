Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYVsV2KF7zDqmf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 11:45:02 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5L1hYEI113367
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 21:44:59 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23my7xug05-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 21:44:59 -0400
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Mon, 20 Jun 2016 22:44:57 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id EDD1A3520068
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 21:44:37 -0400 (EDT)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5L1ismh11534772
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 22:44:54 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5L1irfG029947
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 22:44:54 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: kexec@lists.infradead.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 Eric Biederman <ebiederm@xmission.com>, Dave Young <dyoung@redhat.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Eric Richter <erichte@linux.vnet.ibm.com>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [PATCH 1/6] kexec_file: Add buffer hand-over support for the next
 kernel
Date: Mon, 20 Jun 2016 22:44:31 -0300
In-Reply-To: <1466473476-10104-1-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1466473476-10104-1-git-send-email-bauerman@linux.vnet.ibm.com>
Message-Id: <1466473476-10104-2-git-send-email-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The buffer hand-over mechanism allows the currently running kernel to pass
data to kernel that will be kexec'd via a kexec segment. The second kernel
can check whether the previous kernel sent data and retrieve it.

This is the architecture-independent part of the feature.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 include/linux/kexec.h | 40 ++++++++++++++++++++++++++
 kernel/kexec_file.c   | 79 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 119 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index a08cd986b5a1..72db95c623b3 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -325,6 +325,46 @@ int __weak arch_kexec_walk_mem(unsigned int image_type, unsigned long start,
 void arch_kexec_protect_crashkres(void);
 void arch_kexec_unprotect_crashkres(void);
 
+#ifdef CONFIG_KEXEC_FILE
+bool __weak kexec_can_hand_over_buffer(void);
+int __weak arch_kexec_add_handover_buffer(struct kimage *image,
+					  unsigned long load_addr,
+					  unsigned long size);
+int kexec_add_handover_buffer(struct kimage *image, void *buffer,
+			      unsigned long bufsz, unsigned long memsz,
+			      unsigned long buf_align, unsigned long buf_min,
+			      unsigned long buf_max, bool top_down,
+			      unsigned long *load_addr);
+int __weak kexec_get_handover_buffer(void **addr, unsigned long *size);
+int __weak kexec_free_handover_buffer(void);
+#else
+static inline bool kexec_can_hand_over_buffer(void)
+{
+	return false;
+}
+
+static inline int kexec_add_handover_buffer(struct kimage *image, void *buffer,
+					    unsigned long bufsz,
+					    unsigned long memsz,
+					    unsigned long buf_align,
+					    unsigned long buf_min,
+					    unsigned long buf_max,
+					    bool top_down, bool checksum,
+					    unsigned long *load_addr)
+{
+	return -ENOTSUPP;
+}
+
+static inline int kexec_get_handover_buffer(void **addr, unsigned long *size)
+{
+	return -ENOTSUPP;
+}
+
+static inline int kexec_free_handover_buffer(void)
+{
+	return -ENOTSUPP;
+}
+#endif /* CONFIG_KEXEC_FILE */
 #else /* !CONFIG_KEXEC_CORE */
 struct pt_regs;
 struct task_struct;
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 3e494261d32a..d6ba702654f5 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -113,6 +113,85 @@ void kimage_file_post_load_cleanup(struct kimage *image)
 	image->image_loader_data = NULL;
 }
 
+/**
+ * kexec_can_hand_over_buffer - can we pass data to the kexec'd kernel?
+ */
+bool __weak kexec_can_hand_over_buffer(void)
+{
+	return false;
+}
+
+/**
+ * arch_kexec_add_handover_buffer - do arch-specific steps to handover buffer
+ *
+ * Architectures should use this function to pass on the handover buffer
+ * information to the next kernel.
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+int __weak arch_kexec_add_handover_buffer(struct kimage *image,
+					  unsigned long load_addr,
+					  unsigned long size)
+{
+	return -ENOTSUPP;
+}
+
+/**
+ * kexec_add_handover_buffer - add buffer to be used by the next kernel
+ * @image:	kexec image to add buffer to.
+ * @buffer:	Contents of the handover buffer.
+ * @bufsz:	@buffer size.
+ * @memsz:	Handover buffer size in memory.
+ * @buf_align:	Buffer alignment restriction.
+ * @buf_min:	Minimum address where buffer can be placed.
+ * @buf_max:	Maximum address where buffer can be placed.
+ * @top_down:	Find the highest available memory position for the buffer?
+ * @load_addr:	On successful return, set to the physical memory address of the
+ * 		buffer in the next kernel.
+ *
+ * This function assumes that kexec_mutex is held.
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+int kexec_add_handover_buffer(struct kimage *image, void *buffer,
+			      unsigned long bufsz, unsigned long memsz,
+			      unsigned long buf_align, unsigned long buf_min,
+			      unsigned long buf_max, bool top_down,
+			      unsigned long *load_addr)
+{
+	int ret;
+
+	if (!kexec_can_hand_over_buffer())
+		return -ENOTSUPP;
+
+	ret = kexec_add_buffer(image, buffer, bufsz, memsz, buf_align, buf_min,
+			       buf_max, top_down, load_addr);
+	if (ret)
+		return ret;
+
+	return arch_kexec_add_handover_buffer(image, *load_addr, memsz);
+}
+
+/**
+ * kexec_get_handover_buffer - get the handover buffer from the previous kernel
+ * @addr:	On successful return, set to point to the buffer contents.
+ * @size:	On successful return, set to the buffer size.
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+int __weak kexec_get_handover_buffer(void **addr, unsigned long *size)
+{
+	return -ENOTSUPP;
+}
+
+/**
+ * kexec_free_handover_buffer - free memory used by the handover buffer
+ */
+int __weak kexec_free_handover_buffer(void)
+{
+	return -ENOTSUPP;
+}
+
 /*
  * In file mode list of segments is prepared by kernel. Copy relevant
  * data from user space, do error checking, prepare segment list
-- 
1.9.1
