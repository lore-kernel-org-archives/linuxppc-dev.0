Return-Path: <linuxppc-dev+bounces-22514-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B02B3CD98C7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 17:12:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbq2Q1nlwz3bqh;
	Fri, 12 Jun 2026 03:12:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781197934;
	cv=none; b=Kie9tWt2BIfMQVJU+7gIgTVcskcPJ83nmrnPCGR/noUslK2+QeYYZScyNFcwHWkMXtTEn4Ru82mQIg7S6K+S/gfoS956FAcv+qSjP2ctdQ9Dh5aoY1TSTHqzPAyebVvGbM5+DfMDeM4QAjVqZRBcSXfOQpTb7WHH+ikMvHlv82xs5qoZ9hmMoZpFXiZIaMYITKQRfSVT4eQRgohC63hrDgCHQS/Ozma1nChAbB+jxqbFRDxNF1otk0HOEALU3kpV2cNbCTo4ocn9r/XKyQLvbCJ34LRvjo+6cWFhVo30P5sNtraEWo3XZWAcAPGHzS075UZth5TxWK/PowEJ5B5Ecw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781197934; c=relaxed/relaxed;
	bh=QUhb0LXL29TRj1XmX4fg/eZOCymWXris1Gg/NE+c6fU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=QCvQHyb8yjjv9xGDZWb7xYhnK2CkT8mIsYSWFVpkD+40g5YiaTH9FaletGWnYuB/cv8rRjhyHfFC2EYot2aHumMvtA+iMwut3EqtYYPL2HS41j7BPiqJbM4wADlZQplysGr3EgcU1xVM+qyo9X9ALDjD9Zy61SOE7EMLip2Py4PPinn9JeJSbLUjp8o+sii7NgpBZvNGBE8UVCZ+cxdL26PQGYBFF/pha+qrmoE8qz7+IODXB0TxH6ZaFvludoSXIpXsjwbduHPxr8gFdSye/eCFHAlKRkxzzVKI2XU3Y3L3LVH05yIF/iHfu1Cm2MqjH2xAZd0znZACcWEyQtXRUg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DgT2Xvpu; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DgT2Xvpu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbq2N5pVRz3bpP
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 03:12:11 +1000 (AEST)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-36bb3551f6eso171528a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 10:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781197929; x=1781802729; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QUhb0LXL29TRj1XmX4fg/eZOCymWXris1Gg/NE+c6fU=;
        b=DgT2XvpuJGs7+ii63XXOPSEtruyaMM8T2Y3TaqWJyXRBDjZLeIpnfqs3YZQ2gFKHC+
         k5kujvu017vuev+7hlOLVu8x1kKPN6F2KJBKtL21B7+XKWWYeUsZtud/acAGZqYXqxWu
         VUfI/YHr4ZDeCMGZPCAoWR4A807183q5bKfrLN/LP0HvLm0tpzArLU7gGNIRdil+qK+e
         khmdc26tMxbraZZKYvA3LtQnfQGW21PqIuR8kBBirbR4JvvQHHySPXkbPKoGFTuMNxNd
         rwSQK0vVeA//ewLmYfyi665+uUfwxRMISiyTfJEnDRGc+bfx4ZlklZi28di1NPXIibKM
         r5mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781197929; x=1781802729;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QUhb0LXL29TRj1XmX4fg/eZOCymWXris1Gg/NE+c6fU=;
        b=HfkiW/PYchtmw6i+d+59wlK8lF8Zyaqmgi0yRdKtwqa11KIumZ6U5c/OxrUO6dPfU3
         YvX45VwkfYDepFS1vloXHLkFa3V8v2ebNiX/htjQMYJyA6zSNIZ6A3sepKxDNX/j3dyt
         rrTZQpE99GrqrjkVpfFyLZxj8W9yihex3oL1PE5pzvmQn5YreMkrZ/Qah7DHZ5tuqtZk
         X6vEfmNi1WKhnSIcAJi7qZ0BNUik/8Hg299/zSKgYSdxHiOa01gGixrdiN/8iNyAYz+L
         /pgY6LcCBIMB4w+BRIJJMIT3LUGOk6Das6AyVBrLq2qjOMx+3LDV4JM+AZMU7DPIk+tU
         B3Lg==
