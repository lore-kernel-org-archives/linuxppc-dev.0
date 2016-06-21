Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYVsX2095zDqmF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 11:45:04 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5L1hXXO108666
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 21:45:02 -0400
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23n2cqrxfv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 21:45:02 -0400
Received: from localhost
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Mon, 20 Jun 2016 22:44:59 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id AC3EF1DC006E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 21:44:50 -0400 (EDT)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5L1iveV22348280
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 22:44:57 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5L1ivQS030021
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 22:44:57 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: kexec@lists.infradead.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 Eric Biederman <ebiederm@xmission.com>, Dave Young <dyoung@redhat.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Eric Richter <erichte@linux.vnet.ibm.com>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [PATCH 4/6] kexec_file: Add mechanism to update kexec segments.
Date: Mon, 20 Jun 2016 22:44:34 -0300
In-Reply-To: <1466473476-10104-1-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1466473476-10104-1-git-send-email-bauerman@linux.vnet.ibm.com>
Message-Id: <1466473476-10104-5-git-send-email-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

kexec_update_segment allows a given segment in kexec_image to have
its contents updated. This is useful if the current kernel wants to
send information to the next kernel that is up-to-date at the time of
reboot.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 include/linux/kexec.h |  2 ++
 kernel/kexec_core.c   | 88 +++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/kexec_file.c   |  1 +
 3 files changed, 91 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 131b1fc7820e..14d4ac070a8c 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -222,6 +222,8 @@ extern int kexec_add_buffer(struct kimage *image, char *buffer,
 			    unsigned long buf_align, unsigned long buf_min,
 			    unsigned long buf_max, bool top_down, bool checksum,
 			    unsigned long *load_addr);
+int kexec_update_segment(const char *buffer, unsigned long bufsz,
+			 unsigned long load_addr, unsigned long memsz);
 extern struct page *kimage_alloc_control_pages(struct kimage *image,
 						unsigned int order);
 extern int kexec_load_purgatory(struct kimage *image, unsigned long min,
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 56b3ed0927b0..8781d3e4479d 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -700,6 +700,94 @@ static struct page *kimage_alloc_page(struct kimage *image,
 	return page;
 }
 
+/**
+ * kexec_update_segment - update the contents of a kimage segment
+ * @buffer:	New contents of the segment.
+ * @bufsz:	@buffer size.
+ * @load_addr:	Segment's physical address in the next kernel.
+ * @memsz:	Segment size.
+ *
+ * This function assumes kexec_mutex is held.
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+int kexec_update_segment(const char *buffer, unsigned long bufsz,
+			 unsigned long load_addr, unsigned long memsz)
+{
+	int i;
+	unsigned long entry;
+	unsigned long *ptr = NULL;
+	void *dest = NULL;
+
+	for (i = 0; i < kexec_image->nr_segments; i++)
+		/* We only support updating whole segments. */
+		if (load_addr == kexec_image->segment[i].mem &&
+		    memsz == kexec_image->segment[i].memsz) {
+			if (kexec_image->segment[i].do_checksum) {
+				pr_err("Trying to update non-modifiable segment.\n");
+				return -EINVAL;
+			}
+
+			break;
+		}
+	if (i == kexec_image->nr_segments) {
+		pr_err("Couldn't find segment to update: 0x%lx, size 0x%lx\n",
+		       load_addr, memsz);
+		return -EINVAL;
+	}
+
+	for (entry = kexec_image->head; !(entry & IND_DONE) && memsz;
+	     entry = *ptr++) {
+		void *addr = (void *) (entry & PAGE_MASK);
+
+		switch (entry & IND_FLAGS) {
+		case IND_DESTINATION:
+			dest = addr;
+			break;
+		case IND_INDIRECTION:
+			ptr = __va(addr);
+			break;
+		case IND_SOURCE:
+			/* Shouldn't happen, but verify just to be safe. */
+			if (dest == NULL) {
+				pr_err("Invalid kexec entries list.");
+				return -EINVAL;
+			}
+
+			if (dest == (void *) load_addr) {
+				struct page *page;
+				char *ptr;
+				size_t uchunk, mchunk;
+
+				page = kmap_to_page(addr);
+
+				ptr = kmap(page);
+				ptr += load_addr & ~PAGE_MASK;
+				mchunk = min_t(size_t, memsz,
+					       PAGE_SIZE - (load_addr & ~PAGE_MASK));
+				uchunk = min(bufsz, mchunk);
+				memcpy(ptr, buffer, uchunk);
+
+				kunmap(page);
+
+				bufsz -= uchunk;
+				load_addr += mchunk;
+				buffer += mchunk;
+				memsz -= mchunk;
+			}
+			dest += PAGE_SIZE;
+		}
+
+		/* Shouldn't happen, but verify just to be safe. */
+		if (ptr == NULL) {
+			pr_err("Invalid kexec entries list.");
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 static int kimage_load_normal_segment(struct kimage *image,
 					 struct kexec_segment *segment)
 {
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 3aa829a78f50..79d09a7784d8 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -15,6 +15,7 @@
 #include <linux/mm.h>
 #include <linux/file.h>
 #include <linux/slab.h>
+#include <linux/highmem.h>
 #include <linux/kexec.h>
 #include <linux/mutex.h>
 #include <linux/list.h>
-- 
1.9.1
