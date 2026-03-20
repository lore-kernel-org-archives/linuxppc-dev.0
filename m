Return-Path: <linuxppc-dev+bounces-18494-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93CEA1098799
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Mar 2026 15:06:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fcm9j4dSpz2yYy;
	Sat, 21 Mar 2026 02:06:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774019193;
	cv=none; b=PR4V+z4okNC/Jv1CQbM5CQKYBChL2JVNC543s3PGXdxuXxQ1UAJ7FTKB76RnyKQgCxAQyVlByK94kVGGM34XB6gxucYmvyxFjQayi1qd0yIoRasFKAPZ5GoDWgcMhZXIyWty1caPHXKEs92W6VJVmLCuCPX/YcpYonkplOs/OezZxqp74XoULRrjD7z2JWiBVT6caeZRPSqCmNP40WHA8UcxnTYuy90VAIztCItxeIHjyJjSkG5vhzjCMOaOK6nuUwIgy9QfrQnxRTwAU95twe8YoabjKBKqw6tWUH6rQtQuEhd9KdbnhTIMvndUtCUdp39OlaVeecyxUkx7byPu8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774019193; c=relaxed/relaxed;
	bh=Elxiw+fM0cLxx9UyvCmQFeSyh6yWLYKeCjqleADrGWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VysHYmCvvkPg+LeQXRPFByO6vbM20UlhdtexpKf2uH6rp63lhlJTsdLKPWEyYjJOfgFEtxTHyp6xl+2HMGuxW39Z2XOcKC/DY+Lt4A9qgC4c2ZkcD7uyZfKhb2z0Yp+rquDHlfYBl9OdBsG5nZqKveiSKb3I0NTiSiGXgLaLfkFZ5fXDDY9ueFzaD8QGC0ZUPYIpEv9zHUc3u6Rd2rYJgUmzrEfxP/3RungjRsbtfBDJ3Z8BHJSjchjJN7wcbMDbTZBMEo7+HaF7ZdhZaoCtkv1PrOsQ0LOm0VZKsfCJOS7NhzL53WkYmLzqLpiJ+BwOmvpMTIS+vHjC7vU8/7rMfQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=c11vSApR; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=vbabka@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=c11vSApR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=vbabka@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fcm9h2RV8z2yY9
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Mar 2026 02:06:32 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 7D49042DAB;
	Fri, 20 Mar 2026 15:06:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BB13C2BCB0;
	Fri, 20 Mar 2026 15:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774019189;
	bh=4U/RLB5BQTlqqUA+aRxQ/uoxRsEa6t8UeWu6iGAM7vU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=c11vSApRocA25rRA6R1Rg5PoZbJKYkvTzPDMmIS8hDyX2AXYHd8mYvTvGHczpbW0e
	 ZICqmAxAG7qjbn/OIwttlwgweqfJ3T6xWbF6Jn4Ykx0PlThw+3A3UFYPQkowwyM+MR
	 xph2xDZ24qQOpQjw0PB/HBpsqSQshv8HCPxdObcRx0m/O9B6JgKfWn2YSzucm3bNUO
	 LGc+GK60aJmwylKmXisUdB28GjM0TrMGRhwdo3hoTW7hoBzOgalk4j+n72KHrlUXBf
	 swr5E6qUe0gXbEloU8Cxg7ZJR5ROhpNrWzLfTbBhCZSP8AXpxr+lme2+aRUwijSnnb
	 jet5knkPIKlag==
Message-ID: <7e2aea13-e047-4891-bd6f-ff6705c4fc28@kernel.org>
Date: Fri, 20 Mar 2026 16:06:15 +0100
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/23] mm: convert do_brk_flags() to use vma_flags_t
Content-Language: en-US
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Kees Cook <kees@kernel.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Brian Cain <bcain@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Dinh Nguyen <dinguyen@kernel.org>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H . Peter Anvin" <hpa@zytor.com>, Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>,
 Michal Hocko <mhocko@suse.com>, Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Ondrej Mosnacek <omosnace@redhat.com>, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-um@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org
References: <cover.1773846935.git.ljs@kernel.org>
 <981ed1afcd19115432e61778e7d226a36f8f5c2b.1773846935.git.ljs@kernel.org>
 <1d300b3b-2476-4381-b8df-a680f486b284@kernel.org>
 <f47e24c4-3a11-4a58-96f5-871443660246@lucifer.local>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <f47e24c4-3a11-4a58-96f5-871443660246@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/20/26 14:42, Lorenzo Stoakes (Oracle) wrote:
>>
>> More nits below:
>>
>> > diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
>> > index b39cc1127e1f..e25d0d18f6d7 100644
>> > --- a/arch/arm64/include/asm/page.h
>> > +++ b/arch/arm64/include/asm/page.h
>> > @@ -46,7 +46,12 @@ int pfn_is_map_memory(unsigned long pfn);
>> >
>> >  #endif /* !__ASSEMBLER__ */
>> >
>> > -#define VM_DATA_DEFAULT_FLAGS	(VM_DATA_FLAGS_TSK_EXEC | VM_MTE_ALLOWED)
>> > +#ifdef CONFIG_ARM64_MTE
>> > +#define VMA_DATA_DEFAULT_FLAGS	append_vma_flags(VMA_DATA_FLAGS_TSK_EXEC, \
>> > +						 VMA_MTE_ALLOWED_BIT)
>>
>> I wonder what's the bloat-o-meter impact of these #define's (this
>> arm64-specific one isn't the only one) being no longer compile-time-constants?
> 
> I mean there's a precedent for this, but the compiler _should_ figure out this
> as a constant value, I have repeatedly confirmed that it's good at that in
> godbolt, via make foo/bar.S etc.

Great, thanks!

> 
>>
>> >   */
>> >  #define vma_desc_set_flags(desc, ...) \
>> >  	vma_desc_set_flags_mask(desc, mk_vma_flags(__VA_ARGS__))
>> > @@ -4059,7 +4071,6 @@ extern int replace_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file);
>> >  extern struct file *get_mm_exe_file(struct mm_struct *mm);
>> >  extern struct file *get_task_exe_file(struct task_struct *task);
>> >
>> > -extern bool may_expand_vm(struct mm_struct *, vm_flags_t, unsigned long npages);
>> >  extern void vm_stat_account(struct mm_struct *, vm_flags_t, long npages);
>> >
>> >  extern bool vma_is_special_mapping(const struct vm_area_struct *vma,
>> > diff --git a/mm/internal.h b/mm/internal.h
>> > index f98f4746ac41..80d8651441a7 100644
>>
>> > diff --git a/mm/mprotect.c b/mm/mprotect.c
>> > index 9681f055b9fc..eaa724b99908 100644
>> > --- a/mm/mprotect.c
>> > +++ b/mm/mprotect.c
>>
>> > @@ -773,19 +778,24 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
>> >
>> >  	change_protection(tlb, vma, start, end, mm_cp_flags);
>> >
>> > -	if ((oldflags & VM_ACCOUNT) && !(newflags & VM_ACCOUNT))
>> > +	if (vma_flags_test(&old_vma_flags, VMA_ACCOUNT_BIT) &&
>> > +	    !vma_flags_test(&new_vma_flags, VMA_ACCOUNT_BIT))
>> >  		vm_unacct_memory(nrpages);
>> >
>> >  	/*
>> >  	 * Private VM_LOCKED VMA becoming writable: trigger COW to avoid major
>> >  	 * fault on access.
>> >  	 */
>> > -	if ((oldflags & (VM_WRITE | VM_SHARED | VM_LOCKED)) == VM_LOCKED &&
>> > -			(newflags & VM_WRITE)) {
>> > -		populate_vma_page_range(vma, start, end, NULL);
>> > +	if (vma_flags_test(&new_vma_flags, VMA_WRITE_BIT)) {
>> > +		const vma_flags_t mask =
>> > +			vma_flags_and(&old_vma_flags, VMA_WRITE_BIT,
>> > +				      VMA_SHARED_BIT, VMA_LOCKED_BIT);
>> > +
>> > +		if (vma_flags_same(&mask, VMA_LOCKED_BIT))
>>
>> That converts the original logic 1:1, but I wonder if it's now feasible to
>> write it more obviously as "VMA_LOCKED_BIT must be set, VM_WRITE_BIT and
>> VM_SHARED_BIT must not" ?
> 
> Hmm, I'm not sure if I can express this more clearly, it's a pain either
> way. Could do:
> 
> 	if (vma_flags_test(&new_vma_flags, VMA_WRITE_BIT) &&
> 	    !vma_flags_test_any(&old_vma_flags, VMA_WRITE_BIT, VMA_SHARED_BIT))
> 		populate_vma_page_range(vma, start, end, NULL);

It would be a bit more:

	if (vma_flags_test(&new_vma_flags, VMA_WRITE_BIT) &&
	    vma_flags_test(&old_vma_flags, VMA_LOCKED_BIT) &&
 	    !vma_flags_test_any(&old_vma_flags, VMA_WRITE_BIT, VMA_SHARED_BIT))
 		populate_vma_page_range(vma, start, end, NULL);

(or reordered in whatever way the short circuting works best here, the original
code tested oldflags first).

But yeah, at least to me it's more clear what that's testing and doesn't need to
set up the intermediate mask variable, and VMA_LOCKED_BIT is there only once
in the code now. The number of vma_flags_* operations is the same.
 
>>
>> > +			populate_vma_page_range(vma, start, end, NULL);
>> >  	}
>> >
>> > -	vm_stat_account(mm, oldflags, -nrpages);
>> > +	vm_stat_account(mm, vma_flags_to_legacy(old_vma_flags), -nrpages);
>> >  	vm_stat_account(mm, newflags, nrpages);
>> >  	perf_event_mmap(vma);
>> >  	return 0;
>>
>> > diff --git a/mm/vma.h b/mm/vma.h
>> > index cf8926558bf6..1f2de6cb3b97 100644
>> > --- a/mm/vma.h
>> > +++ b/mm/vma.h
>>
>> > +static inline bool is_data_mapping_vma_flags(const vma_flags_t *vma_flags)
>> > +{
>> > +	const vma_flags_t mask = vma_flags_and(vma_flags,
>> > +			VMA_WRITE_BIT, VMA_SHARED_BIT, VMA_STACK_BIT);
>> > +
>> > +	return vma_flags_same(&mask, VMA_WRITE_BIT);
>>
>> Ditto?
> 
> I may do both as a follow up patch given the series is a pain to rework at this point
> and I want at least the first version to be like-for-like intentionally.

OK sure.

>>
>> > +}
>> >
>> >  static inline void vma_iter_config(struct vma_iterator *vmi,
>> >  		unsigned long index, unsigned long last)
>> > diff --git a/mm/vma_exec.c b/mm/vma_exec.c
>> > index 8134e1afca68..5cee8b7efa0f 100644
> 
> Thanks, Lorenzo


