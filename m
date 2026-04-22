Return-Path: <linuxppc-dev+bounces-19979-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD5FAFA1FEF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Apr 2026 20:19:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g19Z0027Tz2yv1;
	Thu, 23 Apr 2026 06:19:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776889191;
	cv=none; b=jldEGfJTi6TMn7IlLXCNfApP3AXk1F7RrpjYJMEhSYnP7ywnZXo5KhlmTsAqPQ4XGcqz/rkil+tG+QiMVwsELUsmUm9iLs9mZ+NnR4juDDEtNyBz5c8WxyS0Ua32PtPRlY+ptdBCMV5TENDEbamtOwis7qPFuY2VXSniyPDc9a8t2HzcKk0RrJV7kuFxUOcXvVG/oHj9rsz+oCD2vNae7+E6pWZ6TgPLwXMIKItI/k0ImgHuiI3ldMIJUAjT3HbEoAOIHR68sVrRv+L10zxP6ZTJj3lPPqak9h1qkI4VnmQWzBVvfgfSiYAwmS31OcbODp97zbkgj1UueW+Nr9ruZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776889191; c=relaxed/relaxed;
	bh=VlOiElM1EsJf5YDp7i1dvsovk1trsjX6zfWq60AQT9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RNCFbaPNdVlBMsyvoHVTVYtgbWYTOMifzcAXf+78Ozq2Fs9sS9T4GxOO8MMO5zIGqdhM50CgCRmsBf1uXmIBbsBdVezBIKo0H4NyvQV7HYCNk6QtMzOY/qr056Z4+QEv+ZbHkDBgx8A7ibVNPrRW9kJp6p9ioSmgL3ZsFqlVcTgjfodzCF0Hb10z1g8zV1HczADXyvOx/2nQDtszVGZgcTRlyg3KCb72T2br5Z4X1VRN7Ag8jAyHU91kpkEwGqRacU3un7fyJ7iN09vFnDe3M2Wh1WnHoT1OCrJDJ+FFQFAwjP9WQ2wTNU3hrckl39/rZn/lcLynresDeBG40A6x5Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TwcCsK0j; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=yosry@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TwcCsK0j;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=yosry@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g19Yy5w3pz2xc8
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 06:19:50 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A3D2061863;
	Wed, 22 Apr 2026 20:19:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B332BC19425;
	Wed, 22 Apr 2026 20:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776889187;
	bh=VmymqZSlNHKqJ1j2tud/g10QS0Cg2TvqmT88ttFNvUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TwcCsK0jWEpERnj6fn77/McX7WjmOg8rcZliPqj306Z+swnRvkbX8wyIMOHJlq/SG
	 0reOKFo/vD8Ccmj/bWliseYUJstGJa1ng3gjEIH0yUVFO26W6VmlNISyw2E5RXz7Nh
	 cIx2zcHcFpWxZF5QzsGko1v5v+GoI0xFR7fBHEaa/cEmkE1TZTbOuInv0jmKXsZdaR
	 fSCCbTSCB3bKNVpjavSt4HnOVFF175w0m+szXZvmnmnZwMCUbvfG5UxBVMwoRgkpE/
	 6KoWtnhwhDfMJKFHryHD6Do7phu3cojzVNe38LSCldbtRJnqWSGOl5JMjhdKYJPYT6
	 FAHIXp52VEz+g==
Date: Wed, 22 Apr 2026 20:19:45 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Peter Fang <peter.fang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Ritesh Harjani <ritesh.list@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] KVM: Take gpa_t in kvm_vcpu_map[_readonly]()
Message-ID: <aekrJrSRoclZoBo9@google.com>
References: <20260408001137.3290444-1-peter.fang@intel.com>
 <20260408001137.3290444-4-peter.fang@intel.com>
 <aegDJssx-ZvbfggI@google.com>
 <aegF59gToidudIUC@google.com>
 <aegIPGYPH-nxGsua@google.com>
 <CAO9r8zOsHdsMuyjWr3XafjNnMKDci1OOdw8eJHrH-O+jrDH10Q@mail.gmail.com>
 <aegV3ELp20DlC5Ge@google.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aegV3ELp20DlC5Ge@google.com>

