Return-Path: <linuxppc-dev+bounces-17350-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB8AFD4600
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Feb 2026 06:47:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fMf5Z2gh5z3bmR;
	Fri, 27 Feb 2026 17:47:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772174850;
	cv=none; b=EgKuIJQzYQQRuJfAFNhjqipGZr5nTCAjLN57TBWtk7JBq6JykPqMYZLwfR5D5ecOQK2WiF16Yk57P+XhczemLNIaQg1soPY1WzMCqsuvZ999zy2HwYKL7QGDGxAPJCqBv7xswy377IF9jnM0DJehzZisKLxZ0AVHwlNgqzBALcxmj6UqMDslG3luj4jKsmp0nkUou86+/4SFInxiFjvyaIToo1QXwByxGZ4H8a7oUPVplBo30HSbxWvGwX1eE0+/rRfVN8VRdzt2h6VACNCchOBGeB0zoUA4/iLi9xolfO+9mmmx+PJBflx05YRKcpMQ1njs2ov0AuxOp8/GrYl7sA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772174850; c=relaxed/relaxed;
	bh=mEN5vr4kMOUu6FGvzSN84qC/mx/J6IWnb35GhSr8CZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=moh3ij4ZnldRQEp/z6oywCRLG0iC+mlxSGawQCNCE+uFPVhhY/r2+5aCvWzrSr/X7/73LQhxLf4YBqZVCIS9ryhIK1nLABpvmrHIVfiDlkowInKEODcK/Ghuwua9wNWO5MLR3hOFvJLxNFZlboIh6GDR48tz3JK1sn10ZNL8+Guz2q8H/TFLquGvU1cmNRVvHEWvAodRrjlRNK26ZBq78Qo5ykmQa718dJKV0b390iAbp2xGU5vC8uPngXplAHetE+iusfhRLHLP3YrHD8FPsPQDIIQlulMo4oVOJHljC7JChcCiwyFWr8i3NYtl7jPww5VDtLc9nZwmsU26/P7Z3g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=PPYM0RiM; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=PPYM0RiM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fMf5Y3mjVz2yFQ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2026 17:47:29 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B7C30600AA;
	Fri, 27 Feb 2026 06:47:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF83C19422;
	Fri, 27 Feb 2026 06:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772174847;
	bh=KO2bW00MM7LDG//quqXYZmj/ahwm2FnxZhGD6CmuPkc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PPYM0RiMcmK4BZUonZBiN7hp3nR4ppxvaDhDxzl0NbcO5XRjZ91TMYXbShCI54IVZ
	 JvN1rA3Ml1woOMP0m+wIjntDHOEu3aRhaIP0zOtPkZ9E/CKzgktxC/jyEMpkxbexf7
	 /czR5FfE/5J98rtUZWaEnsjHK8VYxycf1GGbFpDpN3bMnxMxPSepmdiQaXS2Oyu+zG
	 Npyx/UwNsnLxyP7A/JPD4f5fR831f9pRGSjIKcSNqRUy/5hLhU+NiFgvSF4d+s3mQ8
	 v9AWPK6Y16exoSilsS+YLigMUjHo4g2eU/p0IHsvOVH4LZe6H7/i3oA/LzqlljZK9h
	 zfarBq1DXpLUA==
Message-ID: <abfbe83b-23fb-400d-9069-b8bf4ad21d95@kernel.org>
Date: Fri, 27 Feb 2026 07:47:22 +0100
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
Subject: Re: [RFC v1 2/2] powerpc/64s: Add support for huge pfnmaps
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: linux-mm@kvack.org, kvm@vger.kernel.org,
 Alex Williamson <alex@shazbot.org>, Peter Xu <peterx@redhat.com>
References: <0b8fce7a61561640634317a5e287cdb4794715fd.1772170860.git.ritesh.list@gmail.com>
 <d159058a45ac5e225f2e64cc7c8bbbd1583e51f3.1772170860.git.ritesh.list@gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <d159058a45ac5e225f2e64cc7c8bbbd1583e51f3.1772170860.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 27/02/2026 à 07:16, Ritesh Harjani (IBM) a écrit :
