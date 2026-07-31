Return-Path: <linuxppc-dev+bounces-25187-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C91AC55173
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 Jul 2026 20:10:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hBcdL1RTPz2ygh;
	Sat, 01 Aug 2026 06:10:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::648"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785528646;
	cv=none; b=E4fdL07yfp7GtGkKQPvLAWTH5eot6qRgCazBS6hVy/eIM2RX4NjKCTd9vbdu9KFTmEKdakbecqHhDx364SmzfWq21D38W6p1VQLHkMuqxygZT9tvj03AGhxeaOZUqkI/kNmxehdfx5s3LzFXCxiHZfH/35ybBdjy9E4NoOAtOdlKYmiE2kfjsg/quX2OumvMrwuuGosvRLNZPY/+h5E6R3H3uzFM01AaKZZPB2PnI1wZLbX6qvWyOgoFuZiPcB/p6/iKGGfWpRiFVKR1jHRhY38PUAb1gb0OGsNftnyCBAaivyyOz879aQPoMbk31AZNSoyA3PuJC7Ous4gf9BxZZA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785528646; c=relaxed/relaxed;
	bh=FU39kIkoMhXTKKpE37dh0PJvK+pnljqlvEGquRB6geM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mBUBx5bXI4ckwnG4OfP+SPaosjn6sH0ogOJTaOumNGfjvYoenJo1bYPwDGYFiz1Yx7g6+/lZveaayip0cmAE287UhNtj5rqycFuckgaC54uHMZIFVgWUsoC5jWhLLSclbI8yn2nzmXGLod6LDCbDR7m3HcF/oodi4e2pCDBpiVLIUYHE7xEN9i25q55Cy0aDSTABDw3Ik1QjgDJS5J4QOfgv36ZgiARMOM13KUMhjS+QrwhKLEsIK3zVlYAcaNrO+GEZV89zqd+idVqVjUUxb4Boy3kj5OpYdIkoEqGSg48oA3OIryjxQeVy4OHOs2s2e0mi7948GHWrr6D3Ubf6fg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ebFw9/MR; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::648; helo=mail-pl1-x648.google.com; envelope-from=3qaftagykdfebxt62vz77z4x.v75416dg88v-wxe41bcb.7i4tub.7az@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ebFw9/MR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::648; helo=mail-pl1-x648.google.com; envelope-from=3qaftagykdfebxt62vz77z4x.v75416dg88v-wxe41bcb.7i4tub.7az@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x648.google.com (mail-pl1-x648.google.com [IPv6:2607:f8b0:4864:20::648])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hBcdJ6Bljz2yY1
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 01 Aug 2026 06:10:44 +1000 (AEST)
Received: by mail-pl1-x648.google.com with SMTP id d9443c01a7336-2cee1ec30f2so15117115ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2026 13:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785528641; x=1786133441; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FU39kIkoMhXTKKpE37dh0PJvK+pnljqlvEGquRB6geM=;
        b=ebFw9/MR9cvoBovhczO1H31e9uGmg/H6fwFnkFkU9yuCqr2hkYcVysAgn07VS4ntzM
         f/MvFCkL9vb4SeFwrUUyyTRddCFK0kOUJ1YQ/vIb0AmfSfap1hBVePEtj6cHY2JwADXP
         e713OoKnYpTdZUrMOq9XxlsPsAX6bNi4m/0mmXVyzP9KlejcQvj0H7BFOhPgRIVpjdtQ
         2XsbxL3S+p30G07fx1PRVxiQqW2Xj/9WELio9apf9hdVoswbdMx9MmjLTdCSFonqLIWQ
         YAgk6c6r91tIGRH7yggrBfF5DMMNCzkgFikI6p18HTUJJkLdRWwXrkVrG5mACnvDtJdF
         bXrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785528641; x=1786133441;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FU39kIkoMhXTKKpE37dh0PJvK+pnljqlvEGquRB6geM=;
        b=DRQJNZJW4kRgwBYXYglYVAe6gfWB48P6YC9HXVap2jh3Q9Mi1YJbmJFBpR5jY3Netg
         8FshGBgpHCEt5JYwcQQXKSnAERQbIxRZxPwRsHjfNjKcSCZKteXCLirv+ST/cyyyZwOu
         isx74e7VrtXjKjvFGKKDKag5Di34/ufPB09SicUbi0BnH/y7pLs3Xq3GBqOPK+80b8Tj
         +Y7nnE4ni+C/Dt4soxE0N+PdoiEe/Dt9R6ICeq/YHhze7XXPZFZcUxFzaaCChPm9IY5u
         sFi0Cbese5Ur2QeoVyR8RUzFXxmELKhNQAPKvzyhwaLApLXbzp7XDEBQQs8Qfdp3M+Hl
         gD4w==
X-Forwarded-Encrypted: i=1; AHgh+Ro6INkQkHdIh95Kix1A2jhnA49G2PsDoabO4h48QeCwdplx99CDV3Bpggd6maElXIOeDDMPL2SluF6AAkQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyAsC0leFdRnNvO3nim1NCpAuorj3u4ltfsvbWHhd9IGT1b/7I5
	Kz6ZJCMwzhR9eci3Le9lVxozmFIR0BuCXPD4T8bYG3DAc1Dt0MvPzmT5dgWX5TlFUDfVeR3vXpw
	m5JjEoQ==
X-Received: from plbi4.prod.google.com ([2002:a17:903:20c4:b0:2ca:caf1:5e10])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:390c:b0:2ca:ce92:6e44
 with SMTP id d9443c01a7336-2d05218984fmr11367635ad.8.1785528640749; Fri, 31
 Jul 2026 13:10:40 -0700 (PDT)
Date: Fri, 31 Jul 2026 13:09:52 -0700
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
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <178552810478.2701886.12087185654970147716.b4-ty@google.com>
Subject: Re: [PATCH 0/6] KVM: Harden kvm_vcpu_map() usage against memory leaks
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="utf-8"

On Thu, 23 Jul 2026 17:47:51 -0700, Sean Christopherson wrote:
> Harden kvm_vcpu_map() usage against memory leaks by yelling if there's already
> a valid mapping, and then unmapping the existing mapping before establishing a
> new one.  To get there, add a CLASS() for local, on-stack usage, to guarantee
> the map metadata is zero-initialized (well, so long as the CLASS() is used).
> 
> Prompted by 2f2312c422fd ("KVM: nVMX: Put vmcs12 pages if nested VM-Enter fails
> due to invalid guest state").
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/6] KVM: nVMX: Ensure KVM_REQ_GET_NESTED_STATE_PAGES is cleared on VM-Exit
      https://github.com/kvm-x86/linux/commit/11722439fb20
[2/6] KVM: nSVM: Add CLASS()es for automagically handling local kvm_vcpu_map() usage
      https://github.com/kvm-x86/linux/commit/d196e4d91e78
[3/6] KVM: nSVM: Use CLASS(kvm_vcpu_map_local) for SMM VMCB mappings
      https://github.com/kvm-x86/linux/commit/b717245a7b08
[4/6] KVM: nVMX: Use CLASS(kvm_vcpu_map_local_readonly) for MSR bitmap merging
      https://github.com/kvm-x86/linux/commit/6bb3493175d8
[5/6] KVM: PPC: Use CLASS(kvm_vcpu_map_local_readonly) for patching dcbz
      https://github.com/kvm-x86/linux/commit/e060b94a1cd4
[6/6] KVM: Harden kvm_vcpu_map() against double-mapping and thus leaking references
      https://github.com/kvm-x86/linux/commit/e186d4e34ad5

--
https://github.com/kvm-x86/linux/tree/next

