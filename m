Return-Path: <linuxppc-dev+bounces-19916-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0CA5F94CB7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2026 23:29:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0dpp1Tt2z2xSG;
	Wed, 22 Apr 2026 09:29:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::44a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776814146;
	cv=none; b=RvtZqhcYhcSHG5JnID/C4xFZyKsVU+dL+6ulNPbZHrBZl+FVb8iF3tnn+FzZf0zP2ZK1rm8fJD8sA6P4N8BfsYTmI18J9XLtdOMQUZCKckVneQd7FSwGG3RCYa8TGvP49YV7eIPPCmd5tGUN1WFhCceEK2g+3nsqDrsr4U6G/O5cVMkBohGF7vlSCV8cIF2eAXglPpLzxIylI3YgDSR9b031+Qw3nlxj/6w4TatX0jSVz3k63kOGziura3CMrF4oqVefRgyPM4nWBCbEBqyaF1WG5nVaMRbHbfiySACxqXW8b/ZG0PVv141zrJv/EBDXnJ/9v3YsY0df0DtlWS/hEw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776814146; c=relaxed/relaxed;
	bh=ZWZYxE3QD5cUq20TfuzmdK/ApbS+ouPpLPbbjRuSCrk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dpqZn/KkT1+OJ/i9PpCUshGJcsmBSSFNmI6BTygo3mrGRmR+vaUjjReDBlGRm8zlI3nImbBXL8PHm7UMKOnfpCSuDAB/84byjlxLVz6Nb0LpnbZBYyiU8XAz+5JIcYgp4wIWIoJ7u0STIB2RXUYABcYPEQdLeKSBvxdF4dfk8xm4079RSm9jZJz1FONnhGjiH5m9YkQKW8n3Xhv4CEfuxFx2KT5yCdDRPHYp+90Y+ogU/OnR7LfrGh1wvhcmzSSNUx9IdSsE8Srf6zwsyCjWeYiE5LOpLLVS6x8JGaZtxj35vXcdLzbqXNhM8KqbcpcYqU4rKF4/Nqgu5ZOWNqr6zw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=FtWnd2wV; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::44a; helo=mail-pf1-x44a.google.com; envelope-from=3pgjoaqykdeuzlhuqjnvvnsl.jvtspu14wwj-kl2spz0z.v6shiz.vyn@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=FtWnd2wV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::44a; helo=mail-pf1-x44a.google.com; envelope-from=3pgjoaqykdeuzlhuqjnvvnsl.jvtspu14wwj-kl2spz0z.v6shiz.vyn@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0dpn39K2z2xSB
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2026 09:29:04 +1000 (AEST)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-82f5f48458eso2758600b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2026 16:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776814142; x=1777418942; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWZYxE3QD5cUq20TfuzmdK/ApbS+ouPpLPbbjRuSCrk=;
        b=FtWnd2wVwyFtWFVPmKnP0I7zRsNScJvIb6Qtec8DfGmnSiJ9PVh9gtIIwLUWpUIL9z
         LtlEK3hs2bvc1cdBg3Y6GquAd0s8YBNvqr/jn3iyyWHHzegCsCujNK4yNWCeFgZ94uqD
         4yHUmOIj3xN9ZJE2m9zHxnt+rMD2npXxBInG4HnItlyWQTinBaRTJe8UoYFdB/2zOdO8
         99n+0+B/dzhhNBr/yrpu3Wuz0qpFpDiNRyBgy7eH0NDJqsTOhiByRH2f86ugivewtvhh
         ZtmTuLa9BWHto5S0xyGVF7nN15I5r/8COlGTnbSDtIrhnwmxl1USRAUohJwMOYaS8fry
         sScw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776814142; x=1777418942;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWZYxE3QD5cUq20TfuzmdK/ApbS+ouPpLPbbjRuSCrk=;
        b=mbXp3DNmIG5IhsW5PeDge54J/dRWGWJ6UZSTsZIYCx8SRekIN2LgY+9IMIvHgu2Q3B
         /BPpkd3dkr9+zDjTOqZLx1OfF6PewPXdjmm0h+nf5Mt4LFtjxbLaClovcDTzwweUA1qi
         sBlui8AOTzJYbqQ4fxXbUDj/vGNEs2i4JvzUKiUa0xdhGQxjqsYwzwEVa4T3KgNTujo7
         gAdAM5IY2Nh+/DLD26lyCDAminmfIwkw8PFdX/fDs95izh5UMzW1hybGS0+TENdy1a1p
         Kb/c0HZCg924h6tRziMA5DbA5msVPRw7s1y3IA6wIbI+SNFdj/CItY3RqRTe1SITss+m
         9w+Q==
