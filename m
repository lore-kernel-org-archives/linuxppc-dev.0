Return-Path: <SRS0=Z4Cu=QL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044B5C282C4
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 14:53:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 775F12082F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 14:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5oDETFb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 775F12082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43tW1W3MRyzDqDr
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 01:53:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Z5oDETFb"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43tVFf3m4FzDqHj
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2019 01:19:18 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id g9so5258plo.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Feb 2019 06:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=iDPiqqY73Vlfqjt3QVclnZPCXiFvUFraoum10AGuQ2g=;
 b=Z5oDETFbLHxFrn9zh/uTZUHP38PWVChzLVjbT2SlYRlZocfORjfISxZLsw2PpvnB6N
 ABxVSFVKCr6qyHzPRhHlYRt2c2EcBHwC9craQvpOVdEfcJLkWL/96HAYoEequAx8Afsd
 WY9pvLdlTvYNl04nXXyyz3SG2CcstB7EYmTitUrCJsY3LF+Stt5d2/+PTWao/Kdztbgd
 RI6bobmuqC8cY8EEd73dn8+LGV1RIdAxwtcxFcAntvG+5adbhuDYCrYEnDD0qITTPfNt
 7Yy9bZauZRWAFF5B3KoP2A1Oq3szaFKnPvpwb6Gb9O2X6j51x5D1S2C8sKG25UPZXaWM
 +87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=iDPiqqY73Vlfqjt3QVclnZPCXiFvUFraoum10AGuQ2g=;
 b=aiiF0e0t437PEXRBhIrjTO3HIFy9tQiyuqeOJ8aji0V/H7G8XaSnhP51zEeynb6K0q
 QVcJUBRsO7Yf9ymIW6j+ppHlFjD9ugMnjigAFKZsRoeAWnL2ORnDca8F5f99LT0gkHGY
 gaj8bwbM4espOn6e4wROi1s24PCRfS349rt9hltRM8H4BCUAQNIcUFhdJC5wIRoFzeM9
 RrmgeLmri6np+vNwIadWc5H4Dsv1OqpOJZmKiqgTduHPNtk7+JkV33o2joESQfmSiPMF
 MvnhmEp8OPfdoIzIMifqQMAvHAAyVw4ftGn8YQyMNtdIaTV8lKizU8+ov2s9Cqfn69tg
 NqFA==
X-Gm-Message-State: AJcUukfKUFdx8L6AmdFbwbWuzLLEQq3u0oGcSVmGwck1FVxZMOXBRE4e
 okUHROsusyjWL1PRpiR27EM4yC0e
X-Google-Smtp-Source: ALg8bN6qguBkpye2BCEL7WAMS0hw6DaCnaqD18AkSHGlBCUf3TE05hqz4e24xd3UFyYKP+i9WoI5qA==
X-Received: by 2002:a17:902:33c1:: with SMTP id
 b59mr51167056plc.220.1549289956454; 
 Mon, 04 Feb 2019 06:19:16 -0800 (PST)
Received: from roar.local0.net ([210.185.78.69])
 by smtp.gmail.com with ESMTPSA id h9sm226230pgd.53.2019.02.04.06.19.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 04 Feb 2019 06:19:15 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 17/17] powerpc/64s/exception: move head-64.h code to
 exception-64s.S where it is used
Date: Tue,  5 Feb 2019 00:18:28 +1000
Message-Id: <20190204141828.13043-18-npiggin@gmail.com>
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
 arch/powerpc/include/asm/head-64.h   | 252 ---------------------------
 arch/powerpc/kernel/exceptions-64s.S | 251 ++++++++++++++++++++++++++
 2 files changed, 251 insertions(+), 252 deletions(-)

diff --git a/arch/powerpc/include/asm/head-64.h b/arch/powerpc/include/asm/head-64.h
index 341f23306a80..a466765709a9 100644
--- a/arch/powerpc/include/asm/head-64.h
+++ b/arch/powerpc/include/asm/head-64.h
@@ -169,53 +169,6 @@ end_##sname:
 
 #define ABS_ADDR(label) (label - fs_label + fs_start)
 
