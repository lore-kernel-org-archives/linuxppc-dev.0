Return-Path: <linuxppc-dev+bounces-22559-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BEABCD98CE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2026 14:44:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gcMjS4tX2z2ykX;
	Sat, 13 Jun 2026 00:44:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781275468;
	cv=none; b=f39LKR0ddZ+UcQZtyu/wHHbt6pGzLy/n4LnKzzSM+n9iXPW9c8DTalQZe5+F5MohW49a29rUttXdhtECUtYQ7YH14eOu5WbrXhODPg8+rGQdXDliXaeWfJeBWfRLm5Iac53ICyTogA7BC/bsIRRzLblYKG+4UIl5sHD9WwXBrcrVwcCzHN9fEkL58VG3UhYq7VFSkglLagcUVW1mP7QZWe2od323w+YSrNl9mqGY/2YZTl9M15xphKoI9uUKhFoBefzwslcsgPxaJHHP1P8Df7nKDMIxJaGuBSqQo+rea8LscNNI6utAiyEtwBKc2PqzM4qv5d4NfXdexNzpiRraXg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781275468; c=relaxed/relaxed;
	bh=JTJ6LQiVaizRbhp8ioa0/mpPc2OvfEQezfKHZpIfGYU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=Uk1LlHK+s4P67KNnIgl9Yayeu4WxFX1dmfe1NXtonOOmcvXjN4W86hlnF5zuAZ6pJudLl3g3bXB+f0zRZf8Pf/JCY4WVpnPGqWcrGkRzR2jzSHk7blmatzB7qVTMicHCqN8OFWzbJkz1dyrcZ4pENqYsFQiGVUzBk6cYvVScxjY4JfW9dcE00dyHTp7Bt4Tcivt+7WXYju3hUfaChpaS3ITE3yCTk63diyM83e05F6OC6CtliATAwMfGwHdEcjKPamaYhBhdhtWj47aZJMHWJCnpv5P5IMdc7pFsUxQorvXe9fc0FhQi8FOgVDK4eYurYWsRhQONFclQUwBru0Ws8Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=La/cu6ON; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=La/cu6ON;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gcMjR5Sr1z2yjp
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Jun 2026 00:44:26 +1000 (AEST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-2c0c1e0b0faso6940095ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 07:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781275465; x=1781880265; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JTJ6LQiVaizRbhp8ioa0/mpPc2OvfEQezfKHZpIfGYU=;
        b=La/cu6ONS4Bzfe05E7CoCM1S40lp9SHRR6tXpltZYudC9qESYRgzEnOxtGim9qscZu
         Nqugza4PdHjFMER8dab2IuHCfQ2sp1DAq6s/UUlmuQ6VEAAc3FRIqsLixuwnv/0lj+1K
         /LaD965nxnCo7ZZTA0Wpjdj8T2KJklzWL5x5g/wWFgZckkkVrhx4M90iB8wnVZPVYXiO
         d5Cee++OTjpVe/5BpP3QW6AJhNG90qjxC7gM6R09CkH83FVue3yLDi9VMu1FtCLtWJLW
         qNfJf/sva90ZIvvT1fNSzfsNwm553jWIlHGdd/z1U/hJ1y6oYji+QKUsEjypzoqacPfi
         HDzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781275465; x=1781880265;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JTJ6LQiVaizRbhp8ioa0/mpPc2OvfEQezfKHZpIfGYU=;
        b=BZdqeA3qCwAmj+N4w/Ru8OZzhM+rnr5oAC5vAeNoE9Du69l+f4kF7hVv+JSbQLyxJk
         VQjTeN863UMIcnaafby2HPvG5ptJ6SWv2FlqNFkIulz5krQz6VpLo4WKtlV5Uu+YMdf7
         wMUJJ9kF6+27NjBvCW2XzIJ3JjCdsyJoUxL+RwDKKG/jRyYvNpJPxtfidzLkx7G+i+Mj
         IYLne/bbtBv1Zl6Jkm6muuQOSUihPXLoYcDoChUi1ecJgPQvE3AzEay/Is6Pie4DcbU8
         Fa/9ResmO5NzzHc224h4OX+cpykKKYqmXFh2NbUdX6L5kyHf/oPztCkf2JUWrhEnrOzR
         C9Ug==
X-Forwarded-Encrypted: i=1; AFNElJ8/kOFBy7/L3R7Jxwa55ydGHjpx6Pl4jsB7K5F+Q99nK6q2tuRDxqk0AN2ZDCGltxlIcKfAXm/70oFA08k=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyZh+tk9sYYZoCLChWlu6i5Fl7Nb4zq4RklxPNBjdm1u0/G48FD
	14Pp/CFsQ5HBZRpR303SWc+smSVyQvjDFwJ38sVMzwQRsA2zoUzWDhFi
X-Gm-Gg: Acq92OFjRe2eYV3Q04mIS9TRE8mjnEvjbl8wrgibuZn/LyOwjiPPzzGoJ+ZqgN2xNb+
	xVwFrqO9qnQguQAvPufRpqx/7JEFpiwZpLh4q+t9Z3vEFklUsLmeRF3bD7/rTPQhXX6URbsC3Bk
	kOInmMyOEZPsfbPUNGEkChQPnlQgb9JVW2gtS7EIrz86EHEpAKYuS/4LKWP+xKtprlepXj54A1T
	o5K8o5Of3Yw9NWNw3xHLoCRYnBt6P3lG00JI4g+0p6JcHL71Ji1XmYR1Wf5ESQbAdcir7lVBoys
	jhOPW1DPoqIYP3iJDk3PTOfzvWAaph87zs+JEaqs8dCwCsIMYnaeuNO7byvR/OscKM132eJI7jX
	nasopWkUsqW0gaMqChQ0mxFktxmrNNMkVAQR87+bYVnkIFfjtOvFAG/lZ2nx2kLFwfHwEqZQVsh
	F2v67ad5G8Y8k55OsTCx1/a6NyAg==
X-Received: by 2002:a17:903:2352:b0:2c2:27be:39a3 with SMTP id d9443c01a7336-2c41300f817mr36848625ad.29.1781275464660;
        Fri, 12 Jun 2026 07:44:24 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c432c8becesm23773525ad.56.2026.06.12.07.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 07:44:23 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <chleroy@kernel.org>, Anushree Mathur <anushree.mathur@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, Ackerley Tng <ackerleytng@google.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 RESEND 02/10] KVM: selftests: Add aligned guest physical page allocator
