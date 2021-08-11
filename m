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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F59AC4338F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Aug 2021 16:35:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC44460FE6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Aug 2021 16:35:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EC44460FE6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GlFn43J9Hz3gWq
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Aug 2021 02:35:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=XpfG/oBD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::633;
 helo=mail-pl1-x633.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=XpfG/oBD; dkim-atps=neutral
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GlF4H289cz3dK6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Aug 2021 02:03:59 +1000 (AEST)
Received: by mail-pl1-x633.google.com with SMTP id e15so3275750plh.8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Aug 2021 09:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YPJZZMuZFYpGZBXtppoHRcw+wdz7vh9/1f9Siez1f5U=;
 b=XpfG/oBD/a2Of074nJtLK0nL3jxrc8SSKSvketXMz4tho9Dvh/lmWNL63BCD9CAvKN
 /XydlZXVqvakb4ONKYLsrTAsRx0mfFBGQ+UD3MRqxcgQ9vJpx0+wZZGbKMubM2Bsw2ky
 XLcMWNInfU66kcJxbu9nqBvXviXq5tYnWgBvdvqpwNvNwbKzAU9QMRvblIEyi1x01RdT
 g7MdZ+JZJTHKNxkxY2lf6842EI/GuW7GqrQc2YSwzK0ALL048t7ZVqSN7Ku6xFZgjZ0n
 MJXn3n6ddYQzJkK1twTOSMFpLbEjeTdbiG/E6ZVJ/PcvTGCaq0NKIZGSWGN3ULmwa8Be
 QrMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YPJZZMuZFYpGZBXtppoHRcw+wdz7vh9/1f9Siez1f5U=;
 b=Mrjs66FTQe9utplvloAtDdxe74ssbV/hTH610sz30JXV1kT7xmz5QPMnsDRIR0xCL1
 Qro0JR2iWHbB3YeCSF2d1hGNZSPkwrnQ5XKEw39E1X7Q9luKY5k2w8S2sOufOeNBWhO+
 kckStwjd3Qhj4NFWhiE3Ovu/mgtMbsCGdp5yvegFwb1eOmiFL++dbizfGN+GZTTLLNpG
 J3KeY5NO6xchKAeIT0N25vjxtUl0GCmumv/bc5A6Ov5vE+jU87mUx9+CmRIULFq32wnE
 EQashC7fBwb87ZzwtoO6cGK6wQV2Q9SciSf+xhnsdrn9LYwkkxUUEUnms5dl28aoSrV1
 4wDA==
X-Gm-Message-State: AOAM532LMgrSKObU13YMC8bJ7JgSf56JbTbApOx8qI5dqwkH0plVgDq7
 Gy8WklMB6uERxQYJXFFkaQg=
X-Google-Smtp-Source: ABdhPJwmzGFeCI5I2sRo2QfWGQYCu8NZ4sdLy7ZTEWbY5glAA6hY6+suelHJzEopfOWKpWdtSDu5uA==
X-Received: by 2002:a17:902:7611:b029:12b:e55e:6ee8 with SMTP id
 k17-20020a1709027611b029012be55e6ee8mr4878885pll.4.1628697837491; 
 Wed, 11 Aug 2021 09:03:57 -0700 (PDT)
Received: from bobo.ibm.com ([118.210.97.79])
 by smtp.gmail.com with ESMTPSA id k19sm6596494pff.28.2021.08.11.09.03.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Aug 2021 09:03:57 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v2 51/60] KVM: PPC: Book3S HV Nested: Avoid extra mftb() in
 nested entry
Date: Thu, 12 Aug 2021 02:01:25 +1000
Message-Id: <20210811160134.904987-52-npiggin@gmail.com>
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

mftb() is expensive and one can be avoided on nested guest dispatch.

If the time checking code distinguishes between the L0 timer and the
nested HV timer, then both can be tested in the same place with the
same mftb() value.