-/*
- * Following are the BOOK3S exception handler helper macros.
- * Handlers come in a number of types, and each type has a number of varieties.
- *
- * EXC_REAL_*     - real, unrelocated exception vectors
- * EXC_VIRT_*     - virt (AIL), unrelocated exception vectors
- * TRAMP_REAL_*   - real, unrelocated helpers (virt can call these)
- * TRAMP_VIRT_*   - virt, unreloc helpers (in practice, real can use)
- * TRAMP_KVM      - KVM handlers that get put into real, unrelocated
- * EXC_COMMON     - virt, relocated common handlers
- *
- * The EXC handlers are given a name, and branch to name_common, or the
- * appropriate KVM or masking function. Vector handler verieties are as
- * follows:
- *
- * EXC_{REAL|VIRT}_BEGIN/END - used to open-code the exception
- *
- * EXC_{REAL|VIRT}  - standard exception
- *
- * EXC_{REAL|VIRT}_suffix
- *     where _suffix is:
- *   - _MASKABLE               - maskable exception
- *   - _OOL                    - out of line with trampoline to common handler
- *   - _HV                     - HV exception
- *
- * There can be combinations, e.g., EXC_VIRT_OOL_MASKABLE_HV
- *
- * The one unusual case is __EXC_REAL_OOL_HV_DIRECT, which is
- * an OOL vector that branches to a specified handler rather than the usual
- * trampoline that goes to common. It, and other underscore macros, should
- * be used with care.
- *
- * KVM handlers come in the following verieties:
- * TRAMP_KVM
- * TRAMP_KVM_SKIP
- * TRAMP_KVM_HV
- * TRAMP_KVM_HV_SKIP
- *
- * COMMON handlers come in the following verieties:
- * EXC_COMMON_BEGIN/END - used to open-code the handler
- * EXC_COMMON
- * EXC_COMMON_ASYNC
- *
- * TRAMP_REAL and TRAMP_VIRT can be used with BEGIN/END. KVM
- * and OOL handlers are implemented as types of TRAMP and TRAMP_VIRT handlers.
- */
-
 #define EXC_REAL_BEGIN(name, start, size)			\
 	FIXED_SECTION_ENTRY_BEGIN_LOCATION(real_vectors, exc_real_##start##_##name, start, size)
 
@@ -257,211 +210,6 @@ end_##sname:
 	FIXED_SECTION_ENTRY_BEGIN_LOCATION(virt_vectors, exc_virt_##start##_##unused, start, size); \
 	FIXED_SECTION_ENTRY_END_LOCATION(virt_vectors, exc_virt_##start##_##unused, start, size)
 
-
-#define __EXC_REAL(name, start, size, area)				\
-	EXC_REAL_BEGIN(name, start, size);				\
-	SET_SCRATCH0(r13);		/* save r13 */			\
-	EXCEPTION_PROLOG_0 area ;					\
-	EXCEPTION_PROLOG_1 EXC_STD, area, 1, start, 0 ;			\
-	EXCEPTION_PROLOG_2_REAL name##_common, EXC_STD, 1 ;		\
-	EXC_REAL_END(name, start, size)
-
-#define EXC_REAL(name, start, size)					\
-	__EXC_REAL(name, start, size, PACA_EXGEN)
-
-#define __EXC_VIRT(name, start, size, realvec, area)			\
-	EXC_VIRT_BEGIN(name, start, size);				\
-	SET_SCRATCH0(r13);    /* save r13 */				\
-	EXCEPTION_PROLOG_0 area ;					\
-	EXCEPTION_PROLOG_1 EXC_STD, area, 0, realvec, 0;		\
-	EXCEPTION_PROLOG_2_VIRT name##_common, EXC_STD ;		\
-	EXC_VIRT_END(name, start, size)
-
-#define EXC_VIRT(name, start, size, realvec)				\
-	__EXC_VIRT(name, start, size, realvec, PACA_EXGEN)
-
-#define EXC_REAL_MASKABLE(name, start, size, bitmask)			\
-	EXC_REAL_BEGIN(name, start, size);				\
-	SET_SCRATCH0(r13);    /* save r13 */				\
-	EXCEPTION_PROLOG_0 PACA_EXGEN ;					\
-	EXCEPTION_PROLOG_1 EXC_STD, PACA_EXGEN, 1, start, bitmask ;	\
-	EXCEPTION_PROLOG_2_REAL name##_common, EXC_STD, 1 ;		\
-	EXC_REAL_END(name, start, size)
-
-#define EXC_VIRT_MASKABLE(name, start, size, realvec, bitmask)		\
-	EXC_VIRT_BEGIN(name, start, size);				\
-	SET_SCRATCH0(r13);    /* save r13 */				\
-	EXCEPTION_PROLOG_0 PACA_EXGEN ;					\
-	EXCEPTION_PROLOG_1 EXC_STD, PACA_EXGEN, 0, realvec, bitmask ;	\
-	EXCEPTION_PROLOG_2_VIRT name##_common, EXC_STD ;		\
-	EXC_VIRT_END(name, start, size)
-
-#define EXC_REAL_HV(name, start, size)					\
-	EXC_REAL_BEGIN(name, start, size);				\
-	SET_SCRATCH0(r13);		/* save r13 */			\
-	EXCEPTION_PROLOG_0 PACA_EXGEN;					\
-	EXCEPTION_PROLOG_1 EXC_HV, PACA_EXGEN, 1, start, 0 ;		\
-	EXCEPTION_PROLOG_2_REAL name##_common, EXC_HV, 1 ;		\
-	EXC_REAL_END(name, start, size)
-
-#define EXC_VIRT_HV(name, start, size, realvec)				\
-	EXC_VIRT_BEGIN(name, start, size);				\
-	SET_SCRATCH0(r13);		/* save r13 */			\
-	EXCEPTION_PROLOG_0 PACA_EXGEN;					\
-	EXCEPTION_PROLOG_1 EXC_HV, PACA_EXGEN, 1, realvec, 0 ;		\
-	EXCEPTION_PROLOG_2_VIRT name##_common, EXC_HV ;			\
-	EXC_VIRT_END(name, start, size)
-
-#define __EXC_REAL_OOL(name, start, size)				\
-	EXC_REAL_BEGIN(name, start, size);				\
-	SET_SCRATCH0(r13);						\
-	EXCEPTION_PROLOG_0 PACA_EXGEN ;					\
-	b	tramp_real_##name ;					\
-	EXC_REAL_END(name, start, size)
-
-#define __TRAMP_REAL_OOL(name, vec)					\
-	TRAMP_REAL_BEGIN(tramp_real_##name);				\
-	EXCEPTION_PROLOG_1 EXC_STD, PACA_EXGEN, 1, vec, 0 ;	\
-	EXCEPTION_PROLOG_2_REAL name##_common, EXC_STD, 1
-
-#define EXC_REAL_OOL(name, start, size)					\
-	__EXC_REAL_OOL(name, start, size);				\
-	__TRAMP_REAL_OOL(name, start)
-
-#define __EXC_REAL_OOL_MASKABLE(name, start, size)			\
-	__EXC_REAL_OOL(name, start, size)
-
-#define __TRAMP_REAL_OOL_MASKABLE(name, vec, bitmask)			\
-	TRAMP_REAL_BEGIN(tramp_real_##name);				\
-	EXCEPTION_PROLOG_1 EXC_STD, PACA_EXGEN, 1, vec, bitmask ;	\
-	EXCEPTION_PROLOG_2_REAL name##_common, EXC_STD, 1
-
-#define EXC_REAL_OOL_MASKABLE(name, start, size, bitmask)		\
-	__EXC_REAL_OOL_MASKABLE(name, start, size);			\
-	__TRAMP_REAL_OOL_MASKABLE(name, start, bitmask)
-
-#define __EXC_REAL_OOL_HV_DIRECT(name, start, size, handler)		\
-	EXC_REAL_BEGIN(name, start, size);				\
-	SET_SCRATCH0(r13);						\
-	EXCEPTION_PROLOG_0 PACA_EXGEN ;					\
-	b	hanndler;						\
-	EXC_REAL_END(name, start, size)
-
-#define __EXC_REAL_OOL_HV(name, start, size)				\
-	__EXC_REAL_OOL(name, start, size)
-
-#define __TRAMP_REAL_OOL_HV(name, vec)					\
-	TRAMP_REAL_BEGIN(tramp_real_##name);				\
-	EXCEPTION_PROLOG_1 EXC_HV, PACA_EXGEN, 1, vec, 0 ;	\
-	EXCEPTION_PROLOG_2_REAL name##_common, EXC_HV, 1
-
-#define EXC_REAL_OOL_HV(name, start, size)				\
-	__EXC_REAL_OOL_HV(name, start, size);				\
-	__TRAMP_REAL_OOL_HV(name, start)
-
-#define __EXC_REAL_OOL_MASKABLE_HV(name, start, size)			\
-	__EXC_REAL_OOL(name, start, size)
-
-#define __TRAMP_REAL_OOL_MASKABLE_HV(name, vec, bitmask)		\
-	TRAMP_REAL_BEGIN(tramp_real_##name);				\
-	EXCEPTION_PROLOG_1 EXC_HV, PACA_EXGEN, 1, vec, bitmask ;	\
-	EXCEPTION_PROLOG_2_REAL name##_common, EXC_HV, 1
-
-#define EXC_REAL_OOL_MASKABLE_HV(name, start, size, bitmask)		\
-	__EXC_REAL_OOL_MASKABLE_HV(name, start, size);			\
-	__TRAMP_REAL_OOL_MASKABLE_HV(name, start, bitmask)
-
-#define __EXC_VIRT_OOL(name, start, size)				\
-	EXC_VIRT_BEGIN(name, start, size);				\
-	SET_SCRATCH0(r13);						\
-	EXCEPTION_PROLOG_0 PACA_EXGEN ;					\
-	b	tramp_virt_##name;					\
-	EXC_VIRT_END(name, start, size)
-
-#define __TRAMP_VIRT_OOL(name, realvec)					\
-	TRAMP_VIRT_BEGIN(tramp_virt_##name);				\
-	EXCEPTION_PROLOG_1 EXC_STD, PACA_EXGEN, 0, vec, 0 ;		\
-	EXCEPTION_PROLOG_2_VIRT name##_common, EXC_STD
-
-#define EXC_VIRT_OOL(name, start, size, realvec)			\
-	__EXC_VIRT_OOL(name, start, size);				\
-	__TRAMP_VIRT_OOL(name, realvec)
-
-#define __EXC_VIRT_OOL_MASKABLE(name, start, size)			\
-	__EXC_VIRT_OOL(name, start, size)
-
-#define __TRAMP_VIRT_OOL_MASKABLE(name, realvec, bitmask)		\
-	TRAMP_VIRT_BEGIN(tramp_virt_##name);				\
-	EXCEPTION_PROLOG_1 EXC_STD, PACA_EXGEN, 0, realvec, bitmask ;	\
-	EXCEPTION_PROLOG_2_REAL name##_common, EXC_STD, 1
-
-#define EXC_VIRT_OOL_MASKABLE(name, start, size, realvec, bitmask)	\
-	__EXC_VIRT_OOL_MASKABLE(name, start, size);			\
-	__TRAMP_VIRT_OOL_MASKABLE(name, realvec, bitmask)
-
-#define __EXC_VIRT_OOL_HV(name, start, size)				\
-	__EXC_VIRT_OOL(name, start, size)
-
-#define __TRAMP_VIRT_OOL_HV(name, realvec)				\
-	TRAMP_VIRT_BEGIN(tramp_virt_##name);				\
-	EXCEPTION_PROLOG_1 EXC_HV, PACA_EXGEN, 1, vec, 0 ;		\
-	EXCEPTION_PROLOG_2_VIRT name##_common, EXC_HV
-
-#define EXC_VIRT_OOL_HV(name, start, size, realvec)			\
-	__EXC_VIRT_OOL_HV(name, start, size);				\
-	__TRAMP_VIRT_OOL_HV(name, realvec)
-
-#define __EXC_VIRT_OOL_MASKABLE_HV(name, start, size)			\
-	__EXC_VIRT_OOL(name, start, size)
-
-#define __TRAMP_VIRT_OOL_MASKABLE_HV(name, realvec, bitmask)		\
-	TRAMP_VIRT_BEGIN(tramp_virt_##name);				\
-	EXCEPTION_PROLOG_1 EXC_HV, PACA_EXGEN, 1, realvec, bitmask ;	\
-	EXCEPTION_PROLOG_2_VIRT name##_common, EXC_HV
-
-#define EXC_VIRT_OOL_MASKABLE_HV(name, start, size, realvec, bitmask)	\
-	__EXC_VIRT_OOL_MASKABLE_HV(name, start, size);			\
-	__TRAMP_VIRT_OOL_MASKABLE_HV(name, realvec, bitmask)
-
-#define TRAMP_KVM(area, n)						\
-	TRAMP_KVM_BEGIN(do_kvm_##n);					\
-	KVM_HANDLER area, EXC_STD, n, 0
-
-#define TRAMP_KVM_SKIP(area, n)						\
-	TRAMP_KVM_BEGIN(do_kvm_##n);					\
-	KVM_HANDLER area, EXC_STD, n, 1
-
-#define TRAMP_KVM_HV(area, n)						\
-	TRAMP_KVM_BEGIN(do_kvm_H##n);					\
-	KVM_HANDLER area, EXC_HV, n, 0
-
-#define TRAMP_KVM_HV_SKIP(area, n)					\
-	TRAMP_KVM_BEGIN(do_kvm_H##n);					\
-	KVM_HANDLER area, EXC_HV, n, 1
-
-#define EXC_COMMON(name, realvec, hdlr)					\
-	EXC_COMMON_BEGIN(name);						\
-	EXCEPTION_COMMON(PACA_EXGEN, realvec);				\
-	bl	save_nvgprs;						\
-	RECONCILE_IRQ_STATE(r10, r11);					\
-	addi	r3,r1,STACK_FRAME_OVERHEAD;				\
-	bl	hdlr;							\
-	b	ret_from_except
-
-/*
- * Like EXC_COMMON, but for exceptions that can occur in the idle task and
- * therefore need the special idle handling (finish nap and runlatch)
- */
-#define EXC_COMMON_ASYNC(name, realvec, hdlr)				\
-	EXC_COMMON_BEGIN(name);						\
-	EXCEPTION_COMMON(PACA_EXGEN, realvec);				\
-	FINISH_NAP;							\
-	RECONCILE_IRQ_STATE(r10, r11);					\
-	RUNLATCH_ON;							\
-	addi	r3,r1,STACK_FRAME_OVERHEAD;				\
-	bl	hdlr;							\
-	b	ret_from_except_lite
-
 #endif /* __ASSEMBLY__ */
 
 #endif	/* _ASM_POWERPC_HEAD_64_H */
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 8d19afa09776..f0c569507cb0 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -448,6 +448,257 @@ END_FTR_SECTION_IFSET(CPU_FTR_CAN_NAP)
 #define FINISH_NAP
 #endif
 
+/*
+ * Following are the BOOK3S exception handler helper macros.
+ * Handlers come in a number of types, and each type has a number of varieties.
+ *
+ * EXC_REAL_*     - real, unrelocated exception vectors
+ * EXC_VIRT_*     - virt (AIL), unrelocated exception vectors
+ * TRAMP_REAL_*   - real, unrelocated helpers (virt can call these)
+ * TRAMP_VIRT_*   - virt, unreloc helpers (in practice, real can use)
+ * TRAMP_KVM      - KVM handlers that get put into real, unrelocated
+ * EXC_COMMON     - virt, relocated common handlers
+ *
+ * The EXC handlers are given a name, and branch to name_common, or the
+ * appropriate KVM or masking function. Vector handler verieties are as
+ * follows:
+ *
+ * EXC_{REAL|VIRT}_BEGIN/END - used to open-code the exception
+ *
+ * EXC_{REAL|VIRT}  - standard exception
+ *
+ * EXC_{REAL|VIRT}_suffix
+ *     where _suffix is:
+ *   - _MASKABLE               - maskable exception
+ *   - _OOL                    - out of line with trampoline to common handler
+ *   - _HV                     - HV exception
+ *
+ * There can be combinations, e.g., EXC_VIRT_OOL_MASKABLE_HV
+ *
+ * The one unusual case is __EXC_REAL_OOL_HV_DIRECT, which is
+ * an OOL vector that branches to a specified handler rather than the usual
+ * trampoline that goes to common. It, and other underscore macros, should
+ * be used with care.
+ *
+ * KVM handlers come in the following verieties:
+ * TRAMP_KVM
+ * TRAMP_KVM_SKIP
+ * TRAMP_KVM_HV
+ * TRAMP_KVM_HV_SKIP
+ *
+ * COMMON handlers come in the following verieties:
+ * EXC_COMMON_BEGIN/END - used to open-code the handler
+ * EXC_COMMON
+ * EXC_COMMON_ASYNC
+ *
+ * TRAMP_REAL and TRAMP_VIRT can be used with BEGIN/END. KVM
+ * and OOL handlers are implemented as types of TRAMP and TRAMP_VIRT handlers.
+ */
+
+#define __EXC_REAL(name, start, size, area)				\
+	EXC_REAL_BEGIN(name, start, size);				\
+	SET_SCRATCH0(r13);		/* save r13 */			\
+	EXCEPTION_PROLOG_0 area ;					\
+	EXCEPTION_PROLOG_1 EXC_STD, area, 1, start, 0 ;			\
+	EXCEPTION_PROLOG_2_REAL name##_common, EXC_STD, 1 ;		\
+	EXC_REAL_END(name, start, size)
+
+#define EXC_REAL(name, start, size)					\
+	__EXC_REAL(name, start, size, PACA_EXGEN)
+
+#define __EXC_VIRT(name, start, size, realvec, area)			\
+	EXC_VIRT_BEGIN(name, start, size);				\
+	SET_SCRATCH0(r13);    /* save r13 */				\
+	EXCEPTION_PROLOG_0 area ;					\
+	EXCEPTION_PROLOG_1 EXC_STD, area, 0, realvec, 0;		\
+	EXCEPTION_PROLOG_2_VIRT name##_common, EXC_STD ;		\
+	EXC_VIRT_END(name, start, size)
+
+#define EXC_VIRT(name, start, size, realvec)				\
+	__EXC_VIRT(name, start, size, realvec, PACA_EXGEN)
+
+#define EXC_REAL_MASKABLE(name, start, size, bitmask)			\
+	EXC_REAL_BEGIN(name, start, size);				\
+	SET_SCRATCH0(r13);    /* save r13 */				\
+	EXCEPTION_PROLOG_0 PACA_EXGEN ;					\
+	EXCEPTION_PROLOG_1 EXC_STD, PACA_EXGEN, 1, start, bitmask ;	\
+	EXCEPTION_PROLOG_2_REAL name##_common, EXC_STD, 1 ;		\
+	EXC_REAL_END(name, start, size)
+
+#define EXC_VIRT_MASKABLE(name, start, size, realvec, bitmask)		\
+	EXC_VIRT_BEGIN(name, start, size);				\
+	SET_SCRATCH0(r13);    /* save r13 */				\
+	EXCEPTION_PROLOG_0 PACA_EXGEN ;					\
+	EXCEPTION_PROLOG_1 EXC_STD, PACA_EXGEN, 0, realvec, bitmask ;	\
+	EXCEPTION_PROLOG_2_VIRT name##_common, EXC_STD ;		\
+	EXC_VIRT_END(name, start, size)
+
+#define EXC_REAL_HV(name, start, size)					\
+	EXC_REAL_BEGIN(name, start, size);				\
+	SET_SCRATCH0(r13);		/* save r13 */			\
+	EXCEPTION_PROLOG_0 PACA_EXGEN;					\
+	EXCEPTION_PROLOG_1 EXC_HV, PACA_EXGEN, 1, start, 0 ;		\
+	EXCEPTION_PROLOG_2_REAL name##_common, EXC_HV, 1 ;		\
+	EXC_REAL_END(name, start, size)
+
+#define EXC_VIRT_HV(name, start, size, realvec)				\
+	EXC_VIRT_BEGIN(name, start, size);				\
+	SET_SCRATCH0(r13);		/* save r13 */			\
+	EXCEPTION_PROLOG_0 PACA_EXGEN;					\
+	EXCEPTION_PROLOG_1 EXC_HV, PACA_EXGEN, 1, realvec, 0 ;		\
+	EXCEPTION_PROLOG_2_VIRT name##_common, EXC_HV ;			\
+	EXC_VIRT_END(name, start, size)
+
+#define __EXC_REAL_OOL(name, start, size)				\
+	EXC_REAL_BEGIN(name, start, size);				\
+	SET_SCRATCH0(r13);						\
+	EXCEPTION_PROLOG_0 PACA_EXGEN ;					\
+	b	tramp_real_##name ;					\
+	EXC_REAL_END(name, start, size)
+
+#define __TRAMP_REAL_OOL(name, vec)					\
+	TRAMP_REAL_BEGIN(tramp_real_##name);				\
+	EXCEPTION_PROLOG_1 EXC_STD, PACA_EXGEN, 1, vec, 0 ;	\
+	EXCEPTION_PROLOG_2_REAL name##_common, EXC_STD, 1
+
+#define EXC_REAL_OOL(name, start, size)					\
+	__EXC_REAL_OOL(name, start, size);				\
+	__TRAMP_REAL_OOL(name, start)
+
+#define __EXC_REAL_OOL_MASKABLE(name, start, size)			\
+	__EXC_REAL_OOL(name, start, size)
+
+#define __TRAMP_REAL_OOL_MASKABLE(name, vec, bitmask)			\
+	TRAMP_REAL_BEGIN(tramp_real_##name);				\
+	EXCEPTION_PROLOG_1 EXC_STD, PACA_EXGEN, 1, vec, bitmask ;	\
+	EXCEPTION_PROLOG_2_REAL name##_common, EXC_STD, 1
+
+#define EXC_REAL_OOL_MASKABLE(name, start, size, bitmask)		\
+	__EXC_REAL_OOL_MASKABLE(name, start, size);			\
+	__TRAMP_REAL_OOL_MASKABLE(name, start, bitmask)
+
+#define __EXC_REAL_OOL_HV_DIRECT(name, start, size, handler)		\
+	EXC_REAL_BEGIN(name, start, size);				\
+	SET_SCRATCH0(r13);						\
+	EXCEPTION_PROLOG_0 PACA_EXGEN ;					\
+	b	hanndler;						\
+	EXC_REAL_END(name, start, size)
+
+#define __EXC_REAL_OOL_HV(name, start, size)				\
+	__EXC_REAL_OOL(name, start, size)
+
+#define __TRAMP_REAL_OOL_HV(name, vec)					\
+	TRAMP_REAL_BEGIN(tramp_real_##name);				\
+	EXCEPTION_PROLOG_1 EXC_HV, PACA_EXGEN, 1, vec, 0 ;	\
+	EXCEPTION_PROLOG_2_REAL name##_common, EXC_HV, 1
+
+#define EXC_REAL_OOL_HV(name, start, size)				\
+	__EXC_REAL_OOL_HV(name, start, size);				\
+	__TRAMP_REAL_OOL_HV(name, start)
+
+#define __EXC_REAL_OOL_MASKABLE_HV(name, start, size)			\
+	__EXC_REAL_OOL(name, start, size)
+
+#define __TRAMP_REAL_OOL_MASKABLE_HV(name, vec, bitmask)		\
+	TRAMP_REAL_BEGIN(tramp_real_##name);				\
+	EXCEPTION_PROLOG_1 EXC_HV, PACA_EXGEN, 1, vec, bitmask ;	\
+	EXCEPTION_PROLOG_2_REAL name##_common, EXC_HV, 1
+
+#define EXC_REAL_OOL_MASKABLE_HV(name, start, size, bitmask)		\
+	__EXC_REAL_OOL_MASKABLE_HV(name, start, size);			\
+	__TRAMP_REAL_OOL_MASKABLE_HV(name, start, bitmask)
+
+#define __EXC_VIRT_OOL(name, start, size)				\
+	EXC_VIRT_BEGIN(name, start, size);				\
+	SET_SCRATCH0(r13);						\
+	EXCEPTION_PROLOG_0 PACA_EXGEN ;					\
+	b	tramp_virt_##name;					\
+	EXC_VIRT_END(name, start, size)
+
+#define __TRAMP_VIRT_OOL(name, realvec)					\
+	TRAMP_VIRT_BEGIN(tramp_virt_##name);				\
+	EXCEPTION_PROLOG_1 EXC_STD, PACA_EXGEN, 0, vec, 0 ;		\
+	EXCEPTION_PROLOG_2_VIRT name##_common, EXC_STD
+
+#define EXC_VIRT_OOL(name, start, size, realvec)			\
+	__EXC_VIRT_OOL(name, start, size);				\
+	__TRAMP_VIRT_OOL(name, realvec)
+
+#define __EXC_VIRT_OOL_MASKABLE(name, start, size)			\
+	__EXC_VIRT_OOL(name, start, size)
+
+#define __TRAMP_VIRT_OOL_MASKABLE(name, realvec, bitmask)		\
+	TRAMP_VIRT_BEGIN(tramp_virt_##name);				\
+	EXCEPTION_PROLOG_1 EXC_STD, PACA_EXGEN, 0, realvec, bitmask ;	\
+	EXCEPTION_PROLOG_2_REAL name##_common, EXC_STD, 1
+
+#define EXC_VIRT_OOL_MASKABLE(name, start, size, realvec, bitmask)	\
+	__EXC_VIRT_OOL_MASKABLE(name, start, size);			\
+	__TRAMP_VIRT_OOL_MASKABLE(name, realvec, bitmask)
+
+#define __EXC_VIRT_OOL_HV(name, start, size)				\
+	__EXC_VIRT_OOL(name, start, size)
+
+#define __TRAMP_VIRT_OOL_HV(name, realvec)				\
+	TRAMP_VIRT_BEGIN(tramp_virt_##name);				\
+	EXCEPTION_PROLOG_1 EXC_HV, PACA_EXGEN, 1, vec, 0 ;		\
+	EXCEPTION_PROLOG_2_VIRT name##_common, EXC_HV
+
+#define EXC_VIRT_OOL_HV(name, start, size, realvec)			\
+	__EXC_VIRT_OOL_HV(name, start, size);				\
+	__TRAMP_VIRT_OOL_HV(name, realvec)
+
+#define __EXC_VIRT_OOL_MASKABLE_HV(name, start, size)			\
+	__EXC_VIRT_OOL(name, start, size)
+
+#define __TRAMP_VIRT_OOL_MASKABLE_HV(name, realvec, bitmask)		\
+	TRAMP_VIRT_BEGIN(tramp_virt_##name);				\
+	EXCEPTION_PROLOG_1 EXC_HV, PACA_EXGEN, 1, realvec, bitmask ;	\
+	EXCEPTION_PROLOG_2_VIRT name##_common, EXC_HV
+
+#define EXC_VIRT_OOL_MASKABLE_HV(name, start, size, realvec, bitmask)	\
+	__EXC_VIRT_OOL_MASKABLE_HV(name, start, size);			\
+	__TRAMP_VIRT_OOL_MASKABLE_HV(name, realvec, bitmask)
+
+#define TRAMP_KVM(area, n)						\
+	TRAMP_KVM_BEGIN(do_kvm_##n);					\
+	KVM_HANDLER area, EXC_STD, n, 0
+
+#define TRAMP_KVM_SKIP(area, n)						\
+	TRAMP_KVM_BEGIN(do_kvm_##n);					\
+	KVM_HANDLER area, EXC_STD, n, 1
+
+#define TRAMP_KVM_HV(area, n)						\
+	TRAMP_KVM_BEGIN(do_kvm_H##n);					\
+	KVM_HANDLER area, EXC_HV, n, 0
+
+#define TRAMP_KVM_HV_SKIP(area, n)					\
+	TRAMP_KVM_BEGIN(do_kvm_H##n);					\
+	KVM_HANDLER area, EXC_HV, n, 1
+
+#define EXC_COMMON(name, realvec, hdlr)					\
+	EXC_COMMON_BEGIN(name);						\
+	EXCEPTION_COMMON(PACA_EXGEN, realvec);				\
+	bl	save_nvgprs;						\
+	RECONCILE_IRQ_STATE(r10, r11);					\
+	addi	r3,r1,STACK_FRAME_OVERHEAD;				\
+	bl	hdlr;							\
+	b	ret_from_except
+
+/*
+ * Like EXC_COMMON, but for exceptions that can occur in the idle task and
+ * therefore need the special idle handling (finish nap and runlatch)
+ */
+#define EXC_COMMON_ASYNC(name, realvec, hdlr)				\
+	EXC_COMMON_BEGIN(name);						\
+	EXCEPTION_COMMON(PACA_EXGEN, realvec);				\
+	FINISH_NAP;							\
+	RECONCILE_IRQ_STATE(r10, r11);					\
+	RUNLATCH_ON;							\
+	addi	r3,r1,STACK_FRAME_OVERHEAD;				\
+	bl	hdlr;							\
+	b	ret_from_except_lite
+
 
 /*
  * There are a few constraints to be concerned with.
-- 
2.18.0

