Return-Path: <linuxppc-dev+bounces-17689-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA1DEB7EB3
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Mar 2026 09:00:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fQmpM0lXYz30hq;
	Wed, 04 Mar 2026 20:00:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772614811;
	cv=none; b=SD9B7ktXmLTd0KWH07fp62pZifWoruEPS7jetPq0Q6878pFYq0d60qgOqnYZowjhMDI5iA2eCVQJcVHo6drbeN7AQ25uXds8GH7DKUe6v9rT12SSs/qHbBB2eHGlIllD2f6veBycdfTW5M+kwWSqhw9vwmaGgJbwV5wJOE6OZ4bToIbFfAl0sxyqNvdpnH1bJ/U/pg7qDwiAwWXHzC07aH+TwmYERj7sQW/N2n60/VxBtue5t/Mi1Go/jb8oT+ZTrSUx5qVi1lElBY34cHf4b624uuSyUrgfvoKhLjTk3mi9On6DcfplP5+8bgIva0YNNQLU5NgMmMr9QMVfGQcFEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772614811; c=relaxed/relaxed;
	bh=8k5Yev2diQYM+kPrrSqykQkGj4em+aEHEpNJoOvXFHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wg2gDTS6Xw4rxu/+cF27keiSBsPYT6drqF4TejcRM0CxuCTOPvfY/qV55n6LLUzaHhzKUyNrkNAB0L1gGTaCycWk9paiqkEmA/hUH6/ccvJhOAgmaLzlpX/6wxN2TvaxNw4LL1HSKcIzas0jGSuF6FAJjRJRaUT+FP5o/tDmlWGNSFkx9qibB0kVfIeNTrT/nxQO0NJvE8SxE+qqbzfPYJPMaJY9RhmoablHysvf7XSWDC82WeItrfZxp7j4xvu4fwQqTdpX2eaD2UzNXQLJwMl3R/G4QFE6PVHc+PtFvMi2hvSPkDD1A6T7XiFv2iag18szGtONXVc8tPaive1kKQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=s1E1RcXB; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=s1E1RcXB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQmpL0yPwz2yFY
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Mar 2026 20:00:10 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id C3D126057A;
	Wed,  4 Mar 2026 09:00:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966CCC19423;
	Wed,  4 Mar 2026 09:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772614807;
	bh=gifGbD6JMEv6L9NlQtyraekK4duLMCrGJ52WNb14fOM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=s1E1RcXBmTr/rW3gJAHmwNQJoKtvL+v8v747G71JRzSxTXgoW+GDONtMSk20kLetk
	 7AH8uwWvEQPoGjsuGXGXxWcXOWHpJm5wALSqafUS0AcBkFNVUntTME9KyZLJahOWJM
	 ULDgMDC3uttYxif/9Y0f6PPd0NUx1j62TETbLrUyNnmmuxNPeFNmfr08XSzk4uoA1O
	 ZLKMCrREaVbS2HHUc27Go0ipAJIb3xfm9rKw6yeCIv9KMcl8U8Eut+wPPrlWLx/UKT
	 wyc10bJs0N9jjVbBZvepuSWxI41FXgfj0U9sPrjijWQR4+aJiz5j+W8aNmt56x1hrs
	 o/3VOvOrQsDpA==
Message-ID: <e1eabcbf-40da-4899-9db6-828a7b697328@kernel.org>
Date: Wed, 4 Mar 2026 10:00:03 +0100
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
Subject: Re: [RFC v1 05/10] powerpc/64s: Move serialize_against_pte_lookup()
 to hash_pgtable.c
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: linux-mm@kvack.org, Hugh Dickins <hughd@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
 Venkat Rao Bagalkote <venkat88@linux.ibm.com>
References: <cover.1772013273.git.ritesh.list@gmail.com>
 <dd9b5abdcc56d935681f7f95fa018bd886d59ba0.1772013273.git.ritesh.list@gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <dd9b5abdcc56d935681f7f95fa018bd886d59ba0.1772013273.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 25/02/2026 à 12:04, Ritesh Harjani (IBM) a écrit :
