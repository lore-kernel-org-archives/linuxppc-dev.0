Return-Path: <SRS0=3S3E=UK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB7CC43218
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Jun 2019 14:49:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D368E2054F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Jun 2019 14:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cc9Ck6P8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D368E2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45NXvW13R0zDq7c
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Jun 2019 00:49:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Cc9Ck6P8"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45NXYn1XbxzDqL2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jun 2019 00:33:48 +1000 (AEST)
Received: by mail-pg1-x543.google.com with SMTP id 20so7092893pgr.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jun 2019 07:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NjCvLFOtU9i9FT3zHzMhgnil1zbdOKRxQG0hqy7OAXE=;
 b=Cc9Ck6P83vHIlyG0+CvsBFzuLOHpm/mzstI129AirVxPA7p/oizejVrNy0HH3WCjNt
 hT61UoqKD5p/UyNjgRTV1YOv+enGXmfLrNJClQ7YXAvKywuVk8qEXKkOxh2VW3rQP4Kf
 cQwygtTbkJ358s4ojTPibmM7hc5RT248fQo7LiPcOAqCdVGz4x7ZcYJPZ26URWq8BpD8
 YIuSUfkW7L66DvJQ11chcavrcEBSWPgBek5p0GtwL/8phOdhocUWY9mIO0N1E9gUb9n4
 wMKSP4jN+/rQHGvtVvM6E0bc5gByM/ihoopV3PFIWLhr8vhgorNbwI/P6AK55os8htMt
 aUSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NjCvLFOtU9i9FT3zHzMhgnil1zbdOKRxQG0hqy7OAXE=;
 b=CORBNbKVUVIcvCLeTs244/0t8uQpGJ5wzMxwgxewLC/DMdMxpgkXVY7+by/fjppFgO
 AQFSmNJwu+kulWWBtfIoOnc5pSMUERVFNdvm9v631IV6JjsbFxPZO4cVY/TKKkYGBNKs
 2+UZ7XqjWsu7lGeTeFrU1tkFg0AjYdn7hmsKn72nhkVHER9iy0O2OSno5wJQ6gEqdNlv
 MNEptpd6/51jwjNyB2KZdT0P4qqId/uO0ZLGIqBse73aENs9rX1FBZWMlDEwGwGgXnA5
 ujrxrSW1RSJ5NAe3iXRiIOfkvMXgmpTbBBDwoe5+c7yUchujZPXE808oXFt51rJQfxuD
 LFXw==
X-Gm-Message-State: APjAAAUul2W/y5i+Znm+gYw3cT4zbZwFhWTWbeNrM2sIP94Jst0adQsA
 l2SJcutAQgNY56VkpTZCduY9gxsU
X-Google-Smtp-Source: APXvYqwOzD93cnoZzwxHDnw8IWYoFDgsIrddKdMuK5ijA5Bk81z/JaaqR+LN4xsqQj4R7H1mzUZ6VA==
X-Received: by 2002:a17:90a:7146:: with SMTP id
 g6mr27073529pjs.45.1560263626383; 
 Tue, 11 Jun 2019 07:33:46 -0700 (PDT)
Received: from bobo.local0.net (242.60.168.202.static.comindico.com.au.
 [202.168.60.242])
 by smtp.gmail.com with ESMTPSA id a16sm25345568pfd.68.2019.06.11.07.33.44
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 11 Jun 2019 07:33:45 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 03/28] powerpc/64s/exception: consolidate EXCEPTION_PROLOG_2
 with _NORI variant
Date: Wed, 12 Jun 2019 00:30:15 +1000
Message-Id: <20190611143040.7834-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611143040.7834-1-npiggin@gmail.com>
References: <20190611143040.7834-1-npiggin@gmail.com>
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
Cc: Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Switch to a gas macro that conditionally expands the RI clearing
instruction.

No generated code change.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/exception-64s.h | 43 ++++++------------------
 arch/powerpc/kernel/exceptions-64s.S     | 12 +++----
 2 files changed, 17 insertions(+), 38 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 1496e4089cee..94c4992188a7 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -319,32 +319,11 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
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
@@ -369,7 +348,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	SET_SCRATCH0(r13);		/* save r13 */			\
 	EXCEPTION_PROLOG_0(area);					\
 	EXCEPTION_PROLOG_1(area, extra, vec);				\
