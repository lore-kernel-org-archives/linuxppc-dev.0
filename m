Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t0VKp1Zj1zDvZR
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 13:41:02 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9L2d5Qt117211
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2016 22:41:00 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2675yfryk8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2016 22:41:00 -0400
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Fri, 21 Oct 2016 00:40:57 -0200
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 3934B352005C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2016 22:40:28 -0400 (EDT)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u9L2es0Z26542496
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 00:40:54 -0200
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u9L2eroo005543
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 00:40:54 -0200
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: kexec@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 x86@kernel.org, Eric Biederman <ebiederm@xmission.com>,
 Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
 Baoquan He <bhe@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [PATCH v9 01/10] kexec_file: Allow arch-specific memory walking for
 kexec_add_buffer
Date: Fri, 21 Oct 2016 00:40:08 -0200
In-Reply-To: <1477017617-8540-1-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1477017617-8540-1-git-send-email-bauerman@linux.vnet.ibm.com>
Message-Id: <1477017617-8540-2-git-send-email-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Allow architectures to specify a different memory walking function for
kexec_add_buffer. x86 uses iomem to track reserved memory ranges, but
PowerPC uses the memblock subsystem.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Acked-by: Dave Young <dyoung@redhat.com>
Acked-by: Balbir Singh <bsingharora@gmail.com>
---
 include/linux/kexec.h   | 29 ++++++++++++++++++++++++++++-
 kernel/kexec_file.c     | 30 ++++++++++++++++++++++--------
 kernel/kexec_internal.h | 16 ----------------
 3 files changed, 50 insertions(+), 25 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 406c33dcae13..5e320ddaaa82 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -148,7 +148,34 @@ struct kexec_file_ops {
 	kexec_verify_sig_t *verify_sig;
 #endif
 };
-#endif
+
+/**
+ * struct kexec_buf - parameters for finding a place for a buffer in memory
+ * @image:	kexec image in which memory to search.
+ * @buffer:	Contents which will be copied to the allocated memory.
+ * @bufsz:	Size of @buffer.
+ * @mem:	On return will have address of the buffer in memory.
+ * @memsz:	Size for the buffer in memory.
+ * @buf_align:	Minimum alignment needed.
+ * @buf_min:	The buffer can't be placed below this address.
+ * @buf_max:	The buffer can't be placed above this address.
+ * @top_down:	Allocate from top of memory.
+ */
+struct kexec_buf {
+	struct kimage *image;
+	char *buffer;
+	unsigned long bufsz;
+	unsigned long mem;
+	unsigned long memsz;
+	unsigned long buf_align;
+	unsigned long buf_min;
+	unsigned long buf_max;
+	bool top_down;
+};
+
+int __weak arch_kexec_walk_mem(struct kexec_buf *kbuf,
+			       int (*func)(u64, u64, void *));
+#endif /* CONFIG_KEXEC_FILE */
 
 struct kimage {
 	kimage_entry_t head;
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 037c321c5618..f865674bff51 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -428,6 +428,27 @@ static int locate_mem_hole_callback(u64 start, u64 end, void *arg)
 	return locate_mem_hole_bottom_up(start, end, kbuf);
 }
 
+/**
+ * arch_kexec_walk_mem - call func(data) on free memory regions
+ * @kbuf:	Context info for the search. Also passed to @func.
+ * @func:	Function to call for each memory region.
+ *
+ * Return: The memory walk will stop when func returns a non-zero value
+ * and that value will be returned. If all free regions are visited without
+ * func returning non-zero, then zero will be returned.
+ */
+int __weak arch_kexec_walk_mem(struct kexec_buf *kbuf,
+			       int (*func)(u64, u64, void *))
+{
+	if (kbuf->image->type == KEXEC_TYPE_CRASH)
+		return walk_iomem_res_desc(crashk_res.desc,
+					   IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
+					   crashk_res.start, crashk_res.end,
+					   kbuf, func);
+	else
+		return walk_system_ram_res(0, ULONG_MAX, kbuf, func);
+}
+
 /*
  * Helper function for placing a buffer in a kexec segment. This assumes
  * that kexec_mutex is held.
@@ -474,14 +495,7 @@ int kexec_add_buffer(struct kimage *image, char *buffer, unsigned long bufsz,
 	kbuf->top_down = top_down;
 
 	/* Walk the RAM ranges and allocate a suitable range for the buffer */
-	if (image->type == KEXEC_TYPE_CRASH)
-		ret = walk_iomem_res_desc(crashk_res.desc,
-				IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
-				crashk_res.start, crashk_res.end, kbuf,
-				locate_mem_hole_callback);
-	else
-		ret = walk_system_ram_res(0, -1, kbuf,
-					  locate_mem_hole_callback);
+	ret = arch_kexec_walk_mem(kbuf, locate_mem_hole_callback);
 	if (ret != 1) {
 		/* A suitable memory range could not be found for buffer */
 		return -EADDRNOTAVAIL;
diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
index 0a52315d9c62..4cef7e4706b0 100644
--- a/kernel/kexec_internal.h
+++ b/kernel/kexec_internal.h
@@ -20,22 +20,6 @@ struct kexec_sha_region {
 	unsigned long len;
 };
 
-/*
- * Keeps track of buffer parameters as provided by caller for requesting
- * memory placement of buffer.
- */
-struct kexec_buf {
-	struct kimage *image;
-	char *buffer;
-	unsigned long bufsz;
-	unsigned long mem;
-	unsigned long memsz;
-	unsigned long buf_align;
-	unsigned long buf_min;
-	unsigned long buf_max;
-	bool top_down;		/* allocate from top of memory hole */
-};
-
 void kimage_file_post_load_cleanup(struct kimage *image);
 #else /* CONFIG_KEXEC_FILE */
 static inline void kimage_file_post_load_cleanup(struct kimage *image) { }
-- 
2.7.4
