Return-Path: <linuxppc-dev+bounces-22516-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E337BCD8C9D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 17:54:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbqys39JYz3bqh;
	Fri, 12 Jun 2026 03:54:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::64a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781200453;
	cv=none; b=U1RyFyyVb5uctoVY2J3z8FwP0YdapTQVlauEJ4fhbJk6VKDwjXKVVWMKxv+5zSf5nCdNR/rNhoGEgzAabWm6jkV2bzC2VgCu+HnfB65SbHYQWg2FSUm6leVBnN6W34EM8yBody/PgEo8AgwhhJ94M8M6eI1XhxLnGIOYi56Mu65tcrZsOml0on6nnzkRGnqZq0rbobzxtawHPxYpK8r3iEMYZZI+01U/qxzKsWjXUNYEpvHd7VK+A/Gy6L8L9Bc8VUSRM2fnfhOXj9Gw7krlUcNUjG2p+r9dQ7VbFcKM7SSC1Bj/LkbjsJAzgNHaZLCw0RnjQJqQfOhkfmmfi2+nZA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781200453; c=relaxed/relaxed;
	bh=IOJyOW3TzN5ixErWyO0JSYunyAbYlgebTlL8SlVIneA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c+cywSaij1jXnZHDQGLT/tmEaDae/8WLyB93qG4fMhdWnC5Pm3+gufVEPPevsunZo4jUGA0YDYL6gAZty8sAYw8tX3108WAEcwx1DgSi2Xr5P1PezUJMR7OQ8whsgW3J4GqjnwKA/JyMe1fJ890ooM1Es6tEF2+9qpNGvzXlZ3dy5WCi3dXL2j1vSOzSyqTvSrA9HNpQ/aP/aGUur1FD+aeYx/ZBo9QozxSjN4an63OCN6U1dj/XSGhVfqYerekgkaxBPTS9/kUnvHPKPnR+UTtCvLC2FNOLbaDKsXk/42STokXfoF/PUIx86EC5eCfnjg9F62H1H+ivwZXyNWak4A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=pQwQhaJk; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::64a; helo=mail-pl1-x64a.google.com; envelope-from=3qpyqagykddefrnawptbbtyr.pbzyvahkccp-qriyvfgf.bmynof.bet@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=pQwQhaJk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::64a; helo=mail-pl1-x64a.google.com; envelope-from=3qpyqagykddefrnawptbbtyr.pbzyvahkccp-qriyvfgf.bmynof.bet@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbqyq5JnMz2xl6
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 03:54:10 +1000 (AEST)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-2bf0b7425bbso2057825ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 10:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781200449; x=1781805249; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IOJyOW3TzN5ixErWyO0JSYunyAbYlgebTlL8SlVIneA=;
        b=pQwQhaJkADlZbRAKdS1JqXUBuQsf//vM3SvD0nxMuhpr7Ex6gYNDdMcGxpX6xeFDvY
         EkB5PVZKQGeHu04fzJTw/hZGIPv/6pjjXHTDGJmlA1ZDNoDvQD/kEa9hnVChKEABEqMX
         3zuju1MXTFlKCYqTHNCIdEU7ZDG8rMyb8MC4alUOANKSfadlN+F+l9HhyQZgxA5dlan1
         BF2eWS56nqcVt3wPXL+ovU7VWjSq9wWmF6FUU7jJRA8ED2bqmsfqXDrAN+0tXdmbzl8Y
         eEz6l0I0i5Rb/X/AVrrTt9crdACJ2TD8ybGdUGx2yF1XR+2npOfqb3+oG9RS8wAn56Kd
         LCJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781200449; x=1781805249;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IOJyOW3TzN5ixErWyO0JSYunyAbYlgebTlL8SlVIneA=;
        b=p1beKdTaRb00NVqHpP3frYpIq9N+z2DzUz5K4tVcREcqlgeLYEjb9e8BYOZCzzgNx9
         UI+JzuoL5RBuGI+WzbSCQKBGGFjhcjVbifL91FKRIfQ3qV33eCVzMgAIbsnZmOLbXzZr
         95GOuZIiHOLjhKoLmalBw4l2Frk3tu0qv8QBbfPaco+jExf8SSGo91MAF6ajVseyLQE7
         Jpz+bkjhnUgRxkuCTVltBhNujqHA9Ucgq+cjnb0gOTjiFUBiV2Ndf2Y8uQITShXgCS5o
         hbloR+jr4eW4oKEWqOJ+Opjx8RVBOELlVNBiKIOG2wigGpn5cKGPiAXebUsNJL9DpwV9
         s4LA==
