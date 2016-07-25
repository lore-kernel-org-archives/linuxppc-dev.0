Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ryWRd2b5QzDqdw
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 16:23:57 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id h186so11314361pfg.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Jul 2016 23:23:57 -0700 (PDT)
Date: Mon, 25 Jul 2016 16:23:49 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH for-4.8 V2 03/10] powerpc/mm/radix: Add radix_set_pte to
 use in early init
Message-ID: <20160725162349.1bc9a9fe@roar.ozlabs.ibm.com>
In-Reply-To: <1469265163-1491-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1469265163-1491-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1469265163-1491-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 23 Jul 2016 14:42:36 +0530
"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:

> We want to use the static key based feature check in set_pte_at. Since
> we call radix__map_kernel_page early in boot before jump label is
> initialized we can't call set_pte_at there. Add radix__set_pte for the
> same.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/pgtable-radix.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/mm/pgtable-radix.c
> b/arch/powerpc/mm/pgtable-radix.c index 003ff48a11b6..6d2eb76b508e
> 100644 --- a/arch/powerpc/mm/pgtable-radix.c
> +++ b/arch/powerpc/mm/pgtable-radix.c
> @@ -39,6 +39,27 @@ static __ref void *early_alloc_pgtable(unsigned
> long size) 
>  	return pt;
>  }
> +/*
> + * set_pte stores a linux PTE into the linux page table.
> + */
> +static void radix__set_pte(struct mm_struct *mm, unsigned long addr,
> pte_t *ptep,
> +			   pte_t pte)
> +{
> +	/*
> +	 * When handling numa faults, we already have the pte marked
> +	 * _PAGE_PRESENT, but we can be sure that it is not in hpte.
> +	 * Hence we can use set_pte_at for them.
> +	 */
> +	VM_WARN_ON(pte_present(*ptep) && !pte_protnone(*ptep));
> +
> +	/*
> +	 * Add the pte bit when tryint set a pte
> +	 */
> +	pte = __pte(pte_val(pte) | _PAGE_PTE);
> +
> +	/* Perform the setting of the PTE */
> +	radix__set_pte_at(mm, addr, ptep, pte, 0);
> +}
>  
>  int radix__map_kernel_page(unsigned long ea, unsigned long pa,
>  			  pgprot_t flags,
> @@ -102,7 +123,7 @@ int radix__map_kernel_page(unsigned long ea,
> unsigned long pa, }
>  
>  set_the_pte:
> -	set_pte_at(&init_mm, ea, ptep, pfn_pte(pa >> PAGE_SHIFT,
> flags));
> +	radix__set_pte(&init_mm, ea, ptep, pfn_pte(pa >> PAGE_SHIFT,
> flags)); smp_wmb();

What we have in existing code is set_pte_at() function that adds
the _PAGE_PTE bit, then calls __set_pte_at(), which calls radix or hash
version of __set_pte_at().

Now we also have radix__set_pte(), which has the function of the
set_pte_at(), which is starting to confuse the naming convention.
The new function is a radix-only set_pte_at(), rather than the
radix implementation that gets called via set_pte().

set_pte_at_radix()? That kind of sucks too, though. It might be better
if the radix/hash variants were called __radix__set_pte_at(), and this
new function was called radix__set_pte_at().

Thanks,
Nick
