Return-Path: <SRS0=Z4Cu=QL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C07C282C4
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 14:22:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 613C82082E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 14:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8wnpmJE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 613C82082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43tVJn2201zDqDD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 01:22:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q8wnpmJE"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43tVDy3G3GzDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2019 01:18:42 +1100 (AEDT)
Received: by mail-pl1-x641.google.com with SMTP id 101so6863727pld.6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Feb 2019 06:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Qei9md5QOsJTsZoxKClRA4icRrAfCQh3pYTFs8fyJjU=;
 b=Q8wnpmJE7CWl9qyBbkxoxO7XmV9ZVcuG6jgdzTR4X68y6XQqQyjUFtmyROBltsXsuv
 MT9ha47tT9HQ9/wRr92pmnsiOm0bz98XxFIvfMRjalD2sIKpAIllxQuDVLv8gDdpEAxC
 H2S4urYNBhrt11PMdB20AEjI9x9+X+OmluFbRgv6S/7GJIMNgCpRoepiFXHY/CrcHrZr
 3jFJXHbILiPx2j7mxA6IJSeTAhwhnspLx3Yvb5/EXX7ZQpLRG0La6/IDxr3rlQRB80Ih
 sXbdOM9nmC233NrXyPcp8yMizK8LzFHmYsI/aDwjvCG/ihp5pQxZfsPknVfN3RJg7iJ3
 vZDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Qei9md5QOsJTsZoxKClRA4icRrAfCQh3pYTFs8fyJjU=;
 b=CoHkG3/ll+cbaSrrdUvbbGHhhyKbmPFy/btBUWqmGo2Fpyp3HQY9RbW58VjhlBy7Ny
 BzRaHadeDOH46sM+Xsv2r/+lkPp2J+NbZ1ygaZfhhHCGZLP0JlDn3xQ8Mu6wavS1LhX2
 3SKCUOlDDq9lyPk0lKl/DuFlcAy8CtaK1oVfNnfffsZUqB0RWsOeYPhZghB0m3TGKTTp
 6uRccGYgerWGh4hcWaamPziHf1TiKByAq/R3z8HHGF12EbsnzanZ3bkzmptJGhSg+C5u
 ZC7s3+ToItZu67FWU7dtjKUGJ38fQGC7cIQUjaU8jNVNa18Of9ZghhEK8w+hn5E9qJ7p
 j4vw==
X-Gm-Message-State: AJcUukcfMZJ/5wB+z2qYkP7b0rbk2QZYvz/nEjKqUyLZftcqoASBHhb1
 Wj131rZYn1DWAs0UPYMU3gMXfAwi
X-Google-Smtp-Source: ALg8bN4zPerQcRR1WHfltZfClaNZ8i3k/aING9Dx1TH+pg8MZE0G2j0mULcKX7i7MCEiY5jKwFRmlw==
X-Received: by 2002:a17:902:9a98:: with SMTP id
 w24mr51870353plp.213.1549289920301; 
 Mon, 04 Feb 2019 06:18:40 -0800 (PST)
Received: from roar.local0.net ([210.185.78.69])
 by smtp.gmail.com with ESMTPSA id h9sm226230pgd.53.2019.02.04.06.18.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 04 Feb 2019 06:18:39 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 01/17] powerpc/64s/exception: fix some line wrap and semicolon
 inconsistencies in macros
Date: Tue,  5 Feb 2019 00:18:12 +1000
Message-Id: <20190204141828.13043-2-npiggin@gmail.com>
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

By convention, all lines should be separated by a semicolons. Last line
should have neithe semicolon or line wrap. Small cleanup before we begin.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/exception-64s.h | 36 ++++++-------
 arch/powerpc/include/asm/head-64.h       | 68 ++++++++++++------------
 2 files changed, 52 insertions(+), 52 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 3b4767ed3ec5..f78ff225cb64 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -189,11 +189,11 @@
  */
 #define LOAD_HANDLER(reg, label)					\
 	ld	reg,PACAKBASE(r13);	/* get high part of &label */	\
