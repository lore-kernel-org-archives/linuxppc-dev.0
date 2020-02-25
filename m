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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C401C35E01
	for <linuxppc-dev@archiver.kernel.org>; Tue, 25 Feb 2020 17:58:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4139320CC7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 25 Feb 2020 17:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JCkg+/zI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4139320CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48Rmr84Tl8zDqHH
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Feb 2020 04:58:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::444;
 helo=mail-pf1-x444.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=JCkg+/zI; dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48RmRG3XqgzDqNF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Feb 2020 04:40:10 +1100 (AEDT)
Received: by mail-pf1-x444.google.com with SMTP id 84so7565306pfy.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2020 09:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=18ZLO+XLIbG183rUTM3ik6A+CWDKxjVSwLh9AHXkpPA=;
 b=JCkg+/zIpvFVHe89Je4jGuHq9EYn7c/GxRx2sSZLDfUVB4ghtHXtJpj6Fx7npdYW5a
 G2BHwJBrzXQtD6PDnjf2PUFPP0H1cpzyRBeZm8otxPCHACd259BAMmLAQT7mBpB42N2J
 B0MyCiVOEK8ZVi+RAWtGCvcTqQGrhIhcRz4kZ5WbOlcHcsFKKLtLwuOZ5CP1H8GZbq/u
 milKBzobbNjEq9fBhjx6OIxhyJNoc3WGb7s6l2N+17rjGprKCYwX5wW7pJO0jCDYyizp
 U4oMjjjudeDY1KHTKw9gK54Ex9kNC1U6JZzTK4gEGRHMGb67ArXYF0ySuy4q1POnjEro
 IK9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=18ZLO+XLIbG183rUTM3ik6A+CWDKxjVSwLh9AHXkpPA=;
 b=hL7Lj4O0kwIOuu0cYns0DFKuVafqhSYzktfgFPmjy7p6U8saMTxzb/c8ZmSZHFQd5R
 HMi0ETNrfyaNf+La8KiHli+3P2inxWw3WYVsIT3oyse5baASMSMHSRr4wLOvEPs/JMSz
 AlAG+fw8c1Y4aO8+OZd0CnOE+noZ/gCGlp5fgUCB3LW0ziw8TfdewMFjyWk6Qrvv6u82
 CaXFvMoCDKjvlxw05bVDxRdA4ubhtZhuCta1uiIX4N6NOvsd/1yMOiB5vq4zuLHsA7Lf
 cQt2WXZa6iU9A13LVLC+pRugfpksAUXsOKTj7zT266eLhIU95poRmf8xeJdTCyCuYHpo
 YMYw==
X-Gm-Message-State: APjAAAVjSQUHCvG49ThRy4un3P6l6ng5MdES6MO9vd8D3NNMTu/2utVP
 qwekdq1Z/3fd7hFp1vBnMw4Jk6WJ
X-Google-Smtp-Source: APXvYqydOjiZKhSVP+rMm/FPKNJyvO1vPNJxjcM2/BjEYvPKlrgtTdRKrrnrtiC9tgeAiX1wJ96QWw==
X-Received: by 2002:a65:56c4:: with SMTP id w4mr31824268pgs.45.1582652407455; 
 Tue, 25 Feb 2020 09:40:07 -0800 (PST)
Received: from bobo.ibm.com ([61.68.187.74])
 by smtp.gmail.com with ESMTPSA id z63sm14791480pgd.12.2020.02.25.09.40.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 09:40:07 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 08/32] powerpc/64s/exception: Remove old INT_KVM_HANDLER
Date: Wed, 26 Feb 2020 03:35:17 +1000
Message-Id: <20200225173541.1549955-9-npiggin@gmail.com>
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

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 55 +++++++++++++---------------
 1 file changed, 26 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 90514766dc7d..cba99f9a815b 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -266,15 +266,6 @@ do_define_int n
 	.endif
 .endm
 
