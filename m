Return-Path: <linuxppc-dev+bounces-24755-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7519C531D0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jul 2026 00:48:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5q973pJ5z2ytJ;
	Fri, 24 Jul 2026 10:48:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::646"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784854091;
	cv=none; b=OJAySlXey+YgEdvyb4B7AgcV16zX7Ku5Qqd/Y/9lxBT0h+mDlvvtdajMezZ792ZA1pf9dlnKVGhoLnVxgUU9/E6TnYt7xCWzCYIMRzTy+VFsjDLo10+3uL2ILqER4gnJ0jecYb5ejN4f3wJ8bxElijJklqIvMGpc3WnCVGW3z84sHEdopei6dBjMexD5eMwAcOZmcXzbDV8Ke6IPPuTB7ko9cY2Q//aC6aS9zTmZHO7MVW16fDI+Zb70svqPSGJDUKNs70QYXRxGM3qacchXQkPkYf/y0F1jAsX22ebT2+3/K5LWXDscOcF604mhaDlkGmOrdssKNxJkgV+QTloxTg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784854091; c=relaxed/relaxed;
	bh=iizTcAPrS3gcyVAqe3yTm9VHs8JAlHzgO7yvRefWb4w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=abk0ibCGZQWs90hrIbXEqfwsF3wgjXRAGUtFeF9D6/zPyR6dvjfUXcweRfLkyQzqdh4eiF67R/suz3zZaflncvcSccai2Jh0sDnbvJd2D7tKXtgNol/dVNcWRZzD89IrcHoPKLE7yobAtaDxpjvhA0NZmDCTNquQpi5ZmF2UWMXFhlu3srP754Gp+1G1fMzAFtDcTq20Ih0Zp9JUnGu029PtZgX/Pa8a9YUCk/ABlcDG8L/XlE6PiVJQ6yDQ7V59Jwm8PpOAAnZUHZb6tVFfDOfBjP5/YbrSx83F5Q8nGlIW7Yfch4KoW3UoW682FvQMt1LWNU8rtqKSTk0nKUOHIg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Au1CATS6; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::646; helo=mail-pl1-x646.google.com; envelope-from=3slziagykdjkl73gc59hh9e7.5hfebgnqii5-67oeblml.hse34l.hk9@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Au1CATS6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::646; helo=mail-pl1-x646.google.com; envelope-from=3slziagykdjkl73gc59hh9e7.5hfebgnqii5-67oeblml.hse34l.hk9@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x646.google.com (mail-pl1-x646.google.com [IPv6:2607:f8b0:4864:20::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5q965s1jz2yrS
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jul 2026 10:48:10 +1000 (AEST)
Received: by mail-pl1-x646.google.com with SMTP id d9443c01a7336-2cacd6d37edso19563845ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2026 17:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784854089; x=1785458889; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iizTcAPrS3gcyVAqe3yTm9VHs8JAlHzgO7yvRefWb4w=;
        b=Au1CATS6MKugQFILiF1KMa+AGYf24yYujuRDlosHSE2qVl8xsLJixLLk0r3zuGcPGH
         qUpz8LrMWk6w/X94GQEhMSNn9dBPD+0i1qOHrYZnpPlgDjSVGMjaIdZB3sO2eGiFPdUj
         4MZB4jcE/+7a7hQ/ddskEIBNXYKp8qJaRoqf307KWiv1ijNLVaEuP+GmX1OeQWYzk+5G
         +JHYyuY2JOlUkhJLJpeMqIhmRkQ4OtxlxKbnvX5Eq82Ri+pKI3Jynw96pvDxkZsnzRTJ
         YZs/UdrOSntPYSIAv7LilzYPES1mmIidGa4OQnQYHKFdIOvyC/HGn9pkY4HzFaX9IosJ
         K5Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784854089; x=1785458889;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iizTcAPrS3gcyVAqe3yTm9VHs8JAlHzgO7yvRefWb4w=;
        b=jnq0j9aLXp8wTMjvTG5Vl3MFydyxhxYIlcQ1EspcwVdpabYtst2oxbdlFgyE8xi4n5
         RyyrkINuxG2s0bF1T6XpbdhbWxS+niqjt215Ymzv9ZEm5uGlhiwCaBRr2cE/cJbAddF4
         zam6rPNwiN8BDmA5vxYVRQmjJ2xuxGjlA7t0epLwcyTt1xpynOTX/nDm1cyMJjojGZTZ
         D/Nxmua11IeVXjjgG4QDHEYIC0/U8Gio1f4l6joLC1wBHDC0tnLxLV1mxMyi0W74PWHD
         XWFMZyH4aU2ogGqXXDvHcf+7eQPdCjlgiuJNt5DCt8rrqNMgaCNkHCCuEewcYN90oinz
         tF8A==
X-Forwarded-Encrypted: i=1; AHgh+Rr54Pb9oI8JUTwQgI5JgYhhfBihKm0VBT4jpZFRvlKlqsovAvFsJMcb4DI0FpcrtdG9tEaHrPVYvaTxxgA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyM3Xsb7TFflKaPnu6aUlNFWJKnT0DLgk89OVsr+Z3vvuP7u6CP
	V1mz/IAoAo2M9bsO6muXKIPFJQBOC4HP+MGAbLvRPWpZgz5VkdOy5jAMKvxRLbVWw53C1iL4jbd
	aqU+Vgw==
X-Received: from plblm14.prod.google.com ([2002:a17:903:298e:b0:2bc:838b:f23e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f681:b0:2c9:cf5d:d9bc
 with SMTP id d9443c01a7336-2cfa74b13famr65141725ad.35.1784854088680; Thu, 23
 Jul 2026 17:48:08 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 23 Jul 2026 17:47:57 -0700
In-Reply-To: <20260724004757.131420-1-seanjc@google.com>
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
References: <20260724004757.131420-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260724004757.131420-7-seanjc@google.com>
Subject: [PATCH 6/6] KVM: Harden kvm_vcpu_map() against double-mapping and
 thus leaking references
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Now that all on-stack maps use CLASS(kvm_vcpu_map_local), i.e. now that all
maps are zero-allocated, explicitly put any existing mappings/references
when establishing a new mapping to harden against KVM bugs leaking memory,
but yell loudly as the owner of the map is still ultimately responsible for
the lifecycle of the mapping.

Suggested-by: Yosry Ahmed <yosry@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 2df8ee9ecf6c..e9e32686e41b 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3118,6 +3118,9 @@ int __kvm_vcpu_map(struct kvm_vcpu *vcpu, gfn_t gfn, struct kvm_host_map *map,
 		.pin = true,
 	};
 
+	if (WARN_ON_ONCE(map->hva))
+		kvm_vcpu_unmap(vcpu, map);
+
 	map->pinned_page = NULL;
 	map->page = NULL;
 	map->hva = NULL;
-- 
2.55.0.229.g6434b31f56-goog


