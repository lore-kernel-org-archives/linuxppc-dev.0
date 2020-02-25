Return-Path: <SRS0=ugyh=4N=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E484C35E01
	for <linuxppc-dev@archiver.kernel.org>; Tue, 25 Feb 2020 17:46:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FC832082F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 25 Feb 2020 17:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icSIwBQV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FC832082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48RmZ52LhQzDqPW
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Feb 2020 04:46:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::442;
 helo=mail-pf1-x442.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=icSIwBQV; dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48RmQt5f7WzDqN0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Feb 2020 04:39:50 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id n7so7579203pfn.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2020 09:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uCEbI09lor/qC/aFDBSifMSqGqBOTjPUl9F/CF3mTL4=;
 b=icSIwBQVLFfIDIGmId/mjOhrXGZxZPHr6IAoeAcASqkerI8/I3qZoi4DBoafcyDXqs
 Nr2DJAetesqQal2PZbvvbm/fpt3vhYG3wL4wFfTk6YglGfr9T7WkqZmRczZqcTd2CKog
 tihSZzV3aNhVzosAzRn6KNxRUvKiNAwGYidRdrUQRmvTf4Urs843kxB9uGsciMotsZny
 xbt/3/TN17zb/nNYlLaRi+3N2G7JfD/Tlmci7LVGdRvsgnFwO/uGSCQggmeko6XMnczI
 upZtmQtUGbET12XBccPCl+xvSR/6As3P9+4oAquPr+FfkN6SipLG7eBtgKVMVffVB5kw
 gy7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uCEbI09lor/qC/aFDBSifMSqGqBOTjPUl9F/CF3mTL4=;
 b=E+6HN+oK+VrTNMVwEFPwXWrFN2erRfxzzOAEp0N4KD19J2lQ4GTQhjpjp9wmtszJbz
 oUmr3E/vPGwQjM63qoiix855kRJkA5VNyM/SrTAvCniGymsQ4FvWSQAXBlr/8U0Y2yjQ
 NPtqNBbEqZy4lEkl1Qf85Nt4eJQmo1fYK2OsI3nEugyqFUzDNymFX0L772yK8rs+c+IO
 UEX3tfOjbDO/cuTnLP3E1frjPsOeOA9OZLfHwlvdrZgkFghzrV2XDv7YIbawOxUnCu7O
 hAKGDy1a9Qq+jCoKTFWzxeUonzcWtVUBNUx7mZT19Nvu+ej8fKQvI2WqaKv4nbCehiZz
 ya+w==
X-Gm-Message-State: APjAAAWUmJnmN3Lr2pVifTutds1kvL5SGgKf4CTHMkAYxieiKNnLN/Uo
 h3okEf66sBSHjI9BKftsBGfSGJHD
X-Google-Smtp-Source: APXvYqyCNkx+/3OTgU6omJxRB5o0ooKxWdbLFLDTpdIUam5vij5r4WJH8jY8FXJiDVAgzoGpI11C5g==
X-Received: by 2002:a63:33c4:: with SMTP id
 z187mr58983692pgz.114.1582652387763; 
 Tue, 25 Feb 2020 09:39:47 -0800 (PST)
Received: from bobo.ibm.com ([61.68.187.74])
 by smtp.gmail.com with ESMTPSA id z63sm14791480pgd.12.2020.02.25.09.39.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 09:39:47 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 01/32] powerpc/64s/exception: Introduce INT_DEFINE
 parameter block for code generation
Date: Wed, 26 Feb 2020 03:35:10 +1000
Message-Id: <20200225173541.1549955-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200225173541.1549955-1-npiggin@gmail.com>
References: <20200225173541.1549955-1-npiggin@gmail.com>
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
Cc: Michal Suchanek <msuchanek@suse.de>, Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The code generation macro arguments are difficult to read, and
defaults can't easily be used.

This introduces a block where parameters can be set for interrupt
handler code generation by the subsequent macros, and adds the first
generation macro for interrupt entry.

One interrupt handler is converted to the new macros to demonstrate
the change, the rest will be coverted all at once.

No generated code change.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 77 ++++++++++++++++++++++++++--
 1 file changed, 73 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index ffc15f4f079d..1b942c98bc05 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -193,6 +193,61 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	mtctr	reg;							\
 	bctr
 
