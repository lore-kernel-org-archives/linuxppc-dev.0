Return-Path: <linuxppc-dev+bounces-21137-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A49DACD343F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 May 2026 00:42:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKG8t1whPz2xrC;
	Tue, 19 May 2026 10:42:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::449"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779151342;
	cv=none; b=mgFM7L9rb2HUNicLpp02ug+KJM+7LlRkuK2QTKPlscctAwsXBvjPFgq33o0vsw8sQoMtsIRJS9NI7u5RN5+YuVzj7BUKstsuIbGiMGgm0xXg7SdANLg/AeXM5uJ4H/m0hT4avBMO+AD/RWReU0WvaklFIm0kcvdUXArUvahE4O7N0kIxBa6wORzj+0OTnBn82RW2FuGP+z2IenY7ZiG0S7kBKE6ltBQHyfziCKN8KEL1ZcAJikKErB+IYnSMez4ayygqLbtm99kuRXVICdYp/cdrG5/sLG2HMFWbgNV7iI4kIFzrknA/uEwtUf+vXXWagvWDgOCIO9L51VfenJqRkg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779151342; c=relaxed/relaxed;
	bh=gAWTgC2n5XL5hrjpKs7d7iBSwBHUavq9roRCCFpKuYY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QRK2sYh83ICWH7XUVMI6tDkUfRbqW5i3eG26UT1/sHMefy/D5buv2HrovtTVTLTtyilrHi5I5b+MuL0bWJnvcEswHx1vWssscuiG93AHU6isbkCG4HwQbEHN9qiAAZ4ra6xsLfE/uRGC9Sfogy/VVEcEmxwgpub9qjKPlNomHXix562WplNA079rsQthro+RzeOxw+NwGJtlm401GWV71ZgG/gWwijNZyQO/Is9Eoyu+/YDPLsnjbCVznM8NFo0YIjukeFz/zmemmSV0mIBMY1bVpKtDaGAT9xOEpMm2I49u8iSx3R4YqtepMarkjxOMF28T2vF9DcIKqVajyM1PeQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=EkpaAZPN; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::449; helo=mail-pf1-x449.google.com; envelope-from=36lelagykdnef1xa6z3bb381.zb985ahkccz-01i85fgf.bm8xyf.be3@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=EkpaAZPN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::449; helo=mail-pf1-x449.google.com; envelope-from=36lelagykdnef1xa6z3bb381.zb985ahkccz-01i85fgf.bm8xyf.be3@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKG8s0bXDz2xqv
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2026 10:42:20 +1000 (AEST)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-82f9429f49cso4696431b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 17:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779151337; x=1779756137; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gAWTgC2n5XL5hrjpKs7d7iBSwBHUavq9roRCCFpKuYY=;
        b=EkpaAZPN1AsslG9gl2K/jEM4ujmCjrrd2Zn5vraRpdZyqAhBeVHmjb5xArPO6VOyZR
         u119kAYRt5lxzoU4F6TlorbdopYh2Ia7KOBRX2iSCtbNy8wbWT0yxKie+JSF18G5LVAr
         bKMr1cHIBrbBk3hckOa2mnWr61CbGvjbpG60jUGIJ+zybTxz3fqWAdOcaKr9S/ddc1Yv
         X39KEVHn84dAqGwZHpkb1UsGrP30VHr+c54Q88XE7LPS+2QiBxPSQ66hCyEfYAHezli4
         VKimAjnkvW3vgskqa5alK2OCs5U76unka4JUhtWaTrh+BBCxwE3GUaX92l5WcaDpVEbA
         Lpyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779151337; x=1779756137;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gAWTgC2n5XL5hrjpKs7d7iBSwBHUavq9roRCCFpKuYY=;
        b=iuf5aaEXd6tX+CDQJw/zb17TBOJyaSqHW1sqT+w1bgD8pHr/8i0v2MQiwod4YPes7h
         grr0SYuLo7C2B5QpGnnGsk39JEJX7JO8qoXctlJ1u0M4pBVcqAT/EIuvoW6c6e3V21f6
         LoA7XecEzxswY+TTc7ksmA6QxvW5jG5Kl4e3+Zx/dUGv+MsBI0tU0qPzttuRQX/kEfZS
         qDjOfWphkitQZSh28ZUvdLdRSYlhMjzya38sb8sh9fPrdP4ah4Vhn/LBUW32CA0H85d2
         TkjbU6nOL5wJ205lu+0AeW5Aj+PU8Dh9NI7MQau9b80xvADviEZ/5POyzYKDm65OF6Ln
         aBrg==
X-Forwarded-Encrypted: i=1; AFNElJ+k8l4u19O4jRA9TkDQegk7+M2KO8/o1gldQNhRbKdMab4WBqcu8aaNOXAp9/hsqFsx+hNla4Y07G1vVwM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxbwn0L042frTB4L/Q379SiC1KucGtAZxg4kThikvbfoovg8fOf
	/ZuARqQHmWbk4vHclWcfg7jLnRNVfJXvD9iylS1Hkhk4zS2t2ywqf5SRmym7JjrFCTSW6+5vIXZ
	Q73IDfA==
X-Received: from pfde1.prod.google.com ([2002:aa7:8c41:0:b0:82f:7fb6:b50b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:440f:b0:824:374a:1407
 with SMTP id d2e1a72fcca58-83f33c9e8dbmr17940362b3a.16.1779151336836; Mon, 18
 May 2026 17:42:16 -0700 (PDT)
Date: Mon, 18 May 2026 17:40:38 -0700
In-Reply-To: <20260408001137.3290444-1-peter.fang@intel.com>
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
References: <20260408001137.3290444-1-peter.fang@intel.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <177915089967.2228074.1398572969116564533.b4-ty@google.com>
Subject: Re: [PATCH v2 0/3] KVM: Fix and clean up kvm_vcpu_map[_readonly]() usages
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Peter Fang <peter.fang@intel.com>
Cc: Yosry Ahmed <yosry@kernel.org>, Ritesh Harjani <ritesh.list@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, 07 Apr 2026 17:11:27 -0700, Peter Fang wrote:
> kvm_vcpu_map() and kvm_vcpu_map_readonly() are declared to take a gpa_t
> in kvm_host.h when they're supposed to take a gfn_t. First fix the
> function prototypes, and then refactor them to correctly take a gpa_t,
> reducing boilerplate gpa->gfn conversions at all call sites.
> 
> No actual harm has been done yet as all of the call sites are correctly
> passing in a gfn.
> 
> [...]

Applied patch 1 to kvm-x86 generic.  I'm moderately optimistic that the gpc
stuff will land soon enough that I won't regret skipping 2 and 3 :-)

Thanks much!

[1/3] KVM: Fix kvm_vcpu_map[_readonly]() function prototypes
      https://github.com/kvm-x86/linux/commit/ccd6c77223bb

--
https://github.com/kvm-x86/linux/tree/next