X-Forwarded-Encrypted: i=1; AFNElJ8+GyoK4u6aagZoOU3kIRL859oLLPWTfPqiyGeVoAdpa93vPtmQBIkLZQGE6vFQwmkm+W21Vqhy7qwr/dI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzqGW0GpDVHn7eV+Abf37Qu73fusjl6Pax7LyL6F8inP6oUqOOm
	JZBvcgSOpjfsOpZTpr3bSk2io1juoBwOLeVbM2sAaXenMmNIc6cOimq8
X-Gm-Gg: Acq92OFN/+K5CUdUnl3HQJY5BwEY7aAXKMJjIW609sgmoxr6H9DLIgkpwoKk3pToxll
	g9RrUowmN4Ra4M9Wc+gL2PXxiEK6Nwh6nIMMHllZbPm4wOIHe8LzmZDcrG4FZ8yVPMhhQUOJhkB
	DQuGItFj6OtcpcS5t1Ewmd+zm9TH+WaNr3vxuOTWCA0sKCTx0xuYbJYxK+9xmqMRZ3IKNvjfCpK
	yupsYdEricD838iSMBIiAqsfUfspCdeus45VpFmwsp43qdUDrxLcOhqnSqHfdy9IGN9mlDQc6jt
	j8JMivUAZYF9fnYRg3tOux4E6j7m/wyTVIs8UyPIr3hTiHurKtDPnHXSn/srtQpdky8eQBqUnKw
	L2082IFywkvNpMYudd6FTb0zQ1JxYjrNqFWzfiyUI3EpQpFkKBnZdup7IRwkb91p3iFi4fB56ak
	oXGbg2q5JFdzWfxUyOnBIQJhTwJYQAEWwRvmVc
X-Received: by 2002:a17:90a:e185:b0:36a:f612:e6a3 with SMTP id 98e67ed59e1d1-377a8bd3113mr4246286a91.17.1781197928626;
        Thu, 11 Jun 2026 10:12:08 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3775549af60sm3035656a91.12.2026.06.11.10.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 10:12:07 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <chleroy@kernel.org>, Anushree Mathur <anushree.mathur@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, Ackerley Tng <ackerleytng@google.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 RESEND 02/10] KVM: selftests: Add aligned guest physical page allocator
In-Reply-To: <aimOVomL2RzYt2J4@google.com>
Date: Thu, 11 Jun 2026 22:00:19 +0530
Message-ID: <ldcldopw.ritesh.list@gmail.com>
References: <cover.1781093720.git.ritesh.list@gmail.com> <df86b5ccdbdafc3509d9538bd5e6796737bab2db.1781093720.git.ritesh.list@gmail.com> <aimOVomL2RzYt2J4@google.com>
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

Sean Christopherson <seanjc@google.com> writes:

> On Wed, Jun 10, 2026, Ritesh Harjani (IBM) wrote:
>> From: Nicholas Piggin <npiggin@gmail.com>
>> 
>> powerpc will require this to allocate MMU tables in guest memory that
>> are larger than guest base page size.
>> 
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> [Rebased to latest mainline tree]
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> ---
>>  .../testing/selftests/kvm/include/kvm_util.h  | 20 +++++++++--
>>  tools/testing/selftests/kvm/lib/kvm_util.c    | 33 +++++++++----------
>>  2 files changed, 33 insertions(+), 20 deletions(-)
>> 
>> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
>> index 3666a8530f31..c515c918c2c9 100644
>> --- a/tools/testing/selftests/kvm/include/kvm_util.h
>> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
>> @@ -991,8 +991,8 @@ void kvm_gsi_routing_write(struct kvm_vm *vm, struct kvm_irq_routing *routing);
>>  const char *exit_reason_str(unsigned int exit_reason);
>>  
>>  gpa_t vm_phy_page_alloc(struct kvm_vm *vm, gpa_t min_gpa, u32 memslot);
>> -gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t num, gpa_t min_gpa,
>> -			   u32 memslot, bool protected);
>> +gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t num, size_t align,
>> +			   gpa_t min_gpa, u32 memslot, bool protected);
>>  gpa_t vm_alloc_page_table(struct kvm_vm *vm);
>>  
>>  static inline gpa_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
>> @@ -1003,10 +1003,24 @@ static inline gpa_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
>>  	 * protected memory, as the majority of memory for such VMs is
>>  	 * protected, i.e. using shared memory is effectively opt-in.
>>  	 */
>> -	return __vm_phy_pages_alloc(vm, num, min_gpa, memslot,
>> +	return __vm_phy_pages_alloc(vm, num, 1, min_gpa, memslot,
>>  				    vm_arch_has_protected_memory(vm));
>>  }
>>  
>> +static inline gpa_t vm_phy_pages_alloc_align(struct kvm_vm *vm, size_t num,
>> +					     size_t align, gpa_t min_gpa,
>> +					     u32 memslot)
>
> Given that the PPC usage is all for naturally aligned allocations, I think it
> makes sense for that to be the API, i.e. have "bool naturally_aligned" instead
> of an arbitrary alignment.
>

