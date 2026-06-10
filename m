Return-Path: <linuxppc-dev+bounces-22422-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E7BCD8CB2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jun 2026 16:18:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gb9ty6Sklz30FP;
	Thu, 11 Jun 2026 02:18:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::649"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781108314;
	cv=none; b=J5IG3dO32a9J2ZLIpvPTc20kdtp8CttL3NBWRR7Ptd31Q7nP3pv7bMpYlLGtJMvr485swacwIyF8xW8hWs17MklsqQDtoSGJy4wUB/zFljuutDHyjK8Xbe1Dnmn6pvWpFxxk1cRZ1RJTWCRfMCQynEkPcAZvltYDmZPOVPhw+fs1MzgN6GHhd1+0KaqZEQxznFXz/xEXQof90AuwzmlOBmvB5bptGGe38hw8ITl9va52exJ7QP2w4bmDwu9iGWDQ+hJ+se0aSamOSCrcE8TwY712NGPyBJI1tWAPZGYatUV/6Lacz02+I/963SbHJIENtOvw8p4V1GEFDjDF+6CAaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781108314; c=relaxed/relaxed;
	bh=tYkb0fEp3Wc9CbFkLlm6u5HgKSmOOMvt3al7TMw8h4Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hY5tJEvP4Vx4VKBo9WVZATP1epCBRJYXynMYthwkBVCCHD8chwCuuom+w6KMO8poF6YW74I14dnfDLSEKtZ3QBAmRu+AXG6aGcJR0UZCIN44fksEY69ODraGWPXk+ToNlmj+YV+4yUxRpgODYtFlXAfqLivi0iB6T6zEIgwC6L8f+QrtoPqqU4d+Wi0GNdZTkInN3sY/oaBmk2acZ/Qv3WaXi44Gt3mPhHV2OwtUCPxLAIs6GbEe+SbrGw6mny0hFM0GWEaF06BXlBCOLzgFxRjwOoBhaYbIibswpDwpPUFh9W8juD1Iu5sCvTCrI6VhBT8fDXU7aEYoyggOFoIBHA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=fcF4KarN; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::649; helo=mail-pl1-x649.google.com; envelope-from=3vo4pagykdhehtpcyrvddvat.rdbaxcjmeer-stkaxhih.doapqh.dgv@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=fcF4KarN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::649; helo=mail-pl1-x649.google.com; envelope-from=3vo4pagykdhehtpcyrvddvat.rdbaxcjmeer-stkaxhih.doapqh.dgv@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gb9tx4vL7z2yv0
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 02:18:33 +1000 (AEST)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-2c0532a6588so64642165ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 09:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781108311; x=1781713111; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tYkb0fEp3Wc9CbFkLlm6u5HgKSmOOMvt3al7TMw8h4Q=;
        b=fcF4KarNVmj5sw+tjvZcAugECUBAuS8X2Sgd1NxnNrBMaPJF95Xw3AkuHZvOprT50a
         zGZQZxD7zyb8iW3AIsSKA4hNfHqbfWdhZ4omMvFkc4aCJX1j3Iy5dgawVHt11UOPhtDX
         ou5WiJKFDrNOkyyw0Ue35lCizljNK3D1mU2JV24ucvNZ/Os5+o/aT3DpQ3A8L+HEvk2n
         gALP2zvDvn2nz1iUzb7k19QVKJZ5kQF2R2jORWat1Z5qzFT4tN8viTOUsSHTmZ71/fcQ
         J53bZQak0863RqewZuWwPweZD/djQngwmAn7bkFFVxcyN84Nqeg2qCYntySwDgYeGtzv
         gNrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781108311; x=1781713111;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tYkb0fEp3Wc9CbFkLlm6u5HgKSmOOMvt3al7TMw8h4Q=;
        b=StSperq6zlwsgDsnaNxrhepw9QOzPW4deCrAxrApTP9BURyLJ0U7kwAEJhc5DGJMJc
         jCkX3ZrNWr/WuVns+s+QOt8ahGNITlg/IzB3OV0lW8vnolpe7tWsSsip8Xvx6Ekx0Dhc
         iCrSVfpLpMHnl1iZ0+ppP0mz3F9Xb+dD3sz+U1+t6Fdy3A7zuOpiUGHbZDy0oC6IayFd
         SvylKTNDV1cGfX3M6tBqpGjx555gnx/A9patyz/H4XNsmfb9wikVc7iUfjbp+eor8N8p
         KsClss52Tcjm/fvnXTO20RNGsHGTCYLmwEEfNQYxfZ3Rmtat309EBauqOjvxqpCbqN0L
         duKA==
