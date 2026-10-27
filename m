Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FA6606A31A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2026 22:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SOg9DFq9
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDl9H0jNFz3bkg;
	Wed, 28 Oct 2026 09:12:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793139155;
	cv=none; b=UWTDKrig4OP5fNVKyCmIZdl48odJ4BnburlhKA6sgLI9RVPYkRAVhwRcihpHD/FcrZ6eOXs//l9dzC5M6JP+A9ZC/4Q9iUgw72/ii/gj/55/bEFwAuUw7WwtvlN9GxEyq1S/O3/3NmfnnAgEnRnyfmSpl/a/XF1oei57uT9X6reSwT8GWvKIN5Q/kaNvRt+vraGUfclkXK0+P75a+vtbuPl6US38uj4bJ8xPvR+s1EHRkn0SArzCApjG0mmQns0QDs7pBk9vcEc3MBDj1xwp80qeyhiQisOeysuTJhBe86HlcYHT1BErJTBpvAtyTYGfPu77GYmeuphbAoep27zd5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793139155; c=relaxed/relaxed;
	bh=uF+GZpKK7NjsO1exIpL/wQvgd3ehG85WpQ6BvbS1JDc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JkfJWSeRKJQDEPMl88hGtlxqzopariSsQoEGYMVJeuI7IdtEXq7C0AGMWxkhzdgXw2mYMxhPZFTuxS9S7BmmEIXR9tXITUR24yKu4HTN9+xrrrVJO87JMpzgNaAxh6lniBz6JKbSOWVcaUwOP+qfCCQ3F1P76bI118b45D139lXCENGgfcU41CbMT83QWqP04QQkwDi8euncSqUCUfrw1RtTFp37IzdX6RrwCyj+1ymUQaNRShUo69LyiIwBTtkc2u+96b6yTUuS/mlvQVkAoGwTET9uxrsrWpg6KyvYADjvKsTdkddoVM608YAYcnt3Ey8llGVb4AajhpOtdPxY5Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SOg9DFq9; dkim-atps=neutral; spf=pass (client-ip=209.85.216.72; helo=mail-pj1-f72.google.com; envelope-from=3zyhhagykdpqoawjfyckkcha.ykihejqtlly-zarheopo.kvhwxo.knc@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SOg9DFq9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=209.85.216.72; helo=mail-pj1-f72.google.com; envelope-from=3zyhhagykdpqoawjfyckkcha.ykihejqtlly-zarheopo.kvhwxo.knc@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDl9G24gYz2ySl
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 09:12:34 +1100 (AEDT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3adcb81f487so505434a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2026 15:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793139152; x=1793743952; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uF+GZpKK7NjsO1exIpL/wQvgd3ehG85WpQ6BvbS1JDc=;
        b=SOg9DFq9LbEdbMVasooozBwzbV44haUWsNtqHulGmhbOucsVQobQdGi4u9yy++gxC0
         BbhBCSMuXtUmuZiF5blH/pfy3bBepzB6jMhV5RZ/rQvAVlzEUsXKUg7QWuGRLeI5ihsF
         1/Zc+V824GlKPT0s/nmvO7x2f3HYLjHmxbCV0uyH7hGR1TwhR70ub5/Rt0E7tTa14BLo
         3e6bsW+xDhUdekY2j2UKdI2G4jabbDC/WH1Q/0vWUbAK9sIKkQvTURL5kj46H+6s3Unj
         sDSuir8pvOVXXbygnOOx4IKmtFGZfs6AQhv8M3PWJrYYyrxs7ypDb4O11OSYZjozGQ5e
         FbFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793139152; x=1793743952;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uF+GZpKK7NjsO1exIpL/wQvgd3ehG85WpQ6BvbS1JDc=;
        b=2fQo8nmCoVf16WaY6GrEvMTW5eUZx0hEEirrv7OqCFUWp7IEvzvSCmUZuynAYzOggJ
         OpwgKfAVsc7jwu1ZXAJqZYXUEkjnb82omKSO0UIED2VwaqBXjFewVg3bptdhbnE1VW8J
         wpP4z9nuNXyN844TVdpftneuD3dB+3hZOF/D6k5fC3K9yTBHsvK5Wf5bGRRco6hgM9gB
         dnvh9YH2hBbXA56H5v8OJjpC91/CnBiDq4v5XcrA1+xuom6UMLnegoIbKP9kWONnFram
         yxe+V4PpFMSt4b4B5dxGjPDuy79Yify+6d3O9U7kc0eCvmmcZ83NbMUCmaARNpMk5Frt
         NceA==
X-Forwarded-Encrypted: i=1; AKwUvBx7OqACo2iUEhiE7rg835UqcbUOe2htVKf691jhkNZ6XMlxhrZ2B+mOWka+pThedpAkJ3fhzbBgA1ZKrxQ=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKo4wnOWOCI8AUi7MDap4LF2wH8n6ZWMMIlbQmsrxtcVkYQdlSd
	p+uupLLB4yOEgqOc967vl7tu/rkGYWpJpugNM7uWuW+EDVY4vkMRr6/HNGN7QYoRslDQN3dR0vN
	wF3ESyg==
X-Received: from pjyp3.prod.google.com ([2002:a17:90a:e703:b0:3a8:28d0:2510])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:17c5:b0:3ad:50a2:9abf
 with SMTP id 98e67ed59e1d1-3ae582adce0mr350233a91.38.1793139151657; Tue, 27
 Oct 2026 15:12:31 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 27 Oct 2026 15:12:08 -0700
In-Reply-To: <20261027221209.1560865-1-seanjc@google.com>
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
References: <20261027221209.1560865-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261027221209.1560865-16-seanjc@google.com>
Subject: [PATCH v3 15/15] KVM: nVMX: Don't load+put the vCPU when freeing
 nested state for a dying vCPU
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

Drop the vcpu_{load,put}() pair when freeing nested state for a dying vCPU,
as nothing in what was free_nested() requires the vCPU to be loaded, common
x86 doesn't require the vCPU to be loaded when it's dying (because SVM
never loads the vCPU), KVM now explicitly handles taking the vCPU off the
PI wakeup list (was subtly being handled by vt_vcpu_pi_load()), and the
rest of vmx_vcpu_load() has no effects outside of loading/modifying the
VMCS or vCPU-specific metadata.

As for put(), because the vCPU obviously can't be loaded at the start of
nested_vmx_free_vcpu(), "guest_state_loaded" can't be true and thus
vmx_prepare_switch_to_host() must be a nop.  Similarly, the vCPU can't be
blocking when it's dying, and so vt_vcpu_pi_put() is also a nop (and if
it's not, that would be a fatal bug as it means the vCPU would be left on
the PI wakeup list after being freed).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 4a8f57eb3277..51183520f64a 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -330,7 +330,7 @@ static void nested_put_vmcs12_pages(struct kvm_vcpu *vcpu)
 	vmx->nested.pi_desc = NULL;
 }
 
-static void free_nested(struct kvm_vcpu *vcpu)
+void nested_vmx_free_vcpu(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
@@ -390,14 +390,7 @@ static void nested_vmx_do_vmxoff(struct kvm_vcpu *vcpu)
 		free_vmcs(shadow_vmcs);
 	}
 
-	free_nested(vcpu);
-}
-
-void nested_vmx_free_vcpu(struct kvm_vcpu *vcpu)
-{
-	vcpu_load(vcpu);
-	free_nested(vcpu);
-	vcpu_put(vcpu);
+	nested_vmx_free_vcpu(vcpu);
 }
 
 #define EPTP_PA_MASK   GENMASK_ULL(51, 12)
-- 
2.56.0.307.g5fe7bd680c-goog


