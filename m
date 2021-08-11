Return-Path: <SRS0=Olcr=NC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4E4C4338F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Aug 2021 16:03:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 494A860F38
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Aug 2021 16:03:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 494A860F38
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GlF3z43W2z3dH8
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Aug 2021 02:03:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=fzedp2iN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102b;
 helo=mail-pj1-x102b.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=fzedp2iN; dkim-atps=neutral
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GlF1t2nvnz30G2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Aug 2021 02:01:54 +1000 (AEST)
Received: by mail-pj1-x102b.google.com with SMTP id
 s22-20020a17090a1c16b0290177caeba067so10425269pjs.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Aug 2021 09:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VBST8AqhrKncX0fAkXnrZxL4xRtwbCPCtY6hZhbOAns=;
 b=fzedp2iNkDVZSFJUEZt6rIf9covcWofEVp1wWIULIKSSUOVdlFVNuLfSNf4xKeuh2o
 v8Coq9zLeVfMstaCGb1dtmQ5AQjV/NwYE4PzNEgj458CHi1DoxfVuobkQoQnyYfOj2Ly
 29qW/yAllHoEk0sWTpZWL4VA5l19XWEq9vSJJiPXijMTHDdzZi+tfnrLd9h4f51qX/Ok
 GFZfPrBIX70JfowjVRl7CqCZis0EKOaUvy4/u8soIMpXGTRCRutpr40BuZ3NGHdl5+RA
 qyH/T2rNAKRq5qh6amY5W4MoNrQNCSEQSKUJkzSFmWPAU4O29H8obTyV7w/Gs8OXopTL
 oWQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VBST8AqhrKncX0fAkXnrZxL4xRtwbCPCtY6hZhbOAns=;
 b=cNlgnz0niNNTkYQby9ROK49F3QIyaMTYtd/uwmUgf9hQGHDF68OQG3wuP5o1bjgLTX
 auP1VeCHjLFl0V1EEMibMFp1eYwZUTQ7HHlheTqcfdf6MkoxSEvXhW+a13KoxYusjxct
 hvCX89VUJZJ/yDMWFVxrZ9mxIlTtbczhlRzMkOOZqNqVwclOUL6t8ZkhZiLjG2cISpQD
 uFH/MrdjSi3f4vJ9X237PrtN+1i36QEYcMZNThdsdmITWVDRhWTwD4OCmBSRf6eLFcyL
 GdBa7IqL8KgNGmhBGLuNXll5FOCqOt7a1xz2V3bIyrWh/U+eAyvBb2E5g0YzUXjBr+tP
 GIeg==
X-Gm-Message-State: AOAM5318nJ4gcHw5l2PbY25vx9dk0T4IyifCPRg1NSHapZrQrnQekRMV
 Eu+VohOFLJBLJ4M/bleHWujPKsUZNcI=
X-Google-Smtp-Source: ABdhPJxDqfy9grce4lnzimGRNfvr4PUNGpKbtsfaYfR4JnNRxSKDAXUDCmTdm9bVnXKMY1zZcYdtxg==
X-Received: by 2002:a17:903:4094:b029:12d:242e:a68e with SMTP id
 z20-20020a1709034094b029012d242ea68emr4810396plc.82.1628697712145; 
 Wed, 11 Aug 2021 09:01:52 -0700 (PDT)
Received: from bobo.ibm.com ([118.210.97.79])
 by smtp.gmail.com with ESMTPSA id k19sm6596494pff.28.2021.08.11.09.01.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Aug 2021 09:01:51 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v2 03/60] KVM: PPC: Book3S HV P9: Fixes for TM softpatch
 interrupt NIP
