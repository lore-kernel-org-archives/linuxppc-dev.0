Return-Path: <SRS0=q7yE=HP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B860C433DB
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Feb 2021 16:17:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 980F864DD9
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Feb 2021 16:17:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 980F864DD9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DdFry5rb1zDvWt
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Feb 2021 03:17:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.microsoft.com (client-ip=13.77.154.182;
 helo=linux.microsoft.com; envelope-from=nramas@linux.microsoft.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.a=rsa-sha256 header.s=default header.b=BGczkjJC; 
 dkim-atps=neutral
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by lists.ozlabs.org (Postfix) with ESMTP id 4DdFhx4JlWzDqDL
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Feb 2021 03:10:57 +1100 (AEDT)
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net
 [73.42.176.67])
 by linux.microsoft.com (Postfix) with ESMTPSA id CA34520B57A0;
 Sat, 13 Feb 2021 08:10:55 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CA34520B57A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1613232656;
 bh=W4nfk42A7xcjjuWVwXZ5p95MM79jT4rO0IEgmmAlhU0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BGczkjJC/2YMNuqpzttE2Qqwl+1QakY0vI1+r9FBaAJOFWRUBDn5k9bHUrYsDW1+b
 EXJpL/izfEKvAlG5p1BKsdy8/GtrviadcVSSZKVdv7QLM0+Iq3iUIALWWzJLBvI58d
 ebaoNgfVPlTxppC2ESNeMWJP6c9iocgx32dBAR9s=
From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To: zohar@linux.ibm.com, bauerman@linux.ibm.com, robh@kernel.org,
 takahiro.akashi@linaro.org, gregkh@linuxfoundation.org, will@kernel.org,
 joe@perches.com, catalin.marinas@arm.com, mpe@ellerman.id.au
Subject: [PATCH v18 02/11] arm64: Rename kexec elf_headers_mem to elf_load_addr
Date: Sat, 13 Feb 2021 08:10:40 -0800
Message-Id: <20210213161049.6190-3-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210213161049.6190-1-nramas@linux.microsoft.com>
References: <20210213161049.6190-1-nramas@linux.microsoft.com>
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

The architecture specific field, elf_headers_mem in struct kimage_arch,
that holds the address of the buffer in memory for ELF core header for
arm64 has a different name than the one used for powerpc.  This makes
it hard to have a common code for setting up the device tree for
kexec system call.

Rename elf_headers_mem to elf_load_addr to align with powerpc name so
common code can use it.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Suggested-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 arch/arm64/include/asm/kexec.h         | 2 +-
 arch/arm64/kernel/machine_kexec_file.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index d24b527e8c00..e6a99dfdffb8 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -98,7 +98,7 @@ struct kimage_arch {
 	unsigned long dtb_mem;
 	/* Core ELF header buffer */
 	void *elf_headers;
-	unsigned long elf_headers_mem;
+	unsigned long elf_load_addr;
 	unsigned long elf_headers_sz;
 };
 
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 03210f644790..d98bacec9426 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -73,7 +73,7 @@ static int setup_dtb(struct kimage *image,
 		/* add linux,elfcorehdr */
 		ret = fdt_appendprop_addrrange(dtb, 0, off,
 				FDT_PROP_KEXEC_ELFHDR,
-				image->arch.elf_headers_mem,
+				image->arch.elf_load_addr,
 				image->arch.elf_headers_sz);
 		if (ret)
 			return (ret == -FDT_ERR_NOSPACE ? -ENOMEM : -EINVAL);
@@ -283,11 +283,11 @@ int load_other_segments(struct kimage *image,
 			goto out_err;
 		}
 		image->arch.elf_headers = headers;
-		image->arch.elf_headers_mem = kbuf.mem;
+		image->arch.elf_load_addr = kbuf.mem;
 		image->arch.elf_headers_sz = headers_sz;
 
 		pr_debug("Loaded elf core header at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
-			 image->arch.elf_headers_mem, kbuf.bufsz, kbuf.memsz);
+			 image->arch.elf_load_addr, kbuf.bufsz, kbuf.memsz);
 	}
 
 	/* load initrd */
-- 
2.30.0

