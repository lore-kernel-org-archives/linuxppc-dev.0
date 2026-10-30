Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BBE606B786
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 21:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DN+44G2a
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGYtt0kp7z3blK;
	Sat, 31 Oct 2026 08:21:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1047"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793395286;
	cv=none; b=Oe3Pj3GdHG/hEhHlW3MIzLHjKvGUS4lukvvLUQ52AuZ2nBUwibeKS9MqI88IghXvtPiPlBoZqX/hX1S9H9nn/yOFGLiQoJNB7tqNYHjNelHCKt9EGdyt91nm1Sz4PjsGF8TMZbLncvkw250mMQgbhUeZpUkIlnFtRTHoIWpibR13GD/vyfFGTE4dpuipVVfGTRgG1t9ECZtMhq5L3Ao44xcHybiheW3sD67e1q6sF4IGzZsCKu0lpes9ed5dUOl11reMS6GUOWizSQOG1o4QlwCbkmwvNbVUUg+jF3NmqQpd1G2hMaP+LDJs+iHUzqS/tRZjk5DNszEtr/w9h9tFVg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793395286; c=relaxed/relaxed;
	bh=mm/jFK6aaegQ9pZQ54m0VqIEuYvDOfyBcHCegw/+L/s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NkFbGwEc3MSHJqjqTfLVHMFDWb9jNXlaZk5EXSLq2p9T1IWnT3BQCIMEIbu/SGvXoBCxSdW736H0MO+Rlf62vuDKN2hJ6Vv6stkYtBOsj45wcFGv9s/v5y/wyr4sqnmZjXJV49A7/hw8H92q55pt2ufGBoXhY/H+pQ/mE/NfS/U+uxtrKyIfJxNdRHSO2bimew1LfwNtD+hc73/I7USV44ZBfzh3RFgQr0C3R5MVo/Tr7uuAkE2DG+agLNDX8KZqrn1GkGkloAVcj2P/yRW5oUq+NUc7fdhCPDMZn5w1OtPAu+9i5e+Tz9WsNORSpKZXyZUu6ov/8vXv9AO1UmTrYQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DN+44G2a; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1047; helo=mail-pj1-x1047.google.com; envelope-from=3uwrlagykdfok62fb48gg8d6.4gedafmphh4-56ndaklk.grd23k.gj8@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DN+44G2a;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::1047; helo=mail-pj1-x1047.google.com; envelope-from=3uwrlagykdfok62fb48gg8d6.4gedafmphh4-56ndaklk.grd23k.gj8@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1047.google.com (mail-pj1-x1047.google.com [IPv6:2607:f8b0:4864:20::1047])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGYts3MSwz3bkd
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Oct 2026 08:21:25 +1100 (AEDT)
Received: by mail-pj1-x1047.google.com with SMTP id 98e67ed59e1d1-3ad30487d55so1692186a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 14:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793395283; x=1794000083; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mm/jFK6aaegQ9pZQ54m0VqIEuYvDOfyBcHCegw/+L/s=;
        b=DN+44G2aCLAkC7JGxs5+kJ/kjzkvJkt8kTOdShWiUSbZfZw72SltG2Xz9M0bhbZiMQ
         VJrA+ma2howpSU1X5BP3/qC18H2Ov4vBRvWHS+fyURyM7Dnb6rl/hbekOxW52cHVa6fA
         DLeJ9lTjhbLNwFUDHv1cCu5+g1xumhW4X9XqU7Y5AptbQmHmLuTxHmGO79ELjbRmjmg2
         1eXcwId7dFiPOSepz7LX5BOsRYC1m6gFd0r/WCLxXOstgRkW9KLtO2Cki+wic1pb3tkz
         HspwwDuqX5QT9AXEGgMKds1zitidvHVhIb6x9JAR2KUhsWrhehcOHNjkvhlJ8jZCsYWE
         0dzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395283; x=1794000083;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mm/jFK6aaegQ9pZQ54m0VqIEuYvDOfyBcHCegw/+L/s=;
        b=zRHuSHGymI82YxqY668U5EIEesCyiThWWYxuWE//Qb7qBEYTSOA+m2LMCdI1XoHvdP
         PT1RoMZa4VOW6XTRyMWCNZ7m4pJ5je8Rr90/om4DSB6IMQhPF7CSUKPgowrGr3Voy+oV
         Z2f3N2ejuJO4UnCks7eerhv7KjStt1tk8OG/AAXjDsklOP+80j4ibNo+CJWNIfpFToqV
         wy9oeGfuBMIlXUiikNFcFUYed4mvw58EcTYVGUSuCmO1JAnIqthr33AbqrsL090fKXSw
         nTqLS/VtmwAWIzyPwdJZ0yf7RevuitA//dahaMqjGM3jI9/t+CoQ8me90xnzzl3lQOgo
         3Oqg==