> Originally,
> commit fa4531f753f1 ("powerpc/mm: Don't send IPI to all cpus on THP updates")
> introduced serialize_against_pte_lookup() call for both Radix and Hash.
> 
> However below commit fixed the race with Radix
> commit 70cbc3cc78a9 ("mm: gup: fix the fast GUP race against THP collapse")
> 
> And therefore following commit removed the
> serialize_against_pte_lookup() call from radix_pgtable.c
> commit bedf03416913
> ("powerpc/64s/radix: don't need to broadcast IPI for radix pmd collapse flush")
> 
> Now since serialize_against_pte_lookup() only gets called from
> hash__pmdp_collapse_flush(), thus move the related functions to
> hash_pgtable.c
> 
> Hence this patch:
> - moves serialize_against_pte_lookup() from radix_pgtable.c to hash_pgtable.c
> - removes the radix specific calls from do_serialize()
> - renames do_serialize() to do_nothing().
> 
> There should not be any functionality change in this patch.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

> ---
>   arch/powerpc/include/asm/book3s/64/pgtable.h |  1 -
>   arch/powerpc/mm/book3s64/hash_pgtable.c      | 21 ++++++++++++++++
>   arch/powerpc/mm/book3s64/pgtable.c           | 25 --------------------
>   3 files changed, 21 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index 1a91762b455d..ff264d930fe8 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -1400,7 +1400,6 @@ static inline bool arch_needs_pgtable_deposit(void)
>   		return false;
>   	return true;
>   }
> -extern void serialize_against_pte_lookup(struct mm_struct *mm);
>   
>   #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>   
> diff --git a/arch/powerpc/mm/book3s64/hash_pgtable.c b/arch/powerpc/mm/book3s64/hash_pgtable.c
> index ac2a24d15d2e..d9b5b751d7b7 100644
> --- a/arch/powerpc/mm/book3s64/hash_pgtable.c
> +++ b/arch/powerpc/mm/book3s64/hash_pgtable.c
> @@ -221,6 +221,27 @@ unsigned long hash__pmd_hugepage_update(struct mm_struct *mm, unsigned long addr
>   	return old;
>   }
>   
> +static void do_nothing(void *arg)
> +{
> +
> +}
> +
> +/*
> + * Serialize against __find_linux_pte() which does lock-less
> + * lookup in page tables with local interrupts disabled. For huge pages
> + * it casts pmd_t to pte_t. Since format of pte_t is different from
> + * pmd_t we want to prevent transit from pmd pointing to page table
> + * to pmd pointing to huge page (and back) while interrupts are disabled.
> + * We clear pmd to possibly replace it with page table pointer in
> + * different code paths. So make sure we wait for the parallel
> + * __find_linux_pte() to finish.
> + */
> +static void serialize_against_pte_lookup(struct mm_struct *mm)
> +{
> +	smp_mb();
> +	smp_call_function_many(mm_cpumask(mm), do_nothing, mm, 1);
> +}
> +
>   pmd_t hash__pmdp_collapse_flush(struct vm_area_struct *vma, unsigned long address,
>   			    pmd_t *pmdp)
>   {
> diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
> index 359092001670..84284dff650a 100644
> --- a/arch/powerpc/mm/book3s64/pgtable.c
> +++ b/arch/powerpc/mm/book3s64/pgtable.c
> @@ -150,31 +150,6 @@ void set_pud_at(struct mm_struct *mm, unsigned long addr,
>   	return set_pte_at_unchecked(mm, addr, pudp_ptep(pudp), pud_pte(pud));
>   }
>   
> -static void do_serialize(void *arg)
> -{
> -	/* We've taken the IPI, so try to trim the mask while here */
> -	if (radix_enabled()) {
> -		struct mm_struct *mm = arg;
> -		exit_lazy_flush_tlb(mm, false);
> -	}
> -}
> -
> -/*
> - * Serialize against __find_linux_pte() which does lock-less
> - * lookup in page tables with local interrupts disabled. For huge pages
> - * it casts pmd_t to pte_t. Since format of pte_t is different from
> - * pmd_t we want to prevent transit from pmd pointing to page table
> - * to pmd pointing to huge page (and back) while interrupts are disabled.
> - * We clear pmd to possibly replace it with page table pointer in
> - * different code paths. So make sure we wait for the parallel
> - * __find_linux_pte() to finish.
> - */
> -void serialize_against_pte_lookup(struct mm_struct *mm)
> -{
> -	smp_mb();
> -	smp_call_function_many(mm_cpumask(mm), do_serialize, mm, 1);
> -}
> -
>   /*
>    * We use this to invalidate a pmdp entry before switching from a
>    * hugepte to regular pmd entry.


