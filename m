Return-Path: <linuxppc-dev+bounces-27872-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60CE5C982E6
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2026 17:45:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpVx65gbzz3bdD;
	Tue, 22 Sep 2026 03:44:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1045"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790012698;
	cv=none; b=jkZNwfHIyQQhl5nQpY9kNvNZwveqdLU+cC0W4BstzcL2/l/e4lOEzrwBxN2UbKHdLmsXZfxfK1b70ctHMN3RYw550EsbNP9QMIMWI2GAMGwSv7/TkZgZ0Tpg6w+/VRQV6MpzdPWq4SKESlEL6VHSKZN8aK7mQIy47iMYBMx/Cp1c8GgIhxLUFMzXzdeLwE3MVibm3vx8c8KIKfiQJtwniaZ0zFVF+1yk079DzJUUNnT1601UBsvdb8+aoKaQAIKGncinspPdK/xArM03wJubWI7cLpJgKo7CiOpg8zOuoXcsPQXg7o887kvgCOig1oSsU0MSAAkqJWqCpVa8lQYyGw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790012698; c=relaxed/relaxed;
	bh=YYqX0VJzWkRuy7Rww/xIfxaxsSEw1uv9+hGx8/FiNWw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ajy1+Gh0l9g/pLUXxDKpRnLUGgcHm7oJzEyDFGnOkanwfq584emYo0IMWSEgEl6zUnNNTHPCcP/YpXq0fq1tkyv88xplgdWRWtyHVXakyzbpJ8AKVftvOtl3RT26IpZ8PPSgKJp71i8Ei0d9sLVGAIX8WbQN2GOudd/BdA76KjcOBgu1fbDPF4KipMxj4at2HzbCkxLi59IQzHetBRk9tZxlU+jRElMTgHRVd8CvgNBfmgo2b8AJq9pJoUQrSyDS/kEfZ9RD/VoDUnlz3QOnRdJRnTHMTchMeotjyiyXKx6guQS5SSb6nLFInkqa1D5FJZjt+4NXEomIzLqnpxJNtw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=WOp+mVTw; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1045; helo=mail-pj1-x1045.google.com; envelope-from=3f22xagykdbqcyu73w08805y.w86527eh99w-xyf52cdc.8j5uvc.8b0@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=WOp+mVTw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::1045; helo=mail-pj1-x1045.google.com; envelope-from=3f22xagykdbqcyu73w08805y.w86527eh99w-xyf52cdc.8j5uvc.8b0@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1045.google.com (mail-pj1-x1045.google.com [IPv6:2607:f8b0:4864:20::1045])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hpVx61D9xz3bbm
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 03:44:58 +1000 (AEST)
Received: by mail-pj1-x1045.google.com with SMTP id 98e67ed59e1d1-39e25a5f6e8so6027905a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2026 10:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790012696; x=1790617496; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YYqX0VJzWkRuy7Rww/xIfxaxsSEw1uv9+hGx8/FiNWw=;
        b=WOp+mVTwpElY0MI7OH2/Qfm2y86lF+1E39wv9qJkFmjYRzZCCjblY46XOlgzh6xNvd
         D/jt3l2mSDlpe+6uTw8lHQvSCRLlim3+U1Dc7pD1IqdPB+PqSXoBDT5hCeaFIiHH8Xkd
         Sr2yP8IkpoKwfsMuCBzpQuWcDCLHejB61CxPj7L2X7MASlwB7bN/yHi4bddkVwcmimm/
         +0/Mje3oN3TkZK4lW5Ig9xfOkAeYGy1iuRinuGkbcdbsCGRxL9eR1nuCuWvWC7SOqvSx
         XtztZZ2SvriWHEc/YJOc60apGlYWtap45mcFyKuc76pJGEN24gCV3WvKRl8nK9ICSmSh
         BlHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790012696; x=1790617496;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YYqX0VJzWkRuy7Rww/xIfxaxsSEw1uv9+hGx8/FiNWw=;
        b=VukVIfuVDxB6+AdrjuRTdfKgkYCULdwdAjOfgWidF8ztSmbCaLefG+SRoxZZZyQkqf
         POVYDC5tDC6H962bwGK1hqsgz9rL0dRFkampNKXJXOXSvTgtmGvKHAYYrAZQDcj9w2KY
         uxeimQclai3Ey36JbS/5mqR10D/OiCgAcwJ2ODej4HSEsPivfVoitzrbDBvlQfOOTE2O
         DVe/oFqW/5DoSR27cljnAyEOs6EzMiFDLg0xaWp+sD3+SKctXxfBzMMs6jcVXRHUqTNN
         Ix+rbj7kyJkcEXoqElfV8chv9MbLHGQA5clwxKagMXjmwga4jl7MpfMTwtg32WNYt9Po
         DnxQ==
X-Forwarded-Encrypted: i=1; AKwUvBzISynZ8xNyy6zCYelCjk6FXkw0CSSFMhlRPQXlB37AIfU6jCVRG0d2qehob+vGP9/gswWj1CEcYFN45pg=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kc52QaI3Aa4r+IIQ22l/5SIS9/xLoAV+4qPT571nB6xjkj/dnp
	db6i40dUzlv8Ncf0ymSYPBGiERxmSPZWGdD8qIZjoUxWGCMUBKKtMmbfr9V2y7wIvsCqazv69+e
	MD5UTpg==
X-Received: from pjro5.prod.google.com ([2002:a17:90a:b885:b0:3a0:645b:1c57])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d888:b0:39e:4c7f:8b16
 with SMTP id 98e67ed59e1d1-39e54cf8bdbmr17922638a91.27.1790012695572; Mon, 21
 Sep 2026 10:44:55 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 21 Sep 2026 10:44:45 -0700
In-Reply-To: <20260921174445.911676-1-seanjc@google.com>
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
References: <20260921174445.911676-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921174445.911676-8-seanjc@google.com>
Subject: [PATCH v2 7/7] KVM: WARN if vCPU creation is in-progress when locking
 all vCPUs
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Atish Patra <atish.patra@linux.dev>, 
	Alexandre Ghiti <alex@ghiti.fr>, Dave Hansen <dave.hansen@linux.intel.com>, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	x86@kernel.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Jean-Christophe Guillain <jean-christophe@guillain.net>, 
	"=?UTF-8?q?Pawe=C5=82=20S?=" <spawel523@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Now that KVM holds kvm->lock for the entirety of vCPU creation, from when
created_vcpus is incremented until the new vCPU is fully onlined, WARN if
the impossible happens and KVM somehow sees a discrepancy between the
number of vCPUs "created" and "onlined".

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 985af39b980a..e66d9761ee49 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1363,7 +1363,7 @@ int kvm_trylock_all_vcpus(struct kvm *kvm)
 
 	lockdep_assert_held(&kvm->lock);
 
-	if (kvm_is_vcpu_creation_in_progress(kvm))
+	if (WARN_ON_ONCE(kvm_is_vcpu_creation_in_progress(kvm)))
 		return -EBUSY;
 
 	kvm_for_each_vcpu(i, vcpu, kvm)
@@ -1389,7 +1389,7 @@ int kvm_lock_all_vcpus(struct kvm *kvm)
 
 	lockdep_assert_held(&kvm->lock);
 
-	if (kvm_is_vcpu_creation_in_progress(kvm))
+	if (WARN_ON_ONCE(kvm_is_vcpu_creation_in_progress(kvm)))
 		return -EBUSY;
 
 	kvm_for_each_vcpu(i, vcpu, kvm) {
-- 
2.55.0.1082.g2b9226bbc0-goog


