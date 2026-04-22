Return-Path: <linuxppc-dev+bounces-19980-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 280F4FA1FF0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Apr 2026 20:34:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g19tz3sq4z2yv1;
	Thu, 23 Apr 2026 06:34:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::104a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776890075;
	cv=none; b=dGTgxNvNBnn4O7Zs40TyyvdlEVuiq/+IMBDKkVdpaZ4r6Pywrn+x0hei0JPcR+jsQsdVvXmHEW5OQeBFB1tYO2TNG78rSfYnDcab8fUnfhN4SsaWGGKmg0eXm3yypy2lYEfEzinxp2Dm6+lkX9WNMVUGmpC59vwrSuAKbNE6QmSURK+MqDRXZ9vn96HHUb72p4LcJiFcaVIsV93jXSnGfjMhE/01afs1w1cMXL1J5MabINDtrTkxLIlWZ18MZM6lNXJchHLzb5rdJF43NrzV6h/TDy44yOTE+WgmrZ/1qDAynBphdi4PlcAOeYt6IW2eQoLUkdomLgAtxKA+a8dsfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776890075; c=relaxed/relaxed;
	bh=r6cKYb2nrrVr10xS0LVArs9DazD2S5XwOnl2A2OaOrk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ebGr+8l8iKtsWt747k4SkX9p6hoUZZMCeRogVpD1a1h1GA5LIT0EGWfo4IpQTnFA+uf9/1YsfSBHZWp4N9cHDW49VHwxjweMwOn0NT5rt9zYtY7vdrnSW5n4qLVcqlrCacJVJ4hAkbdzd+pbCsmU1SihkP5eeW0rCQdDb1DcNC+i8zOOSvJ8V1U7E5NSf5QaoVcfUOpMPKDSNolCdWyfXbs0bYG4jNhk/IrXrAe2ykDf7Czlln0Zp3f8EP6hpKmfMj1lTEkgRGse2JtlfJQvormXX2K3XlmOY9/jR9jse2H1URxVSl9zrOR5UWUJ9+XfIyghvft7rrwEQu/pQt0hrQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=H19Zl46s; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::104a; helo=mail-pj1-x104a.google.com; envelope-from=31jdpaqykddmhtpcyrvddvat.rdbaxcjmeer-stkaxhih.doapqh.dgv@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=H19Zl46s;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::104a; helo=mail-pj1-x104a.google.com; envelope-from=31jdpaqykddmhtpcyrvddvat.rdbaxcjmeer-stkaxhih.doapqh.dgv@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g19ty00lmz2xc8
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 06:34:33 +1000 (AEST)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-35845fcf0f5so6397373a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2026 13:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776890071; x=1777494871; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r6cKYb2nrrVr10xS0LVArs9DazD2S5XwOnl2A2OaOrk=;
        b=H19Zl46sUz4pwjlzxBm2Qi7RjoHWun7nZiFgdID/WOnTfCsHcrHvEKkB2MUovSNZuD
         tsYzPEy5v2jDJOamnzV+Y0SMsRj++fEdtRERdIzQvgO1U/TBMN6H1RAWVQ8Cm2cmSjSD
         +k8QBvdvESOhEVD7ptgL4ozz/aoYxqMZRehoUV/UW95awZpm2p2h/IrxIbks3PMQpgA1
         0fjksHb3bFv96MFcYDsxkCL076CderR9zrsBRagxpFkVY5Pl+rNwmFvQ0w4WaOLBZN0g
         YwXxsuamcH/M7/ON1eRBcir57ZosjPzg9InDWn9BakSfOairrGlBKSAL7Hv6mswEKh6x
         QHxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776890071; x=1777494871;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r6cKYb2nrrVr10xS0LVArs9DazD2S5XwOnl2A2OaOrk=;
        b=XFXeHLtYO9bYRCAD6uBY7u8A14KCKQhHDQBVwjBhyNSiXvOAm3qxozP5D9Fw4TQlWR
         DPAnccwhbOk0H2CAntdJDpepiJUnSZy8u+CGlchO8nBfcC9U/Wh96jxRvoFxQmgReCdK
         IXI6KG6pVj3W0TZIUi+TNbVs+POzbVfdhn+CGEJVWNEX+ByUHOLgybV/fyjrvqVtdJPh
         An5sKpBFcMsMDFiMZznzxv5KXXSmAGQshTMIZT9sawotfO4bYOOm2zvJ3nWdSyfGwipN
         1SCuiDP57eutaxQ7TNPWSilq0LFI3Uu2mCoHHoh6morJh5Cy6FPNNYXs9JOT5RdWIOD1
         kigQ==
