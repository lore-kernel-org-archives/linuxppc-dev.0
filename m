Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vMpZb1QfyzDqHH
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 14:59:19 +1100 (AEDT)
Message-ID: <1487044759.21048.24.camel@neuling.org>
Subject: Re: [PATCH 2/2] powerpc/mm/autonuma: Switch ppc64 to its own
 implementeation of saved write
From: Michael Neuling <mikey@neuling.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 akpm@linux-foundation.org, Rik van Riel <riel@surriel.com>, Mel Gorman
 <mgorman@techsingularity.net>, paulus@ozlabs.org, benh@kernel.crashing.org
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Date: Tue, 14 Feb 2017 14:59:19 +1100
In-Reply-To: <1486609259-6796-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1486609259-6796-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1486609259-6796-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

On Thu, 2017-02-09 at 08:30 +0530, Aneesh Kumar K.V wrote:
> With this our protnone becomes a present pte with READ/WRITE/EXEC bit cle=
ared.
> By default we also set _PAGE_PRIVILEGED on such pte. This is now used to =
help
> us identify a protnone pte that as saved write bit. For such pte, we will
> clear
> the _PAGE_PRIVILEGED bit. The pte still remain non-accessible from both u=
ser
> and kernel.
>=20
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>


FWIW I've tested this, so:

Acked-By: Michael Neuling <mikey@neuling.org>

> ---
> =C2=A0arch/powerpc/include/asm/book3s/64/mmu-hash.h |=C2=A0=C2=A03 +++
> =C2=A0arch/powerpc/include/asm/book3s/64/pgtable.h=C2=A0=C2=A0| 32 ++++++=
+++++++++++++++++++-
> -
> =C2=A02 files changed, 33 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> index 0735d5a8049f..8720a406bbbe 100644
> --- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> +++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> @@ -16,6 +16,9 @@
> =C2=A0#include <asm/page.h>
> =C2=A0#include <asm/bug.h>
> =C2=A0
> +#ifndef __ASSEMBLY__
> +#include <linux/mmdebug.h>
> +#endif
> =C2=A0/*
> =C2=A0 * This is necessary to get the definition of PGTABLE_RANGE which w=
e
> =C2=A0 * need for various slices related matters. Note that this isn't th=
e
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h
> b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index e91ada786d48..efff910a84b1 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -443,8 +443,8 @@ static inline pte_t pte_clear_soft_dirty(pte_t pte)
> =C2=A0 */
> =C2=A0static inline int pte_protnone(pte_t pte)
> =C2=A0{
> -	return (pte_raw(pte) & cpu_to_be64(_PAGE_PRESENT | _PAGE_PRIVILEGED))
> =3D=3D
> -		cpu_to_be64(_PAGE_PRESENT | _PAGE_PRIVILEGED);
> +	return (pte_raw(pte) & cpu_to_be64(_PAGE_PRESENT | _PAGE_RWX)) =3D=3D
> +		cpu_to_be64(_PAGE_PRESENT);
> =C2=A0}
> =C2=A0#endif /* CONFIG_NUMA_BALANCING */
> =C2=A0
> @@ -514,6 +514,32 @@ static inline pte_t pte_mkhuge(pte_t pte)
> =C2=A0	return pte;
> =C2=A0}
> =C2=A0
> +#define pte_mk_savedwrite pte_mk_savedwrite
> +static inline pte_t pte_mk_savedwrite(pte_t pte)
> +{
> +	/*
> +	=C2=A0* Used by Autonuma subsystem to preserve the write bit
> +	=C2=A0* while marking the pte PROT_NONE. Only allow this
> +	=C2=A0* on PROT_NONE pte
> +	=C2=A0*/
> +	VM_BUG_ON((pte_raw(pte) & cpu_to_be64(_PAGE_PRESENT | _PAGE_RWX |
> _PAGE_PRIVILEGED)) !=3D
> +		=C2=A0=C2=A0cpu_to_be64(_PAGE_PRESENT | _PAGE_PRIVILEGED));
> +	return __pte(pte_val(pte) & ~_PAGE_PRIVILEGED);
> +}
> +
> +#define pte_savedwrite pte_savedwrite
> +static inline bool pte_savedwrite(pte_t pte)
> +{
> +	/*
> +	=C2=A0* Saved write ptes are prot none ptes that doesn't have
> +	=C2=A0* privileged bit sit. We mark prot none as one which has
> +	=C2=A0* present and pviliged bit set and RWX cleared. To mark
> +	=C2=A0* protnone which used to have _PAGE_WRITE set we clear
> +	=C2=A0* the privileged bit.
> +	=C2=A0*/
> +	return !(pte_raw(pte) & cpu_to_be64(_PAGE_RWX | _PAGE_PRIVILEGED));
> +}
> +
> =C2=A0static inline pte_t pte_mkdevmap(pte_t pte)
> =C2=A0{
> =C2=A0	return __pte(pte_val(pte) | _PAGE_SPECIAL|_PAGE_DEVMAP);
> @@ -885,6 +911,7 @@ static inline pte_t *pmdp_ptep(pmd_t *pmd)
> =C2=A0#define pmd_mkclean(pmd)	pte_pmd(pte_mkclean(pmd_pte(pmd)))
> =C2=A0#define pmd_mkyoung(pmd)	pte_pmd(pte_mkyoung(pmd_pte(pmd)))
> =C2=A0#define pmd_mkwrite(pmd)	pte_pmd(pte_mkwrite(pmd_pte(pmd)))
> +#define pmd_mk_savedwrite(pmd)	pte_pmd(pte_mk_savedwrite(pmd_pte(pmd))
> )
> =C2=A0
> =C2=A0#ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
> =C2=A0#define pmd_soft_dirty(pmd)=C2=A0=C2=A0=C2=A0=C2=A0pte_soft_dirty(p=
md_pte(pmd))
> @@ -901,6 +928,7 @@ static inline int pmd_protnone(pmd_t pmd)
> =C2=A0
> =C2=A0#define __HAVE_ARCH_PMD_WRITE
> =C2=A0#define pmd_write(pmd)		pte_write(pmd_pte(pmd))
> +#define pmd_savedwrite(pmd)	pte_savedwrite(pmd_pte(pmd))
> =C2=A0
> =C2=A0#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> =C2=A0extern pmd_t pfn_pmd(unsigned long pfn, pgprot_t pgprot);