-	ori	reg,reg,FIXED_SYMBOL_ABS_ADDR(label);
+	ori	reg,reg,FIXED_SYMBOL_ABS_ADDR(label)
 
 #define __LOAD_HANDLER(reg, label)					\
 	ld	reg,PACAKBASE(r13);					\
-	ori	reg,reg,(ABS_ADDR(label))@l;
+	ori	reg,reg,(ABS_ADDR(label))@l
 
 /*
  * Branches from unrelocated code (e.g., interrupts) to labels outside
@@ -202,7 +202,7 @@
 #define __LOAD_FAR_HANDLER(reg, label)					\
 	ld	reg,PACAKBASE(r13);					\
 	ori	reg,reg,(ABS_ADDR(label))@l;				\
-	addis	reg,reg,(ABS_ADDR(label))@h;
+	addis	reg,reg,(ABS_ADDR(label))@h
 
 /* Exception register prefixes */
 #define EXC_HV	H
@@ -277,7 +277,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	OPT_SAVE_REG_TO_PACA(area+EX_CFAR, r10, CPU_FTR_CFAR);		\
 	INTERRUPT_TO_KERNEL;						\
 	SAVE_CTR(r10, area);						\
-	mfcr	r9;
+	mfcr	r9
 
 #define __EXCEPTION_PROLOG_1_POST(area)					\
 	std	r11,area+EX_R11(r13);					\
@@ -294,7 +294,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 #define MASKABLE_EXCEPTION_PROLOG_1(area, extra, vec, bitmask)			\
 	__EXCEPTION_PROLOG_1_PRE(area);					\
 	extra(vec, bitmask);						\
-	__EXCEPTION_PROLOG_1_POST(area);
+	__EXCEPTION_PROLOG_1_POST(area)
 
 /*
  * This version of the EXCEPTION_PROLOG_1 is intended
@@ -303,7 +303,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 #define _EXCEPTION_PROLOG_1(area, extra, vec)				\
 	__EXCEPTION_PROLOG_1_PRE(area);					\
 	extra(vec);							\
-	__EXCEPTION_PROLOG_1_POST(area);
+	__EXCEPTION_PROLOG_1_POST(area)
 
 #define EXCEPTION_PROLOG_1(area, extra, vec)				\
 	_EXCEPTION_PROLOG_1(area, extra, vec)
@@ -311,7 +311,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 #define __EXCEPTION_PROLOG_2(label, h)					\
 	ld	r10,PACAKMSR(r13);	/* get MSR value for kernel */	\
 	mfspr	r11,SPRN_##h##SRR0;	/* save SRR0 */			\
-	LOAD_HANDLER(r12,label)						\
+	LOAD_HANDLER(r12,label);					\
 	mtspr	SPRN_##h##SRR0,r12;					\
 	mfspr	r12,SPRN_##h##SRR1;	/* and SRR1 */			\
 	mtspr	SPRN_##h##SRR1,r10;					\
@@ -325,7 +325,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	ld	r10,PACAKMSR(r13);	/* get MSR value for kernel */	\
 	xori	r10,r10,MSR_RI;		/* Clear MSR_RI */		\
 	mfspr	r11,SPRN_##h##SRR0;	/* save SRR0 */			\
-	LOAD_HANDLER(r12,label)						\
+	LOAD_HANDLER(r12,label);					\
 	mtspr	SPRN_##h##SRR0,r12;					\
 	mfspr	r12,SPRN_##h##SRR1;	/* and SRR1 */			\
 	mtspr	SPRN_##h##SRR1,r10;					\
@@ -339,7 +339,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	SET_SCRATCH0(r13);		/* save r13 */			\
 	EXCEPTION_PROLOG_0(area);					\
 	EXCEPTION_PROLOG_1(area, extra, vec);				\
