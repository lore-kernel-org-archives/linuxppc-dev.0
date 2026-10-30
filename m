Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3E7606A9AD
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 21:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eiaYVlU+
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGYvB4l2Cz3cH4;
	Sat, 31 Oct 2026 08:21:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.215.197
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793395302;
	cv=none; b=i22c+JZUMAFMbdvh/xVG+J5xTPOxBrjufSXs2jeErBZAThO6HWmoJlRQPqc0JxQu8mKVOqcVNhgOf51p99pYMKhByp2IaRMLuXwGtvw7rgsCP/c0MIjIxWljKM2KNJJDaXXEfVCxYfrk5zdbYPebGnXdQKoHrURSTw5AHO811zw8VpNI3V9sVJPqzTlMmh2RQw6vNERSWyRG7AmR0vQyiojVdI+/aS5BC9TNlADXVu7QsQLD94Dc0096lMQBCRDve2KggB77bdWfp92fQHWzKil/ytI9KH3PzWoqh9jTKOe0Voq0kIVYu91qXu8gT/X8U0pO+IQWItYPZmAOws21rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793395302; c=relaxed/relaxed;
	bh=ceuCOM2fbzBxVJGWrb7TFjcOc/THvEWLPHPqQKuhuMg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hY5fzvH0GJhOHixIz0BJenHUdNu3DfoYsDmhbWC+yjC8kxtqfd31yv2d8qrnAldqnnX7uybsevRZSlDb1LrVQsy6ifkLZevwsWgIygdTywa+yDMrRGNNuFHBpRwqG88dv3kv4JWS/k12W6LM5Y0Y6AAuEs/7vMnu7mICJ7jRaS7MG7aOyRgFqnVaN9e41p02xfCs0XCNCkySV1KOUyaEq41f6Ih79fdORsn10Go+AyesN7y6CCj39UFlaHHcedGyddcr0hxoAJlJjsmOYNMGHUwT+j5uyLlwFbODA+MD6D/JhHJvhrsg4BFpbP+eCuIC+FPrdh5FPdCXuy6Wy8k2cw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eiaYVlU+; dkim-atps=neutral; spf=pass (client-ip=209.85.215.197; helo=mail-pg1-f197.google.com; envelope-from=3ywrlagykdgoamivrkowwotm.kwutqvcfxxk-lmdtqaba.whtija.wzo@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eiaYVlU+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=209.85.215.197; helo=mail-pg1-f197.google.com; envelope-from=3ywrlagykdgoamivrkowwotm.kwutqvcfxxk-lmdtqaba.whtija.wzo@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGYv96pxSz3cKb
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Oct 2026 08:21:41 +1100 (AEDT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cdacb64970bso584680a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 14:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793395299; x=1794000099; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ceuCOM2fbzBxVJGWrb7TFjcOc/THvEWLPHPqQKuhuMg=;
        b=eiaYVlU+V4Fh+zJ3i8dTUo70mmwwXSZXGWZXPoo3s5HcPyVFWRyqwQdBB+BBanExrY
         LzjpsMcRc0RILmlMRJsMOCjCUn/FbW7jIZVbTLwSoZV/7A14QtT7KsORN1uwD5Ll5R1P
         pq0YNMmcu0kNGvitBG4CHdg3t9TFLBiIgxvvNoZ35cTX7tPoWfSMtYq3s5EMvk3f0uYV
         pc9n2IEtzWzWP4QcVi8RgfRFCL+UGUNDMBXx7APuC27kVpqHrlHFbPIwUEJMS+zUaL3S
         Hy/ZnQoCRH8T/xACSt6iYnB/Mc6qGQegi05Q1tZstiZH9rj02U5GY6moVlbuHyFnqe5Y
         JoLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395299; x=1794000099;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ceuCOM2fbzBxVJGWrb7TFjcOc/THvEWLPHPqQKuhuMg=;
        b=W726Ip15kjR/38xFM188rwnHThoZH+px2eS2/+YNp2+T/gXAR3Tm6RJ0hO9GWMBO2/
         327ohX18w/jz9AK3V/ZKi0/Nig7ygZvRTP2Kks2cZpurkH/9xP2xgoASKroxIxm4h+J5
         TDEISP4wwKH0kPZcQxbjAnLWOI/Xi5QVk2X8iB6+tCf+Ldf+sHfuUbFM3h/x5saW+6eE
         paCDMHqgSA7QqqtKH/XQG9DTUtdxcGXcuhbL21g+jAL2SdNG/kv2nz+tgTLo44RskafA
         PwGpVOom0/y54E3EgxzGyirEjMqIOBNn8A5XoKjdkXPKqYLniK5CDDxZB70fNipYMbc7
         ePQQ==
X-Forwarded-Encrypted: i=1; AKwUvBwQGERTZnaC6m1TOY2R6dFKFxSnf4h764iF0SwLet+SspAqyakGpNBcSbZJz2vFofYJgteaT4muv9VGs9o=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYI7vzrBGMZ0fNLBOqKl0ihDikcngkD80yZtJ2ElOafHs3pqZ6p7
	7VpQAnpeI/rxREhfkDhutePHaEHeSVtU+zIzYgIjSgbEofNUtC9teQtVEpUq9vpXlMxQNzD/Aef
	VrcSK7w==
X-Received: from pjbgj14.prod.google.com ([2002:a17:90b:108e:b0:3a4:fb9f:4a65])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1c07:b0:3ad:a17d:f46c
 with SMTP id 98e67ed59e1d1-3ae8982bcf3mr2740137a91.62.1793395299370; Fri, 30
 Oct 2026 14:21:39 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 30 Oct 2026 14:21:09 -0700
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
Message-ID: <20261030212112.2598640-22-seanjc@google.com>
Subject: [PATCH v4 21/23] KVM: nVMX: Don't switch to vmcs01 when freeing a vCPU
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
2.56.0.385.gac671c819a-goog