This also nicely illustrates the relationship between the L0 and nested
HV timers.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/kvm_asm.h  |  1 +
 arch/powerpc/kvm/book3s_hv.c        | 12 ++++++++++++
 arch/powerpc/kvm/book3s_hv_nested.c |  5 -----
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_asm.h b/arch/powerpc/include/asm/kvm_asm.h
index fbbf3cec92e9..d68d71987d5c 100644
--- a/arch/powerpc/include/asm/kvm_asm.h
+++ b/arch/powerpc/include/asm/kvm_asm.h
@@ -79,6 +79,7 @@
 #define BOOK3S_INTERRUPT_FP_UNAVAIL	0x800
 #define BOOK3S_INTERRUPT_DECREMENTER	0x900
 #define BOOK3S_INTERRUPT_HV_DECREMENTER	0x980
+#define BOOK3S_INTERRUPT_NESTED_HV_DECREMENTER	0x1980
 #define BOOK3S_INTERRUPT_DOORBELL	0xa00
 #define BOOK3S_INTERRUPT_SYSCALL	0xc00
 #define BOOK3S_INTERRUPT_TRACE		0xd00
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 7d08b826d355..7337c0ca94c6 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -1486,6 +1486,10 @@ static int kvmppc_handle_exit_hv(struct kvm_vcpu *vcpu,
 	run->ready_for_interrupt_injection = 1;
 	switch (vcpu->arch.trap) {
 	/* We're good on these - the host merely wanted to get our attention */
+	case BOOK3S_INTERRUPT_NESTED_HV_DECREMENTER:
+		WARN_ON_ONCE(1); /* Should never happen */
+		vcpu->arch.trap = BOOK3S_INTERRUPT_HV_DECREMENTER;
+		fallthrough;
 	case BOOK3S_INTERRUPT_HV_DECREMENTER:
 		vcpu->stat.dec_exits++;
 		r = RESUME_GUEST;
@@ -1817,6 +1821,12 @@ static int kvmppc_handle_nested_exit(struct kvm_vcpu *vcpu)
 		vcpu->stat.ext_intr_exits++;
 		r = RESUME_GUEST;
 		break;
+	/* These need to go to the nested HV */
+	case BOOK3S_INTERRUPT_NESTED_HV_DECREMENTER:
+		vcpu->arch.trap = BOOK3S_INTERRUPT_HV_DECREMENTER;
+		vcpu->stat.dec_exits++;
+		r = RESUME_HOST;
+		break;
 	/* SR/HMI/PMI are HV interrupts that host has handled. Resume guest.*/
 	case BOOK3S_INTERRUPT_HMI:
 	case BOOK3S_INTERRUPT_PERFMON:
@@ -3978,6 +3988,8 @@ static int kvmhv_p9_guest_entry(struct kvm_vcpu *vcpu, u64 time_limit,
 		return BOOK3S_INTERRUPT_HV_DECREMENTER;
 	if (next_timer < time_limit)
 		time_limit = next_timer;
+	else if (*tb >= time_limit) /* nested time limit */
+		return BOOK3S_INTERRUPT_NESTED_HV_DECREMENTER;
 
 	vcpu->arch.ceded = 0;
 
diff --git a/arch/powerpc/kvm/book3s_hv_nested.c b/arch/powerpc/kvm/book3s_hv_nested.c
index 7bed0b91245e..e57c08b968c0 100644
--- a/arch/powerpc/kvm/book3s_hv_nested.c
+++ b/arch/powerpc/kvm/book3s_hv_nested.c
@@ -375,11 +375,6 @@ long kvmhv_enter_nested_guest(struct kvm_vcpu *vcpu)
 	vcpu->arch.ret = RESUME_GUEST;
 	vcpu->arch.trap = 0;
 	do {
-		if (mftb() >= hdec_exp) {
-			vcpu->arch.trap = BOOK3S_INTERRUPT_HV_DECREMENTER;
-			r = RESUME_HOST;
-			break;
-		}
 		r = kvmhv_run_single_vcpu(vcpu, hdec_exp, lpcr);
 	} while (is_kvmppc_resume_guest(r));
 
-- 
2.23.0

