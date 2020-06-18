Return-Path: <SRS0=k+Co=77=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6590CC433E0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Jun 2020 07:18:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1678821548
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Jun 2020 07:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="pA12moG/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1678821548
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49nYDl0Jt8zDrJ1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Jun 2020 17:17:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.microsoft.com (client-ip=13.77.154.182;
 helo=linux.microsoft.com; envelope-from=prsriva@linux.microsoft.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.a=rsa-sha256 header.s=default header.b=pA12moG/; 
 dkim-atps=neutral
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by lists.ozlabs.org (Postfix) with ESMTP id 49nY4w69cyzDrCN
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jun 2020 17:11:12 +1000 (AEST)
Received: from prsriva-linux.hsd1.wa.comcast.net
 (c-24-19-135-168.hsd1.wa.comcast.net [24.19.135.168])
 by linux.microsoft.com (Postfix) with ESMTPSA id 0B30120B4786;
 Thu, 18 Jun 2020 00:11:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0B30120B4786
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1592464271;
 bh=FU/dh8XJhvc2HADs0zF7wiDVVprap0U1bWT1cyNAets=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pA12moG/pVT/6D2LjfiKGdFUV8aZDZxjmK2ZKUfs8hvEa3eYCS0hsi6ytCRyEu1cy
 QiBbEeTFdcxHe+zxWVt10ayF2H5VUDbh/PVCGpZ6b+d/uSsxrAvVYrHhtB7x6yhGwy
 fN6wovAr3OG9o8jeSugfrhhITTI7SvLGQyi2bBbs=
From: Prakhar Srivastava <prsriva@linux.microsoft.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
 linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [V2 PATCH 3/3] Add support for arm64 to carry over IMA measurement
 logs
Date: Thu, 18 Jun 2020 00:10:45 -0700
Message-Id: <20200618071045.471131-4-prsriva@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618071045.471131-1-prsriva@linux.microsoft.com>
References: <20200618071045.471131-1-prsriva@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: kstewart@linuxfoundation.org, mark.rutland@arm.com, catalin.marinas@arm.com,
 bhsharma@redhat.com, tao.li@vivo.com, zohar@linux.ibm.com, paulus@samba.org,
 vincenzo.frascino@arm.com, frowand.list@gmail.com, nramas@linux.microsoft.com,
 masahiroy@kernel.org, jmorris@namei.org, takahiro.akashi@linaro.org,
 serge@hallyn.com, pasha.tatashin@soleen.com, will@kernel.org,
 prsriva@linux.microsoft.com, robh+dt@kernel.org, hsinyi@chromium.org,
 tusharsu@linux.microsoft.com, tglx@linutronix.de, allison@lohutok.net,
 christophe.leroy@c-s.fr, mbrugger@suse.com, balajib@linux.microsoft.com,
 dmitry.kasatkin@gmail.com, james.morse@arm.com, gregkh@linuxfoundation.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Add support for arm64 to carry over IMA measurement logs.
Update arm64 code to call into functions made available in patch 1/3.

---
 arch/arm64/Kconfig                     |  1 +
 arch/arm64/include/asm/ima.h           | 17 ++++++++++
 arch/arm64/include/asm/kexec.h         |  3 ++
 arch/arm64/kernel/machine_kexec_file.c | 47 +++++++++++++++++++++-----
 4 files changed, 60 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm64/include/asm/ima.h

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5d513f461957..3d544e2e25e6 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1070,6 +1070,7 @@ config KEXEC
 config KEXEC_FILE
 	bool "kexec file based system call"
 	select KEXEC_CORE
+	select HAVE_IMA_KEXEC
 	help
 	  This is new version of kexec system call. This system call is
 	  file based and takes file descriptors as system call argument
diff --git a/arch/arm64/include/asm/ima.h b/arch/arm64/include/asm/ima.h
new file mode 100644
index 000000000000..70ac39b74607
--- /dev/null
+++ b/arch/arm64/include/asm/ima.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_ARCH_IMA_H
+#define _ASM_ARCH_IMA_H
+
+struct kimage;
+
+#ifdef CONFIG_IMA_KEXEC
+int arch_ima_add_kexec_buffer(struct kimage *image, unsigned long load_addr,
+			      size_t size);
+#else
+static inline int arch_ima_add_kexec_buffer(struct kimage *image,
+			unsigned long load_addr, size_t size)
+{
+	return 0;
+}
+#endif /* CONFIG_IMA_KEXEC */
+#endif /* _ASM_ARCH_IMA_H */
diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index d24b527e8c00..7bd60c185ad3 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -100,6 +100,9 @@ struct kimage_arch {
 	void *elf_headers;
 	unsigned long elf_headers_mem;
 	unsigned long elf_headers_sz;
+
+	phys_addr_t ima_buffer_addr;
+	size_t ima_buffer_size;
 };
 
 extern const struct kexec_file_ops kexec_image_ops;
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index b40c3b0def92..1e9007c926db 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -24,20 +24,37 @@
 #include <asm/byteorder.h>
 
 /* relevant device tree properties */
-#define FDT_PROP_KEXEC_ELFHDR	"linux,elfcorehdr"
-#define FDT_PROP_MEM_RANGE	"linux,usable-memory-range"
-#define FDT_PROP_INITRD_START	"linux,initrd-start"
-#define FDT_PROP_INITRD_END	"linux,initrd-end"
-#define FDT_PROP_BOOTARGS	"bootargs"
-#define FDT_PROP_KASLR_SEED	"kaslr-seed"
-#define FDT_PROP_RNG_SEED	"rng-seed"
-#define RNG_SEED_SIZE		128
+#define FDT_PROP_KEXEC_ELFHDR		"linux,elfcorehdr"
+#define FDT_PROP_MEM_RANGE		"linux,usable-memory-range"
+#define FDT_PROP_INITRD_START		"linux,initrd-start"
+#define FDT_PROP_INITRD_END		"linux,initrd-end"
+#define FDT_PROP_BOOTARGS		"bootargs"
+#define FDT_PROP_KASLR_SEED		"kaslr-seed"
+#define FDT_PROP_RNG_SEED		"rng-seed"
+#define FDT_PROP_IMA_KEXEC_BUFFER	"linux,ima-kexec-buffer"
+#define RNG_SEED_SIZE			128
 
 const struct kexec_file_ops * const kexec_file_loaders[] = {
 	&kexec_image_ops,
 	NULL
 };
 
+/**
+ * arch_ima_add_kexec_buffer - do arch-specific steps to add the IMA buffer
+ *
+ * Architectures should use this function to pass on the IMA buffer
+ * information to the next kernel.
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+int arch_ima_add_kexec_buffer(struct kimage *image, unsigned long load_addr,
+			      size_t size)
+{
+	image->arch.ima_buffer_addr = load_addr;
+	image->arch.ima_buffer_size = size;
+	return 0;
+}
+
 int arch_kimage_file_post_load_cleanup(struct kimage *image)
 {
 	vfree(image->arch.dtb);
@@ -66,6 +83,9 @@ static int setup_dtb(struct kimage *image,
 	if (ret && ret != -FDT_ERR_NOTFOUND)
 		goto out;
 	ret = fdt_delprop(dtb, off, FDT_PROP_MEM_RANGE);
+	if (ret && ret != -FDT_ERR_NOTFOUND)
+		goto out;
+	ret = fdt_delprop(dtb, off, FDT_PROP_IMA_KEXEC_BUFFER);
 	if (ret && ret != -FDT_ERR_NOTFOUND)
 		goto out;
 
@@ -119,6 +139,17 @@ static int setup_dtb(struct kimage *image,
 			goto out;
 	}
 
+	if (image->arch.ima_buffer_size > 0) {
+
+		ret = fdt_appendprop_addrrange(dtb, 0, off,
+				FDT_PROP_IMA_KEXEC_BUFFER,
+				image->arch.ima_buffer_addr,
+				image->arch.ima_buffer_size);
+		if (ret)
+			return (ret == -FDT_ERR_NOSPACE ? -ENOMEM : -EINVAL);
+
+	}
+
 	/* add kaslr-seed */
 	ret = fdt_delprop(dtb, off, FDT_PROP_KASLR_SEED);
 	if (ret == -FDT_ERR_NOTFOUND)
-- 
2.25.1