> > > To elaborate a bit, I'm all for adding WARNs in flows where something bad is all
> > > but guaranteed to happen if an assumption is violated, or in APIs where there's
> > > a history of goofs and/or subtlety in how the API behaves.
> > >
> > > What I'm against is adding WARNs because someone could write bad code in the
> > > future, or because KVM doesn't do XYZ at this time.  Such WARNs usualy just add
> > > noise, and can even be actively harmful.  E.g. in this case, ignoring the PID
> > > usage, a reader might look at the WARN and think it's _wrong_ to map a page in
> > > order to access a subset of the page, which is just not true.
> > 
> > Yeah I agree with most/all of your objections to my suggestions, it's
> > usually that I don't have enough context to understand how the WARN
> > could be harmful (like here), or am just being too paranoid or
> > defending against bad code as you mentioned. I was mentioning your
> > objections semi-sarcastically and intentionally bringing up the WARN
> > in case it's actually useful.
> > 
> > Taking a step back, what I really want to clarify and/or detect misuse
> > of, is that kvm_vcpu_map() will map exactly one page, the one that the
> > GPA lies in. For example, there's nothing protecting against the PID
> > address being the last byte of the page, 
> 
> Well, technically there is:
> 
> 	    CC(!kvm_vcpu_is_legal_aligned_gpa(vcpu, vmcs12->posted_intr_desc_addr, 64))))
> 		return -EINVAL;
> 
> But I'm pretty sure what you're saying is that "nothing in the common helper code
> protects against a stupid caller".

Yes. Now I am actually glad I brought up the WARN and you elaborated
your thoughts, because it made me think and spell out my actual concern
(that my brain translated into just WARN initiailly): we need bounds
checking.

> 
> > in which case accessing all of it would be wrong as it spans the mapped page
> > boundary. This is difficult to hit if you are passing in a GFN, as it's more
> > obvious that KVM is mapping one physical page.
> 
> Eh, that just leads to a different class of bugs (and possible even *worse* bugs).
> E.g. caller passes in a GFN, accesses the kernel mapping beyond the page, and
> reads/write arbitrary kernel memory (pfn_valid() case using the direct map), or
> hits a !PRESENT #PF (remap case).
> 
> > Perhaps we just need to rename the functions (e.g.
> > kvm_vcpu_map_page()), or more intrusively pass in a size and do bounds
> > checking.
> 
> Definitely the latter.  Or both I guess, but probably just the latter.

I think both. I think renaming to kvm_vcpu_map_page() (and similar for
others) would further clarify things, especially with the introduction
of kvm_vcpu_map_ptr() below.

> 
> Commit 025dde582bbf ("KVM: Harden guest memory APIs against out-of-bounds accesses")
> added that type of hardening for the "slow" APIs, exactly because of the type of
> OOB bug you're describing: commit f559b2e9c5c5 ("KVM: nSVM: Ignore nCR3[4:0] when
> loading PDPTEs from memory").
> 
> Actually, that's actually useful feedback for patch 3.  __kvm_vcpu_map() should
> do the GPA=>GFN conversion, not its caller.

Yes.

> 
> Anyways, back to the hardening.  We can do it with minimal additional churn.  After
> patch 3 (passing a @gpa to __kvm_vcpu_map(), not a @gfn), do the below over a few
> patches (completely untested).  This way the common case of mapping and accessing
> an entire page Just Works, and flows like the PI descriptor handling don't have to
> many provide the length (which also can be error prone).

Yeah probably this (maybe not in the same order):
- Convert map->pfn to map->hpa.
- Pass size to __kvm_vcpu_map() and do bounds checking.
- Rename kvm_vcpu_map() and __kvm_vpcu_map() to kvm_vcpu_map_page() and
  __kvm_vcpu_map_page().
- Introduce kvm_vcpu_map_ptr() wrapper and simplify the nested PID call
  site.

Generally looks good with a small nit/question below. Peter, would you
be interested in extending the series to do this? If not, I can send a
follow up on top of your series when it's hashed out.

