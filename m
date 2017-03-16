Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vkjvb6bStzDqYX
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Mar 2017 09:34:35 +1100 (AEDT)
Date: Fri, 17 Mar 2017 09:27:25 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V2 09/11] powerpc/mm: Lower the max real address to 51 bits
Message-ID: <20170316222725.GI10100@fergus.ozlabs.ibm.com>
References: <1489660329-22501-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1489660329-22501-10-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1489660329-22501-10-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 16, 2017 at 04:02:07PM +0530, Aneesh Kumar K.V wrote:
> Max value supported by hardware is 51 bits address. Radix page table define
> a slot of 57 bits for future expansion. We restrict the value supported in
> linux kernel 51 bits, so that we can use the bits between 57-51 for storing
> hash linux page table bits. This is done in the next patch.
> 
> This will free up the software page table bits to be used for features
> that are needed for both hash and radix. The current hash linux page table
> format doesn't have any free software bits. Moving hash linux page table
> specific bits to top of RPN field free up the software bits for other purpose.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---

There are a couple of comment typos below, but for the actual code change:

Reviewed-by: Paul Mackerras <paulus@ozlabs.org>

>  arch/powerpc/include/asm/book3s/64/pgtable.h | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index 96566df547a8..c470dcc815d5 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -38,6 +38,25 @@
>  #define _RPAGE_RSV4		0x0200000000000000UL
>  #define _RPAGE_RPN0		0x01000
>  #define _RPAGE_RPN1		0x02000
> +/* Max physicall address bit as per radix table */

physical not physicall

> +#define _RPAGE_PA_MAX		57
> +/*
> + * Max physical address bit we will use for now.
> + *
> + * This is mostly a hardware limitation and for now Power9 has
> + * a 51 bit limit.
> + *
> + * This is different from the number of physical bit required to address
> + * the last byte of memory. That is defined by MAX_PHYSMEM_BITS.
> + * MAX_PHYSMEM_BITS is a linux limitation imposed by the maximum
> + * number of sections we can support (SECTIONS_SHIFT).
> + *
> + * This is different from Radix page table limitation above and
> + * should always be less than that. The limit is done such that
> + * we can overload the bits between _RPAGE_PA_MAX and _PAGE_PA_MAX
> + * for hash linux page table specific bits.
> + */
> +#define _PAGE_PA_MAX		51
>  
>  #define _PAGE_SOFT_DIRTY	_RPAGE_SW3 /* software: software dirty tracking */
>  #define _PAGE_SPECIAL		_RPAGE_SW2 /* software: special page */
> @@ -51,10 +70,11 @@
>   */
>  #define _PAGE_NO_CACHE		_PAGE_TOLERANT
>  /*
> - * We support 57 bit real address in pte. Clear everything above 57, and
> + * We support _RPAGE_PA_MAX bit real address in pte. On the linux side
> + * we are limited by _PAGE_PA_MAX. Clear everything above _PAGE_PA_MAX
>   * every thing below PAGE_SHIFT;

You lost an "and" in that last sentence.

>   */
> -#define PTE_RPN_MASK	(((1UL << 57) - 1) & (PAGE_MASK))
> +#define PTE_RPN_MASK	(((1UL << _PAGE_PA_MAX) - 1) & (PAGE_MASK))
>  /*
>   * set of bits not changed in pmd_modify. Even though we have hash specific bits
>   * in here, on radix we expect them to be zero.
> -- 
> 2.7.4

Paul.