> This uses _RPAGE_SW2 bit for the PMD and PUDs similar to PTEs.
> This also adds support for {pte,pmd,pud}_pgprot helpers needed for
> follow_pfnmap APIs.
> 
> This allows us to extend the PFN mappings, e.g. PCI MMIO bars where
> it can grow as large as 8GB or even bigger, to map at PMD / PUD level.
> VFIO PCI core driver already supports fault handling at PMD / PUD level
> for more efficient BAR mappings.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>


> ---
> 
> @linux-mm:
> Is there any official test which I could use to verify this functionality.
> 
> For now I used basic ivshmem setup + vfio using Qemu and validated using some
> basic test to see that we are seeing these prints.
> 
> [ 4351.435050] vfio_pci_mmap_huge_fault: 3 callbacks suppressed
> [ 4351.435234] vfio-pci 0001:00:00.0: vfio_pci_mmap_huge_fault(,order = 5) BAR 2 page offset 0x0: 0x100
> [ 4351.457005] vfio-pci 0001:00:00.0: vfio_pci_mmap_huge_fault(,order = 5) BAR 2 page offset 0x40: 0x100
> [ 4351.463684] vfio-pci 0001:00:00.0: vfio_pci_mmap_huge_fault(,order = 5) BAR 2 page offset 0x20: 0x100
> 
>   arch/powerpc/Kconfig                         |  1 +
>   arch/powerpc/include/asm/book3s/64/pgtable.h | 23 ++++++++++++++++++++
>   arch/powerpc/include/asm/pgtable.h           | 12 ++++++++++
>   3 files changed, 36 insertions(+)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index ad7a2fe63a2a..cf9283757e5d 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -172,6 +172,7 @@ config PPC
>   	select ARCH_STACKWALK
>   	select ARCH_SUPPORTS_ATOMIC_RMW
>   	select ARCH_SUPPORTS_DEBUG_PAGEALLOC	if PPC_BOOK3S || PPC_8xx
> +	select ARCH_SUPPORTS_HUGE_PFNMAP	if PPC_BOOK3S_64 && TRANSPARENT_HUGEPAGE
>   	select ARCH_SUPPORTS_PAGE_TABLE_CHECK	if !HUGETLB_PAGE
>   	select ARCH_SUPPORTS_SCHED_MC		if SMP
>   	select ARCH_SUPPORTS_SCHED_SMT		if PPC64 && SMP
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index 1a91762b455d..639cbf34f752 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -1289,6 +1289,29 @@ static inline pud_t pud_mkhuge(pud_t pud)
>   	return pud;
>   }
> 
> +#ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
> +static inline bool pmd_special(pmd_t pmd)
> +{
> +	return pte_special(pmd_pte(pmd));
> +}
> +
> +static inline pmd_t pmd_mkspecial(pmd_t pmd)
> +{
> +	return pte_pmd(pte_mkspecial(pmd_pte(pmd)));
> +}
> +#endif
> +
> +#ifdef CONFIG_ARCH_SUPPORTS_PUD_PFNMAP
> +static inline bool pud_special(pud_t pud)
> +{
> +	return pte_special(pud_pte(pud));
> +}
> +
> +static inline pud_t pud_mkspecial(pud_t pud)
> +{
> +	return pte_pud(pte_mkspecial(pud_pte(pud)));
> +}
> +#endif
> 
>   #define __HAVE_ARCH_PMDP_SET_ACCESS_FLAGS
>   extern int pmdp_set_access_flags(struct vm_area_struct *vma,
> diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
> index dcd3a88caaf6..2d27cb1c2334 100644
> --- a/arch/powerpc/include/asm/pgtable.h
> +++ b/arch/powerpc/include/asm/pgtable.h
> @@ -63,6 +63,18 @@ static inline pgprot_t pte_pgprot(pte_t pte)
>   	return __pgprot(pte_flags);
>   }
> 
> +#define pmd_pgprot pmd_pgprot
> +static inline pgprot_t pmd_pgprot(pmd_t pmd)
> +{
> +	return pte_pgprot(pmd_pte(pmd));
> +}
> +
> +#define pud_pgprot pud_pgprot
> +static inline pgprot_t pud_pgprot(pud_t pud)
> +{
> +	return pte_pgprot(pud_pte(pud));
> +}
> +
>   static inline pgprot_t pgprot_nx(pgprot_t prot)
>   {
>   	return pte_pgprot(pte_exprotect(__pte(pgprot_val(prot))));
> --
> 2.53.0
> 
> 