I would still prefer passing an explicit align value to the allocator,
because IMHO that's a useful allocator interface to have.

However, if we do want to go down this road than I don't have any strong
objection either, since as you mentioned powerpc mostly just needs
natual alignment for it's page table region. So alignment can be
extracted from the region type as you described below, so no need to
pass it all the time.

>> +{
>> +	/*
>> +	 * By default, allocate memory as protected for VMs that support
>> +	 * protected memory, as the majority of memory for such VMs is
>> +	 * protected, i.e. using shared memory is effectively opt-in.
>> +	 */
>
> Duplicating this big comment is very ugly.

yes, my bad. I should have removed one copy of the comment.

> In general, these APIs could use
> some love.  E.g. taking in @memslot is essentially a historical wart that isn't
> necessary except for literally just memslot_perf_test.c, which allocates memory
> in a huge number of memslots.
>
> If we rework the APIs to take the memory region type instead of the memslot, then
> we can kill many birds with one stone.  It takes quite a bit of cleanup to throw
> that one stone, but I think the end result can be quite nice.
>
> Compile tested only at this point, but I now have a series of ~17 patches to yield:
>
>   __weak bool kvm_arch_needs_naturally_aligned_page_tables(void)
>   {
> 	return false;
>   }
>
>   gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t nr_pages,
> 			   enum kvm_mem_region_type type, bool protected)
>   {
> 	struct userspace_mem_region *region = vm_get_mem_region(vm, type);
> 	bool naturally_aligned = false;
> 	gpa_t min_gpa;
>
> 	TEST_ASSERT(region, "No region for type '%u', memslot '%u'",
> 		    type, vm->memslots[type]);
>
> 	switch (type) {
> 	case MEM_REGION_CODE:
> 	case MEM_REGION_DATA:
> 	case MEM_REGION_TEST_DATA:
> 		/*
> 		 * If the region is backed by the default memslot (id=0), use
> 		 * selftests' hardcoded minimum PFN, otherwise use the base of
> 		 * the custom memory slot that backs the region.
> 		 */
> 		if (!vm->memslots[type])
> 			min_gpa = KVM_UTIL_MIN_PFN * vm->page_size;
> 		else
> 			min_gpa = region->region.guest_phys_addr;
> 		break;
> 	case MEM_REGION_PT:
> 		min_gpa = KVM_GUEST_PAGE_TABLE_MIN_PADDR;
> 		naturally_aligned = kvm_arch_needs_naturally_aligned_page_tables();
> 		break;
> 	case MEM_REGION_TEST_EXTRA:
> 		min_gpa = region->region.guest_phys_addr;
> 		break;
> 	default:
> 		TEST_FAIL("Invalid memory region type '%u'", type);
> 		break;
> 	}
>
> 	return ____vm_phy_pages_alloc(vm, nr_pages, min_gpa, vm->memslots[type],
> 				      protected, naturally_aligned);
>   }
>
> with convenience wrappers:
>
>   static inline gpa_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t nr_pages,
> 				       enum kvm_mem_region_type type)
>   {
> 	/*
> 	 * By default, allocate memory as protected for VMs that support
> 	 * protected memory, as the majority of memory for such VMs is
> 	 * protected, i.e. using shared memory is effectively opt-in.
> 	 */
> 	return __vm_phy_pages_alloc(vm, nr_pages, type,
> 				    vm_arch_has_protected_memory(vm));
>   }
>
>   static inline gpa_t vm_phy_page_alloc(struct kvm_vm *vm,
> 				      enum kvm_mem_region_type type)
>   {
> 	return vm_phy_pages_alloc(vm, 1, type);
>   }
>
>   static inline gpa_t vm_alloc_page_table_pages(struct kvm_vm *vm, size_t nr_pages)
>   {
> 	return vm_phy_page_alloc(vm, MEM_REGION_PT);
>   }
>
>   static inline gpa_t vm_alloc_page_table(struct kvm_vm *vm)
>   {
> 	return vm_alloc_page_table_pages(vm, 1);
>   }
>
> That way we don't need to add yet another rarely used param to the APIs, and
> PPC just needs to define
> kvm_arch_needs_naturally_aligned_page_tables().

