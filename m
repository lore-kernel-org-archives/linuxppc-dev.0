Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52159607315C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2026 22:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=X3RRQGh0
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDl9400Skz30Wg;
	Wed, 28 Oct 2026 09:12:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::646"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793139143;
	cv=none; b=JfhFLiHx4buCMHuan31jH3K3+GJLLc+AVn1eT3wVOzpmoGRue+wgsySYVGLsi5A2cT6MiDIMvvYY9cin2nn+qVeKILTDdaagPVzyD9wrGOcMlI0aDGj9LfEqpqO956MOweiACG1rfFzQu5qHXmz7jAW7RKkAdccfEBqCjE3DoQckvKNYdNlsV9Dg3Xbpg1r+Ci+1oXyDhyOrGgPal/fLJUvNPwKQGa6OEqXOF3OCKh4g6VrABK/Guy65Id2Obt0yAhcolJnBnWQ6Bc9psHi1KYeMkw8T+P5rQ7WSjiztvop6IzSd48RyG90z2XETM31HydCMKQ9yD3q2i021pUR9+g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793139143; c=relaxed/relaxed;
	bh=EI446rcjrN0x44kbFFvKS4UWEA1sDeBtgZ/wnLAywEQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OQByILEPA1/+0KGQ7+1HlDlWuJEIkanooJpZI7oelsdyl0bfTHb6lEwOt7+FWmEmPW6nr4JZMHyJM0Keq0fRUu3HBpxBF70uOxJd6ZzEFOFk6f4hD///xdI7lQXHUzjMyA0HjMGLEvjXYg/n8qaNCMIwxYfOEPa31Cd4S9eijm33PMzaV1fZFKFz/opIhKcmMCbWHMhveByo7tv6Fh9ZRy/vM9tTrvDA5cadD0+UivBq9dQaCWP7KgQOkGkqnA7CKx8HTwh60xQmRSNIg6RQelP4QDCbiY4vu+fcvchp9OdlKvGG33XkCbC8/7v7NuBppAf8g7lbbWh32Ya8fFbSbw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=X3RRQGh0; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::646; helo=mail-pl1-x646.google.com; envelope-from=3xchhagykdokdplyunrzzrwp.nzxwtyfiaan-opgwtded.zkwlmd.zcr@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=X3RRQGh0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::646; helo=mail-pl1-x646.google.com; envelope-from=3xchhagykdokdplyunrzzrwp.nzxwtyfiaan-opgwtded.zkwlmd.zcr@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x646.google.com (mail-pl1-x646.google.com [IPv6:2607:f8b0:4864:20::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDl932chTz30Vv
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 09:12:23 +1100 (AEDT)
Received: by mail-pl1-x646.google.com with SMTP id d9443c01a7336-2e987ec84afso2388145ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2026 15:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793139141; x=1793743941; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EI446rcjrN0x44kbFFvKS4UWEA1sDeBtgZ/wnLAywEQ=;
        b=X3RRQGh0tw8wYZmDtQQPN2Jg4AmXgPEW1I94dqsOF+Lsm6av6MgU6KewMi7o4Pj/RF
         YXDHsVwdVz1G1xiVGkndvEbEQWpcADhbYz+7BTTXaamOn2JlfCNk12dmy2odZtmFWqJR
         y+pqLgtH44o1AX1a9vDKCoNTZ96kgRmoJw+NIvVBJxo+WMtYww44QMWGOLBCqBPDO5Kr
         KftTJ1ctVFZC18+UNNhUs2Vo/Hi8ki6PoKUUEOH0NtEqizPrU7YAnFY80huKBGwLMQ/g
         Eu2Dl/qjY6YrfviPic6yrCehwDJSLLzbMMQJa7OC7GqemlRIIY02QN4cOREq7bqTApqu
         Vt/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793139141; x=1793743941;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EI446rcjrN0x44kbFFvKS4UWEA1sDeBtgZ/wnLAywEQ=;
        b=Hat1W3T84SCLTULFwcettTUwm8qwGucX1MIe1vo5+aIR5ZfmvfwZQkH3RhZ0KFKvw8
         UyAYDUqwBrFbeMhsFI2HVeOlB/C7snDpMNM7nhRJmyFNmkdC9LprujAqTujOOYrR4i3k
         0X6475asDNIVcqR3ePMvuvQKTf2U5RnSk+RBCgsFqvXNGyyCcJj0pbQw9g5OFpYau/WQ
         RRbB9QO7OWQLe4UD/vPWkSLMFluHSVlVQBJRpZRYtZqzUDpEmepP4/VMbFIzS1y+gjwI
         a2wruUqMrATU+RxHW0ze4em/zdb1k30h3YoEqzZMLth+6+pctmxI33TKOIZZl2CKxszG
         nZbw==
X-Forwarded-Encrypted: i=1; AKwUvBwUAB8ov/oGVkhTqYhkIopkrGiGGUf1s85wz6OV1qmXz5XoC+6asOqoZrEJ8x3iEWQQEO8DuMlQfxl1V0c=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIXTERvWfEno4f2VjVmQ11Ma2qxx4u8dDDEWmFb8UNBLtQ9etRS
	yNoqnbbjlhfbA9IgnLWDxVvfAqAnBeU6XBbMBE610s0anPDBNobWYFFui1f/jTlDVfmp7lgY/hu
	7Q94mnA==
X-Received: from plnl5.prod.google.com ([2002:a17:902:fd85:b0:2e8:774e:e582])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f54c:b0:2e9:a090:dd80
 with SMTP id d9443c01a7336-2eb0048632bmr5982595ad.22.1793139140855; Tue, 27
 Oct 2026 15:12:20 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 27 Oct 2026 15:12:01 -0700
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
Message-ID: <20261027221209.1560865-9-seanjc@google.com>
Subject: [PATCH v3 08/15] KVM: WARN and reject guest-based uaccess if VM is dying
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

WARN and reject user accesses to guest memory if the associated VM is dying
even if the current address space happens to be the correct address space.
Accessing guest memory after the last reference to the VM has been put may
be "fine" from a safety perspective, but it's still a KVM bug.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/kvm_host.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index f3f59bdf7e18..ba8ea62b7304 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1355,7 +1355,8 @@ int kvm_gfn_to_hva_cache_init(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 
 static __always_inline __must_check bool kvm_can_do_uaccess(struct kvm *kvm)
 {
-	return !WARN_ON_ONCE(current->mm != kvm->mm);
+	return !WARN_ON_ONCE(current->mm != kvm->mm ||
+			     !refcount_read(&kvm->users_count));
 }
 
 #define BUILD_KVM_COPY_USER_WRAPPER(fn, to_user, from_user)				\
-- 
2.56.0.307.g5fe7bd680c-goog