-	EXCEPTION_PROLOG_2(label, h);
+	EXCEPTION_PROLOG_2(label, h)
 
 #define __KVMTEST(h, n)							\
 	lbz	r10,HSTATE_IN_GUEST(r13);				\
@@ -413,7 +413,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 #define EXCEPTION_PROLOG_NORI(area, label, h, extra, vec)		\
 	EXCEPTION_PROLOG_0(area);					\
 	EXCEPTION_PROLOG_1(area, extra, vec);				\
-	EXCEPTION_PROLOG_2_NORI(label, h);
+	EXCEPTION_PROLOG_2_NORI(label, h)
 
 
 #define __KVM_HANDLER(area, h, n)					\
@@ -549,16 +549,16 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 
 /* Version of above for when we have to branch out-of-line */
 #define __OOL_EXCEPTION(vec, label, hdlr)			\
-	SET_SCRATCH0(r13)					\
-	EXCEPTION_PROLOG_0(PACA_EXGEN)				\
-	b hdlr;
+	SET_SCRATCH0(r13);					\
+	EXCEPTION_PROLOG_0(PACA_EXGEN);				\
+	b hdlr
 
 #define STD_EXCEPTION_OOL(vec, label)				\
 	EXCEPTION_PROLOG_1(PACA_EXGEN, KVMTEST_PR, vec);	\
 	EXCEPTION_PROLOG_2(label, EXC_STD)
 
 #define STD_EXCEPTION_HV(loc, vec, label)			\
-	EXCEPTION_PROLOG(PACA_EXGEN, label, EXC_HV, KVMTEST_HV, vec);
+	EXCEPTION_PROLOG(PACA_EXGEN, label, EXC_HV, KVMTEST_HV, vec)
 
 #define STD_EXCEPTION_HV_OOL(vec, label)			\
 	EXCEPTION_PROLOG_1(PACA_EXGEN, KVMTEST_HV, vec);	\
@@ -566,14 +566,14 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 
 #define STD_RELON_EXCEPTION(loc, vec, label)		\
 	/* No guest interrupts come through here */	\
-	EXCEPTION_RELON_PROLOG(PACA_EXGEN, label, EXC_STD, NOTEST, vec);
+	EXCEPTION_RELON_PROLOG(PACA_EXGEN, label, EXC_STD, NOTEST, vec)
 
 #define STD_RELON_EXCEPTION_OOL(vec, label)			\
 	EXCEPTION_PROLOG_1(PACA_EXGEN, NOTEST, vec);		\
 	EXCEPTION_PROLOG_2_RELON(label, EXC_STD)
 
 #define STD_RELON_EXCEPTION_HV(loc, vec, label)		\
-	EXCEPTION_RELON_PROLOG(PACA_EXGEN, label, EXC_HV, KVMTEST_HV, vec);
+	EXCEPTION_RELON_PROLOG(PACA_EXGEN, label, EXC_HV, KVMTEST_HV, vec)
 
 #define STD_RELON_EXCEPTION_HV_OOL(vec, label)			\
 	EXCEPTION_PROLOG_1(PACA_EXGEN, KVMTEST_HV, vec);	\
@@ -618,7 +618,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	SET_SCRATCH0(r13);    /* save r13 */				\
 	EXCEPTION_PROLOG_0(PACA_EXGEN);					\
 	MASKABLE_EXCEPTION_PROLOG_1(PACA_EXGEN, extra, vec, bitmask);	\
-	EXCEPTION_PROLOG_2(label, h);
+	EXCEPTION_PROLOG_2(label, h)
 
 #define MASKABLE_EXCEPTION(vec, label, bitmask)				\
 	__MASKABLE_EXCEPTION(vec, label, EXC_STD, SOFTEN_TEST_PR, bitmask)
