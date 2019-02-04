Return-Path: <SRS0=Z4Cu=QL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A9D2C282C4
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 14:38:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17E8F2083B
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 14:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLjWVe9S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17E8F2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43tVgz0MwHzDq9W
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 01:38:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="JLjWVe9S"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43tVFJ1qjnzDqDF
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2019 01:19:00 +1100 (AEDT)
Received: by mail-pl1-x644.google.com with SMTP id g9so4837plo.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Feb 2019 06:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=vKZamrRpPj3m1T0jkukO3dRfLApDa+CDV+to++p6xyY=;
 b=JLjWVe9S4oRAzytpbDNCiPZyU/BZMjrAOEQECop79Ir020Tf42dGpj4bdl63G6si6l
 ccxaLBc3+tM1tjzBreF26z/uDQgNBNs5u6HXpP1AvHdJjkUXc3AZDiPflUcDUIY38C3X
 Lxu6MfIIZk5P27Q+V1Fi0iU8uFQqaQfYSLod2sT2ifvJ8ebR3CH50KGr105RpV6972g2
 zVtKzeT7Ehwf8qd6DvjuDy5ciLyLD808TNGRK6gKc/Q4kOeZne4ge83GErcJYLt5xFnB
 w8CRj6MGoQkIc6p9teQzZ9KvvHaI6NwP6sIintetAwoyT7giCWu91Q768av8eXOmUlad
 6bqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=vKZamrRpPj3m1T0jkukO3dRfLApDa+CDV+to++p6xyY=;
 b=C7OHwDDvAmfXGvTmjmfr1yZJh16+6CNh+YolM/qjQdS/Mr7SmAi4de8+itBgkHZbVy
 JAnMNR1tY5HdU+W202fmF7n3nW0bI468hgv9welL/CU2rwDRikA+VXGT7ZWI8mNb5dEx
 wunPndShACxbLuP9f4S+hrk5O8YOD0uFZXyVAC1BivUKazfnIz8LmzBUymAQBpjx6KDO
 IkGOK/8nyTUhk2kzTAzaeGtmhZAau5huXPSvopdzTal06zPinwxZZFpfep2gMQgmi56b
 rLqpfIUDuHf3EbrDfqNoUy7ijApyD3tD75AikJz5dVf7bT2GkPNbaAeEvCo9ibxxdCAQ
 +MEw==
X-Gm-Message-State: AHQUAuYDXrVu+MF9BLVZwqLk/sJ1QZQgCNhiCoPwrzBHH8G4uj+0SnIJ
 RQYyuF3mIOMZ9Nj2db+Bsmpx53UE
X-Google-Smtp-Source: AHgI3IYArM/a0AizpM1YgMnEcPeVj4l5Wds3SAAxoMoDS7hDMF+mmUE06gMLhv/cR56V86RCOtP2Ww==
X-Received: by 2002:a17:902:8c91:: with SMTP id
 t17mr4005117plo.212.1549289938409; 
 Mon, 04 Feb 2019 06:18:58 -0800 (PST)
Received: from roar.local0.net ([210.185.78.69])
 by smtp.gmail.com with ESMTPSA id h9sm226230pgd.53.2019.02.04.06.18.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 04 Feb 2019 06:18:57 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 09/17] powerpc/64s/exception: Make EXCEPTION_PROLOG_0 a gas
 macro for consistency with others
Date: Tue,  5 Feb 2019 00:18:20 +1000
Message-Id: <20190204141828.13043-10-npiggin@gmail.com>
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

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/exception-64s.h | 25 ++++++++++++------------
 arch/powerpc/kernel/exceptions-64s.S     | 12 ++++++------
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index c78d9b1bf22d..35efb46c6f5f 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -237,7 +237,7 @@
  */
 #define EXCEPTION_RELON_PROLOG(area, label, hsrr, kvm, vec)		\
 	SET_SCRATCH0(r13);		/* save r13 */			\
-	EXCEPTION_PROLOG_0(area);					\
+	EXCEPTION_PROLOG_0 area ;					\
 	EXCEPTION_PROLOG_1 hsrr, area, kvm, vec, 0 ;			\
 	EXCEPTION_PROLOG_2_VIRT label, hsrr
 
@@ -301,13 +301,14 @@ BEGIN_FTR_SECTION_NESTED(943)						\
 	std	ra,offset(r13);						\
 END_FTR_SECTION_NESTED(ftr,ftr,943)
 
-#define EXCEPTION_PROLOG_0(area)					\
-	GET_PACA(r13);							\
-	std	r9,area+EX_R9(r13);	/* save r9 */			\
-	OPT_GET_SPR(r9, SPRN_PPR, CPU_FTR_HAS_PPR);			\
-	HMT_MEDIUM;							\
-	std	r10,area+EX_R10(r13);	/* save r10 - r12 */		\
+.macro EXCEPTION_PROLOG_0 area
+	GET_PACA(r13)
+	std	r9,\area\()+EX_R9(r13)		/* save r9 */
+	OPT_GET_SPR(r9, SPRN_PPR, CPU_FTR_HAS_PPR)
+	HMT_MEDIUM
+	std	r10,\area\()+EX_R10(r13)	/* save r10 - r12 */
 	OPT_GET_SPR(r10, SPRN_CFAR, CPU_FTR_CFAR)
+.endm
 
 .macro EXCEPTION_PROLOG_1 hsrr, area, kvm, vec, bitmask
 	OPT_SAVE_REG_TO_PACA(\area\()+EX_PPR, r9, CPU_FTR_HAS_PPR)
@@ -351,7 +352,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 
 #define EXCEPTION_PROLOG(area, label, hsrr, kvm, vec)			\
 	SET_SCRATCH0(r13);		/* save r13 */			\