In-Reply-To: <air2QB-HUzxpCm_M@google.com>
Date: Fri, 12 Jun 2026 20:06:23 +0530
Message-ID: <h5n7esgo.ritesh.list@gmail.com>
References: <cover.1781093720.git.ritesh.list@gmail.com> <df86b5ccdbdafc3509d9538bd5e6796737bab2db.1781093720.git.ritesh.list@gmail.com> <aimOVomL2RzYt2J4@google.com> <ldcldopw.ritesh.list@gmail.com> <air2QB-HUzxpCm_M@google.com>
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

> On Thu, Jun 11, 2026, Ritesh Harjani wrote:
>> Sean Christopherson <seanjc@google.com> writes:
>> 
>> > On Wed, Jun 10, 2026, Ritesh Harjani (IBM) wrote:
>> >> From: Nicholas Piggin <npiggin@gmail.com>
>> >> 
>> >> powerpc will require this to allocate MMU tables in guest memory that
>> >> are larger than guest base page size.
>> >> 
>> >> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> >> [Rebased to latest mainline tree]
>> >> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> >> ---
>> >>  .../testing/selftests/kvm/include/kvm_util.h  | 20 +++++++++--
>> >>  tools/testing/selftests/kvm/lib/kvm_util.c    | 33 +++++++++----------
>> >>  2 files changed, 33 insertions(+), 20 deletions(-)
>> >> 
>> >> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
>> >> index 3666a8530f31..c515c918c2c9 100644
>> >> --- a/tools/testing/selftests/kvm/include/kvm_util.h
>> >> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
>> >> @@ -991,8 +991,8 @@ void kvm_gsi_routing_write(struct kvm_vm *vm, struct kvm_irq_routing *routing);
>> >>  const char *exit_reason_str(unsigned int exit_reason);
>> >>  
>> >>  gpa_t vm_phy_page_alloc(struct kvm_vm *vm, gpa_t min_gpa, u32 memslot);
>> >> -gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t num, gpa_t min_gpa,
>> >> -			   u32 memslot, bool protected);
>> >> +gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t num, size_t align,
>> >> +			   gpa_t min_gpa, u32 memslot, bool protected);
>> >>  gpa_t vm_alloc_page_table(struct kvm_vm *vm);
>> >>  
>> >>  static inline gpa_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
>> >> @@ -1003,10 +1003,24 @@ static inline gpa_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
>> >>  	 * protected memory, as the majority of memory for such VMs is
>> >>  	 * protected, i.e. using shared memory is effectively opt-in.
>> >>  	 */
>> >> -	return __vm_phy_pages_alloc(vm, num, min_gpa, memslot,
>> >> +	return __vm_phy_pages_alloc(vm, num, 1, min_gpa, memslot,
>> >>  				    vm_arch_has_protected_memory(vm));
>> >>  }
>> >>  
>> >> +static inline gpa_t vm_phy_pages_alloc_align(struct kvm_vm *vm, size_t num,
>> >> +					     size_t align, gpa_t min_gpa,
>> >> +					     u32 memslot)
>> >
>> > Given that the PPC usage is all for naturally aligned allocations, I think it
>> > makes sense for that to be the API, i.e. have "bool naturally_aligned" instead
>> > of an arbitrary alignment.
>> >
>> 
>> I would still prefer passing an explicit align value to the allocator,
>> because IMHO that's a useful allocator interface to have.
>
> Why?  What are the use cases?  I can't think of anything that requires multi-page
> allocations to have specific alignment, all of the cases I can think of require
> natural alignment.
>

I agree, that's what I mentioned too, so far all cases we care about,
they require natual alignment. So it should be fine.