-.macro INT_KVM_HANDLER name, vec, hsrr, area, skip
-	TRAMP_KVM_BEGIN(\name\()_kvm)
-	KVM_HANDLER \vec, \hsrr, \area, \skip
-.endm
-
-.macro GEN_KVM name
-	KVM_HANDLER IVEC, IHSRR, IAREA, IKVM_SKIP
-.endm
-
 #ifdef CONFIG_KVM_BOOK3S_64_HANDLER
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 /*
@@ -293,35 +284,35 @@ do_define_int n
 	bne	\name\()_kvm
 .endm
 
-.macro KVM_HANDLER vec, hsrr, area, skip
-	.if \skip
+.macro GEN_KVM name
+	.if IKVM_SKIP
 	cmpwi	r10,KVM_GUEST_MODE_SKIP
 	beq	89f
 	.else
 BEGIN_FTR_SECTION_NESTED(947)
-	ld	r10,\area+EX_CFAR(r13)
+	ld	r10,IAREA+EX_CFAR(r13)
 	std	r10,HSTATE_CFAR(r13)
 END_FTR_SECTION_NESTED(CPU_FTR_CFAR,CPU_FTR_CFAR,947)
 	.endif
 
 BEGIN_FTR_SECTION_NESTED(948)
-	ld	r10,\area+EX_PPR(r13)
+	ld	r10,IAREA+EX_PPR(r13)
 	std	r10,HSTATE_PPR(r13)
 END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,948)
-	ld	r10,\area+EX_R10(r13)
+	ld	r10,IAREA+EX_R10(r13)
 	std	r12,HSTATE_SCRATCH0(r13)
 	sldi	r12,r9,32
 	/* HSRR variants have the 0x2 bit added to their trap number */
-	.if \hsrr == EXC_HV_OR_STD
+	.if IHSRR == EXC_HV_OR_STD
 	BEGIN_FTR_SECTION
-	ori	r12,r12,(\vec + 0x2)
+	ori	r12,r12,(IVEC + 0x2)
 	FTR_SECTION_ELSE
-	ori	r12,r12,(\vec)
+	ori	r12,r12,(IVEC)
 	ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206)
-	.elseif \hsrr
-	ori	r12,r12,(\vec + 0x2)
+	.elseif IHSRR
+	ori	r12,r12,(IVEC+ 0x2)
 	.else
-	ori	r12,r12,(\vec)
+	ori	r12,r12,(IVEC)
 	.endif
 
 #ifdef CONFIG_RELOCATABLE
@@ -334,25 +325,25 @@ END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,948)
 	std	r9,HSTATE_SCRATCH1(r13)
 	__LOAD_FAR_HANDLER(r9, kvmppc_interrupt)
 	mtctr	r9
-	ld	r9,\area+EX_R9(r13)
+	ld	r9,IAREA+EX_R9(r13)
 	bctr
 #else
-	ld	r9,\area+EX_R9(r13)
+	ld	r9,IAREA+EX_R9(r13)
 	b	kvmppc_interrupt
 #endif
 
 
-	.if \skip
+	.if IKVM_SKIP
 89:	mtocrf	0x80,r9
-	ld	r9,\area+EX_R9(r13)
-	ld	r10,\area+EX_R10(r13)
-	.if \hsrr == EXC_HV_OR_STD
+	ld	r9,IAREA+EX_R9(r13)
+	ld	r10,IAREA+EX_R10(r13)
+	.if IHSRR == EXC_HV_OR_STD
 	BEGIN_FTR_SECTION
 	b	kvmppc_skip_Hinterrupt
 	FTR_SECTION_ELSE
 	b	kvmppc_skip_interrupt
 	ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206)
-	.elseif \hsrr
+	.elseif IHSRR
 	b	kvmppc_skip_Hinterrupt
 	.else
 	b	kvmppc_skip_interrupt
@@ -363,7 +354,7 @@ END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,948)
 #else
 .macro KVMTEST name, hsrr, n
 .endm
-.macro KVM_HANDLER name, vec, hsrr, area, skip
+.macro GEN_KVM name
 .endm
 #endif
 
@@ -1627,6 +1618,12 @@ EXC_VIRT_NONE(0x4b00, 0x100)
  * without saving, though xer is not a good idea to use, as hardware may
  * interpret some bits so it may be costly to change them.
  */
+INT_DEFINE_BEGIN(system_call)
+	IVEC=0xc00
+	IKVM_REAL=1
+	IKVM_VIRT=1
+INT_DEFINE_END(system_call)
+
 .macro SYSTEM_CALL virt
 #ifdef CONFIG_KVM_BOOK3S_64_HANDLER
 	/*
@@ -1720,7 +1717,7 @@ TRAMP_KVM_BEGIN(system_call_kvm)
 	SET_SCRATCH0(r10)
 	std	r9,PACA_EXGEN+EX_R9(r13)
 	mfcr	r9
-	KVM_HANDLER 0xc00, EXC_STD, PACA_EXGEN, 0
+	GEN_KVM system_call
 #endif
 
 
-- 
2.23.0