X-Forwarded-Encrypted: i=1; AFNElJ+Xb3ZYxwZ5RjixfrfRsSH4FtqSYDne61JAEGJMMo4/mN7F+RtIVDHx+u4XV4YtMdZUWAZsu918wuRRgrQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwK3J/joQR3T5zN61ovOUqQE8PHAJ4sp8ekM05xH1hcIBQaYxye
	loRGRFbq3Ne70xGTkYvxopnJmQnq4JJ683uT6kWYZUZ30ZfEJkHrJiuzSJVir/lBSm92/wRPC8U
	BzOTXCw==
X-Received: from pfve12.prod.google.com ([2002:a05:6a00:1a8c:b0:82f:6a57:a9aa])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2889:b0:82f:4d2e:5a9a
 with SMTP id d2e1a72fcca58-82f8c8c5b8emr20478533b3a.29.1776814142280; Tue, 21
 Apr 2026 16:29:02 -0700 (PDT)
Date: Tue, 21 Apr 2026 16:29:00 -0700
In-Reply-To: <aegF59gToidudIUC@google.com>
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
 <20260408001137.3290444-4-peter.fang@intel.com> <aegDJssx-ZvbfggI@google.com> <aegF59gToidudIUC@google.com>
Message-ID: <aegIPGYPH-nxGsua@google.com>
Subject: Re: [PATCH v2 3/3] KVM: Take gpa_t in kvm_vcpu_map[_readonly]()
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Peter Fang <peter.fang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Ritesh Harjani <ritesh.list@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 21, 2026, Sean Christopherson wrote:
> On Tue, Apr 21, 2026, Yosry Ahmed wrote:
> > On Tue, Apr 07, 2026 at 05:11:30PM -0700, Peter Fang wrote:
> > > Move the conversion from a gpa_t to a gfn_t into kvm_vcpu_map() and
> > > kvm_vcpu_map_readonly() so that they take a gpa_t directly, reducing
> > > boilerplate at call sites.
> > > 
> > > __kvm_vcpu_map() still takes a gfn_t because guest page mapping is
> > > fundamentally GFN-based.
> > > 
> > > No functional change intended.
> > > 
> > > Compile-tested on x86 and ppc, which are the current users of these
> > > interfaces.
> > > 
> > > Suggested-by: Yosry Ahmed <yosry@kernel.org>
> > > Signed-off-by: Peter Fang <peter.fang@intel.com>
> > > ---
> > 
> > I was going to suggest a WARN in kvm_vcpu_map() and
> > kvm_vcpu_map_readonly() if the passed GPA is not page-aligned, but Sean
> > usually hates my paranoid WARN suggestions.
> 
> Heh, for good reason.  Adding such a WARN would be triggered by this code:
> 
>                 if (!kvm_vcpu_map(vcpu, vmcs12->posted_intr_desc_addr, map)) {
>                         vmx->nested.pi_desc =
>                                 (struct pi_desc *)(((void *)map->hva) +
>                                 offset_in_page(vmcs12->posted_intr_desc_addr));
> 
> The PI descriptor only needs to be 64-bit aligned, not page-aligned.

To elaborate a bit, I'm all for adding WARNs in flows where something bad is all
but guaranteed to happen if an assumption is violated, or in APIs where there's
a history of goofs and/or subtlety in how the API behaves.

What I'm against is adding WARNs because someone could write bad code in the
future, or because KVM doesn't do XYZ at this time.  Such WARNs usualy just add
noise, and can even be actively harmful.  E.g. in this case, ignoring the PID
usage, a reader might look at the WARN and think it's _wrong_ to map a page in
order to access a subset of the page, which is just not true.