yup, looks good.

> The bonus is that @min_gpa goes away too.

powerpc needs min_gpa for it's exception handling pages. see.

	excp_paddr = vm_phy_pages_alloc(vm, excp_pages, 0,
					vm->memslots[MEM_REGION_DATA]);

	TEST_ASSERT(excp_paddr == 0,
		    "Interrupt vectors not allocated at gPA address 0: (0x%lx)",
		    excp_paddr);

So, will arch still have an access to the API for passing min_gpa = 0
for cases like above?

>
> It'll probably take me a few days/weeks, but I'll try get a series posted before
> the 7.2 merge window closes, so that you can build on top to get the PPC selftests
> support landed in 7.3.
>

Thanks Sean for your help! Yes, landing kvm selftests for powerpc will
be definitely helpful to verify against any kvm regressions.

BTW, I was thinking whether landing powerpc first will be easier for you
to consider all the API requirements from all users / usecases?  But
either way is fine please. I can work on top of your changes too and if
something is missing for powerpc, we can add / modify on top, once your
series is finished.


>> @@ -2039,23 +2039,22 @@ gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
>>  	TEST_ASSERT(!protected || region->protected_phy_pages,
>>  		    "Region doesn't support protected memory");
>>  
>> -	base = pg = min_gpa >> vm->page_shift;
>> -	do {
>> -		for (; pg < base + num; ++pg) {
>> -			if (!sparsebit_is_set(region->unused_phy_pages, pg)) {
>> -				base = pg = sparsebit_next_set(region->unused_phy_pages, pg);
>> -				break;
>> +	base = min_gpa >> vm->page_shift;
>> +again:
>> +	base = (base + align - 1) & ~(align - 1);
>> +	for (pg = base; pg < base + num; ++pg) {
>> +		if (!sparsebit_is_set(region->unused_phy_pages, pg)) {
>> +			base = sparsebit_next_set(region->unused_phy_pages, pg);
>> +			if (!base) {
>> +				fprintf(stderr, "No guest physical page available, "
>> +					"min_gpa: 0x%lx page_size: 0x%x memslot: %u\n",
>> +					min_gpa, vm->page_size, memslot);
>> +				fputs("---- vm dump ----\n", stderr);
>> +				vm_dump(stderr, vm, 2);
>> +				abort();
>>  			}
>> +			goto again;
>>  		}
>> -	} while (pg && pg != base + num);
>> -
>> -	if (pg == 0) {
>> -		fprintf(stderr, "No guest physical page available, "
>> -			"min_gpa: 0x%lx page_size: 0x%x memslot: %u\n",
>> -			min_gpa, vm->page_size, memslot);
>> -		fputs("---- vm dump ----\n", stderr);
>> -		vm_dump(stderr, vm, 2);
>> -		abort();
>>  	}
>
> This is unnecessary churn.  I'm not saying the current code is pretty or anything,
> but unless I'm missing something, this can simply be:
>

Not really, we need the base to be aligned everytime, that's why the
goto again loop aligns the base in the new code. Plus I feel the above
refactoring also simplifies the special handling of pg == 0 case, which
earlier was being handled separately after the loop ends.

> @@ -2025,7 +2027,7 @@ gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t nr_pages, gpa_t min_gpa,
>         TEST_ASSERT(!protected || region->protected_phy_pages,
>                     "Region doesn't support protected memory");
>  
> -       base = pg = min_gpa >> vm->page_shift;
> +       base = pg = ALIGN(min_gpa >> vm->page_shift, alignment);
>         do {
>                 for (; pg < base + nr_pages; ++pg) {
>                         if (!sparsebit_is_set(region->unused_phy_pages, pg)) {
>
>>  
>>  	for (pg = base; pg < base + num; ++pg) {
>> -- 
>> 2.50.1 (Apple Git-155)
>> 

Thanks once again for your help with this!

-ritesh

