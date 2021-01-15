Return-Path: <SRS0=Y1I/=GS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0F1C433DB
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Jan 2021 18:49:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6D9C23A59
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Jan 2021 18:49:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6D9C23A59
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DHVZs3fpyzDvYY
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Jan 2021 05:49:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.microsoft.com (client-ip=13.77.154.182;
 helo=linux.microsoft.com; envelope-from=nramas@linux.microsoft.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.a=rsa-sha256 header.s=default header.b=Jf5B9mbO; 
 dkim-atps=neutral
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by lists.ozlabs.org (Postfix) with ESMTP id 4DHSrB153kzDsbB
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Jan 2021 04:30:34 +1100 (AEDT)
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net
 [73.42.176.67])
 by linux.microsoft.com (Postfix) with ESMTPSA id 687B420B6C48;
 Fri, 15 Jan 2021 09:30:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 687B420B6C48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1610731830;
 bh=axPbEa6PnZm+iW25Zsi9IlEECBFRe6hBfmO2Ulu9IEs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Jf5B9mbOV5Z9FseEFixwYoYT/sNPZ5VkfqSOIKX7Wxxb9AhFYZty+z0EHderu5hsO
 Q0FbrBbSam7UfegH2wIKa7xQINuS9tmb0xkcOkg9PB81roGo2LGW+AA3EgUIL3fqq2
 0nNAIysgt1rH6iOnFkvlf9vgxHXlYh1eXm2WkQ5E=
From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To: zohar@linux.ibm.com, bauerman@linux.ibm.com, robh@kernel.org,
 takahiro.akashi@linaro.org, gregkh@linuxfoundation.org, will@kernel.org,
 catalin.marinas@arm.com, mpe@ellerman.id.au
Subject: [PATCH v15 09/10] arm64: Call kmalloc() to allocate DTB buffer
Date: Fri, 15 Jan 2021 09:30:16 -0800
Message-Id: <20210115173017.30617-10-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210115173017.30617-1-nramas@linux.microsoft.com>
References: <20210115173017.30617-1-nramas@linux.microsoft.com>
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
Cc: mark.rutland@arm.com, bhsharma@redhat.com, tao.li@vivo.com,
 paulus@samba.org, vincenzo.frascino@arm.com, frowand.list@gmail.com,
 sashal@kernel.org, masahiroy@kernel.org, jmorris@namei.org,
 linux-arm-kernel@lists.infradead.org, serge@hallyn.com,
 devicetree@vger.kernel.org, pasha.tatashin@soleen.com,
 prsriva@linux.microsoft.com, hsinyi@chromium.org, allison@lohutok.net,
 christophe.leroy@c-s.fr, mbrugger@suse.com, balajib@linux.microsoft.com,
 dmitry.kasatkin@gmail.com, linux-kernel@vger.kernel.org, james.morse@arm.com,
 linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

create_dtb() function allocates kernel virtual memory for
the device tree blob (DTB).  This is not consistent with other
architectures, such as powerpc, which calls kmalloc() for allocating
memory for the DTB.

Call kmalloc() to allocate memory for the DTB, and kfree() to free
the allocated memory.

Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 arch/arm64/kernel/machine_kexec_file.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 7de9c47dee7c..51c40143d6fa 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -29,7 +29,7 @@ const struct kexec_file_ops * const kexec_file_loaders[] = {
 
 int arch_kimage_file_post_load_cleanup(struct kimage *image)
 {
-	vfree(image->arch.dtb);
+	kfree(image->arch.dtb);
 	image->arch.dtb = NULL;
 
 	vfree(image->arch.elf_headers);
@@ -59,19 +59,21 @@ static int create_dtb(struct kimage *image,
 			+ cmdline_len + DTB_EXTRA_SPACE;
 
 	for (;;) {
-		buf = vmalloc(buf_size);
+		buf = kmalloc(buf_size, GFP_KERNEL);
 		if (!buf)
 			return -ENOMEM;
 
 		/* duplicate a device tree blob */
 		ret = fdt_open_into(initial_boot_params, buf, buf_size);
-		if (ret)
+		if (ret) {
+			kfree(buf);
 			return -EINVAL;
+		}
 
 		ret = of_kexec_setup_new_fdt(image, buf, initrd_load_addr,
 					     initrd_len, cmdline);
 		if (ret) {
-			vfree(buf);
+			kfree(buf);
 			if (ret == -ENOMEM) {
 				/* unlikely, but just in case */
 				buf_size += DTB_EXTRA_SPACE;
@@ -217,6 +219,6 @@ int load_other_segments(struct kimage *image,
 	return 0;
 
 out_err:
-	vfree(dtb);
+	kfree(dtb);
 	return ret;
 }
-- 
2.30.0

