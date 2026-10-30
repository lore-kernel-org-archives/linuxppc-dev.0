Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169DD606D970
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 21:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=D7nyASfj
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGYtn0CZQz2yPR;
	Sat, 31 Oct 2026 08:21:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::447"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793395280;
	cv=none; b=moD47XOVNCVhOMiRH1jcZnpVnc1MLFElLcwZZHvbJnMql4WwIGo3GwiqSBiSnte3aUx75ZXzQxcH+MwUaBazqIRNLx65/rdOzc/UTKbyJMBMMJ2B/VevtoZARqmf0u6oUHGO9P0BS540UbGvnJ2qfZ4EoWrIhIicryn80ioncotihuq2EKpWXIdfPKhnNkTYUMlPs+y/usV1vn6xigNjMWieuSLGFELI5Ay6jlJUVquShSzIRxas28ePnhWdcSFnr09RtnpU/Vsos8aaRpL3U56kbia25q0b6cvtp03eXJqG45fhMzLDWRtExC5tkfhDc0r8dPrKUJPI1cxusX5g3g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793395280; c=relaxed/relaxed;
	bh=xVLOuB5izvjqY2+yn+X5wA6bkjFEaB6u1KjQAeAFkZo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dR8h9lZ+jfY24Wc95uG8W2leVhGFgs9GqZWSALWCMZRMlgX305mu0SRz8lkBdEL589hLfx9m/c5V6kmyeR+Xc29zzHlY357oA82jSBRx9TQY7CFKzWiubPYsEqEsl1Gly4K2NQhAwfDAo1uPVk+Sf4PgIiLTA/vZrwlU0D2TUj5nvb6SSdNeeZpeGOO+2xQUexwoIrAm/JX+5HOn+iaqpC7ev05+pJTgjcZy6IpRZIf4KDvrygIN6+aT/1UaKbddLzsSohxeT+P6PC2y4J3utmEhWBdxOelSrafpRz0pYV8wiL7pLNcwzCncAZYGOTwMom3YCXIwkGTg5srEY6Oo4A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=D7nyASfj; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::447; helo=mail-pf1-x447.google.com; envelope-from=3tarlagykdfmdzv84x19916z.x97638fiaax-yzg63ded.9k6vwd.9c1@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=D7nyASfj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::447; helo=mail-pf1-x447.google.com; envelope-from=3tarlagykdfmdzv84x19916z.x97638fiaax-yzg63ded.9k6vwd.9c1@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x447.google.com (mail-pf1-x447.google.com [IPv6:2607:f8b0:4864:20::447])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGYtl6F14z30Wg
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Oct 2026 08:21:19 +1100 (AEDT)
Received: by mail-pf1-x447.google.com with SMTP id d2e1a72fcca58-89e05d31e54so788391b3a.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 14:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793395277; x=1794000077; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xVLOuB5izvjqY2+yn+X5wA6bkjFEaB6u1KjQAeAFkZo=;
        b=D7nyASfj1gj14cUlx2Ku6Df+APdYAyJOa6zgqMwh6gdUfXOngRJ8sS/tnYMnCta/u4
         HXJhhKpJ7y7Kw+yLYBv0ZGN/p4+dWgbCuzPJ0TmuQkT1S5tWMYwRRAcNt0mGD9MHazQ3
         DgQi4hj29sVRReS9/KPi/Qykse/f7w/lks8BbioO8Wu4W4f1X/XC0ozsxt6o2Ypi17F7
         RpMNxGD3y9h/u0a2CGFz9vqkFeGx5RBtCYry3BFye7LuCBADMsnvl3cmur/EK4ghJq3S
         XMlENBS44deqx8g/YZbzlrfwBomNeZJorBcimduoUnqgKXlurrSU4ISdgarGkRaFRyvP
         igfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395277; x=1794000077;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xVLOuB5izvjqY2+yn+X5wA6bkjFEaB6u1KjQAeAFkZo=;
        b=uugyhFRnOzchYHhHSg8H5u8kTC82PEQybHaTBYg1gbNEGNSAQR7d5XW9iK0zjK9v1S
         uhskaosNCofdpE/p40IJo/JV9/IXa1tTHCLlY72miCycsXro0ukuF7EhZzNhz5VDiwuS
         lYG98P3sTMVHeGhv2AFcaXSlQV02jDejarGbmz/yeQKgIyWvKsJng/TRS8fPT5EqccoT
         MMrK6qvLw4R7IXlTugWkc13WEI3nIj3ngpy1eMPajdEp3L5KR1QKkdVBDGS1MX6dtp4O
         +Vj5OwrQ+xUFcxdQFCaTaACDA7G4Ig5kB5z2EtuHQFoQ2EnuF0W+i99K8UncXuMqpDDy
         vVrw==
X-Forwarded-Encrypted: i=1; AKwUvBwp+RJV0jamvEAsxgEnUm84Lv0JLT/b2y8tSES5Q0ITZWxv4btwBKwvt4DcMaAlmI/JiJm+yQjt4WZR8mA=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIXwc4jetgqwpsQovhVxZI0ulnUH/mzrgEhgxTr0VeqO6e5OokU
	nEpltXiOgwq6KLMvm5O6XIw0tv37QyZVuiukkTaRZtPhV3EoS/pU3a7lum0i5ncMnVfE0JneJqA
	BXBD4AQ==
X-Received: from pfwy10.prod.google.com ([2002:a05:6a00:1c8a:b0:89f:5522:3f42])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a118:b0:89f:c441:580a
 with SMTP id d2e1a72fcca58-8a9bf339441mr2641764b3a.36.1793395276884; Fri, 30
 Oct 2026 14:21:16 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 30 Oct 2026 14:20:51 -0700
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
Message-ID: <20261030212112.2598640-4-seanjc@google.com>
Subject: [PATCH v4 03/23] KVM: PPC: Flush/zap all memslots on kvm_arch_flush_shadow_all()
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

Flush/zap every memslot in kvm_arch_flush_shadow_all(), i.e. when the
owning userspace process is exiting, as KVM must ensure all associated
memory is unmapped from the guest.

Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/powerpc/include/asm/kvm_host.h |  1 -
 arch/powerpc/kvm/powerpc.c          | 11 +++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 708a32f89776..50a42f80e5f1 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -910,7 +910,6 @@ struct kvm_vcpu_arch {
 #define __KVM_HAVE_CREATE_DEVICE
 
 static inline void kvm_arch_memslots_updated(struct kvm *kvm, u64 gen) {}
-static inline void kvm_arch_flush_shadow_all(struct kvm *kvm) {}
 static inline void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu) {}
 static inline void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu) {}
 
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 9194cf492d1c..9e9d0865c2f6 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -764,6 +764,17 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 	kvmppc_core_commit_memory_region(kvm, old, new, change);
 }
 
+void kvm_arch_flush_shadow_all(struct kvm *kvm)
+{
+	struct kvm_memory_slot *slot;
+	struct kvm_memslots *slots;
+	int bkt;
+
+	slots = kvm_memslots(kvm);
+	kvm_for_each_memslot(slot, bkt, slots)
+		kvmppc_core_flush_memslot(kvm, slot);
+}
+
 void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
 				   struct kvm_memory_slot *slot)
 {
-- 
2.56.0.385.gac671c819a-goog


