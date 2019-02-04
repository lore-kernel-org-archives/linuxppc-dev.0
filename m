Return-Path: <SRS0=Z4Cu=QL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14975C282C4
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 14:26:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 868E32082E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 14:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtY6S8Ne"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 868E32082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43tVQH35FszDqJf
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 01:26:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="mtY6S8Ne"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43tVF26grFzDqCH
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2019 01:18:46 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id e5so6867465plb.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Feb 2019 06:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=hbbKbkMeTID1gQ4UoZhk06BFroVwVlof+q+IyhRdUu0=;
 b=mtY6S8Ne29S2Pv5NdNhBFevcIAK1Ss5DvZzc/yCme2mnmPcfx58aFyuXMuGg4+uaE/
 OhZZn6qzinPDr2W1Vn4GG5xOL0TiXBreLRTNRzUPBYtUJPJSUSvOk9gAuEnMup6fULJr
 h2cEgHxoao1E2mymzGxnLPDBGnoZuHqqtZfRhat3vAE0By3r1kPBsqoIZVWut4WkKqcA
 2F7N+pFZlA4IV080L7x+zz27znaO6YanF7ds09VovyeE8xpd8e/D4gLRttqzBlBG3E/N
 iFxIF0OgBoPbYXvtnWWe2usYw3+F4pxFiDn8EFRM9CrRygo3+r7vahg33opav4RrlwUT
 bADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=hbbKbkMeTID1gQ4UoZhk06BFroVwVlof+q+IyhRdUu0=;
 b=L1KgJ5daJ1ZrBTyeuCx8mYKd969ZNp7ZLxSkjMO07MvVnmx2/bXvC8gmfpZvyNG3vL
 ONnA6vQGL86au+uIYcPB2XTHnpJrKQ1r2d7mnwUK9wfeNt1tYBb1qJP/Fb7HWHeaztuh
 SJ6eJcU9pRzbPesNMx3ESA8y3K3k2XyGFHIOx5j2PPYElvUHBpkzlcsxNyFqsCO4mF2y
 AT6cMThA6a19BQL4nSBepqBgFHx7Zv4XZENC+kHkiVI0cRFCfXGt/YrvA5og/2Mu0h8z
 0KjIDOP7TLjPrA1372rI/QFcdJ+9YXHCQcUc+UZOGyClvfYWfCTK1fPTTLoS3G88rgqB
 D9zQ==
X-Gm-Message-State: AJcUukdo22rJFFmM+RUYpTldrK1DH9GCw5UN27ULKCiq4+D9BCKZLP7f
 2f/kDixW3axKa4PVBCx9KEukrTmt
X-Google-Smtp-Source: ALg8bN44BpTUPaJ+YYfRX5HXdfM6RX9dD0Ias3FaMbm0Ly0W3RjJ19zE6P3zRq4/lKHCu7Bl2QcLdg==
X-Received: by 2002:a17:902:264:: with SMTP id
 91mr52267606plc.108.1549289924722; 
 Mon, 04 Feb 2019 06:18:44 -0800 (PST)
Received: from roar.local0.net ([210.185.78.69])
 by smtp.gmail.com with ESMTPSA id h9sm226230pgd.53.2019.02.04.06.18.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 04 Feb 2019 06:18:44 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 03/17] powerpc/64s/exception: consolidate EXCEPTION_PROLOG_2
 with _NORI variant
Date: Tue,  5 Feb 2019 00:18:14 +1000
Message-Id: <20190204141828.13043-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190204141828.13043-1-npiggin@gmail.com>
References: <20190204141828.13043-1-npiggin@gmail.com>
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

Switch to a gas macro that conditionally expands the RI clearing
instruction.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/exception-64s.h | 43 ++++++------------------
 arch/powerpc/kernel/exceptions-64s.S     |  6 ++--
 2 files changed, 14 insertions(+), 35 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 230328724314..aa19c95e7cfa 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -323,32 +323,11 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 #define EXCEPTION_PROLOG_1(area, extra, vec)				\
 	_EXCEPTION_PROLOG_1(area, extra, vec)
 
-.macro EXCEPTION_PROLOG_2 label, hsrr
-	ld	r10,PACAKMSR(r13)	/* get MSR value for kernel */
-	.if \hsrr
-	mfspr	r11,SPRN_HSRR0		/* save HSRR0 */
-	.else
-	mfspr	r11,SPRN_SRR0		/* save SRR0 */
-	.endif
-	LOAD_HANDLER(r12,\label\())
-	.if \hsrr
-	mtspr	SPRN_HSRR0,r12
-	mfspr	r12,SPRN_HSRR1		/* and HSRR1 */
-	mtspr	SPRN_HSRR1,r10
-	HRFI_TO_KERNEL
-	.else
-	mtspr	SPRN_SRR0,r12
-	mfspr	r12,SPRN_SRR1		/* and SRR1 */
-	mtspr	SPRN_SRR1,r10
-	RFI_TO_KERNEL
-	.endif
-	b	.	/* prevent speculative execution */
-.endm
-
-/* _NORI variant keeps MSR_RI clear */
-.macro EXCEPTION_PROLOG_2_NORI label, hsrr
+.macro EXCEPTION_PROLOG_2 label, hsrr, set_ri
 	ld	r10,PACAKMSR(r13)	/* get MSR value for kernel */
+	.if ! \set_ri
 	xori	r10,r10,MSR_RI		/* Clear MSR_RI */
+	.endif
 	.if \hsrr
 	mfspr	r11,SPRN_HSRR0		/* save HSRR0 */
 	.else