X-Forwarded-Encrypted: i=1; AFNElJ+2qfbAyKQM1iRo/ImhNW6GS990nvdnRkjObUPlIm5AAWqYGGg5T8aaIaLigmxgtNha2yraDUBcUl+Kd2o=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz2NM+neFgNFIV0tqNcI19M1TfnCmeOyCnoZTBc0cza5IKI0F2O
	Ox5/h1YMdOEXaMtPXmIjkGl15uNafvdEQvZf8jJg08lV6LEwcDqYwJmzd23u8vrIdLsu1zRqNzW
	x0PyXWg==
X-Received: from plog3.prod.google.com ([2002:a17:902:8683:b0:2bc:ae34:223a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a88:b0:2bf:21e6:baee
 with SMTP id d9443c01a7336-2c2f470dc43mr48152335ad.28.1781200448836; Thu, 11
 Jun 2026 10:54:08 -0700 (PDT)
Date: Thu, 11 Jun 2026 10:54:08 -0700
In-Reply-To: <ldcldopw.ritesh.list@gmail.com>
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
References: <cover.1781093720.git.ritesh.list@gmail.com> <df86b5ccdbdafc3509d9538bd5e6796737bab2db.1781093720.git.ritesh.list@gmail.com>
 <aimOVomL2RzYt2J4@google.com> <ldcldopw.ritesh.list@gmail.com>
Message-ID: <air2QB-HUzxpCm_M@google.com>
Subject: Re: [PATCH v3 RESEND 02/10] KVM: selftests: Add aligned guest
 physical page allocator
From: Sean Christopherson <seanjc@google.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Christophe Leroy <chleroy@kernel.org>, Anushree Mathur <anushree.mathur@linux.ibm.com>, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
	Ackerley Tng <ackerleytng@google.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Jun 11, 2026, Ritesh Harjani wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
> > On Wed, Jun 10, 2026, Ritesh Harjani (IBM) wrote:
> >> From: Nicholas Piggin <npiggin@gmail.com>
> >> 
> >> powerpc will require this to allocate MMU tables in guest memory that
> >> are larger than guest base page size.
> >> 
> >> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> >> [Rebased to latest mainline tree]
> >> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> >> ---
> >>  .../testing/selftests/kvm/include/kvm_util.h  | 20 +++++++++--
> >>  tools/testing/selftests/kvm/lib/kvm_util.c    | 33 +++++++++----------
> >>  2 files changed, 33 insertions(+), 20 deletions(-)
> >> 
> >> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> >> index 3666a8530f31..c515c918c2c9 100644
> >> --- a/tools/testing/selftests/kvm/include/kvm_util.h
> >> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> >> @@ -991,8 +991,8 @@ void kvm_gsi_routing_write(struct kvm_vm *vm, struct kvm_irq_routing *routing);
> >>  const char *exit_reason_str(unsigned int exit_reason);
> >>  
> >>  gpa_t vm_phy_page_alloc(struct kvm_vm *vm, gpa_t min_gpa, u32 memslot);
> >> -gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t num, gpa_t min_gpa,
> >> -			   u32 memslot, bool protected);
> >> +gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t num, size_t align,
> >> +			   gpa_t min_gpa, u32 memslot, bool protected);
> >>  gpa_t vm_alloc_page_table(struct kvm_vm *vm);
> >>  
> >>  static inline gpa_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
> >> @@ -1003,10 +1003,24 @@ static inline gpa_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
> >>  	 * protected memory, as the majority of memory for such VMs is
> >>  	 * protected, i.e. using shared memory is effectively opt-in.
> >>  	 */
> >> -	return __vm_phy_pages_alloc(vm, num, min_gpa, memslot,
> >> +	return __vm_phy_pages_alloc(vm, num, 1, min_gpa, memslot,
> >>  				    vm_arch_has_protected_memory(vm));
> >>  }
> >>  
> >> +static inline gpa_t vm_phy_pages_alloc_align(struct kvm_vm *vm, size_t num,
> >> +					     size_t align, gpa_t min_gpa,
> >> +					     u32 memslot)
> >
> > Given that the PPC usage is all for naturally aligned allocations, I think it
> > makes sense for that to be the API, i.e. have "bool naturally_aligned" instead
> > of an arbitrary alignment.
> >
> 
> I would still prefer passing an explicit align value to the allocator,
> because IMHO that's a useful allocator interface to have.

