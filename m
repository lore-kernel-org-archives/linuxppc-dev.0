Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vMpzW2Q95zDqGx
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 15:17:27 +1100 (AEDT)
Message-ID: <1487045848.21048.26.camel@neuling.org>
Subject: Re: [PATCH 2/3] powerpc/mm/radix: Use ptep_get_and_clear_full when
 clearing pte for full mm
From: Michael Neuling <mikey@neuling.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Date: Tue, 14 Feb 2017 15:17:28 +1100
In-Reply-To: <1486609101-5231-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1486609101-5231-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1486609101-5231-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-02-09 at 08:28 +0530, Aneesh Kumar K.V wrote:
> This helps us to do some optimization for application exit case, where we=
 can
> skip the DD1 style pte update sequence.
>=20
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Tested-by: Michael Neuling <mikey@neuling.org>

> ---
> =C2=A0arch/powerpc/include/asm/book3s/64/pgtable.h | 17 +++++++++++++++++
> =C2=A0arch/powerpc/include/asm/book3s/64/radix.h=C2=A0=C2=A0=C2=A0| 23 ++=
++++++++++++++++++++-
> =C2=A02 files changed, 39 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h
> b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index 6f15bde94da2..e91ada786d48 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -373,6 +373,23 @@ static inline pte_t ptep_get_and_clear(struct mm_str=
uct
> *mm,
> =C2=A0	return __pte(old);
> =C2=A0}
> =C2=A0
> +#define __HAVE_ARCH_PTEP_GET_AND_CLEAR_FULL
> +static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
> +					=C2=A0=C2=A0=C2=A0=C2=A0unsigned long addr,
> +					=C2=A0=C2=A0=C2=A0=C2=A0pte_t *ptep, int full)
> +{
> +	if (full && radix_enabled()) {
> +		/*
> +		=C2=A0* Let's skip the DD1 style pte update here. We know that
> +		=C2=A0* this is a full mm pte clear and hence can be sure there is
> +		=C2=A0* no parallel set_pte.
> +		=C2=A0*/
> +		return radix__ptep_get_and_clear_full(mm, addr, ptep, full);
> +	}
> +	return ptep_get_and_clear(mm, addr, ptep);
> +}
> +
> +
> =C2=A0static inline void pte_clear(struct mm_struct *mm, unsigned long ad=
dr,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pte_t * ptep)
> =C2=A0{
> diff --git a/arch/powerpc/include/asm/book3s/64/radix.h
> b/arch/powerpc/include/asm/book3s/64/radix.h
> index 70a3cdcdbe47..fcf822d6c204 100644
> --- a/arch/powerpc/include/asm/book3s/64/radix.h
> +++ b/arch/powerpc/include/asm/book3s/64/radix.h
> @@ -139,7 +139,7 @@ static inline unsigned long radix__pte_update(struct
> mm_struct *mm,
> =C2=A0
> =C2=A0		unsigned long new_pte;
> =C2=A0
> -		old_pte =3D __radix_pte_update(ptep, ~0, 0);
> +		old_pte =3D __radix_pte_update(ptep, ~0ul, 0);
> =C2=A0		/*
> =C2=A0		=C2=A0* new value of pte
> =C2=A0		=C2=A0*/
> @@ -157,6 +157,27 @@ static inline unsigned long radix__pte_update(struct
> mm_struct *mm,
> =C2=A0	return old_pte;
> =C2=A0}
> =C2=A0
> +static inline pte_t radix__ptep_get_and_clear_full(struct mm_struct *mm,
> +						=C2=A0=C2=A0=C2=A0unsigned long addr,
> +						=C2=A0=C2=A0=C2=A0pte_t *ptep, int full)
> +{
> +	unsigned long old_pte;
> +
> +	if (full) {
> +		/*
> +		=C2=A0* If we are trying to clear the pte, we can skip
> +		=C2=A0* the DD1 pte update sequence and batch the tlb flush. The
> +		=C2=A0* tlb flush batching is done by mmu gather code. We
> +		=C2=A0* still keep the cmp_xchg update to make sure we get
> +		=C2=A0* correct R/C bit which might be updated via Nest MMU.
> +		=C2=A0*/
> +		old_pte =3D __radix_pte_update(ptep, ~0ul, 0);
> +	} else
> +		old_pte =3D radix__pte_update(mm, addr, ptep, ~0ul, 0, 0);
> +
> +	return __pte(old_pte);
> +}
> +
> =C2=A0/*
> =C2=A0 * Set the dirty and/or accessed bits atomically in a linux PTE, th=
is
> =C2=A0 * function doesn't need to invalidate tlb.
