Return-Path: <linuxppc-dev+bounces-24753-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F097C531CC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jul 2026 00:48:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5q951gKNz2yps;
	Fri, 24 Jul 2026 10:48:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::646"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784854089;
	cv=none; b=SqJtk/y8V71ZX2lUszsVQTgmz0dY6RQSm+xZOnbp9Cw4nXlaMNu24qHYYrh1PlyTYrso3OcHAbiVijt6t0uuDhRwkDTAGkb4NcgUKhX3vIIlYifEyc/aBfMo/bfJ4BOgMfuEzKIoBP2JLOEE8KkGhy+dai8l8b1O8ZeH/EDAZtRHlG1zdlgeP1t2NS2cG/5PAXFsyXNx9vuauDciDEOKJVWcOYo/4ZtqGdfas/DLxqbXg2iQqMvjoXaxAI4IuS3iy1c1GJ+wd4LAJ+DttqVw57bC87d6ETo/SH5yZ2FIy3M9B2/9tHXvJL7fzE2/bFSiLmFkpWwih0QNhiTTVJ1R4g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784854089; c=relaxed/relaxed;
	bh=tr4QID59hK65Du0CDEGLYDncOCtn06VQ/PfFkprj5Bw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KyM+08UJ24UzNOubqLbCr8Cmcq2A6OgNaraR/3P5wd4OIXbD/iImiYri+RHEsbKWYyv+Tt0U+KTIobYSEL5mB9q46mcGWNN3PsF2O87QE2mhXo/1Mhk1wgiss9PdX7pz/TmXAc8ooKxHuL/unntlVFsTr2y3LVfwXknMmA44AKN0gEqPxkNpFVRWnHJu+Z5Z15h9xg6Mq8KUVnYmZlMAuL0pJnPNN1o+JStub4DfFMq49RxLTvuFGzxdoZHhotSh14+NGuqRAm3R9KHLkRwYkOV2B9BrDcua2GZ/4qXMgxMUjzFoIeepF35aTczIMYTkXTQPROXgg0cmnIV6wLWRng==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=pI0pa2SY; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::646; helo=mail-pl1-x646.google.com; envelope-from=3rrziagykdjcj51ea37ff7c5.3fdc9elogg3-45mc9jkj.fqc12j.fi7@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=pI0pa2SY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::646; helo=mail-pl1-x646.google.com; envelope-from=3rrziagykdjcj51ea37ff7c5.3fdc9elogg3-45mc9jkj.fqc12j.fi7@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x646.google.com (mail-pl1-x646.google.com [IPv6:2607:f8b0:4864:20::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5q943dPQz2ymg
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jul 2026 10:48:08 +1000 (AEST)
Received: by mail-pl1-x646.google.com with SMTP id d9443c01a7336-2cae455cf6dso19762665ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2026 17:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784854086; x=1785458886; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tr4QID59hK65Du0CDEGLYDncOCtn06VQ/PfFkprj5Bw=;
        b=pI0pa2SYURFLEh1Tu9HZHj3S33GcVS/UVlCVoON7mthRA7go5JrQsIVkaa2w196Gzb
         W0F4rPNVQcm8zbKbVE/LWzXIgMkq9u6sK2O3qRA7MT9iE5D1fT2aImGWUD5ZJYWT5fkH
         dU7UNd6XXbmJxviK/emwAoYTtQccYF2U4yX62rvU7yAMDysWO+58me8aqzI2xPdSy/O6
         +FykXGYTYBJdBjNUoOdtL0DO72P3lhb31hwZ8SBbTE7HYFZYG7nLc8z3ZbIFcU5Cp5Pe
         busPKFHs6W9iBz3Z5QRWgXIimmgkSvw/oYXx17qr/G2JdUTixPKFBAEe8aRo8Udrbk4v
         +ZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784854086; x=1785458886;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tr4QID59hK65Du0CDEGLYDncOCtn06VQ/PfFkprj5Bw=;
        b=n3MJ8j4Fn8WNvO1o+ImxblXXQMADom91lONA8Yy5ryxP1u0eHNXZJsVFKhe7vG8z4T
         hh3Tci4JaTqF4Cy/9t+0Y4c34PYmDAGJhgjJoxuADVD2SIu5pEhLJl0jjOQjMmLPUZQM
         lSMI1kHBen2wyD+YaWgmOWNcPzbnLUSTHXlvYWsYCadTCuyiUVSjxJcZhr26xjmvUiEb
         OmpVU1u+93JFpMMb+xxExq0nA7GshffwFybexEFNuGwtmUpPLQwawpmkp/yPddGAxMCx
         zQ6oVIwHf3/UVDUSuC2FceVHxkL6Fll3SsEXdYbt6iLhap923s+4b1fS+28J3JR2E7C6
         Pv5g==
X-Forwarded-Encrypted: i=1; AHgh+RqDYhTSqSt8HEC1R0bP/b03rJGUr+2Tch6mfbaLXyIVHRiyNdeSm+gUWQW8nlPth+qn+T5a5IEt6sbZ+7I=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzdv6kh+q8qUd0oWJUjoFgWUEvBB77OUDWTubbEpat/msxdQhhz
	AG+P6fdalkKGryIUbOBiSJtFw5dul8p8f6Dy0S+poYoTbUAKIoutPSKL6bsJSprny1dDnw/Yc4/
	yjL/Y/w==
X-Received: from plbli8.prod.google.com ([2002:a17:903:2948:b0:2ce:9c01:be21])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d54c:b0:2ce:7563:70a5
 with SMTP id d9443c01a7336-2cfa71b8455mr70685705ad.6.1784854086369; Thu, 23
 Jul 2026 17:48:06 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 23 Jul 2026 17:47:55 -0700
In-Reply-To: <20260724004757.131420-1-seanjc@google.com>
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
References: <20260724004757.131420-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260724004757.131420-5-seanjc@google.com>
Subject: [PATCH 4/6] KVM: nVMX: Use CLASS(kvm_vcpu_map_local_readonly) for MSR
 bitmap merging
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Convert the kvm_vcpu_map_readonly() usage in nVMX's MSR bitmap merging to
the new CLASS(kvm_vcpu_map_local_readonly) implementation, to eliminate the
last of the open-coded on-stack "struct kvm_host_map" declarations (in x86,
PPC still has one more to convert).

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index f2518d67e7de..ef79769c6287 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -730,7 +730,6 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
 	int msr;
 	unsigned long *msr_bitmap_l1;
 	unsigned long *msr_bitmap_l0 = vmx->nested.vmcs02.msr_bitmap;
-	struct kvm_host_map map;
 
 	/* Nothing to do if the MSR bitmap is not in use.  */
 	if (!cpu_has_vmx_msr_bitmap() ||
@@ -753,10 +752,11 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
 			return true;
 	}
 
-	if (kvm_vcpu_map_readonly(vcpu, gpa_to_gfn(vmcs12->msr_bitmap), &map))
+	CLASS(kvm_vcpu_map_local_readonly, m)(vcpu, gpa_to_gfn(vmcs12->msr_bitmap));
+	if (m.ret)
 		return false;
 
-	msr_bitmap_l1 = (unsigned long *)map.hva;
+	msr_bitmap_l1 = (unsigned long *)m.map.hva;
 
 	/*
 	 * To keep the control flow simple, pay eight 8-byte writes (sixteen
@@ -836,8 +836,6 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
 
 	nested_vmx_merge_pmu_msr_bitmaps(vcpu, msr_bitmap_l1, msr_bitmap_l0);
 
-	kvm_vcpu_unmap(vcpu, &map);
-
 	vmx->nested.force_msr_bitmap_recalc = false;
 
 	return true;
-- 
2.55.0.229.g6434b31f56-goog


