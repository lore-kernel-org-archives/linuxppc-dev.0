Return-Path: <SRS0=Z4Cu=QL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D3AC282C4
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 14:33:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 458E02083B
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 14:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eqd+dAIO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 458E02083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43tVZS4cK6zDqJc
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 01:33:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Eqd+dAIO"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43tVFC5rXDzDqG8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2019 01:18:55 +1100 (AEDT)
Received: by mail-pl1-x641.google.com with SMTP id a14so6844649plm.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Feb 2019 06:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=gWWgXyCJH4lq/KjTi+oxZySiOj3cFLZuaf96glBJTAY=;
 b=Eqd+dAIONhKuh6rSFX8c1S0Wchqob1ZtrsEdgj7/5VUJnI1/NudY9ewzkOcUYOTvEu
 z8O0IRzu7QNHMI5CsYaN5LYHU7UFSlt9GS357BTPlxDMlcwljBaeo+n376fbQDmPK4qv
 s+dikBxE3A9NRn90hcgYWm434AfPdleycGYQhknHN/C7hkrQNtC2YuIvYPSOmURXBC8V
 8Uv7S+pFuDV+nEbocbHRfmnt1aXWGcCU6Is21PloZRdJKpijBgT+/fgCvCjc7VgC7rtB
 WA3Xyi+1nYJt7jJKQd9pxhcgpe7FN2OwE9frP/PJKig2pGekCqTwrvQnOGbWNfa6b+DB
 //Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=gWWgXyCJH4lq/KjTi+oxZySiOj3cFLZuaf96glBJTAY=;
 b=TqGHJeoBeVLbGmELUREZvnTjO37/RjV0FsNr5vySwVOpH0nMTMGeyxJFlwpboSepcc
 9gEK15jIxwgM2Z/1drbb2pb/41gK4GAirYrqI1o4Xe5gnlsOCRW95RT7ccQpu3LDL03R
 C15Zcik7XXFoiKg+EmZuM0Sa3Z86K02rX/+Wcs0pWR9DMVvmIgzPms8+F1Wrh2LJHEvx
 r+oY92Y+1wdR1FT5aXmNYSE8/KbxAm+EjPxYvPuVfWozvyy2LIfkDfcIzeycVnxx9JS8
 FEvzJNA/TbdvIDVXD0Me69vCyF3jBRC5nw/y9UYDPvQKKQBGe1wESbrDtIHhoXZ3NqON
 g/dw==
X-Gm-Message-State: AJcUukdtxxf6wym6voLdtx4x7pTsyFZKwQBx5scYomoXgf9o+Uy65GiX
 Nnd9hC2hNCiQB0lq3FcYR2B3vf+4
X-Google-Smtp-Source: ALg8bN56EG3YD9ud9CFhDYfIh/ioOqrUjls7dCojLmWJKkmLBUd154efokqzWw8kW40UglVv1FgcBg==
X-Received: by 2002:a17:902:b60a:: with SMTP id
 b10mr48709066pls.303.1549289933987; 
 Mon, 04 Feb 2019 06:18:53 -0800 (PST)
Received: from roar.local0.net ([210.185.78.69])
 by smtp.gmail.com with ESMTPSA id h9sm226230pgd.53.2019.02.04.06.18.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 04 Feb 2019 06:18:53 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 07/17] powerpc/64s/exception: merge KVM handler and skip
 variants
Date: Tue,  5 Feb 2019 00:18:18 +1000
Message-Id: <20190204141828.13043-8-npiggin@gmail.com>
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

Conditionally expand the skip case if it is specified.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/exception-64s.h | 28 +++++++++---------------
 arch/powerpc/include/asm/head-64.h       |  8 +++----
 arch/powerpc/kernel/exceptions-64s.S     |  2 +-
 3 files changed, 15 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index adfbc5a0f267..cecef7166a0c 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -435,26 +435,17 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	.endif
 .endm
 
-.macro KVM_HANDLER area, hsrr, n
+.macro KVM_HANDLER area, hsrr, n, skip
+	.if \skip
+	cmpwi	r10,KVM_GUEST_MODE_SKIP
+	beq	89f
+	.else
 	BEGIN_FTR_SECTION_NESTED(947)
 	ld	r10,\area+EX_CFAR(r13)
 	std	r10,HSTATE_CFAR(r13)
 	END_FTR_SECTION_NESTED(CPU_FTR_CFAR,CPU_FTR_CFAR,947)
