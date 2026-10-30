Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29542606A323
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 21:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RfAOCVlr
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGYtv2GTYz3bkd;
	Sat, 31 Oct 2026 08:21:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1047"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793395287;
	cv=none; b=T5Xg90RQlxtE6PkHHvoSN+Cd0p3I3ZLtmYmsoOCIEHwf471DOrVh7HRR2AcC9nwZqmutImg6SOPHtINuekpE9OskRzOU6r82v/uEj4dkxfE697MgvT/T0OuZzG2rdrejxc7spOZgbn3Lp5MmYzdL60KzrE3x89s2IhrXp+4uK+5BmKR5+uqmorImtz6kPfj/ojMeOZTQwGAmIK5oQ3x4EjnC87SuZeMiJsAeYfTv3nkvz1tlBPlQBs4Li3l9caZxZqlSscRae/Ojht9PLJMjRqf7d+AaTzWeWcJCYsJ9/Khqok2NQNlSavTgomihLxWZH7KLCP9doIChmiKzGgzMwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793395287; c=relaxed/relaxed;
	bh=4FBcwwQefjg5U9pbFhBbpj/PcCf2fiNl2oUBEHVQucg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Z9DxnRty5Oxxx/1L4FyaEfm8/ZXc+aJ9zgMYeXaEpODrRWdsGKH/3JtoWKQpB+UXToTw0GdjshyU3Bg93wYTWP97uccxMDaMWbNjg7IGgfPfkxvr5zQZHdUqTmzPm8pIc9owgEoLK+DGZR1s3e6U2P04i9MTGPhJa5ok3znZrOaVw6zDVKrWItbsdBoc+BLeNpzVPu2185zC5ZHdUFRT2+l3v4p/ORZTGNFS4JcGxxjivXjS6DmygQvUiXVuDfsAG6z+f6phj/ggrQQhvkEaJ773SKknZUd/K+0IKReT2gJRjzTxVWgmqFXx6gmMSXF0j+tKBs56u+gYgbXvoocjmQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RfAOCVlr; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1047; helo=mail-pj1-x1047.google.com; envelope-from=3varlagykdfsl73gc59hh9e7.5hfebgnqii5-67oeblml.hse34l.hk9@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RfAOCVlr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::1047; helo=mail-pj1-x1047.google.com; envelope-from=3varlagykdfsl73gc59hh9e7.5hfebgnqii5-67oeblml.hse34l.hk9@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1047.google.com (mail-pj1-x1047.google.com [IPv6:2607:f8b0:4864:20::1047])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGYtt4YbZz3blr
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Oct 2026 08:21:26 +1100 (AEDT)
Received: by mail-pj1-x1047.google.com with SMTP id 98e67ed59e1d1-3adad90c894so1232192a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 14:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793395285; x=1794000085; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4FBcwwQefjg5U9pbFhBbpj/PcCf2fiNl2oUBEHVQucg=;
        b=RfAOCVlrVtjsY8W10z/E8i4sdofCg7bDAiBz3BdE/A+hC6qFOvENXzkUfR8bd0jqF5
         8/z+9RKDNx27R4UU+CjgFjAy3Iobx/wClCNfHZbRCf6b9FAkVb7wGwCz8e/T+VkfzSzz
         sG50iPfmq2hxWhLNDe3fZdAVMQwfohKsyDVCT8CscBRHNycK6LMpY++fqb/inHTrPheg
         VPTd5Y8YNl6OnDcQw4cSlCUenZs0UFTEBekx9cLDv3Qato8dhqaHUiUTUNUnslllyQ6c
         3ar+t7W77h/B2oi9Ta0YldCCvC3/NASS5+iCRJ/MGGNZ+3q3nmWYOuNv9OfCYrGuoZKS
         5QdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395285; x=1794000085;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4FBcwwQefjg5U9pbFhBbpj/PcCf2fiNl2oUBEHVQucg=;
        b=qIBIUmGstBNrwNi6egXQ+/R+jzCQaH+pWfaRmvfFXtnwWlUwv+ieeUAF7MOu1Z7GZ6
         J/j+/R6KqIR5kFxg7NqIGoPzGildPoiZa+yEZSi4IpcFT5C4BcOOyBpmJx9zrUk2Lypg
         Ewtuw2TOOzDkNFb1mo+eyma1sostd+joJORUM1tk7hMztPmZO5rA4oBBkMbmq86RYWXT
         dEOvMEgDlODHgzmt089UJl0kybsxKrnlPlZQTrcF/1lsLz9r6sG7l2cTHpgTTSgOF45U
         Lxlwm/V9961Vs4+rhMSeO1JqJjvATBY8f2HIQ5214/yCbOA/agy1uK9lHA5xOPr2vR5S
         dj4g==