-	EXCEPTION_PROLOG_2 label, h
+	EXCEPTION_PROLOG_2 label, h, 1
 
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 /*
@@ -438,7 +417,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 #define EXCEPTION_PROLOG_NORI(area, label, h, extra, vec)		\
 	EXCEPTION_PROLOG_0(area);					\
 	EXCEPTION_PROLOG_1(area, extra, vec);				\
-	EXCEPTION_PROLOG_2_NORI label, h
+	EXCEPTION_PROLOG_2 label, h, 0
 
 #ifdef CONFIG_KVM_BOOK3S_64_HANDLER
 .macro KVMTEST hsrr, n
@@ -595,14 +574,14 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 
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
@@ -666,21 +645,21 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
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
@@ -693,7 +672,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 
 #define MASKABLE_RELON_EXCEPTION_OOL(vec, label, bitmask)		\
 	MASKABLE_EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_NOTEST_PR, vec, bitmask);\
-	EXCEPTION_PROLOG_2 label, EXC_STD
+	EXCEPTION_PROLOG_2 label, EXC_STD, 1
 
 #define MASKABLE_RELON_EXCEPTION_HV(vec, label, bitmask)		\
 	__MASKABLE_RELON_EXCEPTION(vec, label, EXC_HV, SOFTEN_TEST_HV, bitmask)
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 65d3eecdef53..75becb248d61 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -356,7 +356,7 @@ machine_check_pSeries_0:
 	 * nested machine check corrupts it. machine_check_common enables
 	 * MSR_RI.
 	 */
-	EXCEPTION_PROLOG_2_NORI machine_check_common, EXC_STD
+	EXCEPTION_PROLOG_2 machine_check_common, EXC_STD, 0
 
 TRAMP_KVM_SKIP(PACA_EXMC, 0x200)
 
@@ -598,7 +598,7 @@ EXCEPTION_PROLOG_1(PACA_EXGEN, KVMTEST_PR, 0x300)
 	mfspr	r11,SPRN_DSISR
 	std	r10,PACA_EXGEN+EX_DAR(r13)
 	stw	r11,PACA_EXGEN+EX_DSISR(r13)
-EXCEPTION_PROLOG_2 data_access_common, EXC_STD
+EXCEPTION_PROLOG_2 data_access_common, EXC_STD, 1
 
 EXC_VIRT_BEGIN(data_access, 0x4300, 0x80)
 SET_SCRATCH0(r13)		/* save r13 */
@@ -645,7 +645,7 @@ TRAMP_REAL_BEGIN(tramp_real_data_access_slb)
 EXCEPTION_PROLOG_1(PACA_EXSLB, KVMTEST_PR, 0x380)
 	mfspr	r10,SPRN_DAR
 	std	r10,PACA_EXSLB+EX_DAR(r13)
-EXCEPTION_PROLOG_2 data_access_slb_common, EXC_STD
+EXCEPTION_PROLOG_2 data_access_slb_common, EXC_STD, 1
 
 EXC_VIRT_BEGIN(data_access_slb, 0x4380, 0x80)
 SET_SCRATCH0(r13)		/* save r13 */
@@ -774,7 +774,7 @@ EXCEPTION_PROLOG_1(PACA_EXGEN, KVMTEST_PR, 0x600)
 	mfspr	r11,SPRN_DSISR
 	std	r10,PACA_EXGEN+EX_DAR(r13)
 	stw	r11,PACA_EXGEN+EX_DSISR(r13)
-EXCEPTION_PROLOG_2 alignment_common, EXC_STD
+EXCEPTION_PROLOG_2 alignment_common, EXC_STD, 1
 EXC_REAL_END(alignment, 0x600, 0x100)
 
 EXC_VIRT_BEGIN(alignment, 0x4600, 0x100)
@@ -1320,7 +1320,7 @@ EXC_REAL_BEGIN(denorm_exception_hv, 0x1500, 0x100)
 #endif
 
 	KVMTEST_HV(0x1500)
-	EXCEPTION_PROLOG_2 denorm_common, EXC_HV
+	EXCEPTION_PROLOG_2 denorm_common, EXC_HV, 1
 EXC_REAL_END(denorm_exception_hv, 0x1500, 0x100)
 
 #ifdef CONFIG_PPC_DENORMALISATION
@@ -1442,7 +1442,7 @@ EXC_VIRT_NONE(0x5800, 0x100)
 	std	r12,PACA_EXGEN+EX_R12(r13);		\
 	GET_SCRATCH0(r10);				\
 	std	r10,PACA_EXGEN+EX_R13(r13);		\
-	EXCEPTION_PROLOG_2 soft_nmi_common, _H
+	EXCEPTION_PROLOG_2 soft_nmi_common, _H, 1
 
 /*
  * Branch to soft_nmi_interrupt using the emergency stack. The emergency
-- 
2.20.1

