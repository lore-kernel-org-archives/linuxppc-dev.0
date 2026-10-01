Return-Path: <linuxppc-dev+bounces-28687-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48084CA5FCE
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Oct 2026 20:22:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hwjyc4KKYz30TY;
	Fri, 02 Oct 2026 06:22:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1046"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790886168;
	cv=none; b=aY/gYTrTjjvjCZAs/xB6UNB+Xpq/OV7/w4xVamP6X+Rr9enOx1CTRydSBAF23fGo9mhrZdi6xmurVnBWPd+GrxNl9nb38CwYfE+joLDkH4MmYZtrZjGXQsdstxhUkZtR7TfE/Fv5d9mRUvArOVawBawSJqfBQ7L2Kt+Ny5HvBQ6I3Qd4mDMTGJgI51bj7JR/wALd9DbyP7gMmz3LMT32hZSWFj1O4EiNiaSfpDyCGI0cvkyUzsplIvOv0h+NLkMUhdgTTL2WNDi4cGAUIOzWFfQQGp9nMRgrhJEo5PBH8zVFBaBzJuQqjsrsslF4LZ2+nCkq+ihPRba12XoNDWRvDw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790886168; c=relaxed/relaxed;
	bh=9PdKaetrQW4UpNDi1+fjAOrwm9Lx9nK7VvLmDqJyyw0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NP69w3g+kdWWLJT7B+c0gjp17T25yzdZl4vwGnKopDhfb/p/2w5HkkSM2DM12BF65uAD2iGNHwB+IEYOJRrUPfrIcmqEqxrvtP1nHB/Ahp6c0IKUtsPm6GGbEOq/4qG1f8WUL7VTupshiihnXBgNpza6OQdJLrLQXylLzxYI+M1cDK2dGTWjojUN8ySGvpLQHeg0T4zCE9i4p5olq3srjhDgVJAkZRBdwn+yT65pRHQXsT4/SqvqfoZOZ9FBremUPJsM61taGecu1QlVoAgeTl5/QiwlEqL+0uAE7pl8M9klxnO9DtLcTsF/xyAnx4SucmKiXoFTR7aPNG1rdCx2TQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=RiVz+EXi; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1046; helo=mail-pj1-x1046.google.com; envelope-from=3fmg-agykdo0htpcyrvddvat.rdbaxcjmeer-stkaxhih.doapqh.dgv@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=RiVz+EXi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::1046; helo=mail-pj1-x1046.google.com; envelope-from=3fmg-agykdo0htpcyrvddvat.rdbaxcjmeer-stkaxhih.doapqh.dgv@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1046.google.com (mail-pj1-x1046.google.com [IPv6:2607:f8b0:4864:20::1046])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hwjyZ6bs0z30DZ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 06:22:46 +1000 (AEST)
Received: by mail-pj1-x1046.google.com with SMTP id 98e67ed59e1d1-39b77130a7fso7274450a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 13:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790886164; x=1791490964; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9PdKaetrQW4UpNDi1+fjAOrwm9Lx9nK7VvLmDqJyyw0=;
        b=RiVz+EXiX69Tun8ubjjh3cLTcuSzQ7K9mDm2z2U2mCjEJJi5Z6Tr46ljpb9nhQWiII
         BKtzN1l5YHglvDFtWXdxeLbzJArqQhlepZhW4zNHP3UW6NyRdaalMih3DEIq8wkNrmcH
         zqTeaBg5QhIXR0cd918S8QEDr4l/ofbaW5HGsSPgi3AFQFTwU7UBp9yTeQP3+T8F5v6u
         YLDsXStooohaIKv4ilA7U6w4BXNZsWHSTylDg37zI/UcIxFgHMG2fG88Eov+hhF2uHEk
         ugH6rPeLoqgvIPYDWVavJDicqJd6ueT8bPVdet2WQCB+OPp42Y82upElD+veoT434URE
         BfXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790886164; x=1791490964;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9PdKaetrQW4UpNDi1+fjAOrwm9Lx9nK7VvLmDqJyyw0=;
        b=Nj6HeKfc1hAIKneWY5DgwBpRi6EA7fX84Pa3VCE+F9LV8PKP0GiJmPTH+STZOqAZv6
         1AM2l29nIXrEf1MiNClC/6sERwvAGUSy06mxCg9V23kEru5bG57hNpqEshwjQQf5RoAB
         PKyJqrdQ7BNRvCIJjzgaAnkmxnr8wMTYRHba/YBNyWRRMVwxJQ5euHfbPzpn1Ef/xTp1
         WG6GLEemRMb6GUhhgTeYvt9j4rPndaV/po+A+tkwW9GvFkAOxoDsGtmmsEP6I520xDOz
         ctgXulDTNWzoAuVPTsQEAgZ4m3NTHrKNJdrwUXFyHb/qWeyaxVvlMWZ3sTqlF5A1qnK2
         y4zw==
X-Forwarded-Encrypted: i=1; AKwUvBwBCMi3Hq5q7AluCBKWTyQbbRtXHX/QNJTeehPldTnnIdaNtHDqMIHCxAjo3875uRfXTibJcSHv6iWyS0A=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKXnSzWcGyV+wRGCGn2sKGS/Eta6EAba6vHolqGt/NA1MeqddX6
	D1ErOq9fKAK1uBQ+/ghk1Q/ZWzMiazpkX4M7PbBxy06l9yszTuFJMIezoPRzORXU4ZEUJ8WhmZt
	KB57glg==
X-Received: from pjsc17.prod.google.com ([2002:a17:90a:bf11:b0:3a4:fe64:e6f4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:58c5:b0:3a0:f559:824d
 with SMTP id 98e67ed59e1d1-3a6ce82b3fbmr576331a91.50.1790886164041; Thu, 01
 Oct 2026 13:22:44 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  1 Oct 2026 13:22:26 -0700
In-Reply-To: <20261001202234.3794060-1-seanjc@google.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
Mime-Version: 1.0
References: <20261001202234.3794060-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261001202234.3794060-3-seanjc@google.com>
Subject: [PATCH v2 02/10] KVM: PPC: Flush/zap all memslots on kvm_arch_flush_shadow_all()
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Flush/zap every memslot in kvm_arch_flush_shadow_all(), i.e. when the
owning userspace process is exiting, as KVM must ensure all associated
memory is unmapped from the guest.

Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/powerpc/include/asm/kvm_host.h |  1 -
 arch/powerpc/kvm/powerpc.c          | 11 +++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 2d139c807577..1c8d9d7360e9 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -903,7 +903,6 @@ struct kvm_vcpu_arch {
 #define __KVM_HAVE_CREATE_DEVICE
 
 static inline void kvm_arch_memslots_updated(struct kvm *kvm, u64 gen) {}
-static inline void kvm_arch_flush_shadow_all(struct kvm *kvm) {}
 static inline void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu) {}
 static inline void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu) {}
 
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 9194cf492d1c..9e9d0865c2f6 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -764,6 +764,17 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 	kvmppc_core_commit_memory_region(kvm, old, new, change);
 }
 
+void kvm_arch_flush_shadow_all(struct kvm *kvm)
+{
+	struct kvm_memory_slot *slot;
+	struct kvm_memslots *slots;
+	int bkt;
+
+	slots = kvm_memslots(kvm);
+	kvm_for_each_memslot(slot, bkt, slots)
+		kvmppc_core_flush_memslot(kvm, slot);
+}
+
 void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
 				   struct kvm_memory_slot *slot)
 {
-- 
2.56.0.rc1.315.gc6ed9934b7-goog


