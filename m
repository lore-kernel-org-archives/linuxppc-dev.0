Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E871D2C0091
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Aug 2013 16:37:32 +1000 (EST)
Message-ID: <51FB539D.9040705@windriver.com>
Date: Fri, 2 Aug 2013 14:37:17 +0800
From: =?UTF-8?B?IuKAnHRpZWp1bi5jaGVu4oCdIg==?= <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Bharat Bhushan <r65777@freescale.com>
Subject: Re: [PATCH 5/6 v2] kvm: powerpc: booke: Add linux pte lookup like
 booke3s
References: <1375355558-19187-1-git-send-email-Bharat.Bhushan@freescale.com>
 <1375355558-19187-6-git-send-email-Bharat.Bhushan@freescale.com>
In-Reply-To: <1375355558-19187-6-git-send-email-Bharat.Bhushan@freescale.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: kvm@vger.kernel.org, agraf@suse.de, kvm-ppc@vger.kernel.org,
 Bharat Bhushan <Bharat.Bhushan@freescale.com>, scottwood@freescale.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/01/2013 07:12 PM, Bharat Bhushan wrote:
> KVM need to lookup linux pte for getting TLB attributes (WIMGE).
> This is similar to how book3s does.
> This will be used in follow-up patches.
>
> Signed-off-by: Bharat Bhushan <bharat.bhushan@freescale.com>
> ---
> v1->v2
>   - This is a new change in this version
>
>   arch/powerpc/include/asm/kvm_booke.h |   73 ++++++++++++++++++++++++++++++++++
>   1 files changed, 73 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/kvm_booke.h b/arch/powerpc/include/asm/kvm_booke.h
> index d3c1eb3..903624d 100644
> --- a/arch/powerpc/include/asm/kvm_booke.h
> +++ b/arch/powerpc/include/asm/kvm_booke.h
> @@ -102,4 +102,77 @@ static inline ulong kvmppc_get_msr(struct kvm_vcpu *vcpu)
>   {
>   	return vcpu->arch.shared->msr;
>   }
> +
> +/*
> + * Lock and read a linux PTE.  If it's present and writable, atomically
> + * set dirty and referenced bits and return the PTE, otherwise return 0.
> + */
> +static inline pte_t kvmppc_read_update_linux_pte(pte_t *p, int writing)
> +{
> +	pte_t pte;
> +
> +#ifdef PTE_ATOMIC_UPDATES
> +	pte_t tmp;
> +        /* wait until _PAGE_BUSY is clear then set it atomically */
> +#ifdef CONFIG_PPC64
> +	__asm__ __volatile__ (
> +		"1:	ldarx	%0,0,%3\n"
> +		"	andi.	%1,%0,%4\n"
> +		"	bne-	1b\n"
> +		"	ori	%1,%0,%4\n"
> +		"	stdcx.	%1,0,%3\n"
> +		"	bne-	1b"
> +		: "=&r" (pte), "=&r" (tmp), "=m" (*p)
> +		: "r" (p), "i" (_PAGE_BUSY)
> +		: "cc");
> +#else
> +        __asm__ __volatile__ (
> +                "1:     lwarx   %0,0,%3\n"
> +                "       andi.   %1,%0,%4\n"
> +                "       bne-    1b\n"
> +                "       ori     %1,%0,%4\n"
> +                "       stwcx.  %1,0,%3\n"
> +                "       bne-    1b"
> +                : "=&r" (pte), "=&r" (tmp), "=m" (*p)
> +                : "r" (p), "i" (_PAGE_BUSY)
> +                : "cc");
> +#endif
> +#else
> +	pte = pte_val(*p);
> +#endif
> +
> +	if (pte_present(pte)) {
> +		pte = pte_mkyoung(pte);
> +		if (writing && pte_write(pte))
> +			pte = pte_mkdirty(pte);
> +	}
> +
> +	*p = pte;	/* clears _PAGE_BUSY */
> +
> +	return pte;
> +}
> +
> +static inline pte_t lookup_linux_pte(pgd_t *pgdir, unsigned long hva,
> +			      int writing, unsigned long *pte_sizep)

Looks this function is as same as book3s, so why not improve that as common :)

Tiejun

> +{
> +	pte_t *ptep;
> +	unsigned long ps = *pte_sizep;
> +	unsigned int shift;
> +
> +	ptep = find_linux_pte_or_hugepte(pgdir, hva, &shift);
> +	if (!ptep)
> +		return __pte(0);
> +	if (shift)
> +		*pte_sizep = 1ul << shift;
> +	else
> +		*pte_sizep = PAGE_SIZE;
> +
> +	if (ps > *pte_sizep)
> +		return __pte(0);
> +	if (!pte_present(*ptep))
> +		return __pte(0);
> +
> +	return kvmppc_read_update_linux_pte(ptep, writing);
> +}
> +
>   #endif /* __ASM_KVM_BOOKE_H__ */
>
