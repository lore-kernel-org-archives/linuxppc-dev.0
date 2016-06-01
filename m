Return-Path: <linuxram@us.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rKl401glvzDqVp
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jun 2016 08:13:20 +1000 (AEST)
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Wed, 1 Jun 2016 16:13:18 -0600
Date: Wed, 1 Jun 2016 15:13:11 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/mm: use _raw variant of page table accessors
Message-ID: <20160601221311.GB5658@ram.oc3035372033.ibm.com>
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1464692382-29698-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1464692382-29698-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 31, 2016 at 04:29:42PM +0530, Aneesh Kumar K.V wrote:
> This switch few of the page table accessor to use the __raw variant
> and does the cpu to big endian conversion of constants. This helps in
> generating better code.
> 
> For ex: a pgd_none(pgd) check with and without fix is listed below
> 
> Without fix:
> ------------
>    2240:	20 00 61 eb 	ld      r27,32(r1)
> /* PGD level */
> typedef struct { __be64 pgd; } pgd_t;
> static inline unsigned long pgd_val(pgd_t x)
> {
> 	return be64_to_cpu(x.pgd);
> 
>     2244:	22 00 66 78 	rldicl  r6,r3,32,32
>     2248:	3e 40 7d 54 	rotlwi  r29,r3,8
>     224c:	0e c0 7d 50 	rlwimi  r29,r3,24,0,7
>     2250:	3e 40 c5 54 	rotlwi  r5,r6,8
>     2254:	2e c4 7d 50 	rlwimi  r29,r3,24,16,23
>     2258:	0e c0 c5 50 	rlwimi  r5,r6,24,0,7
>     225c:	2e c4 c5 50 	rlwimi  r5,r6,24,16,23
>     2260:	c6 07 bd 7b 	rldicr  r29,r29,32,31
>     2264:	78 2b bd 7f 	or      r29,r29,r5
> 		if (pgd_none(pgd))
>     2268:	00 00 bd 2f 	cmpdi   cr7,r29,0
>     226c:	54 03 9e 41 	beq     cr7,25c0 <__get_user_pages_fast+0x500>
> 
> With fix:
> ---------
>     2370:	20 00 61 eb 	ld      r27,32(r1)
> 		if (pgd_none(pgd))
>     2374:	00 00 bd 2f 	cmpdi   cr7,r29,0
>     2378:	a8 03 9e 41 	beq     cr7,2720 <__get_user_pages_fast+0x530>
> 			break;
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/pgtable-4k.h  |  6 +-
>  arch/powerpc/include/asm/book3s/64/pgtable-64k.h |  6 +-
>  arch/powerpc/include/asm/book3s/64/pgtable.h     | 99 +++++++++++++++++-------
>  arch/powerpc/include/asm/pgtable-be-types.h      | 15 ++++
>  4 files changed, 91 insertions(+), 35 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable-4k.h b/arch/powerpc/include/asm/book3s/64/pgtable-4k.h
> index 71e9abced493..9db83b4e017d 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable-4k.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable-4k.h
> @@ -11,7 +11,7 @@ static inline int pmd_huge(pmd_t pmd)
>  	 * leaf pte for huge page
>  	 */
>  	if (radix_enabled())
> -		return !!(pmd_val(pmd) & _PAGE_PTE);
> +		return !!(pmd_raw(pmd) & cpu_to_be64(_PAGE_PTE));
>  	return 0;
>  }
>  
> @@ -21,7 +21,7 @@ static inline int pud_huge(pud_t pud)
>  	 * leaf pte for huge page
>  	 */
>  	if (radix_enabled())
> -		return !!(pud_val(pud) & _PAGE_PTE);
> +		return !!(pud_raw(pud) & cpu_to_be64(_PAGE_PTE));
>  	return 0;
>  }
>  
> @@ -31,7 +31,7 @@ static inline int pgd_huge(pgd_t pgd)
>  	 * leaf pte for huge page
>  	 */
>  	if (radix_enabled())
> -		return !!(pgd_val(pgd) & _PAGE_PTE);
> +		return !!(pgd_raw(pgd) & cpu_to_be64(_PAGE_PTE));

pgd_raw() will not do the endian swapping.
But instead cpu_to_be64(_PAGE_PTE) will now do the endian swapping. So does it
really optimize anything? i tend to think it just moves the endian
swapping overhead from one place to the other. no?
Is cpu_to_be64(constant) faster than cpu_to_be64(variable)  ?

RP
