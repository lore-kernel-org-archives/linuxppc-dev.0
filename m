Return-Path: <linuxppc-dev+bounces-17622-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2470EEDEBE6
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Mar 2026 19:03:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fQQFH1Zr2z3bsC;
	Wed, 04 Mar 2026 06:03:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::649"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772564627;
	cv=none; b=UfRku93w3B+jTEPIJADlcdXJjy+ZT8IFN27EegJMB/3c3D/0G4lCVDSSfFgK0AeLBllsNDRTrr8OluXhhuS2YWcrAfcVK0/OYFTwrjyOQCCc1Pe4WNWno+ALdjLIwO9jD18HYu5Y3yG2sKTldFjPn5gdPgCKt2xJVS9dF03ESUl0d9l8fuT0JFajNZV4ArPSkgIqJSkGISidqP9DQq6p5/jGHDtrFMbxMoWvWmcLDaePAN5ywr0qdXRprsLnY4cVxpuBQsX1jDPu4XkqLeVBTiC0chqS7uMNN1WhwUKjlN11Yl5Zyk4SdhoaBK5mQ39Z1Enizsk6wNXCsg5c7QWBBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772564627; c=relaxed/relaxed;
	bh=yz3MkihpO/3OgXiBEUXwzX0zyHyXB+v43DwfQqlp7z0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CRHxHz99RhjFPZo+FrpSyHDeviYqHGXhWKbXTbh1+JuBvdcsdg+Md2RRsbbdzeIp1O765r6JJzzw434AhLYnqXJrYZfbV6c6akl+zWP4BF+qH+sbw3aJTSHKJAGr0nS40Qm8yu11HnaQzPjT9v7xUYQU+6NJ0ayJRhKWMXOcAcQN3bSALztNBIkwfwReZl7SuipO3SSOCL1bGn/kzucbwfux8ew9n8vTf3VZNjFDaPHtwqR0V2ZRyEdz0rLfZx3pEIuGO+9SFTVDDo8odhrsAqJPcJc+pW94ciz7BvmVLq5UwV8XvjeaC8W5PyQVUCzO4/Ch8h5gnCCcTlhVVN20zg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=ieFuCd6p; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::649; helo=mail-pl1-x649.google.com; envelope-from=3kdcnaqykdoevhdqmfjrrjoh.frpolqxassf-ghyolvwv.rcodev.ruj@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=ieFuCd6p;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::649; helo=mail-pl1-x649.google.com; envelope-from=3kdcnaqykdoevhdqmfjrrjoh.frpolqxassf-ghyolvwv.rcodev.ruj@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQQFG1hkBz3bp0
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Mar 2026 06:03:46 +1100 (AEDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-2ae59e057f1so24721065ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Mar 2026 11:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772564624; x=1773169424; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=yz3MkihpO/3OgXiBEUXwzX0zyHyXB+v43DwfQqlp7z0=;
        b=ieFuCd6p0QaGOC9pm0aEJBy018MmOMhi+IDIhX07IMnDtzXZ7tg8JgZuhTUTapq5aR
         BU+1ls6cEthy5qWbK2csjNPLmywE2tZTOw9fiU1GApET8MyakfiXGID2UtngmSZDOVjX
         MBjTgpmtlK+CJedT8xCoKPHvJSRQ/Nb0EPde8p22U+6AMGaRrm2d03NrBPXmGfae+XwV
         seLL2F9dwarwl3YwW63xfziqCOyHVjvmSfddSr3bpZLvjkohmwxI6KK7twNoiiOGnpzf
         lPrhdhPkuSLmUr5zzgLhlKJakI9ySOqfyFLmZUMGaRK5qdkgylJpwwhRbaW98xRGmvHL
         iuyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772564624; x=1773169424;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yz3MkihpO/3OgXiBEUXwzX0zyHyXB+v43DwfQqlp7z0=;
        b=XCrwxPJyL2C8t1TWQnzyJRQjOc6aYfjySRD5xeqNSay9CxCKwCjd5Z4n9lQuDxk8Hw
         lvzdmiI7qaz3EpJ0aLOOD0W3C2M19HSgE+dsqBp4LtRFdSLAaravZl6P4ZuTLBVvzl4Z
         tNVoUzrFz37X/0HlGTBDgdYv4PcDnmVbFHpItpd90NooC84aAAv/RyuAr4t9TRe2xxCZ
         ZxOAicrBpNrOcvfqcFaIO+5XaD7AJiTKT1xJblTSkOX/UUD7ckVFFJ2Vv/PFqhZZ77bI
         li9kNVnMQkx7ebG6hOtDuZ5OkzWHJRSwiR/69QZQdgH850UDuj9QPRn6Va290eQlmY9w
         +2sw==
X-Gm-Message-State: AOJu0YyQQTj7k4trTc3R8hPH3+KDuaLq0lNv5yJe60BMi63PLwfltYd8
	x3P48YDJR8L46qBa8aHI8PIHGY0KjakvE4icONXhADgXAI/p9SbA9ZBjQrk6Ez7K6jEzYztUprN
	SG10ObA==
X-Received: from plcm18.prod.google.com ([2002:a17:902:f212:b0:2ae:5419:3a0a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1aad:b0:2a9:47d0:12cb
 with SMTP id d9443c01a7336-2ae2e401dabmr174603315ad.22.1772564624033; Tue, 03
 Mar 2026 11:03:44 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  3 Mar 2026 11:03:38 -0800
In-Reply-To: <20260303190339.974325-1-seanjc@google.com>
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
References: <20260303190339.974325-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260303190339.974325-2-seanjc@google.com>
Subject: [PATCH 1/2] KVM: PPC: e500: Fix build error due to using
 kmalloc_obj() with wrong type
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Fix a build error in kvmppc_e500_tlb_init() that was introduced by the
conversion to use kzalloc_objs(), as KVM confusingly uses the size of the
structure that is one and only field in tlbe_priv:

  arch/powerpc/kvm/e500_mmu.c:923:33: error: assignment to 'struct tlbe_priv *'
    from incompatible pointer type 'struct tlbe_ref *' [-Wincompatible-pointer-types]
  923 |         vcpu_e500->gtlb_priv[0] = kzalloc_objs(struct tlbe_ref,
      |                                 ^

KVM has been flawed since commit 0164c0f0c404 ("KVM: PPC: e500: clear up
confusion between host and guest entries"), but the issue went unnoticed
until kmalloc_obj() came along and enforced types, as "struct tlbe_priv"
was just a wrapper of "struct tlbe_ref" (why on earth the two ever existed
separately...).

Fixes: 69050f8d6d07 ("treewide: Replace kmalloc with kmalloc_obj for non-scalar types")
Cc: Kees Cook <kees@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/powerpc/kvm/e500_mmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/e500_mmu.c b/arch/powerpc/kvm/e500_mmu.c
index 48580c85f23b..75ed1496ead5 100644
--- a/arch/powerpc/kvm/e500_mmu.c
+++ b/arch/powerpc/kvm/e500_mmu.c
@@ -920,12 +920,12 @@ int kvmppc_e500_tlb_init(struct kvmppc_vcpu_e500 *vcpu_e500)
 	vcpu_e500->gtlb_offset[0] = 0;
 	vcpu_e500->gtlb_offset[1] = KVM_E500_TLB0_SIZE;
 
-	vcpu_e500->gtlb_priv[0] = kzalloc_objs(struct tlbe_ref,
+	vcpu_e500->gtlb_priv[0] = kzalloc_objs(struct tlbe_priv,
 					       vcpu_e500->gtlb_params[0].entries);
 	if (!vcpu_e500->gtlb_priv[0])
 		goto free_vcpu;
 
-	vcpu_e500->gtlb_priv[1] = kzalloc_objs(struct tlbe_ref,
+	vcpu_e500->gtlb_priv[1] = kzalloc_objs(struct tlbe_priv,
 					       vcpu_e500->gtlb_params[1].entries);
 	if (!vcpu_e500->gtlb_priv[1])
 		goto free_vcpu;
-- 
2.53.0.473.g4a7958ca14-goog


