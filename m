Return-Path: <SRS0=YiAJ=HX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D99C433DB
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Feb 2021 17:50:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 303B464DEC
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Feb 2021 17:50:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 303B464DEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DkCWh5BjYz3cKT
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Feb 2021 04:50:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=G/d7RTcg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.microsoft.com (client-ip=13.77.154.182;
 helo=linux.microsoft.com; envelope-from=nramas@linux.microsoft.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.a=rsa-sha256 header.s=default header.b=G/d7RTcg; 
 dkim-atps=neutral
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by lists.ozlabs.org (Postfix) with ESMTP id 4DkCW85SzFz30Mh
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2021 04:49:40 +1100 (AEDT)
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net
 [73.42.176.67])
 by linux.microsoft.com (Postfix) with ESMTPSA id 87CB820B57A1;
 Sun, 21 Feb 2021 09:49:38 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 87CB820B57A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1613929779;
 bh=qa+NJP4aqiYfDfVBgbCgEyvzbYLV5ECOdj7x4WIL6oA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=G/d7RTcg/ory144srJ3zFNOHdVnpVuPjh+/Fz/2/AJljEm7AI8MwD+CZUPeLtWz/b
 6sr1vAA3A1WwA9W1r/hTAIEQUzR15aasFMemQzfHnyseqeXrdhY8MfukrJnrAZXnp4
 EcXVwjlzwkOxnjftqRPQTp6FxkBX1bs0I271mpmM=
From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To: zohar@linux.ibm.com, bauerman@linux.ibm.com, robh@kernel.org,
 takahiro.akashi@linaro.org, gregkh@linuxfoundation.org, will@kernel.org,
 joe@perches.com, catalin.marinas@arm.com, mpe@ellerman.id.au,
 sfr@canb.auug.org.au
Subject: [PATCH v19 04/13] x86: Use ELF fields defined in 'struct kimage'
Date: Sun, 21 Feb 2021 09:49:21 -0800
Message-Id: <20210221174930.27324-5-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210221174930.27324-1-nramas@linux.microsoft.com>
References: <20210221174930.27324-1-nramas@linux.microsoft.com>
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
Cc: mark.rutland@arm.com, tao.li@vivo.com, paulus@samba.org,
 vincenzo.frascino@arm.com, frowand.list@gmail.com, sashal@kernel.org,
 masahiroy@kernel.org, jmorris@namei.org, allison@lohutok.net, serge@hallyn.com,
 devicetree@vger.kernel.org, pasha.tatashin@soleen.com,
 prsriva@linux.microsoft.com, hsinyi@chromium.org,
 linux-arm-kernel@lists.infradead.org, christophe.leroy@c-s.fr,
 mbrugger@suse.com, balajib@linux.microsoft.com, dmitry.kasatkin@gmail.com,
 linux-kernel@vger.kernel.org, james.morse@arm.com,
 linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

ELF related fields elf_headers, elf_headers_sz, and elf_load_addr
have been moved from 'struct kimage_arch' to 'struct kimage'.

Use the ELF fields defined in 'struct kimage'.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Suggested-by: Rob Herring <robh@kernel.org>
Fixes: 33488dc4d61f ("of: Add a common kexec FDT setup function")
Reported-by: kernel test robot <lkp@intel.com>
---
 arch/x86/include/asm/kexec.h       |  5 -----
 arch/x86/kernel/crash.c            | 14 +++++++-------
 arch/x86/kernel/kexec-bzimage64.c  |  2 +-
 arch/x86/kernel/machine_kexec_64.c |  4 ++--
 4 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 6802c59e8252..0a6e34b07017 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -150,11 +150,6 @@ struct kimage_arch {
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
-
-	/* Core ELF header buffer */
-	void *elf_headers;
-	unsigned long elf_headers_sz;
-	unsigned long elf_load_addr;
 };
 #endif /* CONFIG_X86_32 */
 
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index a8f3af257e26..9d0722fb8842 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -323,8 +323,8 @@ static int memmap_exclude_ranges(struct kimage *image, struct crash_mem *cmem,
 	cmem->nr_ranges = 1;
 
 	/* Exclude elf header region */
-	start = image->arch.elf_load_addr;
-	end = start + image->arch.elf_headers_sz - 1;
+	start = image->elf_load_addr;
+	end = start + image->elf_headers_sz - 1;
 	return crash_exclude_mem_range(cmem, start, end);
 }
 
@@ -407,20 +407,20 @@ int crash_load_segments(struct kimage *image)
 	if (ret)
 		return ret;
 
-	image->arch.elf_headers = kbuf.buffer;
-	image->arch.elf_headers_sz = kbuf.bufsz;
+	image->elf_headers = kbuf.buffer;
+	image->elf_headers_sz = kbuf.bufsz;
 
 	kbuf.memsz = kbuf.bufsz;
 	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
 	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
 	ret = kexec_add_buffer(&kbuf);
 	if (ret) {
-		vfree((void *)image->arch.elf_headers);
+		vfree((void *)image->elf_headers);
 		return ret;
 	}
-	image->arch.elf_load_addr = kbuf.mem;
+	image->elf_load_addr = kbuf.mem;
 	pr_debug("Loaded ELF headers at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
-		 image->arch.elf_load_addr, kbuf.bufsz, kbuf.bufsz);
+		 image->elf_load_addr, kbuf.bufsz, kbuf.bufsz);
 
 	return ret;
 }
diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index ce831f9448e7..170d0fd68b1f 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -75,7 +75,7 @@ static int setup_cmdline(struct kimage *image, struct boot_params *params,
 
 	if (image->type == KEXEC_TYPE_CRASH) {
 		len = sprintf(cmdline_ptr,
-			"elfcorehdr=0x%lx ", image->arch.elf_load_addr);
+			"elfcorehdr=0x%lx ", image->elf_load_addr);
 	}
 	memcpy(cmdline_ptr + len, cmdline, cmdline_len);
 	cmdline_len += len;
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index a29a44a98e5b..055c18a6f7bf 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -402,8 +402,8 @@ void machine_kexec(struct kimage *image)
 #ifdef CONFIG_KEXEC_FILE
 void *arch_kexec_kernel_image_load(struct kimage *image)
 {
-	vfree(image->arch.elf_headers);
-	image->arch.elf_headers = NULL;
+	vfree(image->elf_headers);
+	image->elf_headers = NULL;
 
 	if (!image->fops || !image->fops->load)
 		return ERR_PTR(-ENOEXEC);
-- 
2.30.0