X-Forwarded-Encrypted: i=1; AFNElJ9tmWhXJ2VfNHNfshorF2Wh4ps/IA+lpkWCvJ6FLeNuXOdmLG6b3d0he3Gt4s/wyEh5fOLn7c9+f9iS6i4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyYq0HDui+OxO+Awujgy0h+6xh5u+e22H8oYqddznABznlkYojG
	eNG5dgmlJ15LRk+KnFW/I7XYVZnDyMt2qbNipGuVQWxxxQaS6+U2hPrfap2BaK7BjLjET1/z77s
	l444YTA==
X-Received: from plcx2.prod.google.com ([2002:a17:903:c2:b0:2c1:13e7:a57d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1aef:b0:2c2:7e17:39f6
 with SMTP id d9443c01a7336-2c27e173ecfmr158975595ad.36.1781108310808; Wed, 10
 Jun 2026 09:18:30 -0700 (PDT)
Date: Wed, 10 Jun 2026 09:18:30 -0700
In-Reply-To: <df86b5ccdbdafc3509d9538bd5e6796737bab2db.1781093720.git.ritesh.list@gmail.com>
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
Message-ID: <aimOVomL2RzYt2J4@google.com>
Subject: Re: [PATCH v3 RESEND 02/10] KVM: selftests: Add aligned guest
 physical page allocator
From: Sean Christopherson <seanjc@google.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Christophe Leroy <chleroy@kernel.org>, Anushree Mathur <anushree.mathur@linux.ibm.com>, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
	Ackerley Tng <ackerleytng@google.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Jun 10, 2026, Ritesh Harjani (IBM) wrote:
> From: Nicholas Piggin <npiggin@gmail.com>
> 
> powerpc will require this to allocate MMU tables in guest memory that
> are larger than guest base page size.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> [Rebased to latest mainline tree]
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  .../testing/selftests/kvm/include/kvm_util.h  | 20 +++++++++--
>  tools/testing/selftests/kvm/lib/kvm_util.c    | 33 +++++++++----------
>  2 files changed, 33 insertions(+), 20 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> index 3666a8530f31..c515c918c2c9 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> @@ -991,8 +991,8 @@ void kvm_gsi_routing_write(struct kvm_vm *vm, struct kvm_irq_routing *routing);
>  const char *exit_reason_str(unsigned int exit_reason);
>  
>  gpa_t vm_phy_page_alloc(struct kvm_vm *vm, gpa_t min_gpa, u32 memslot);
> -gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t num, gpa_t min_gpa,
> -			   u32 memslot, bool protected);
> +gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t num, size_t align,
> +			   gpa_t min_gpa, u32 memslot, bool protected);
>  gpa_t vm_alloc_page_table(struct kvm_vm *vm);
>  
>  static inline gpa_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
> @@ -1003,10 +1003,24 @@ static inline gpa_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
>  	 * protected memory, as the majority of memory for such VMs is
>  	 * protected, i.e. using shared memory is effectively opt-in.
>  	 */
> -	return __vm_phy_pages_alloc(vm, num, min_gpa, memslot,
> +	return __vm_phy_pages_alloc(vm, num, 1, min_gpa, memslot,
>  				    vm_arch_has_protected_memory(vm));
>  }
>  
> +static inline gpa_t vm_phy_pages_alloc_align(struct kvm_vm *vm, size_t num,
> +					     size_t align, gpa_t min_gpa,
> +					     u32 memslot)

Given that the PPC usage is all for naturally aligned allocations, I think it
makes sense for that to be the API, i.e. have "bool naturally_aligned" instead
of an arbitrary alignment.

> +{
> +	/*
> +	 * By default, allocate memory as protected for VMs that support
> +	 * protected memory, as the majority of memory for such VMs is
> +	 * protected, i.e. using shared memory is effectively opt-in.
> +	 */

Duplicating this big comment is very ugly.  In general, these APIs could use
some love.  E.g. taking in @memslot is essentially a historical wart that isn't
necessary except for literally just memslot_perf_test.c, which allocates memory
in a huge number of memslots.

If we rework the APIs to take the memory region type instead of the memslot, then
we can kill many birds with one stone.  It takes quite a bit of cleanup to throw
that one stone, but I think the end result can be quite nice.

Compile tested only at this point, but I now have a series of ~17 patches to yield:

  __weak bool kvm_arch_needs_naturally_aligned_page_tables(void)
  {
	return false;
  }

  gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t nr_pages,
			   enum kvm_mem_region_type type, bool protected)
  {
	struct userspace_mem_region *region = vm_get_mem_region(vm, type);
	bool naturally_aligned = false;
	gpa_t min_gpa;

	TEST_ASSERT(region, "No region for type '%u', memslot '%u'",
		    type, vm->memslots[type]);

	switch (type) {
	case MEM_REGION_CODE:
	case MEM_REGION_DATA:
	case MEM_REGION_TEST_DATA:
		/*
		 * If the region is backed by the default memslot (id=0), use
		 * selftests' hardcoded minimum PFN, otherwise use the base of
		 * the custom memory slot that backs the region.
		 */
		if (!vm->memslots[type])
			min_gpa = KVM_UTIL_MIN_PFN * vm->page_size;
		else
			min_gpa = region->region.guest_phys_addr;
		break;
	case MEM_REGION_PT:
		min_gpa = KVM_GUEST_PAGE_TABLE_MIN_PADDR;
		naturally_aligned = kvm_arch_needs_naturally_aligned_page_tables();
		break;
	case MEM_REGION_TEST_EXTRA:
		min_gpa = region->region.guest_phys_addr;
		break;
	default:
		TEST_FAIL("Invalid memory region type '%u'", type);
		break;
	}

	return ____vm_phy_pages_alloc(vm, nr_pages, min_gpa, vm->memslots[type],
				      protected, naturally_aligned);
  }

