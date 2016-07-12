Return-Path: <takahiro.akashi@linaro.org>
Received: from mail-pa0-x233.google.com (mail-pa0-x233.google.com
 [IPv6:2607:f8b0:400e:c03::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rpPj632FSzDqxM
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 11:37:30 +1000 (AEST)
Received: by mail-pa0-x233.google.com with SMTP id hu1so755156pad.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 18:37:30 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: ebiederm@xmission.com, vgoyal@redhat.com, dyoung@redhat.com,
 bhe@redhat.com, bauerman@linux.vnet.ibm.com, arnd@arndb.de
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC 2/3] kexec: add dtb info to struct kimage
Date: Tue, 12 Jul 2016 10:42:00 +0900
Message-Id: <20160712014201.11456-3-takahiro.akashi@linaro.org>
In-Reply-To: <20160712014201.11456-1-takahiro.akashi@linaro.org>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Device tree blob must be passed to a second kernel on DTB-capable
archs, like powerpc and arm64, but the current kernel interface
lacks this support.

This patch adds dtb buffer information to struct kimage.
When users don't specify dtb explicitly and the one used for the current
kernel can be re-used, this change will be good enough for implementing
kexec_file_load feature.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 include/linux/kexec.h | 3 +++
 kernel/kexec_file.c   | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index e8acb2b..554c848 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -190,6 +190,9 @@ struct kimage {
 	char *cmdline_buf;
 	unsigned long cmdline_buf_len;
 
+	void *dtb_buf;
+	unsigned long dtb_buf_len;
+
 	/* File operations provided by image loader */
 	struct kexec_file_ops *fops;
 
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 9891464..7278329 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -96,6 +96,11 @@ void kimage_file_post_load_cleanup(struct kimage *image)
 		image->initrd_buf = NULL;
 	}
 
+	if (image->dtb_buf) {
+		vfree(image->dtb_buf);
+		image->dtb_buf = NULL;
+	}
+
 	if (image->cmdline_buf) {
 		kfree(image->cmdline_buf);
 		image->cmdline_buf = NULL;
-- 
2.9.0