Date: Thu, 12 Aug 2021 02:00:37 +1000
Message-Id: <20210811160134.904987-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210811160134.904987-1-npiggin@gmail.com>
References: <20210811160134.904987-1-npiggin@gmail.com>
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
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The softpatch interrupt sets HSRR0 to the faulting instruction +4, so
it should subtract 4 for the faulting instruction address in the case
it is a TM softpatch interrupt (the instruction was not executed) and
it was not emulated.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kvm/book3s_hv_tm.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_tm.c b/arch/powerpc/kvm/book3s_hv_tm.c
index cc90b8b82329..e7c36f8bf205 100644
--- a/arch/powerpc/kvm/book3s_hv_tm.c
+++ b/arch/powerpc/kvm/book3s_hv_tm.c
@@ -46,6 +46,15 @@ int kvmhv_p9_tm_emulation(struct kvm_vcpu *vcpu)
 	u64 newmsr, bescr;
 	int ra, rs;
 
+	/*
+	 * The TM softpatch interrupt sets NIP to the instruction following
+	 * the faulting instruction, which is not executed. Rewind nip to the
+	 * faulting instruction so it looks like a normal synchronous
+	 * interrupt, then update nip in the places where the instruction is
+	 * emulated.
+	 */
+	vcpu->arch.regs.nip -= 4;
+
 	/*
 	 * rfid, rfebb, and mtmsrd encode bit 31 = 0 since it's a reserved bit
 	 * in these instructions, so masking bit 31 out doesn't change these
@@ -67,7 +76,7 @@ int kvmhv_p9_tm_emulation(struct kvm_vcpu *vcpu)
 			       (newmsr & MSR_TM)));
 		newmsr = sanitize_msr(newmsr);
 		vcpu->arch.shregs.msr = newmsr;
-		vcpu->arch.cfar = vcpu->arch.regs.nip - 4;
+		vcpu->arch.cfar = vcpu->arch.regs.nip;
 		vcpu->arch.regs.nip = vcpu->arch.shregs.srr0;
 		return RESUME_GUEST;
 
@@ -100,7 +109,7 @@ int kvmhv_p9_tm_emulation(struct kvm_vcpu *vcpu)
 		vcpu->arch.bescr = bescr;
 		msr = (msr & ~MSR_TS_MASK) | MSR_TS_T;
 		vcpu->arch.shregs.msr = msr;
-		vcpu->arch.cfar = vcpu->arch.regs.nip - 4;
+		vcpu->arch.cfar = vcpu->arch.regs.nip;
 		vcpu->arch.regs.nip = vcpu->arch.ebbrr;
 		return RESUME_GUEST;
 
@@ -116,6 +125,7 @@ int kvmhv_p9_tm_emulation(struct kvm_vcpu *vcpu)
 		newmsr = (newmsr & ~MSR_LE) | (msr & MSR_LE);
 		newmsr = sanitize_msr(newmsr);
 		vcpu->arch.shregs.msr = newmsr;
+		vcpu->arch.regs.nip += 4;
 		return RESUME_GUEST;
 
 	/* ignore bit 31, see comment above */
@@ -152,6 +162,7 @@ int kvmhv_p9_tm_emulation(struct kvm_vcpu *vcpu)
 				msr = (msr & ~MSR_TS_MASK) | MSR_TS_S;
 		}
 		vcpu->arch.shregs.msr = msr;
+		vcpu->arch.regs.nip += 4;
 		return RESUME_GUEST;
 
 	/* ignore bit 31, see comment above */
@@ -189,6 +200,7 @@ int kvmhv_p9_tm_emulation(struct kvm_vcpu *vcpu)
 		vcpu->arch.regs.ccr = (vcpu->arch.regs.ccr & 0x0fffffff) |
 			(((msr & MSR_TS_MASK) >> MSR_TS_S_LG) << 29);
 		vcpu->arch.shregs.msr &= ~MSR_TS_MASK;
+		vcpu->arch.regs.nip += 4;
 		return RESUME_GUEST;
 
 	/* ignore bit 31, see comment above */
@@ -220,6 +232,7 @@ int kvmhv_p9_tm_emulation(struct kvm_vcpu *vcpu)
 		vcpu->arch.regs.ccr = (vcpu->arch.regs.ccr & 0x0fffffff) |
 			(((msr & MSR_TS_MASK) >> MSR_TS_S_LG) << 29);
 		vcpu->arch.shregs.msr = msr | MSR_TS_S;
+		vcpu->arch.regs.nip += 4;
 		return RESUME_GUEST;
 	}
 
-- 
2.23.0