with convenience wrappers:

  static inline gpa_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t nr_pages,
				       enum kvm_mem_region_type type)
  {
	/*
	 * By default, allocate memory as protected for VMs that support
	 * protected memory, as the majority of memory for such VMs is
	 * protected, i.e. using shared memory is effectively opt-in.
	 */
	return __vm_phy_pages_alloc(vm, nr_pages, type,
				    vm_arch_has_protected_memory(vm));
  }

  static inline gpa_t vm_phy_page_alloc(struct kvm_vm *vm,
				      enum kvm_mem_region_type type)
  {
	return vm_phy_pages_alloc(vm, 1, type);
  }

  static inline gpa_t vm_alloc_page_table_pages(struct kvm_vm *vm, size_t nr_pages)
  {
	return vm_phy_page_alloc(vm, MEM_REGION_PT);
  }

  static inline gpa_t vm_alloc_page_table(struct kvm_vm *vm)
  {
	return vm_alloc_page_table_pages(vm, 1);
  }

That way we don't need to add yet another rarely used param to the APIs, and
PPC just needs to define kvm_arch_needs_naturally_aligned_page_tables().  The
bonus is that @min_gpa goes away too.

It'll probably take me a few days/weeks, but I'll try get a series posted before
the 7.2 merge window closes, so that you can build on top to get the PPC selftests
support landed in 7.3.

> @@ -2039,23 +2039,22 @@ gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
>  	TEST_ASSERT(!protected || region->protected_phy_pages,
>  		    "Region doesn't support protected memory");
>  
> -	base = pg = min_gpa >> vm->page_shift;
> -	do {
> -		for (; pg < base + num; ++pg) {
> -			if (!sparsebit_is_set(region->unused_phy_pages, pg)) {
> -				base = pg = sparsebit_next_set(region->unused_phy_pages, pg);
> -				break;
> +	base = min_gpa >> vm->page_shift;
> +again:
> +	base = (base + align - 1) & ~(align - 1);
> +	for (pg = base; pg < base + num; ++pg) {
> +		if (!sparsebit_is_set(region->unused_phy_pages, pg)) {
> +			base = sparsebit_next_set(region->unused_phy_pages, pg);
> +			if (!base) {
> +				fprintf(stderr, "No guest physical page available, "
> +					"min_gpa: 0x%lx page_size: 0x%x memslot: %u\n",
> +					min_gpa, vm->page_size, memslot);
> +				fputs("---- vm dump ----\n", stderr);
> +				vm_dump(stderr, vm, 2);
> +				abort();
>  			}
> +			goto again;
>  		}
> -	} while (pg && pg != base + num);
> -
> -	if (pg == 0) {
> -		fprintf(stderr, "No guest physical page available, "
> -			"min_gpa: 0x%lx page_size: 0x%x memslot: %u\n",
> -			min_gpa, vm->page_size, memslot);
> -		fputs("---- vm dump ----\n", stderr);
> -		vm_dump(stderr, vm, 2);
> -		abort();
>  	}

This is unnecessary churn.  I'm not saying the current code is pretty or anything,
but unless I'm missing something, this can simply be:

@@ -2025,7 +2027,7 @@ gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t nr_pages, gpa_t min_gpa,
        TEST_ASSERT(!protected || region->protected_phy_pages,
                    "Region doesn't support protected memory");
 
-       base = pg = min_gpa >> vm->page_shift;
+       base = pg = ALIGN(min_gpa >> vm->page_shift, alignment);
        do {
                for (; pg < base + nr_pages; ++pg) {
                        if (!sparsebit_is_set(region->unused_phy_pages, pg)) {

>  
>  	for (pg = base; pg < base + num; ++pg) {
> -- 
> 2.50.1 (Apple Git-155)
> 