Why?  What are the use cases?  I can't think of anything that requires multi-page
allocations to have specific alignment, all of the cases I can think of require
natural alignment.

For sub-page allocations, supporting semi-arbitrary alignments makes sense, but
I'm not convinced we should try and support that for page-granularity allocations.

> However, if we do want to go down this road than I don't have any strong
> objection either, since as you mentioned powerpc mostly just needs
> natual alignment for it's page table region. So alignment can be
> extracted from the region type as you described below, so no need to
> pass it all the time.

..

> > The bonus is that @min_gpa goes away too.
> 
> powerpc needs min_gpa for it's exception handling pages. see.
> 
> 	excp_paddr = vm_phy_pages_alloc(vm, excp_pages, 0,
> 					vm->memslots[MEM_REGION_DATA]);
> 
> 	TEST_ASSERT(excp_paddr == 0,
> 		    "Interrupt vectors not allocated at gPA address 0: (0x%lx)",
> 		    excp_paddr);
> 
> So, will arch still have an access to the API for passing min_gpa = 0
> for cases like above?

Yep, ____vm_phy_pages_alloc() will be globally visible, and I think is quite
appropriate in this case since it's more than just specifying a minimum GPA,
it's really specifying an _exact_ GPA for the allocation.

gpa_t ____vm_phy_pages_alloc(struct kvm_vm *vm, size_t nr_pages, gpa_t min_gpa,
			     u32 memslot, bool protected, bool naturally_aligned)

> > It'll probably take me a few days/weeks, but I'll try get a series posted before
> > the 7.2 merge window closes, so that you can build on top to get the PPC selftests
> > support landed in 7.3.
> >
> 
> Thanks Sean for your help! Yes, landing kvm selftests for powerpc will
> be definitely helpful to verify against any kvm regressions.
> 
> BTW, I was thinking whether landing powerpc first will be easier for you
> to consider all the API requirements from all users / usecases?  But
> either way is fine please. I can work on top of your changes too and if
> something is missing for powerpc, we can add / modify on top, once your
> series is finished.

One idea would be for me to include the PPC support in the series; it's "just"
a patch or two on top, albeit one pretty big patch.

> >> @@ -2039,23 +2039,22 @@ gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
> >>  	TEST_ASSERT(!protected || region->protected_phy_pages,
> >>  		    "Region doesn't support protected memory");
> >>  
> >> -	base = pg = min_gpa >> vm->page_shift;
> >> -	do {
> >> -		for (; pg < base + num; ++pg) {
> >> -			if (!sparsebit_is_set(region->unused_phy_pages, pg)) {
> >> -				base = pg = sparsebit_next_set(region->unused_phy_pages, pg);
> >> -				break;
> >> +	base = min_gpa >> vm->page_shift;
> >> +again:
> >> +	base = (base + align - 1) & ~(align - 1);
> >> +	for (pg = base; pg < base + num; ++pg) {
> >> +		if (!sparsebit_is_set(region->unused_phy_pages, pg)) {
> >> +			base = sparsebit_next_set(region->unused_phy_pages, pg);
> >> +			if (!base) {
> >> +				fprintf(stderr, "No guest physical page available, "
> >> +					"min_gpa: 0x%lx page_size: 0x%x memslot: %u\n",
> >> +					min_gpa, vm->page_size, memslot);
> >> +				fputs("---- vm dump ----\n", stderr);
> >> +				vm_dump(stderr, vm, 2);
> >> +				abort();
> >>  			}
> >> +			goto again;
> >>  		}
> >> -	} while (pg && pg != base + num);
> >> -
> >> -	if (pg == 0) {
> >> -		fprintf(stderr, "No guest physical page available, "
> >> -			"min_gpa: 0x%lx page_size: 0x%x memslot: %u\n",
> >> -			min_gpa, vm->page_size, memslot);
> >> -		fputs("---- vm dump ----\n", stderr);
> >> -		vm_dump(stderr, vm, 2);
> >> -		abort();
> >>  	}
> >
> > This is unnecessary churn.  I'm not saying the current code is pretty or anything,
> > but unless I'm missing something, this can simply be:
> 
> Not really, we need the base to be aligned everytime, that's why the
> goto again loop aligns the base in the new code.

Ooh, right, pg needs to be advanced by the aligned number of pages.  Ugh, the
whole do-while part is bizarre, and AFAICT only "works" by dumb luck. 

> Plus I feel the above refactoring also simplifies the special handling of pg
> == 0 case, which earlier was being handled separately after the loop ends.

Yeah, I fiddled with a few other options, but I think I like your approach the
most.