+/*
+ * Interrupt code generation macros
+ */
+#define IVEC		.L_IVEC_\name\()
+#define IHSRR		.L_IHSRR_\name\()
+#define IAREA		.L_IAREA_\name\()
+#define IDAR		.L_IDAR_\name\()
+#define IDSISR		.L_IDSISR_\name\()
+#define ISET_RI		.L_ISET_RI_\name\()
+#define IEARLY		.L_IEARLY_\name\()
+#define IMASK		.L_IMASK_\name\()
+#define IKVM_REAL	.L_IKVM_REAL_\name\()
+#define IKVM_VIRT	.L_IKVM_VIRT_\name\()
+
+#define INT_DEFINE_BEGIN(n)						\
+.macro int_define_ ## n name
+
+#define INT_DEFINE_END(n)						\
+.endm ;									\
+int_define_ ## n n ;							\
+do_define_int n
+
+.macro do_define_int name
+	.ifndef IVEC
+		.error "IVEC not defined"
+	.endif
+	.ifndef IHSRR
+		IHSRR=EXC_STD
+	.endif
+	.ifndef IAREA
+		IAREA=PACA_EXGEN
+	.endif
+	.ifndef IDAR
+		IDAR=0
+	.endif
+	.ifndef IDSISR
+		IDSISR=0
+	.endif
+	.ifndef ISET_RI
+		ISET_RI=1
+	.endif
+	.ifndef IEARLY
+		IEARLY=0
+	.endif
+	.ifndef IMASK
+		IMASK=0
+	.endif
+	.ifndef IKVM_REAL
+		IKVM_REAL=0
+	.endif
+	.ifndef IKVM_VIRT
+		IKVM_VIRT=0
+	.endif
+.endm
+
 .macro INT_KVM_HANDLER name, vec, hsrr, area, skip
 	TRAMP_KVM_BEGIN(\name\()_kvm)
 	KVM_HANDLER \vec, \hsrr, \area, \skip
@@ -474,7 +529,7 @@ END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,948)
 	 */
 	GET_SCRATCH0(r10)
 	std	r10,\area\()+EX_R13(r13)
-	.if \dar
+	.if \dar == 1
 	.if \hsrr
 	mfspr	r10,SPRN_HDAR
 	.else
@@ -482,7 +537,7 @@ END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,948)
 	.endif
 	std	r10,\area\()+EX_DAR(r13)
 	.endif
-	.if \dsisr
+	.if \dsisr == 1
 	.if \hsrr
 	mfspr	r10,SPRN_HDSISR
 	.else
@@ -506,6 +561,14 @@ END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,948)
 	.endif
 .endm
 
+.macro GEN_INT_ENTRY name, virt, ool=0
+	.if ! \virt
+		INT_HANDLER \name, IVEC, \ool, IEARLY, \virt, IHSRR, IAREA, ISET_RI, IDAR, IDSISR, IMASK, IKVM_REAL
+	.else
+		INT_HANDLER \name, IVEC, \ool, IEARLY, \virt, IHSRR, IAREA, ISET_RI, IDAR, IDSISR, IMASK, IKVM_VIRT
+	.endif
+.endm
+
 /*
  * On entry r13 points to the paca, r9-r13 are saved in the paca,
  * r9 contains the saved CR, r11 and r12 contain the saved SRR0 and
@@ -1143,12 +1206,18 @@ END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
 	bl	unrecoverable_exception
 	b	.
 
+INT_DEFINE_BEGIN(data_access)
+	IVEC=0x300
+	IDAR=1
+	IDSISR=1
+	IKVM_REAL=1
+INT_DEFINE_END(data_access)
 
 EXC_REAL_BEGIN(data_access, 0x300, 0x80)
-	INT_HANDLER data_access, 0x300, ool=1, dar=1, dsisr=1, kvm=1
+	GEN_INT_ENTRY data_access, virt=0, ool=1
 EXC_REAL_END(data_access, 0x300, 0x80)
 EXC_VIRT_BEGIN(data_access, 0x4300, 0x80)
-	INT_HANDLER data_access, 0x300, virt=1, dar=1, dsisr=1
+	GEN_INT_ENTRY data_access, virt=1
 EXC_VIRT_END(data_access, 0x4300, 0x80)
 INT_KVM_HANDLER data_access, 0x300, EXC_STD, PACA_EXGEN, 1
 EXC_COMMON_BEGIN(data_access_common)
-- 
2.23.0

