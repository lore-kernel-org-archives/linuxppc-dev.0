Return-Path: <SRS0=7E7R=OX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7E8C65BAE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 03:19:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0AD72086D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 03:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxR198Pi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0AD72086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43GG3l4Dj1zDr1X
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 14:18:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lxR198Pi";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=sjitindarsingh@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="lxR198Pi"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43GFv73wc5zDr68
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Dec 2018 14:11:31 +1100 (AEDT)
Received: by mail-pl1-x644.google.com with SMTP id g9so2033844plo.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Dec 2018 19:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=LvmJuwwziss2COckjTxUbK8p0ozKauVVNTpVJ1JHZwE=;
 b=lxR198PigJvuE5IhDNlzXrA8TlcbjZFBjWcWrvRvQMNuoTcfFLjc7gX9Cljve87TEx
 fntxyFeO+RTRZf5AadqAUbz9ErckvcBGtppQzJdE/B41PsMPF/wt7k7cHFx46sDHIXzK
 Ohe9s1v94iWdNeofuvFmdixh80Rmr63NmszcUM8oZ/rwR2rHMnSKS/mlwgnbR8eWLIAG
 UK/E1uHSy8ysOjc0Av5XeSmSqY9jSxtcePFSznRQUkpHekULmptoeArdXiP6/6Micorw
 xgbj9NsKKhNpf3aRy6L/vvq8ckaSZiHboGXO4cvFEFRn4Mvnii1D48TmfTjMOJqWy4I2
 lE0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=LvmJuwwziss2COckjTxUbK8p0ozKauVVNTpVJ1JHZwE=;
 b=EoFAuQzAVt4JsuWXdELOS2Gk/Ov0SGceoi5FWUN8Zq0s3QRwaE+Kr6EjF+MnYrd6UU
 2nvTJ8tmKB+eWohnV47f7tTc5rTRhAUf1z9SRd5fDm6LOV4CDz4WTPx6/RVkjj8OOskM
 X7YGPkCCX4lXw6aoHYICXuTdh0R9LDsUnrRfTgQxX9QJeEUr47hlx2KjwomFB22l1Ksp
 v//VKynr/5F7WS/sxpFfI/HrKzzx1edF8kSAPjXtF6y4e1r88satysa71GXxtuLNNcHA
 fS1TTu/CpBY9IGAwec4AzUdh3xcVPllrUf9WjOblFXhEMsNN03NQI/CXoosAyAhP99Qm
 LthQ==
X-Gm-Message-State: AA+aEWait5PKY+BjY+I7R3FaVnK/4AZvFuEJQno/QqVLnu0Kkw0YI36Z
 4j2x8Zq+JG8NL4Ue3jNEoTU=
X-Google-Smtp-Source: AFSGD/WJZy9RzJOV+jL4k5ICJ7kZ1CzWq+6x7jJN1ucZNsJpNBpQgjqr7vN0rmP8j4AodFtivOSEsg==
X-Received: by 2002:a17:902:e290:: with SMTP id
 cf16mr1364030plb.81.1544757089677; 
 Thu, 13 Dec 2018 19:11:29 -0800 (PST)
Received: from surajjs2.ozlabs.ibm.com.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id e188sm4079326pfg.130.2018.12.13.19.11.25
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 13 Dec 2018 19:11:28 -0800 (PST)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH V3 2/8] KVM: PPC: Book3S HV: Add function kvmhv_vcpu_is_radix()
Date: Fri, 14 Dec 2018 14:11:03 +1100
Message-Id: <20181214031109.14464-3-sjitindarsingh@gmail.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20181214031109.14464-1-sjitindarsingh@gmail.com>
References: <20181214031109.14464-1-sjitindarsingh@gmail.com>
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
Cc: aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org, sjitindarsingh@gmail.com,
 kvm@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

There exists a function kvm_is_radix() which is used to determine if a
kvm instance is using the radix mmu. However this only applies to the
first level (L1) guest. Add a function kvmhv_vcpu_is_radix() which can
be used to determine if the current execution context of the vcpu is
radix, accounting for if the vcpu is running a nested guest.

Currently all nested guests must be radix but this may change in the
future.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 arch/powerpc/include/asm/kvm_book3s_64.h | 13 +++++++++++++
 arch/powerpc/kvm/book3s_hv_nested.c      |  1 +
 2 files changed, 14 insertions(+)

diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index 6d298145d564..7a9e472f2872 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -55,6 +55,7 @@ struct kvm_nested_guest {
 	cpumask_t need_tlb_flush;
 	cpumask_t cpu_in_guest;
 	short prev_cpu[NR_CPUS];
+	u8 radix;			/* is this nested guest radix */
 };
 
 /*
@@ -150,6 +151,18 @@ static inline bool kvm_is_radix(struct kvm *kvm)
 	return kvm->arch.radix;
 }
 
+static inline bool kvmhv_vcpu_is_radix(struct kvm_vcpu *vcpu)
+{
+	bool radix;
+
+	if (vcpu->arch.nested)
+		radix = vcpu->arch.nested->radix;
+	else
+		radix = kvm_is_radix(vcpu->kvm);
+
+	return radix;
+}
+
 #define KVM_DEFAULT_HPT_ORDER	24	/* 16MB HPT by default */
 #endif
 
diff --git a/arch/powerpc/kvm/book3s_hv_nested.c b/arch/powerpc/kvm/book3s_hv_nested.c
index 401d2ecbebc5..4fca462e54c4 100644
--- a/arch/powerpc/kvm/book3s_hv_nested.c
+++ b/arch/powerpc/kvm/book3s_hv_nested.c
@@ -480,6 +480,7 @@ struct kvm_nested_guest *kvmhv_alloc_nested(struct kvm *kvm, unsigned int lpid)
 	if (shadow_lpid < 0)
 		goto out_free2;
 	gp->shadow_lpid = shadow_lpid;
+	gp->radix = 1;
 
 	memset(gp->prev_cpu, -1, sizeof(gp->prev_cpu));
 
-- 
2.13.6