X-Forwarded-Encrypted: i=1; AKwUvByrmFNvauyLDOy2Yz613QV9hSGrIS/siwN2nXwqMKltzzq3aEAEPs39kZrwW80AM0j/sosm6XksK7kvdkc=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIb13/84O4ksTSiTs9K2O2u9S+oL1zc2lX/Z3wrDfIQ5h27tRKd
	8lJhIRE3T77/soKbiqX8+Mf6lGvHzwr278BvhzNi4qCrIc+Gc/1cu715BlFmJSf7p6ESMUhy5wy
	vUAO3iA==
X-Received: from pgo14.prod.google.com ([2002:a63:e4e:0:b0:cd6:aee6:763e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1cc5:b0:3a0:bbd8:5ba7
 with SMTP id 98e67ed59e1d1-3ae89879e16mr3031014a91.62.1793395283274; Fri, 30
 Oct 2026 14:21:23 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 30 Oct 2026 14:20:56 -0700
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
Message-ID: <20261030212112.2598640-9-seanjc@google.com>
Subject: [PATCH v4 08/23] KVM: x86: Process all address spaces when deleting
 internal memslot
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

Process all address spaces when deleting a KVM-internal memslot, i.e. try
to delete the SMM memslot (if SMM is enabled) even if there is no non-SMM
memslot.  This will allow retrying deletion when inhibiting the APIC access
page (the only scenario where KVM deletes memslots while the VM is alive).

Fixes: 9da0e4d5ac96 ("KVM: x86: work on all available address spaces")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 326f8a9a5d18..0b94f981a2e1 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10011,6 +10011,9 @@ static int x86_set_internal_memslot(struct kvm *kvm, int id, int as_id,
 {
 	struct kvm_userspace_memory_region2 m;
 
+	if (!size && !id_to_memslot(__kvm_memslots(kvm, as_id), id))
+		return 0;
+
 	m.slot = id | (as_id << 16);
 	m.flags = 0;
 	m.guest_phys_addr = gpa;
@@ -10044,8 +10047,6 @@ static int x86_set_internal_memslot(struct kvm *kvm, int id, int as_id,
 void __user * __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
 				      u32 size)
 {
-	struct kvm_memslots *slots = kvm_memslots(kvm);
-	struct kvm_memory_slot *slot;
 	unsigned long hva;
 	int i, r;
 
@@ -10054,11 +10055,10 @@ void __user * __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
 	if (WARN_ON(id >= KVM_MEM_SLOTS_NUM))
 		return ERR_PTR_USR(-EINVAL);
 
-	slot = id_to_memslot(slots, id);
+	if (size && id_to_memslot(kvm_memslots(kvm), id))
+		return ERR_PTR_USR(-EEXIST);
+
 	if (size) {
-		if (slot)
-			return ERR_PTR_USR(-EEXIST);
-
 		/*
 		 * MAP_SHARED to prevent internal slot pages from being moved
 		 * by fork()/COW.
@@ -10068,9 +10068,6 @@ void __user * __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
 		if (IS_ERR_VALUE(hva))
 			return (void __user *)hva;
 	} else {
-		if (!slot)
-			return NULL;
-
 		hva = 0;
 	}
 
-- 
2.56.0.385.gac671c819a-goog