@@ -373,7 +352,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	SET_SCRATCH0(r13);		/* save r13 */			\
 	EXCEPTION_PROLOG_0(area);					\
 	EXCEPTION_PROLOG_1(area, extra, vec);				\
-	EXCEPTION_PROLOG_2 label, h
+	EXCEPTION_PROLOG_2 label, h, 1
 
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 /*
@@ -442,7 +421,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 #define EXCEPTION_PROLOG_NORI(area, label, h, extra, vec)		\
 	EXCEPTION_PROLOG_0(area);					\
 	EXCEPTION_PROLOG_1(area, extra, vec);				\
-	EXCEPTION_PROLOG_2_NORI label, h
+	EXCEPTION_PROLOG_2 label, h, 0
 
 #ifdef CONFIG_KVM_BOOK3S_64_HANDLER
 .macro KVMTEST hsrr, n
@@ -598,14 +577,14 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 
 #define STD_EXCEPTION_OOL(vec, label)				\
 	EXCEPTION_PROLOG_1(PACA_EXGEN, KVMTEST_PR, vec);	\
-	EXCEPTION_PROLOG_2 label, EXC_STD
+	EXCEPTION_PROLOG_2 label, EXC_STD, 1
 
 #define STD_EXCEPTION_HV(loc, vec, label)			\
 	EXCEPTION_PROLOG(PACA_EXGEN, label, EXC_HV, KVMTEST_HV, vec)
 
 #define STD_EXCEPTION_HV_OOL(vec, label)			\
 	EXCEPTION_PROLOG_1(PACA_EXGEN, KVMTEST_HV, vec);	\
-	EXCEPTION_PROLOG_2 label, EXC_HV
+	EXCEPTION_PROLOG_2 label, EXC_HV, 1
 
 #define STD_RELON_EXCEPTION(loc, vec, label)		\
 	/* No guest interrupts come through here */	\
@@ -669,21 +648,21 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	SET_SCRATCH0(r13);    /* save r13 */				\
 	EXCEPTION_PROLOG_0(PACA_EXGEN);					\
 	MASKABLE_EXCEPTION_PROLOG_1(PACA_EXGEN, extra, vec, bitmask);	\
-	EXCEPTION_PROLOG_2 label, h
+	EXCEPTION_PROLOG_2 label, h, 1
 
 #define MASKABLE_EXCEPTION(vec, label, bitmask)				\
 	__MASKABLE_EXCEPTION(vec, label, EXC_STD, SOFTEN_TEST_PR, bitmask)
 
 #define MASKABLE_EXCEPTION_OOL(vec, label, bitmask)			\
 	MASKABLE_EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_TEST_PR, vec, bitmask);\
-	EXCEPTION_PROLOG_2 label, EXC_STD
+	EXCEPTION_PROLOG_2 label, EXC_STD, 1
 
 #define MASKABLE_EXCEPTION_HV(vec, label, bitmask)			\
 	__MASKABLE_EXCEPTION(vec, label, EXC_HV, SOFTEN_TEST_HV, bitmask)
 
 #define MASKABLE_EXCEPTION_HV_OOL(vec, label, bitmask)			\
 	MASKABLE_EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_TEST_HV, vec, bitmask);\
-	EXCEPTION_PROLOG_2 label, EXC_HV
+	EXCEPTION_PROLOG_2 label, EXC_HV, 1
 
 #define __MASKABLE_RELON_EXCEPTION(vec, label, h, extra, bitmask)	\
 	SET_SCRATCH0(r13);    /* save r13 */				\
@@ -696,7 +675,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 
 #define MASKABLE_RELON_EXCEPTION_OOL(vec, label, bitmask)		\
 	MASKABLE_EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_NOTEST_PR, vec, bitmask);\
-	EXCEPTION_PROLOG_2 label, EXC_STD
+	EXCEPTION_PROLOG_2 label, EXC_STD, 1
 
 #define MASKABLE_RELON_EXCEPTION_HV(vec, label, bitmask)		\
 	__MASKABLE_RELON_EXCEPTION(vec, label, EXC_HV, SOFTEN_TEST_HV, bitmask)
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index a50598c295f2..384439ef5c77 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -341,7 +341,7 @@ machine_check_pSeries_0:
 	 * nested machine check corrupts it. machine_check_common enables
 	 * MSR_RI.
 	 */
-	EXCEPTION_PROLOG_2_NORI machine_check_common, EXC_STD
+	EXCEPTION_PROLOG_2 machine_check_common, EXC_STD, 0
 
 TRAMP_KVM_SKIP(PACA_EXMC, 0x200)
 
@@ -1240,7 +1240,7 @@ EXC_REAL_BEGIN(denorm_exception_hv, 0x1500, 0x100)
 #endif
 
 	KVMTEST_HV(0x1500)
-	EXCEPTION_PROLOG_2 denorm_common, EXC_HV
+	EXCEPTION_PROLOG_2 denorm_common, EXC_HV, 1
 EXC_REAL_END(denorm_exception_hv, 0x1500, 0x100)
 
 #ifdef CONFIG_PPC_DENORMALISATION
@@ -1362,7 +1362,7 @@ EXC_VIRT_NONE(0x5800, 0x100)
 	std	r12,PACA_EXGEN+EX_R12(r13);		\
 	GET_SCRATCH0(r10);				\
 	std	r10,PACA_EXGEN+EX_R13(r13);		\
-	EXCEPTION_PROLOG_2 soft_nmi_common, _H
+	EXCEPTION_PROLOG_2 soft_nmi_common, _H, 1
 
 /*
  * Branch to soft_nmi_interrupt using the emergency stack. The emergency
-- 
2.18.0

