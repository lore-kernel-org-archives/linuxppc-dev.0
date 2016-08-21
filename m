Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sHYWJ10VPzDr5Q
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 09:56:11 +1000 (AEST)
Message-ID: <1471823733.19495.88.camel@kernel.crashing.org>
Subject: Re: [PATCH V2 2/5] powerpc/mm: Add radix flush all with IS=3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Date: Mon, 22 Aug 2016 09:55:33 +1000
In-Reply-To: <1471596759-3396-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1471596759-3396-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1471596759-3396-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

On Fri, 2016-08-19 at 14:22 +0530, Aneesh Kumar K.V wrote:
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/tlbflush-radix.h |  1 +
>  arch/powerpc/mm/tlb-radix.c                         | 15
> +++++++++++++++
>  2 files changed, 16 insertions(+)

Don't we need two ? One for partition scoped and one for process scoped
?

> diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
> b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
> index 65037762b120..a9e19cb2f7c5 100644
> --- a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
> +++ b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
> @@ -41,4 +41,5 @@ extern void radix__flush_tlb_page_psize(struct
> mm_struct *mm, unsigned long vmad
>  extern void radix__flush_tlb_lpid_va(unsigned long lpid, unsigned
> long gpa,
>  				     unsigned long page_size);
>  extern void radix__flush_tlb_lpid(unsigned long lpid);
> +extern void radix__flush_tlb_all(void);
>  #endif
> diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-
> radix.c
> index 48df05ef5231..517feb47ebe4 100644
> --- a/arch/powerpc/mm/tlb-radix.c
> +++ b/arch/powerpc/mm/tlb-radix.c
> @@ -400,3 +400,18 @@ void radix__flush_pmd_tlb_range(struct
> vm_area_struct *vma,
>  	radix__flush_tlb_range_psize(vma->vm_mm, start, end,
> MMU_PAGE_2M);
>  }
>  EXPORT_SYMBOL(radix__flush_pmd_tlb_range);
> +
> +void radix__flush_tlb_all(void)
> +{
> +	unsigned long rb,prs,r;
> +	unsigned long ric = RIC_FLUSH_ALL;
> +
> +	rb = 0x3 << PPC_BITLSHIFT(53); /* IS = 3 */
> +	prs = 0; /* partition scoped */
> +	r = 1;   /* raidx format */
> +
> +	asm volatile("ptesync": : :"memory");
> +	asm volatile(PPC_TLBIE_5(%0, %4, %3, %2, %1)
> +		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(0)
> : "memory");
> +	asm volatile("eieio; tlbsync; ptesync": : :"memory");
> +}
