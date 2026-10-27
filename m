Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DC2606A31A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2026 22:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LYURSyLY
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDl9C5SwRz3bcr;
	Wed, 28 Oct 2026 09:12:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793139151;
	cv=none; b=Ay2JfNMqmVlXh6Xq+nkPU0ncakx9Tlw71JG5GZk3ncBEv3cV4WwBzqJY/kxQEBqlNDdk/xpXYayzQwvwGwTpHIrJCGt1OE0QT4W0YMkRQ8loj8CanHNxdJu2BsOHaZMzlINk4uOhSxWBvWtz8eWcfwTRot/gi+LutlQJSzKccQDR2EP5OefkkN0YAgymRG+K3T8yNSmqRWmTSdUlBmCxVXdlMnKOGukVBinME42A8NUGFhrKLc6nZtc5FGDBqPa/S6UusHGhp0C/gQg0ZSMOPhs7QX/9wwbZVJyXHeu17VfCTzsTIN1cj0+7ce4C1sLpMzk/lfHGP+QokIxz8jZE4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793139151; c=relaxed/relaxed;
	bh=dYm1W2He5BBY6NKWGt29bcYFb4hGcqDS3Vh4Emo9n8Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FPwMtTRXsEPtsTY02RR1Z5GugAZEYUFqeZ3q2aemoXtzGF2TW/gFO18qRGyCQlQ3vTPkddByEH58NuuKcBwBSBwWsjGIOG7vh1tZnZndPmaXriSdjmkh61LL1dgSh225G7EXzqs4YbJzpDcTpRWHrpcfSWdPfQH7+LDxtxQIo3MSHFHCe/NbNwxoI41Edp9OFES1v7x0TSbaKJzgydUDJ/UboJrJcOhNRQ7OFwcohUQ8ak5T04Zxv7Ywjg7AA+ZpvARHE9U3lHpoI+/RM2Kv5E2vh2NeW1XvoombQlXnEDZiUI0cc413YqlUnRyYGI0ua5Uxxh66l128Ox5niwI/VA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LYURSyLY; dkim-atps=neutral; spf=pass (client-ip=209.85.214.199; helo=mail-pl1-f199.google.com; envelope-from=3zchhagykdpelxtgcvzhhzex.vhfebgnqiiv-wxoeblml.hsetul.hkz@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LYURSyLY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=209.85.214.199; helo=mail-pl1-f199.google.com; envelope-from=3zchhagykdpelxtgcvzhhzex.vhfebgnqiiv-wxoeblml.hsetul.hkz@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDl9B6dnVz3bZs
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 09:12:30 +1100 (AEDT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2e601800e58so4444905ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2026 15:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793139148; x=1793743948; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dYm1W2He5BBY6NKWGt29bcYFb4hGcqDS3Vh4Emo9n8Y=;
        b=LYURSyLY+iZ1PN7SHXh1KH8DHbceeJPN6qP/s3Tb9ZftIqp2ZR5AH2YgQQIfr3Phuk
         W/kBudvVnN1XBEv2k2JeNIgYO0LB/4KIxkHB31oess6eh1WKNv78M+GaOx/Cedrt3N+5
         o1Hh9x82d61pVwbT74/FbdsJPjcHqyt9KGIKXsZxWUxGU+IvhsaXiVw1vLHCePy1qJM/
         sG5GOFucKnKiO2coSpdXwx1NIUL8yoBHA0vFuQv1LSTtwrwNB53QKtHtNBJQTFkjykCu
         1W5Eu1u153e8iOsiTsCFDm3mIMNGrJiqSL8wVgX9jiiXrzUj8x8mn70N8aFhZY4K84DL
         c43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793139148; x=1793743948;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dYm1W2He5BBY6NKWGt29bcYFb4hGcqDS3Vh4Emo9n8Y=;
        b=CG5gadxi3C3mW0oi962oZmZE4SxOOK50jD199EMuj6RNvNaVFszDNkvdU9K+wR+cCa
         QRbjS2AFXn3kg1Nc6EC6arW7hAVl7X2HGDSlNWAsK0rrO5sNwSrRF2G3lEVFOxkrxhge
         v8RYfWn7PGNv4jxaYt0RDTYh4CQsoQi9MwmiPGwJ3FcHuI4KsLb024T44jStD/eDVCXP
         RrVUdhINaK7g611HPLg1tzBuq0TZ9sPyiHdaIZX5wLkdx0rdv7oZs+wgLgu5wS4DMG9t
         VBAHIOxnZZIBKCseXHomQxp41ekjG2NkQRPc5wum6KtGh7A6Ze5JfM878plpjnSkDtRQ
         xTyA==
X-Forwarded-Encrypted: i=1; AKwUvByGopOeiyIiHM7aXL/JVcytIPEdRRmRNCUmLZnbXC3lVVvXknS6etBWgbkd3PlOyeRZE8qeFWVadzKHu68=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJGXQW/d1Ed5BMCIVhe4HYN0C8dcXQMsmzule2XXgmGD+8oDYsF
	zPRNjAt+IfEeKb4kKaZKgGjPolYFqxMuctCv+hpIvFoQMYwl1rlFmEjTCH7ddPHpdk7RztYaOz9
	TjiC2jQ==
X-Received: from plrb5.prod.google.com ([2002:a17:902:a9c5:b0:2e8:8642:f035])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:18c:b0:2e9:60fb:5e41
 with SMTP id d9443c01a7336-2eb005809a9mr5348485ad.50.1793139148246; Tue, 27
 Oct 2026 15:12:28 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 27 Oct 2026 15:12:05 -0700
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
Message-ID: <20261027221209.1560865-13-seanjc@google.com>
Subject: [PATCH v3 12/15] KVM: nVMX: Cancel the nested VMX Preemption Timer's
 hrtimer in free_nested()
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

Cancel the hrtimer used to emulate a VMX Preemption Timer for L2 when
freeing nested state instead of precisely canceling the timer if and only
if the vCPU is/was in L2.  hrtimer_cancel() bails early if the timer isn't
running, and KVM initializes the timer when allocating nested state, i.e.
canceling the timer even if it's not fully in-use is glorified nop.

Canceling the timer even if L1 is active will allow KVM to leave the vCPU
in L2 without having to retain an "is_guest_mode()" check just to cancel
timer.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 1b30ad7731ee..553915015a75 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -339,6 +339,8 @@ static void free_nested(struct kvm_vcpu *vcpu)
 
 	kvm_clear_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
 
+	hrtimer_cancel(&vmx->nested.preemption_timer);
+
 	vmx->nested.vmxon = false;
 	vmx->nested.smm.vmxon = false;
 	vmx->nested.vmxon_ptr = INVALID_GPA;
@@ -401,7 +403,6 @@ void nested_vmx_free_vcpu(struct kvm_vcpu *vcpu)
 
 	vcpu_load(vcpu);
 	if (is_guest_mode(vcpu)) {
-		hrtimer_cancel(&vmx->nested.preemption_timer);
 		leave_guest_mode(vcpu);
 		vmx_switch_vmcs(vcpu, &vmx->vmcs01);
 	}
-- 
2.56.0.307.g5fe7bd680c-goog


