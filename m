Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDE3606A31D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2026 22:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pj78cvuZ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDl9F6Bhhz3bhG;
	Wed, 28 Oct 2026 09:12:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.214.200
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793139153;
	cv=none; b=mNkpT9/UxYD3Jnot//B0zXgNs/kmGUcbuPXFzSJPihodrtnQof9vLTMHfekMJ6PbBC1ZT4Wk/1U3waGKu1jkBWPKD5Pcj9iHrJoOeN/I7Y9HaeWLkDIYg4HjpDU91Zxwco12Sq4RBMeibtzIxs7+yDwq/E+4526E4yM2Q84X9n8cWTYkFXAluRDDjyVmN6ZIS9TuVvcWQwkpVnaYhCn23SYuDLucIg/Vshk5jFqjxVY77YDFe8oWPpuCnlSeA+1uph3UjKd7F9MLP2J46IHpanxoXgp2aBMCzBsMrWfEdhcxvLmE0GUoPNVi6nsNakCgwWa7Ak+VUIipHFkVUtSuQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793139153; c=relaxed/relaxed;
	bh=LqllTjpYQ11cpzSrufXwFEGHtiXKk3/xQbrtXOylGNw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Fp43OGQovCdvGSHrJoRlvsd93H/FUk04Iu8jI2IvQis0wyvCSlSPuNL9gki6lUd7koEXqpMye9+s2/abP0A29OUBM7wGmlOE72FJ9iA1AfWsbR/qslg9Duaa+P1AX80j5sBVdQUmn6nJfNoN3Y3flBpfKgylgtliFqEjyGIomDPWPtRhX9cGl/4YIPsdNE2zvtoETB3l08o9bpAW29HPF4WEs09qn4X567yNjNXX7a32kFrG1pBTmYUUcN3ko8p8UlYnPBVdharxqnOkMJxSeBTPJ5At8egU1KN6gQ7q0bt+wtE1bdzED+jFyxVS3OtbqftURPI+6sinsIrjDrW6fw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pj78cvuZ; dkim-atps=neutral; spf=pass (client-ip=209.85.214.200; helo=mail-pl1-f200.google.com; envelope-from=3zihhagykdpmnzviexbjjbgz.xjhgdipskkx-yzqgdnon.jugvwn.jmb@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pj78cvuZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=209.85.214.200; helo=mail-pl1-f200.google.com; envelope-from=3zihhagykdpmnzviexbjjbgz.xjhgdipskkx-yzqgdnon.jugvwn.jmb@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDl9F0qk3z3bZs
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 09:12:33 +1100 (AEDT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2eac6e96bd4so3549185ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2026 15:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793139151; x=1793743951; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LqllTjpYQ11cpzSrufXwFEGHtiXKk3/xQbrtXOylGNw=;
        b=pj78cvuZTiUWOnNcFyl7Z7Ikg5eb7dA0Va2yKgoJZOfgU8rI+rpG8IyQpvu0+Nr9oa
         fC6A4rVwe0XMvuTinvCaNLOkFySGagFkIbjPtVkJX4oSfJI/LDutEe5NKlkm1mvlFMOJ
         9wWBRFt0s+VL9V5U2vsMyQjvn2JSseEnRhCSrzXIxL36cxTS53a6RkBFOZEYTDneU4Zu
         1MZMQ9Es8eBMBcI+FF6hKx+j9+i4mHVmqHbCuqPKiNpMXs3ePF8gJCvBwfjJJvrFz0UL
         bB1ulr60A4nU2kzUdEEXbZdVRMrCNftUH10Ke3Ugq3V9szyvMITAosxrwFX3s7vK+VHw
         vEow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793139151; x=1793743951;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LqllTjpYQ11cpzSrufXwFEGHtiXKk3/xQbrtXOylGNw=;
        b=HWsZIYiILHt8n9XcG+bBtfg7XzD7thZWr0X8I7woutWmU8+IqnmzLw49RLNcPSTfWF
         1Gw/XQZb3NLSS2DZPgWsUuAdiaW69xLCpfE6XlXdRkOfuJ/VaCRJm1cx96h3zWyZMJnD
         aeH8YVT2H82AQ/TA9kmgp9oWAdRWY/dfVcTJGT99Wtzq+Acp8jo0tA89PahRGKS6XvPl
         lDYSh2tQcBHul1j9qXtXf7Q5SeKZWA/ShRT23jmYsh50lzryZ8kxP5T6z5kJ6m4HbhqM
         SQ1FqmHsLs0lFBFGwO3KCd5tOzPmkPSVK5lM+DsuvisxHa+9tJxTF/MCvj2wtsHeQD6j
         XnmA==
X-Forwarded-Encrypted: i=1; AKwUvByr+toXs00oQCtAdG7k43rzaAsgu32vFhTdiUeSzpZhF3pHbrEYujpRK2UoHCXqjhqzPz7qzHSIwfKrlyg=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLPWgoD2jVEPsK/XYB59aZnQIkABVBWb3k5aM/tV7yxwdIRMsk/
	pcUVz8GVZY5qpMU3iyx8PFztNqbb+BS1sVMGMSMXXBRUd9jSHtr6hzfZVbJ6DK0BpgapSMLFO3a
	AzKtWgQ==
X-Received: from pjni9.prod.google.com ([2002:a17:90a:8389:b0:3aa:ee30:1a72])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4e83:b0:3ac:7556:8eec
 with SMTP id 98e67ed59e1d1-3ae580dd96bmr289174a91.39.1793139150524; Tue, 27
 Oct 2026 15:12:30 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 27 Oct 2026 15:12:07 -0700
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
Message-ID: <20261027221209.1560865-15-seanjc@google.com>
Subject: [PATCH v3 14/15] KVM: nVMX: Don't switch to vmcs01 when freeing a vCPU
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

Now that neither free_nested() nor vmx_vcpu_free() relies on vmcs01 being
the active VMCS, don't bother switching to L1 and thus vmcs01 when freeing
nested state.

Temporarily keep the vcpu_{load,put}() pair even though the only reason the
vCPU needed to be loaded was to be able to do vmx_switch_vmcs(), as there
was at least one *known* side effect of doing vcpu_load() that KVM was
subtly relying on (taking the vCPU off the PI wakeup list).  I.e. defer
dropping the superfluous load+put to a separate patch so that there's a
dedicated bisection point if there are more lurking dependencies.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 553915015a75..4a8f57eb3277 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -393,19 +393,9 @@ static void nested_vmx_do_vmxoff(struct kvm_vcpu *vcpu)
 	free_nested(vcpu);
 }
 
-/*
- * Ensure that the current vmcs of the logical processor is the
- * vmcs01 of the vcpu before calling free_nested().
- */
 void nested_vmx_free_vcpu(struct kvm_vcpu *vcpu)
 {
-	struct vcpu_vmx *vmx = to_vmx(vcpu);
-
 	vcpu_load(vcpu);
-	if (is_guest_mode(vcpu)) {
-		leave_guest_mode(vcpu);
-		vmx_switch_vmcs(vcpu, &vmx->vmcs01);
-	}
 	free_nested(vcpu);
 	vcpu_put(vcpu);
 }
-- 
2.56.0.307.g5fe7bd680c-goog