@@ -645,7 +645,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 
 #define MASKABLE_RELON_EXCEPTION_OOL(vec, label, bitmask)		\
 	MASKABLE_EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_NOTEST_PR, vec, bitmask);\
-	EXCEPTION_PROLOG_2(label, EXC_STD);
+	EXCEPTION_PROLOG_2(label, EXC_STD)
 
 #define MASKABLE_RELON_EXCEPTION_HV(vec, label, bitmask)		\
 	__MASKABLE_RELON_EXCEPTION(vec, label, EXC_HV, SOFTEN_TEST_HV, bitmask)
diff --git a/arch/powerpc/include/asm/head-64.h b/arch/powerpc/include/asm/head-64.h
index a4f947888744..e34b3d06bf61 100644
--- a/arch/powerpc/include/asm/head-64.h
+++ b/arch/powerpc/include/asm/head-64.h
@@ -255,135 +255,135 @@ end_##sname:
 
 #define EXC_VIRT_NONE(start, size)				\
 	FIXED_SECTION_ENTRY_BEGIN_LOCATION(virt_vectors, exc_virt_##start##_##unused, start, size); \
-	FIXED_SECTION_ENTRY_END_LOCATION(virt_vectors, exc_virt_##start##_##unused, start, size);
+	FIXED_SECTION_ENTRY_END_LOCATION(virt_vectors, exc_virt_##start##_##unused, start, size)
 
 
 #define EXC_REAL(name, start, size)					\
 	EXC_REAL_BEGIN(name, start, size);				\
 	STD_EXCEPTION(start, name##_common);				\
-	EXC_REAL_END(name, start, size);
+	EXC_REAL_END(name, start, size)
 
 #define EXC_VIRT(name, start, size, realvec)				\
 	EXC_VIRT_BEGIN(name, start, size);				\
 	STD_RELON_EXCEPTION(start, realvec, name##_common);		\
-	EXC_VIRT_END(name, start, size);
+	EXC_VIRT_END(name, start, size)
 
 #define EXC_REAL_MASKABLE(name, start, size, bitmask)			\
 	EXC_REAL_BEGIN(name, start, size);				\
 	MASKABLE_EXCEPTION(start, name##_common, bitmask);		\
-	EXC_REAL_END(name, start, size);
+	EXC_REAL_END(name, start, size)
 
 #define EXC_VIRT_MASKABLE(name, start, size, realvec, bitmask)		\
 	EXC_VIRT_BEGIN(name, start, size);				\
 	MASKABLE_RELON_EXCEPTION(realvec, name##_common, bitmask);	\
-	EXC_VIRT_END(name, start, size);
+	EXC_VIRT_END(name, start, size)
 
 #define EXC_REAL_HV(name, start, size)					\
 	EXC_REAL_BEGIN(name, start, size);				\
 	STD_EXCEPTION_HV(start, start, name##_common);			\
-	EXC_REAL_END(name, start, size);
+	EXC_REAL_END(name, start, size)
 
 #define EXC_VIRT_HV(name, start, size, realvec)				\
 	EXC_VIRT_BEGIN(name, start, size);				\
 	STD_RELON_EXCEPTION_HV(start, realvec, name##_common);		\
-	EXC_VIRT_END(name, start, size);
+	EXC_VIRT_END(name, start, size)
 
 #define __EXC_REAL_OOL(name, start, size)				\
 	EXC_REAL_BEGIN(name, start, size);				\
 	__OOL_EXCEPTION(start, label, tramp_real_##name);		\
-	EXC_REAL_END(name, start, size);
+	EXC_REAL_END(name, start, size)
 
 #define __TRAMP_REAL_OOL(name, vec)					\
 	TRAMP_REAL_BEGIN(tramp_real_##name);				\
-	STD_EXCEPTION_OOL(vec, name##_common);
+	STD_EXCEPTION_OOL(vec, name##_common)
 
 #define EXC_REAL_OOL(name, start, size)					\
 	__EXC_REAL_OOL(name, start, size);				\
-	__TRAMP_REAL_OOL(name, start);
+	__TRAMP_REAL_OOL(name, start)
 
 #define __EXC_REAL_OOL_MASKABLE(name, start, size)			\
-	__EXC_REAL_OOL(name, start, size);
+	__EXC_REAL_OOL(name, start, size)
 
 #define __TRAMP_REAL_OOL_MASKABLE(name, vec, bitmask)			\
 	TRAMP_REAL_BEGIN(tramp_real_##name);				\
-	MASKABLE_EXCEPTION_OOL(vec, name##_common, bitmask);
+	MASKABLE_EXCEPTION_OOL(vec, name##_common, bitmask)
 
 #define EXC_REAL_OOL_MASKABLE(name, start, size, bitmask)		\
 	__EXC_REAL_OOL_MASKABLE(name, start, size);			\
-	__TRAMP_REAL_OOL_MASKABLE(name, start, bitmask);
+	__TRAMP_REAL_OOL_MASKABLE(name, start, bitmask)
 
 #define __EXC_REAL_OOL_HV_DIRECT(name, start, size, handler)		\
 	EXC_REAL_BEGIN(name, start, size);				\
 	__OOL_EXCEPTION(start, label, handler);				\
-	EXC_REAL_END(name, start, size);
+	EXC_REAL_END(name, start, size)
 
 #define __EXC_REAL_OOL_HV(name, start, size)				\
-	__EXC_REAL_OOL(name, start, size);
+	__EXC_REAL_OOL(name, start, size)
 
 #define __TRAMP_REAL_OOL_HV(name, vec)					\
 	TRAMP_REAL_BEGIN(tramp_real_##name);				\
-	STD_EXCEPTION_HV_OOL(vec, name##_common);			\
+	STD_EXCEPTION_HV_OOL(vec, name##_common)
 
 #define EXC_REAL_OOL_HV(name, start, size)				\
 	__EXC_REAL_OOL_HV(name, start, size);				\
-	__TRAMP_REAL_OOL_HV(name, start);
+	__TRAMP_REAL_OOL_HV(name, start)
 
 #define __EXC_REAL_OOL_MASKABLE_HV(name, start, size)			\
-	__EXC_REAL_OOL(name, start, size);
+	__EXC_REAL_OOL(name, start, size)
 
 #define __TRAMP_REAL_OOL_MASKABLE_HV(name, vec, bitmask)		\
 	TRAMP_REAL_BEGIN(tramp_real_##name);				\
-	MASKABLE_EXCEPTION_HV_OOL(vec, name##_common, bitmask);		\
+	MASKABLE_EXCEPTION_HV_OOL(vec, name##_common, bitmask)
 
 #define EXC_REAL_OOL_MASKABLE_HV(name, start, size, bitmask)		\
 	__EXC_REAL_OOL_MASKABLE_HV(name, start, size);			\
-	__TRAMP_REAL_OOL_MASKABLE_HV(name, start, bitmask);
+	__TRAMP_REAL_OOL_MASKABLE_HV(name, start, bitmask)
 
 #define __EXC_VIRT_OOL(name, start, size)				\
 	EXC_VIRT_BEGIN(name, start, size);				\
 	__OOL_EXCEPTION(start, label, tramp_virt_##name);		\
-	EXC_VIRT_END(name, start, size);
+	EXC_VIRT_END(name, start, size)
 
 #define __TRAMP_VIRT_OOL(name, realvec)					\
 	TRAMP_VIRT_BEGIN(tramp_virt_##name);				\
-	STD_RELON_EXCEPTION_OOL(realvec, name##_common);
+	STD_RELON_EXCEPTION_OOL(realvec, name##_common)
 
 #define EXC_VIRT_OOL(name, start, size, realvec)			\
 	__EXC_VIRT_OOL(name, start, size);				\
-	__TRAMP_VIRT_OOL(name, realvec);
+	__TRAMP_VIRT_OOL(name, realvec)
 
 #define __EXC_VIRT_OOL_MASKABLE(name, start, size)			\
-	__EXC_VIRT_OOL(name, start, size);
+	__EXC_VIRT_OOL(name, start, size)
 
 #define __TRAMP_VIRT_OOL_MASKABLE(name, realvec, bitmask)		\
 	TRAMP_VIRT_BEGIN(tramp_virt_##name);				\
-	MASKABLE_RELON_EXCEPTION_OOL(realvec, name##_common, bitmask);
+	MASKABLE_RELON_EXCEPTION_OOL(realvec, name##_common, bitmask)
 
 #define EXC_VIRT_OOL_MASKABLE(name, start, size, realvec, bitmask)	\
 	__EXC_VIRT_OOL_MASKABLE(name, start, size);			\
-	__TRAMP_VIRT_OOL_MASKABLE(name, realvec, bitmask);
+	__TRAMP_VIRT_OOL_MASKABLE(name, realvec, bitmask)
 
 #define __EXC_VIRT_OOL_HV(name, start, size)				\
-	__EXC_VIRT_OOL(name, start, size);
+	__EXC_VIRT_OOL(name, start, size)
 
 #define __TRAMP_VIRT_OOL_HV(name, realvec)				\
 	TRAMP_VIRT_BEGIN(tramp_virt_##name);				\
-	STD_RELON_EXCEPTION_HV_OOL(realvec, name##_common);		\
+	STD_RELON_EXCEPTION_HV_OOL(realvec, name##_common)
 
 #define EXC_VIRT_OOL_HV(name, start, size, realvec)			\
 	__EXC_VIRT_OOL_HV(name, start, size);				\
-	__TRAMP_VIRT_OOL_HV(name, realvec);
+	__TRAMP_VIRT_OOL_HV(name, realvec)
 
 #define __EXC_VIRT_OOL_MASKABLE_HV(name, start, size)			\
-	__EXC_VIRT_OOL(name, start, size);
+	__EXC_VIRT_OOL(name, start, size)
 
 #define __TRAMP_VIRT_OOL_MASKABLE_HV(name, realvec, bitmask)		\
 	TRAMP_VIRT_BEGIN(tramp_virt_##name);				\
-	MASKABLE_RELON_EXCEPTION_HV_OOL(realvec, name##_common, bitmask);\
+	MASKABLE_RELON_EXCEPTION_HV_OOL(realvec, name##_common, bitmask)
 
 #define EXC_VIRT_OOL_MASKABLE_HV(name, start, size, realvec, bitmask)	\
 	__EXC_VIRT_OOL_MASKABLE_HV(name, start, size);			\
-	__TRAMP_VIRT_OOL_MASKABLE_HV(name, realvec, bitmask);
+	__TRAMP_VIRT_OOL_MASKABLE_HV(name, realvec, bitmask)
 
 #define TRAMP_KVM(area, n)						\
 	TRAMP_KVM_BEGIN(do_kvm_##n);					\
@@ -406,11 +406,11 @@ end_##sname:
 
 #define EXC_COMMON(name, realvec, hdlr)					\
 	EXC_COMMON_BEGIN(name);						\
-	STD_EXCEPTION_COMMON(realvec, name, hdlr);			\
+	STD_EXCEPTION_COMMON(realvec, name, hdlr)
 
 #define EXC_COMMON_ASYNC(name, realvec, hdlr)				\
 	EXC_COMMON_BEGIN(name);						\
-	STD_EXCEPTION_COMMON_ASYNC(realvec, name, hdlr);		\
+	STD_EXCEPTION_COMMON_ASYNC(realvec, name, hdlr)
 
 #endif /* __ASSEMBLY__ */
 
-- 
2.18.0