> For sub-page allocations, supporting semi-arbitrary alignments makes sense, but
> I'm not convinced we should try and support that for page-granularity allocations.
>
>> However, if we do want to go down this road than I don't have any strong
>> objection either, since as you mentioned powerpc mostly just needs
>> natual alignment for it's page table region. So alignment can be
>> extracted from the region type as you described below, so no need to
>> pass it all the time.
>
> ..
>
>> > The bonus is that @min_gpa goes away too.
>> 
>> powerpc needs min_gpa for it's exception handling pages. see.
>> 
>> 	excp_paddr = vm_phy_pages_alloc(vm, excp_pages, 0,
>> 					vm->memslots[MEM_REGION_DATA]);
>> 
>> 	TEST_ASSERT(excp_paddr == 0,
>> 		    "Interrupt vectors not allocated at gPA address 0: (0x%lx)",
>> 		    excp_paddr);
>> 
>> So, will arch still have an access to the API for passing min_gpa = 0
>> for cases like above?
>
> Yep, ____vm_phy_pages_alloc() will be globally visible, and I think is quite
> appropriate in this case since it's more than just specifying a minimum GPA,
> it's really specifying an _exact_ GPA for the allocation.
>
> gpa_t ____vm_phy_pages_alloc(struct kvm_vm *vm, size_t nr_pages, gpa_t min_gpa,
> 			     u32 memslot, bool protected, bool naturally_aligned)
>

Right, Thanks!

>> > It'll probably take me a few days/weeks, but I'll try get a series posted before
>> > the 7.2 merge window closes, so that you can build on top to get the PPC selftests
>> > support landed in 7.3.
>> >
>> 
>> Thanks Sean for your help! Yes, landing kvm selftests for powerpc will
>> be definitely helpful to verify against any kvm regressions.
>> 
>> BTW, I was thinking whether landing powerpc first will be easier for you
>> to consider all the API requirements from all users / usecases?  But
>> either way is fine please. I can work on top of your changes too and if
>> something is missing for powerpc, we can add / modify on top, once your
>> series is finished.
>
> One idea would be for me to include the PPC support in the series; it's "just"
> a patch or two on top, albeit one pretty big patch.
>


That should be ok Sean. I can rebase my changes on top of yours once
your series is ready then. I will be on travel next week (OSS Mumbai)
and I don't want to stop your patch series due to my late replies for
any of the powerpc part.

So once your series is ready - I can rebase this series on top of it and
it can go as we discussed it earlier - so that we can try and land these
for 7.3, if possible.

Thanks again for your help :)

>> >> @@ -2039,23 +2039,22 @@ gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
>> >>  	TEST_ASSERT(!protected || region->protected_phy_pages,
>> >>  		    "Region doesn't support protected memory");
>> >>  
>> >> -	base = pg = min_gpa >> vm->page_shift;
>> >> -	do {
>> >> -		for (; pg < base + num; ++pg) {
>> >> -			if (!sparsebit_is_set(region->unused_phy_pages, pg)) {
>> >> -				base = pg = sparsebit_next_set(region->unused_phy_pages, pg);
>> >> -				break;
>> >> +	base = min_gpa >> vm->page_shift;
>> >> +again:
>> >> +	base = (base + align - 1) & ~(align - 1);
>> >> +	for (pg = base; pg < base + num; ++pg) {
>> >> +		if (!sparsebit_is_set(region->unused_phy_pages, pg)) {
>> >> +			base = sparsebit_next_set(region->unused_phy_pages, pg);
>> >> +			if (!base) {
>> >> +				fprintf(stderr, "No guest physical page available, "
>> >> +					"min_gpa: 0x%lx page_size: 0x%x memslot: %u\n",
>> >> +					min_gpa, vm->page_size, memslot);
>> >> +				fputs("---- vm dump ----\n", stderr);
>> >> +				vm_dump(stderr, vm, 2);
>> >> +				abort();
>> >>  			}
>> >> +			goto again;
>> >>  		}
>> >> -	} while (pg && pg != base + num);
>> >> -
>> >> -	if (pg == 0) {
>> >> -		fprintf(stderr, "No guest physical page available, "
>> >> -			"min_gpa: 0x%lx page_size: 0x%x memslot: %u\n",
>> >> -			min_gpa, vm->page_size, memslot);
>> >> -		fputs("---- vm dump ----\n", stderr);
>> >> -		vm_dump(stderr, vm, 2);
>> >> -		abort();
>> >>  	}
>> >
>> > This is unnecessary churn.  I'm not saying the current code is pretty or anything,
>> > but unless I'm missing something, this can simply be:
>> 
>> Not really, we need the base to be aligned everytime, that's why the
>> goto again loop aligns the base in the new code.
>
> Ooh, right, pg needs to be advanced by the aligned number of pages.  Ugh, the
> whole do-while part is bizarre, and AFAICT only "works" by dumb luck. 
>
>> Plus I feel the above refactoring also simplifies the special handling of pg
>> == 0 case, which earlier was being handled separately after the loop ends.
>
> Yeah, I fiddled with a few other options, but I think I like your approach the
> most.

Sure then, Thanks!


-ritesh


