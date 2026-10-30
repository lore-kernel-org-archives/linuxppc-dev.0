Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27D7606A981
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 21:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Intd14Fj
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGYv44mPGz3c03;
	Sat, 31 Oct 2026 08:21:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793395296;
	cv=none; b=o16/oD3mt2yad/VhXkYDmjaV4018RsXYFPEJfsxqXebDH29PEuQdouD+QI6MpUbQUr1giB7zTvjVFL2AgKbzETsxbDX7s+4v7vnHxLmGj3Mkcgv68WbN2Yda5YKMd30BLbnxY7RGtVOUARt9lQ9kwUCGetwKd18yt+s2iEJwEDVIQKXW4YwwwO8PJb32LYI5clAq7rVS0u5CPCUlGD6/xmIBALIgbEKf1uTv5iLA2SR8ZGvx/Wm5EEA+tJyKgVQwZrjq59VXQIacPQVjprrlgb9PuHSOxpCwJhosBVaXJxodRnHq9dkVy6dguv31ltUoJQQD2Wgsa9+PqPPC51XVzA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793395296; c=relaxed/relaxed;
	bh=ThXh/PpZVawaCwOY2TL0ZJCsO7ZffHOqKGZR+ZoMMAE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dSW/uQIUo/npr4kxMA57fNDoYtYR++NAqv+A5BdF/3ws4B9TnB2F27d2Qsi5x/1epPdGmSigbdJ37Zw6WibrIu50Gq78WJ39jxTOPqpyTHNHakz0ofW6Z9f4mho53M1rWUiiStT5G94FrFNcdAi1H3AX6xKXhzm9AxskK0taDDsW6Kebcegm93xV3jPaswNg2omm8Xk4ViDer2NE8c42JGXU3BlJdTPDHyWchherRXVbyUkjzoq9OCu7wHegmA5ltRZ7gZoggA+Xo0A7uLbUFMYb233bDRzV+o3dST0FvVRTAHMIb8fPR27RhVpWPG4P0VmtPPgN6txG+4GMvBwP+g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Intd14Fj; dkim-atps=neutral; spf=pass (client-ip=209.85.216.70; helo=mail-pj1-f70.google.com; envelope-from=3xqrlagykdgqugcpleiqqing.eqonkpwzrre-fgxnkuvu.qbncdu.qti@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Intd14Fj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=209.85.216.70; helo=mail-pj1-f70.google.com; envelope-from=3xqrlagykdgqugcpleiqqing.eqonkpwzrre-fgxnkuvu.qbncdu.qti@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGYv40H91z3bx1
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Oct 2026 08:21:35 +1100 (AEDT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3adeba76cadso824926a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 14:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793395293; x=1794000093; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ThXh/PpZVawaCwOY2TL0ZJCsO7ZffHOqKGZR+ZoMMAE=;
        b=Intd14FjaWhHdq8f001a1lTE1H3xhaf3/ND3GBT8/mKwRS4j2nfiOl8p15v/O3LDBP
         yQxaX6AaMzccQFnzIdUGJ0X8qkhTx6Ac4odL/U9IokPJw3s027YOHDWN2YhTZE2+3TBf
         NltRyqzxGgtTipIX8KFzLGWi8v2xpxcW6nBcsChgqKD8+zbrz+dQWvIllmMJ7KKdsxFP
         KAT8hMyJ8t7oT4XLC8ALADnx9P2NMDRBKpYRvCNPrcEJqlWhFOODNli/KDt4byICONTf
         b55yBP7hp3KlnFNiCf0Xx05qluCZP5vbIo9T7xqgV1/HBdTYnFxQw3NiwdYdqI/hlLlo
         ABSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395293; x=1794000093;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ThXh/PpZVawaCwOY2TL0ZJCsO7ZffHOqKGZR+ZoMMAE=;
        b=qIN2TPGx5TF3ibZiO8+injD6/n1McTfQaWJtZ5wxwnRHDCkBAXXpEVPSO2XPD4vWGB
         ntJYdGedvymP0Puz1otAh1OXza9V8j24PRvwQGgceRv7BnFmND9T2pQ92DYG6IVhDWAE
         lq0i3ty5XtwLjnuEhbRv5qUmWabPowtuRGTykgVDsZ9zIpy32gMGCTwXiLEY3qUFoxiL
         rAywhYJ6fA7Vp5qHJ7ERo+MCRjcdx0PVRVt6vycfG5NAYU37NXjO8q3psPrFL2hevApm
         Tri9YCEWju4u7HWkZBczRpkqdlDsxFT5qxWijFRVkUz+M4yVWqRi2kjT18e6wCsQWLzn
         JS2A==
X-Forwarded-Encrypted: i=1; AKwUvByerh954pw43U+Ht90vR/UFG6qS9Q4pv/ck99N9IpfhCxfhD5ElZnwzw4qXIHQeXAhO+/6EZ6w6b1Q9hg4=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYId1qi50F3EkeijqNNlczWjIMaNSDVNPtUl/hhFV2XC+ufGnPb/
	BosX/u4YFD6rMYWsyhvQZLLaFRf2ra1yEnMFMoRGodzzoL6yXo18eupP+Y0YToYHC0rjHy2q9iZ
	H8fIWJA==
X-Received: from pjbir4.prod.google.com ([2002:a17:90b:4684:b0:3a8:74c5:5a5c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2741:b0:3a0:e4ce:31fd
 with SMTP id 98e67ed59e1d1-3ae896f8304mr3027164a91.10.1793395293218; Fri, 30
 Oct 2026 14:21:33 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 30 Oct 2026 14:21:04 -0700
In-Reply-To: <20261030212112.2598640-1-seanjc@google.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261030212112.2598640-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261030212112.2598640-17-seanjc@google.com>
Subject: [PATCH v4 16/23] KVM: VMX: Explicility free vmcs01, not the current
 VMCS, in vCPU free paths
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	James Houghton <jthoughton@google.com>, Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Explicitly free vmcs01 instead of the currently loaded VMCS when freeing a
vCPU, as relying on loaded_vmcs to point at vmcb01 is unnecessarily risky
and confusing.  E.g. during vCPU creation, the error path relies on setting
loaded_vmcs and obfuscates that it should be impossible for vmcb02 to be
allocated, let alone active.  Similarly, if KVM were buggy and left vmcb02
as the current vCPU when freeing a vCPU, operating on loaded_vmcs would hit
a use-after-free *and* leak vmcs01.

Because KVM isn't buggy, no functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index d433cd846ac4..2ef1f634e7ec 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7515,7 +7515,7 @@ void vmx_vcpu_free(struct kvm_vcpu *vcpu)
 		vmx_destroy_pml_buffer(vcpu);
 	free_vpid(vmx->vpid);
 	nested_vmx_free_vcpu(vcpu);
-	free_loaded_vmcs(vmx->loaded_vmcs);
+	free_loaded_vmcs(&vmx->vmcs01);
 	free_page((unsigned long)vmx->ve_info);
 
 	if (vmx_can_use_ipiv(vcpu))
@@ -7614,7 +7614,7 @@ int vmx_vcpu_create(struct kvm_vcpu *vcpu)
 	return 0;
 
 free_vmcs:
-	free_loaded_vmcs(vmx->loaded_vmcs);
+	free_loaded_vmcs(&vmx->vmcs01);
 free_pml:
 	vmx_destroy_pml_buffer(vcpu);
 free_vpid:
-- 
2.56.0.385.gac671c819a-goog