X-Forwarded-Encrypted: i=1; AFNElJ+QGoUtGEUqd68D5KGsrnbF2mecEgx3LCUBflgJ0p9PgJ2zg7fqVBTCeM4v6jf7+v09IdDO7v0yGs+yUTg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxvrTa0DlOKu1QxB6YtHbm5j4EM0u4/xUdJ2DtHgmy5gZVGAu2g
	YOB4DHJREQtf0rKxUnpoJ8D/BpOJl5T0GbCNyXBeTgtKBFZgt/nQGbEpER05+e9j5zG4obuSe1j
	K9YGVuQ==
X-Received: from pjvi16.prod.google.com ([2002:a17:90a:dc10:b0:35e:591b:3591])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3ec5:b0:35f:b4c1:91ea
 with SMTP id 98e67ed59e1d1-361402ee818mr18770329a91.13.1776890070624; Wed, 22
 Apr 2026 13:34:30 -0700 (PDT)
Date: Wed, 22 Apr 2026 13:34:29 -0700
In-Reply-To: <aekrJrSRoclZoBo9@google.com>
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
 <20260408001137.3290444-4-peter.fang@intel.com> <aegDJssx-ZvbfggI@google.com>
 <aegF59gToidudIUC@google.com> <aegIPGYPH-nxGsua@google.com>
 <CAO9r8zOsHdsMuyjWr3XafjNnMKDci1OOdw8eJHrH-O+jrDH10Q@mail.gmail.com>
 <aegV3ELp20DlC5Ge@google.com> <aekrJrSRoclZoBo9@google.com>
Message-ID: <aekw1S5Gdkyx8teC@google.com>
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

On Wed, Apr 22, 2026, Yosry Ahmed wrote:
> > > Perhaps we just need to rename the functions (e.g.
> > > kvm_vcpu_map_page()), or more intrusively pass in a size and do bounds
> > > checking.
> > 
> > Definitely the latter.  Or both I guess, but probably just the latter.
> 
> I think both. I think renaming to kvm_vcpu_map_page() (and similar for
> others) would further clarify things, especially with the introduction
> of kvm_vcpu_map_ptr() below.

I don't like "page" it's too easy to incorrectly assume "page" means "struct page".
There are KVM APIs that do use "page" generically, e.g. kvm_read_guest_page(),
but for this particular case I'd like to stay away from "page; there's a _lot_
of ugly history around mapping "struct page" vs. "other" memory in KVM.

> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index 9093251beb39..e8d2e98b0068 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -3114,9 +3114,10 @@ struct page *__gfn_to_page(struct kvm *kvm, gfn_t gfn, bool write)
> >  }
> >  EXPORT_SYMBOL_FOR_KVM_INTERNAL(__gfn_to_page);
> >  
> > -int __kvm_vcpu_map(struct kvm_vcpu *vcpu, gfn_t gfn, struct kvm_host_map *map,
> > -		   bool writable)
> > +int __kvm_vcpu_map(struct kvm_vcpu *vcpu, gpa_t gpa, gpa_t len,
> > +		   struct kvm_host_map *map, bool writable)
> >  {
> > +	gfn_t gfn = gpa_to_gfn(gpa);
> >  	struct kvm_follow_pfn kfp = {
> >  		.slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn),
> >  		.gfn = gfn,
> > @@ -3124,6 +3125,10 @@ int __kvm_vcpu_map(struct kvm_vcpu *vcpu, gfn_t gfn, struct kvm_host_map *map,
> >  		.refcounted_page = &map->pinned_page,
> >  		.pin = true,
> >  	};
> > +	kvm_pfn_t pfn;
> > +
> > +	if (WARN_ON_ONCE(offset_in_page(gpa) + len > PAGE_SIZE))
> > +		return -EINVAL;
> 
> Maybe do the bounds checking after initializing 'map', then
> kvm_vcpu_map_ptr() wouldn't need to explicitly set the pointer to NULL
> on failure? 

Hmm, no.  I don't want to encourage the caller to rely on the state of @map if
the call fails.

> There is already possibility of failure after initialization anyway.

Sure, but the caller shouldn't rely on that.