X-Forwarded-Encrypted: i=1; AKwUvBy2TbTGRPeANmYmVNDZsmMKel1Z5zImSrk4t9ZSM7f3FUJG4B2YcRsgHxFBDi7+DRQ8WJ+8+HP9oKXAOg4=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKif5LH/ev4LclLLx0DCzADGgrYBqWgdAelEqbQKRLNVSZcqohW
	vWTMx4RXYOXnRV2aIrAGwdFupQzKc7iSDLdQBvVuAtCv9KRq3Gxx7U/zZ0PTcysst511pVsl5jA
	cgHYopQ==
X-Received: from pjry9.prod.google.com ([2002:a17:90a:bd09:b0:3ab:d09d:a37a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3b44:b0:3ac:74b3:a8f3
 with SMTP id 98e67ed59e1d1-3ae8983b590mr3022604a91.44.1793395284519; Fri, 30
 Oct 2026 14:21:24 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 30 Oct 2026 14:20:57 -0700
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
Message-ID: <20261030212112.2598640-10-seanjc@google.com>
Subject: [PATCH v4 09/23] KVM: x86: Re-queue APICv update request if
 inhibiting APIC access page fails
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
	SPF_PASS,TVD_PH_SUBJ_META1,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Re-queue an APICv update request if deleting the APIC access page memslot
fails when trying to (permanently) inhibit the APIC access page.  Sadly,
memslot deletion requires a memory allocation and so can fail even if KVM
does everything right.

Fixes: 2008fab34530 ("KVM: x86: Inhibit APIC memslot if x2APIC and AVIC are enabled")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index ecf611845fb1..c20e2a25834f 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2931,6 +2931,7 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_alloc_apic_access_page);
 void kvm_inhibit_apic_access_page(struct kvm_vcpu *vcpu)
 {
 	struct kvm *kvm = vcpu->kvm;
+	void __user *p;
 
 	if (!kvm->arch.apic_access_memslot_enabled)
 		return;
@@ -2939,25 +2940,30 @@ void kvm_inhibit_apic_access_page(struct kvm_vcpu *vcpu)
 
 	mutex_lock(&kvm->slots_lock);
 
-	if (kvm->arch.apic_access_memslot_enabled) {
-		__x86_set_memory_region(kvm, APIC_ACCESS_PAGE_PRIVATE_MEMSLOT, 0, 0);
-		/*
-		 * Clear "enabled" after the memslot is deleted so that a
-		 * different vCPU doesn't get a false negative when checking
-		 * the flag out of slots_lock.  No additional memory barrier is
-		 * needed as modifying memslots requires waiting other vCPUs to
-		 * drop SRCU (see above), and false positives are ok as the
-		 * flag is rechecked after acquiring slots_lock.
-		 */
-		kvm->arch.apic_access_memslot_enabled = false;
+	if (!kvm->arch.apic_access_memslot_enabled)
+		goto out;
 
-		/*
-		 * Mark the memslot as inhibited to prevent reallocating the
-		 * memslot during vCPU creation, e.g. if a vCPU is hotplugged.
-		 */
-		kvm->arch.apic_access_memslot_inhibited = true;
+	p = __x86_set_memory_region(kvm, APIC_ACCESS_PAGE_PRIVATE_MEMSLOT, 0, 0);
+	if (IS_ERR(p)) {
+		kvm_make_request(KVM_REQ_APICV_UPDATE, vcpu);
+		goto out;
 	}
 
+	/*
+	 * Clear "enabled" after the memslot is deleted so that a different vCPU
+	 * doesn't get a false negative when checking the flag out of slots_lock.
+	 * No additional memory barrier is needed as modifying memslots requires
+	 * waiting other vCPUs to drop SRCU (see above), and false positives are
+	 * ok as the flag is rechecked after acquiring slots_lock.
+	 */
+	kvm->arch.apic_access_memslot_enabled = false;
+
+	/*
+	 * Mark the memslot as inhibited to prevent reallocating the memslot
+	 * during vCPU creation, e.g. if a vCPU is hotplugged.
+	 */
+	kvm->arch.apic_access_memslot_inhibited = true;
+out:
 	mutex_unlock(&kvm->slots_lock);
 
 	kvm_vcpu_srcu_read_lock(vcpu);
-- 
2.56.0.385.gac671c819a-goog