-	EXCEPTION_PROLOG_0(area);					\
+	EXCEPTION_PROLOG_0 area	;					\
 	EXCEPTION_PROLOG_1 hsrr, area, kvm, vec, 0 ;			\
 	EXCEPTION_PROLOG_2_REAL label, hsrr, 1
 
@@ -420,7 +421,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 
 /* Do not enable RI */
 #define EXCEPTION_PROLOG_NORI(area, label, hsrr, kvm, vec)		\
-	EXCEPTION_PROLOG_0(area);					\
+	EXCEPTION_PROLOG_0 area ;					\
 	EXCEPTION_PROLOG_1 hsrr, area, kvm, vec, 0 ;			\
 	EXCEPTION_PROLOG_2_REAL label, hsrr, 0
 
@@ -568,7 +569,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 /* Version of above for when we have to branch out-of-line */
 #define __OOL_EXCEPTION(vec, label, hdlr)			\
 	SET_SCRATCH0(r13);					\
-	EXCEPTION_PROLOG_0(PACA_EXGEN);				\
+	EXCEPTION_PROLOG_0 PACA_EXGEN ;				\
 	b hdlr
 
 #define STD_EXCEPTION_OOL(vec, label)				\
@@ -599,7 +600,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 
 #define __MASKABLE_EXCEPTION(vec, label, hsrr, kvm, bitmask)		\
 	SET_SCRATCH0(r13);    /* save r13 */				\
-	EXCEPTION_PROLOG_0(PACA_EXGEN);					\
+	EXCEPTION_PROLOG_0 PACA_EXGEN ;					\
 	EXCEPTION_PROLOG_1 hsrr, PACA_EXGEN, kvm, vec, bitmask ;	\
 	EXCEPTION_PROLOG_2_REAL label, hsrr, 1
 
@@ -619,7 +620,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 
 #define __MASKABLE_RELON_EXCEPTION(vec, label, hsrr, kvm, bitmask)	\
 	SET_SCRATCH0(r13);    /* save r13 */				\
-	EXCEPTION_PROLOG_0(PACA_EXGEN);					\
+	EXCEPTION_PROLOG_0 PACA_EXGEN ;					\
 	EXCEPTION_PROLOG_1 hsrr, PACA_EXGEN, kvm, vec, bitmask ;	\
 	EXCEPTION_PROLOG_2_VIRT label, hsrr
 
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index ebec428f8791..d6316725a43b 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -100,7 +100,7 @@ EXC_VIRT_NONE(0x4000, 0x100)
 
 EXC_REAL_BEGIN(system_reset, 0x100, 0x100)
 	SET_SCRATCH0(r13)
-	EXCEPTION_PROLOG_0(PACA_EXNMI)
+	EXCEPTION_PROLOG_0 PACA_EXNMI
 
 	/* This is EXCEPTION_PROLOG_1 with the idle feature section added */
 	OPT_SAVE_REG_TO_PACA(PACA_EXNMI+EX_PPR, r9, CPU_FTR_HAS_PPR)
@@ -251,7 +251,7 @@ EXC_REAL_BEGIN(machine_check, 0x200, 0x100)
 	 * vector
 	 */
 	SET_SCRATCH0(r13)		/* save r13 */
-	EXCEPTION_PROLOG_0(PACA_EXMC)
+	EXCEPTION_PROLOG_0 PACA_EXMC
 BEGIN_FTR_SECTION
 	b	machine_check_common_early
 FTR_SECTION_ELSE
@@ -339,7 +339,7 @@ TRAMP_REAL_BEGIN(machine_check_pSeries)
 	.globl machine_check_fwnmi
 machine_check_fwnmi:
 	SET_SCRATCH0(r13)		/* save r13 */
-	EXCEPTION_PROLOG_0(PACA_EXMC)
+	EXCEPTION_PROLOG_0 PACA_EXMC
 BEGIN_FTR_SECTION
 	b	machine_check_common_early
 END_FTR_SECTION_IFCLR(CPU_FTR_HVMODE)
@@ -552,7 +552,7 @@ ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
 	/* Deliver the machine check to host kernel in V mode. */
 	MACHINE_CHECK_HANDLER_WINDUP
 	SET_SCRATCH0(r13)		/* save r13 */
-	EXCEPTION_PROLOG_0(PACA_EXMC)
+	EXCEPTION_PROLOG_0 PACA_EXMC
 	b	machine_check_pSeries_0
 
 EXC_COMMON_BEGIN(unrecover_mce)
@@ -1086,7 +1086,7 @@ TRAMP_REAL_BEGIN(hmi_exception_early)
 	.globl hmi_exception_after_realmode
 hmi_exception_after_realmode:
 	SET_SCRATCH0(r13)
-	EXCEPTION_PROLOG_0(PACA_EXGEN)
+	EXCEPTION_PROLOG_0 PACA_EXGEN
 	b	tramp_real_hmi_exception
 
 EXC_COMMON_BEGIN(hmi_exception_common)
@@ -1239,7 +1239,7 @@ EXC_VIRT_NONE(0x5400, 0x100)
 
 EXC_REAL_BEGIN(denorm_exception_hv, 0x1500, 0x100)
 	mtspr	SPRN_SPRG_HSCRATCH0,r13
-	EXCEPTION_PROLOG_0(PACA_EXGEN)
+	EXCEPTION_PROLOG_0 PACA_EXGEN
 	EXCEPTION_PROLOG_1 EXC_HV, PACA_EXGEN, 0, 0x1500, 0
 
 #ifdef CONFIG_PPC_DENORMALISATION
-- 
2.18.0

