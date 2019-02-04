Return-Path: <SRS0=Z4Cu=QL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317C3C282C4
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 14:37:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A44B92083B
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 14:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u9rF+LV1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A44B92083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43tVf173NdzDqBP
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 01:36:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::52f; helo=mail-pg1-x52f.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="u9rF+LV1"; 
 dkim-atps=neutral
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43tVFG3gZkzDqHk
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2019 01:18:57 +1100 (AEDT)
Received: by mail-pg1-x52f.google.com with SMTP id n2so3617pgm.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Feb 2019 06:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=tNDXF/ebXTtxp3XytqdJW9nQ6CidhRl7jODFlr2npks=;
 b=u9rF+LV1UTArdDEDkQp/3j/kahVgWleEwiSbJBIhuGQxCNLPCHdHdMTnX+mm5pvt42
 scGUqwY0+yeqcMrbxw4qsIBAm8Qa4c4bhIAfLXku0B+CZepObyhCFl4eZKaZ0GmMlEsT
 oS+iNCAQ0RR6fs24k5vvNWddNtlq805NKamnveWLq9sv3UmXqzqn5i4xIPRvwxdg+sD8
 oK1AcWyhQiyPVfm7L8RtFbdFxFqpu3/g7WRGsG+Lp4i8MXZy1aDBfaPQNCtf8U7ggSX2
 PQh5HjCyA9v1Dc8aC8bFn/RbYbBVm9pu3gxuQTIHinB7ls5/E5NbpcOSOWilnRBQG4Pq
 nDqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=tNDXF/ebXTtxp3XytqdJW9nQ6CidhRl7jODFlr2npks=;
 b=gIOVOZ/z99gHn40KaxAHhbzN4sFqQPbDsQ4KvCwUkAjqOQTn6w4tDr1v97bIWsBucs
 STb/vFBXeymG4aT1uScnOOhbbTNu142WHVs18wG7j+LIaWxOun08dHPHc/b0TXS5C0+Z
 0vwseIv1k6nU2D7U27YZEAJYfQGj1aCvJfh6MK4eYkqLQ3Ok3D3n1S+ENpmWuLoPdG+A
 aT4a0qjpR1gfKNvKC59hHWGUODsRFOZG7DZDPJOnBCQOmEtGVzpHOw2I4GmjsHbQ9GPP
 d6IPVovj/bNvxRChpvbjytWTqFuQDqZQDZnSnvPZpCu3X75JJfGQJbeYPYd6cZFTTGlE
 Omfg==
X-Gm-Message-State: AJcUukeljouyeDbSl5FEPwT5afxE64h33yh1b6A5bNpVlcmh7Kwzw9gC
 yUQ8DfF1ML/sg2M9xfBcWxs8dtxZ
X-Google-Smtp-Source: ALg8bN75k10Gxg8O3YieFEfyhwgjgD7EXKpFAnhR8gibwvYG/kElqZk/WnRcKG5PRDAW9y/ZgDxCwQ==
X-Received: by 2002:a62:4c:: with SMTP id 73mr50638842pfa.24.1549289936166;
 Mon, 04 Feb 2019 06:18:56 -0800 (PST)
Received: from roar.local0.net ([210.185.78.69])
 by smtp.gmail.com with ESMTPSA id h9sm226230pgd.53.2019.02.04.06.18.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 04 Feb 2019 06:18:55 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 08/17] powerpc/64s/exception: KVM handler can set the HSRR
 trap bit
Date: Tue,  5 Feb 2019 00:18:19 +1000
Message-Id: <20190204141828.13043-9-npiggin@gmail.com>
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

Move the KVM trap HSRR bit, into the KVM handler, which can be
conditionally applied when hsrr parameter is set.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/exception-64s.h | 5 +++++
 arch/powerpc/include/asm/head-64.h       | 7 ++-----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index cecef7166a0c..c78d9b1bf22d 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -453,7 +453,12 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	ld	r10,\area+EX_R10(r13)
 	std	r12,HSTATE_SCRATCH0(r13)
 	sldi	r12,r9,32
+	/* HSRR variants have the 0x2 bit added to their trap number */
+	.if \hsrr
+	ori	r12,r12,(\n + 0x2)
+	.else
 	ori	r12,r12,(\n)
+	.endif
 	/* This reloads r9 before branching to kvmppc_interrupt */
 	__BRANCH_TO_KVM_EXIT(\area, kvmppc_interrupt)
 
diff --git a/arch/powerpc/include/asm/head-64.h b/arch/powerpc/include/asm/head-64.h
index 518d9758b41e..bdd67a26e959 100644
--- a/arch/powerpc/include/asm/head-64.h
+++ b/arch/powerpc/include/asm/head-64.h
@@ -393,16 +393,13 @@ end_##sname:
 	TRAMP_KVM_BEGIN(do_kvm_##n);					\
 	KVM_HANDLER area, EXC_STD, n, 1
 
-/*
- * HV variant exceptions get the 0x2 bit added to their trap number.
- */
 #define TRAMP_KVM_HV(area, n)						\
 	TRAMP_KVM_BEGIN(do_kvm_H##n);					\
-	KVM_HANDLER area, EXC_HV, n + 0x2, 0
+	KVM_HANDLER area, EXC_HV, n, 0
 
 #define TRAMP_KVM_HV_SKIP(area, n)					\
 	TRAMP_KVM_BEGIN(do_kvm_H##n);					\
-	KVM_HANDLER area, EXC_HV, n + 0x2, 1
+	KVM_HANDLER area, EXC_HV, n, 1
 
 #define EXC_COMMON(name, realvec, hdlr)					\
 	EXC_COMMON_BEGIN(name);						\
-- 
2.18.0