[..]
> @@ -1893,22 +1894,31 @@ static inline hpa_t pfn_to_hpa(kvm_pfn_t pfn)
>  	return (hpa_t)pfn << PAGE_SHIFT;
>  }
>  
> -int __kvm_vcpu_map(struct kvm_vcpu *vcpu, gfn_t gfn, struct kvm_host_map *map,
> -		   bool writable);
> +int __kvm_vcpu_map(struct kvm_vcpu *vcpu, gpa_t gpa, gpa_t len,
> +		   struct kvm_host_map *map, bool writable);
>  void kvm_vcpu_unmap(struct kvm_vcpu *vcpu, struct kvm_host_map *map);
>  
>  static inline int kvm_vcpu_map(struct kvm_vcpu *vcpu, gpa_t gpa,
>  			       struct kvm_host_map *map)
>  {
> -	return __kvm_vcpu_map(vcpu, gpa_to_gfn(gpa), map, true);
> +	return __kvm_vcpu_map(vcpu, gpa, PAGE_SIZE, map, true);
>  }
>  
>  static inline int kvm_vcpu_map_readonly(struct kvm_vcpu *vcpu, gpa_t gpa,
>  					struct kvm_host_map *map)
>  {
> -	return __kvm_vcpu_map(vcpu, gpa_to_gfn(gpa), map, false);
> +	return __kvm_vcpu_map(vcpu, gpa, PAGE_SIZE, map, false);
>  }
>  
> +#define kvm_vcpu_map_ptr(__vcpu, __gpa, __ptr, __map)				\
> +({										\
> +	int r;									\
> +										\
> +	r = __kvm_vcpu_map(__vcpu, __gpa, sizeof(*(__ptr)), __map, true);	\
> +	__ptr = !r ? (__map)->hva : NULL;					\
> +	r;									\
> +})
> +
>  static inline void kvm_vcpu_map_mark_dirty(struct kvm_vcpu *vcpu,
>  					   struct kvm_host_map *map)
>  {
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 9093251beb39..e8d2e98b0068 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -3114,9 +3114,10 @@ struct page *__gfn_to_page(struct kvm *kvm, gfn_t gfn, bool write)
>  }
>  EXPORT_SYMBOL_FOR_KVM_INTERNAL(__gfn_to_page);
>  
> -int __kvm_vcpu_map(struct kvm_vcpu *vcpu, gfn_t gfn, struct kvm_host_map *map,
> -		   bool writable)
> +int __kvm_vcpu_map(struct kvm_vcpu *vcpu, gpa_t gpa, gpa_t len,
> +		   struct kvm_host_map *map, bool writable)
>  {
> +	gfn_t gfn = gpa_to_gfn(gpa);
>  	struct kvm_follow_pfn kfp = {
>  		.slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn),
>  		.gfn = gfn,
> @@ -3124,6 +3125,10 @@ int __kvm_vcpu_map(struct kvm_vcpu *vcpu, gfn_t gfn, struct kvm_host_map *map,
>  		.refcounted_page = &map->pinned_page,
>  		.pin = true,
>  	};
> +	kvm_pfn_t pfn;
> +
> +	if (WARN_ON_ONCE(offset_in_page(gpa) + len > PAGE_SIZE))
> +		return -EINVAL;

Maybe do the bounds checking after initializing 'map', then
kvm_vcpu_map_ptr() wouldn't need to explicitly set the pointer to NULL
on failure? There is already possibility of failure after initialization
anyway.

>  
>  	map->pinned_page = NULL;
>  	map->page = NULL;
> @@ -3131,20 +3136,25 @@ int __kvm_vcpu_map(struct kvm_vcpu *vcpu, gfn_t gfn, struct kvm_host_map *map,
>  	map->gfn = gfn;
>  	map->writable = writable;
>  
> -	map->pfn = kvm_follow_pfn(&kfp);
> -	if (is_error_noslot_pfn(map->pfn))
> +	pfn = kvm_follow_pfn(&kfp);
> +	if (is_error_noslot_pfn(pfn))
>  		return -EINVAL;
>  
> -	if (pfn_valid(map->pfn)) {
> -		map->page = pfn_to_page(map->pfn);
> +	map->hpa = pfn_to_hpa(pfn);
> +	if (pfn_valid(pfn)) {
> +		map->page = pfn_to_page(pfn);
>  		map->hva = kmap(map->page);
>  #ifdef CONFIG_HAS_IOMEM
>  	} else {
> -		map->hva = memremap(pfn_to_hpa(map->pfn), PAGE_SIZE, MEMREMAP_WB);
> +		map->hva = memremap(map->hpa, PAGE_SIZE, MEMREMAP_WB);
> +		if (!map->hva)
> +			return -EFAULT;
>  #endif
>  	}
>  
> -	return map->hva ? 0 : -EFAULT;
> +	map->hpa += offset_in_page(gpa);
> +	map->hva += offset_in_page(gpa);
> +	return 0;
>  }
>  EXPORT_SYMBOL_FOR_KVM_INTERNAL(__kvm_vcpu_map);
[..]