-	BEGIN_FTR_SECTION_NESTED(948)
-	ld	r10,\area+EX_PPR(r13)
-	std	r10,HSTATE_PPR(r13)
-	END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,948)
-	ld	r10,\area+EX_R10(r13)
-	std	r12,HSTATE_SCRATCH0(r13)
-	sldi	r12,r9,32
-	ori	r12,r12,(\n)
-	/* This reloads r9 before branching to kvmppc_interrupt */
-	__BRANCH_TO_KVM_EXIT(\area, kvmppc_interrupt)
-.endm
+	.endif
 
-.macro KVM_HANDLER_SKIP area, hsrr, n
-	cmpwi	r10,KVM_GUEST_MODE_SKIP
-	beq	89f
 	BEGIN_FTR_SECTION_NESTED(948)
 	ld	r10,\area+EX_PPR(r13)
 	std	r10,HSTATE_PPR(r13)
@@ -465,6 +456,8 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	ori	r12,r12,(\n)
 	/* This reloads r9 before branching to kvmppc_interrupt */
 	__BRANCH_TO_KVM_EXIT(\area, kvmppc_interrupt)
+
+	.if \skip
 89:	mtocrf	0x80,r9
 	ld	r9,\area+EX_R9(r13)
 	ld	r10,\area+EX_R10(r13)
@@ -473,14 +466,13 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	.else
 	b	kvmppc_skip_interrupt
 	.endif
+	.endif
 .endm
 
 #else
 .macro KVMTEST hsrr, n
 .endm
-.macro KVM_HANDLER area, hsrr, n
-.endm
-.macro KVM_HANDLER_SKIP area, hsrr, n
+.macro KVM_HANDLER area, hsrr, n, skip
 .endm
 #endif
 
diff --git a/arch/powerpc/include/asm/head-64.h b/arch/powerpc/include/asm/head-64.h
index 4767d6c7b8fa..518d9758b41e 100644
--- a/arch/powerpc/include/asm/head-64.h
+++ b/arch/powerpc/include/asm/head-64.h
@@ -387,22 +387,22 @@ end_##sname:
 
 #define TRAMP_KVM(area, n)						\
 	TRAMP_KVM_BEGIN(do_kvm_##n);					\
-	KVM_HANDLER area, EXC_STD, n
+	KVM_HANDLER area, EXC_STD, n, 0
 
 #define TRAMP_KVM_SKIP(area, n)						\
 	TRAMP_KVM_BEGIN(do_kvm_##n);					\
-	KVM_HANDLER_SKIP area, EXC_STD, n
+	KVM_HANDLER area, EXC_STD, n, 1
 
 /*
  * HV variant exceptions get the 0x2 bit added to their trap number.
  */
 #define TRAMP_KVM_HV(area, n)						\
 	TRAMP_KVM_BEGIN(do_kvm_H##n);					\
-	KVM_HANDLER area, EXC_HV, n + 0x2
+	KVM_HANDLER area, EXC_HV, n + 0x2, 0
 
 #define TRAMP_KVM_HV_SKIP(area, n)					\
 	TRAMP_KVM_BEGIN(do_kvm_H##n);					\
-	KVM_HANDLER_SKIP area, EXC_HV, n + 0x2
+	KVM_HANDLER area, EXC_HV, n + 0x2, 1
 
 #define EXC_COMMON(name, realvec, hdlr)					\
 	EXC_COMMON_BEGIN(name);						\
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index fd6c4748cfa2..ebec428f8791 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -983,7 +983,7 @@ TRAMP_KVM_BEGIN(do_kvm_0xc00)
 	SET_SCRATCH0(r10)
 	std	r9,PACA_EXGEN+EX_R9(r13)
 	mfcr	r9
-	KVM_HANDLER PACA_EXGEN, EXC_STD, 0xc00
+	KVM_HANDLER PACA_EXGEN, EXC_STD, 0xc00, 0
 #endif
 
 
-- 
2.18.0

