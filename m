Return-Path: <SRS0=P3hO=RE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24BBC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 13:06:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 643D72084F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 13:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYMnfweA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 643D72084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 449qSX1HjyzDqJN
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Mar 2019 00:06:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="aYMnfweA"; 
 dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 449qDz1sVXzDqVP
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Mar 2019 23:56:50 +1100 (AEDT)
Received: by mail-pg1-x544.google.com with SMTP id m1so11417724pgq.8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Mar 2019 04:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=IksLj1Sf1ClZcIaTUpFFReQeAryGO2qOdR1X/Hf3fu8=;
 b=aYMnfweA1scHFSVWl6nVfteqVrGZ//sbMdVn2D7CSkuVWSJybpIkTeOo/sf7/7/Uj9
 jL9jBQmR8KGcRzXHXoS0M81e5BrXEzK/GTsEtm1V41oTDldRO5vbj6qD0s05pHL05Bbg
 WOJBYBtNhsmFfThEH04NReeEP4W92Hrofe17RSNd1B2CZ9RtUeO5Ss938YYZgIadt0jy
 PMmMeZRiJ+M8p+LMAF6B7c9ctHiJHdtdBMyEDbsv/jdUmAd4IzZZc5QtFkGrl5ZvCsQx
 1nfpT4I49Wpc61gsnPUfMUX3F+0coPdIYu2t0M7tNtErEdpiPqU6e+oCSeO2kXQLjz5R
 6lTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=IksLj1Sf1ClZcIaTUpFFReQeAryGO2qOdR1X/Hf3fu8=;
 b=XXbIntnPkCDe0EhAXUtMRigizhjHup+qneMXzK56kKA4iZ169puQS7tLY7upO0SCA9
 iSI2t/FDYAVF/qQNGtM/GnGdb59RI5XM10CCfRLYuZMXHSEeJ+JfVTiEPpj6a+JlH2uc
 BjkUf8kw4JTximSIQcbvhkpUcA+zYRvDoG7bjLxdYnvRtxW/7uuPVuDaFILEuo3F8HLX
 kCvBm4BJ6OGChC0uoX8OnV3tMbvVFy3SY5AZ42ArqVO1Nsw9EbtUKlahhD7bv9ivc3hG
 nh21bx7r89N0Fg4Ze8WOmCHf8VNv+C+Un0qjaMujl11qEeeL/SWdZyPxPTgZps2W47x8
 N72A==
X-Gm-Message-State: APjAAAVKdXRv3j2+9unV6J88Jld0V0OwwHPESBO34jMHX1jA6+owiTEB
 Q4trVaYC9KfHUC3PFe4Jxp5CVkAa
X-Google-Smtp-Source: APXvYqyU4Hp3uMbSZKh/l//v0Gp7DkXH4fFUurOqiPRkCK351rE5NnMiZsoF+jUIR2LTplXqpeZACQ==
X-Received: by 2002:a63:6985:: with SMTP id e127mr4710629pgc.101.1551445007038; 
 Fri, 01 Mar 2019 04:56:47 -0800 (PST)
Received: from roar.local0.net (193-116-122-111.tpgi.com.au. [193.116.122.111])
 by smtp.gmail.com with ESMTPSA id i10sm10194688pgs.26.2019.03.01.04.56.44
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 01 Mar 2019 04:56:46 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/64s: Fix unrelocated interrupt trampoline address test
Date: Fri,  1 Mar 2019 22:56:36 +1000
Message-Id: <20190301125636.11292-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.18.0
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
Cc: Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The recent commit got this test wrong, it declared the assembler
symbols the wrong way, and also used the wrong symbol name
(xxx_start rather than start_xxx, see asm/head-64.h).

Fixes: ccd477028a ("powerpc/64s: Fix HV NMI vs HV interrupt recoverability test")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/asm-prototypes.h | 8 --------
 arch/powerpc/include/asm/sections.h       | 7 +++++++
 arch/powerpc/kernel/exceptions-64s.S      | 8 ++++----
 arch/powerpc/kernel/traps.c               | 9 +++++----
 4 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/include/asm/asm-prototypes.h b/arch/powerpc/include/asm/asm-prototypes.h
index 0f8326644fa4..1d911f68a23b 100644
--- a/arch/powerpc/include/asm/asm-prototypes.h
+++ b/arch/powerpc/include/asm/asm-prototypes.h
@@ -51,14 +51,6 @@ int exit_vmx_usercopy(void);
 int enter_vmx_ops(void);
 void *exit_vmx_ops(void *dest);
 
-/* Exceptions */
-#ifdef CONFIG_PPC_POWERNV
-extern unsigned long real_trampolines_start;
-extern unsigned long real_trampolines_end;
-extern unsigned long virt_trampolines_start;
-extern unsigned long virt_trampolines_end;
-#endif
-
 /* Traps */
 long machine_check_early(struct pt_regs *regs);
 long hmi_exception_realmode(struct pt_regs *regs);
diff --git a/arch/powerpc/include/asm/sections.h b/arch/powerpc/include/asm/sections.h
index e335a8f846af..4a1664a8658d 100644
--- a/arch/powerpc/include/asm/sections.h
+++ b/arch/powerpc/include/asm/sections.h
@@ -17,6 +17,13 @@ extern char __end_interrupts[];
 extern char __prom_init_toc_start[];
 extern char __prom_init_toc_end[];
 
+#ifdef CONFIG_PPC_POWERNV
+extern char start_real_trampolines[];
+extern char end_real_trampolines[];
+extern char start_virt_trampolines[];
+extern char end_virt_trampolines[];
+#endif
+
 static inline int in_kernel_text(unsigned long addr)
 {
 	if (addr >= (unsigned long)_stext && addr < (unsigned long)__init_end)
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index d2e9fc968655..6f0057566a80 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -70,10 +70,10 @@ OPEN_FIXED_SECTION(virt_vectors,        0x4000, 0x5900)
 OPEN_FIXED_SECTION(virt_trampolines,    0x5900, 0x7000)
 
 #ifdef CONFIG_PPC_POWERNV
-	.globl real_trampolines_start
-	.globl real_trampolines_end
-	.globl virt_trampolines_start
-	.globl virt_trampolines_end
+	.globl start_real_trampolines
+	.globl end_real_trampolines
+	.globl start_virt_trampolines
+	.globl end_virt_trampolines
 #endif
 
 #if defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV)
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 12b54908c15d..ee7c6cb876ba 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -426,12 +426,13 @@ void hv_nmi_check_nonrecoverable(struct pt_regs *regs)
 		goto nonrecoverable;
 	if ((nip >= 0xf80 && nip < 0xfa0) || (nip >= 0x4f80 && nip < 0x4fa0))
 		goto nonrecoverable;
+
 	/* Trampoline code runs un-relocated so subtract kbase. */
-	if (nip >= real_trampolines_start - kbase &&
-			nip < real_trampolines_end - kbase)
+	if (nip >= (unsigned long)(start_real_trampolines - kbase) &&
+			nip < (unsigned long)(end_real_trampolines - kbase))
 		goto nonrecoverable;
-	if (nip >= virt_trampolines_start - kbase &&
-			nip < virt_trampolines_end - kbase)
+	if (nip >= (unsigned long)(start_virt_trampolines - kbase) &&
+			nip < (unsigned long)(end_virt_trampolines - kbase))
 		goto nonrecoverable;
 	return;
 
-- 
2.18.0

