Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqkNW385czDqxj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 15:12:43 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id i6so3897960pfe.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 22:12:43 -0700 (PDT)
Date: Thu, 14 Jul 2016 15:12:31 +1000
From: Balbir Singh <bsingharora@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH for-4.8 10/12] powerpc/mm/radix: Add LPID based tlb flush
 helpers
Message-ID: <20160714051231.GK18277@balbir.ozlabs.ibm.com>
Reply-To: bsingharora@gmail.com
References: <1468402531-4914-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1468402531-4914-11-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1468402531-4914-11-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 13, 2016 at 03:05:29PM +0530, Aneesh Kumar K.V wrote:
> We add a tlb flush variant, to flush LPID mappings.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  .../powerpc/include/asm/book3s/64/tlbflush-radix.h |  4 +-
>  arch/powerpc/mm/tlb-radix.c                        | 52 ++++++++++++++++++++++
>  2 files changed, 55 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
> index 3fa94fcac628..00703e7e4c94 100644
> --- a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
> +++ b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
> @@ -32,5 +32,7 @@ extern void radix__flush_tlb_pwc(struct mmu_gather *tlb, unsigned long addr);
>  #define radix___flush_tlb_page(mm,addr,p,i)	radix___local_flush_tlb_page(mm,addr,p,i)
>  #define radix__flush_tlb_pwc(tlb, addr)	radix__local_flush_tlb_pwc(tlb, addr)
>  #endif
> -
> +extern void radix__flush_tlb_lpid_va(unsigned long lpid, unsigned long gpa,
> +				     unsigned long page_size);
> +extern void radix__flush_tlb_lpid(unsigned long lpid);
>  #endif
> diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
> index 35690c41f85d..e1f22700fb16 100644
> --- a/arch/powerpc/mm/tlb-radix.c
> +++ b/arch/powerpc/mm/tlb-radix.c
> @@ -282,9 +282,61 @@ void radix__flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
>  }
>  EXPORT_SYMBOL(radix__flush_tlb_range);
>  
> +static int radix_get_mmu_psize(int page_size)
> +{
> +	int psize;
> +
> +	if (page_size == (1UL << mmu_psize_defs[mmu_virtual_psize].shift))
> +		psize = mmu_virtual_psize;
> +	else if (page_size == (1UL << mmu_psize_defs[MMU_PAGE_2M].shift))
> +		psize = MMU_PAGE_2M;
> +	else if (page_size == (1UL << mmu_psize_defs[MMU_PAGE_1G].shift))
> +		psize = MMU_PAGE_1G;
> +	else
> +		return -1;

Just do psize = -1;

> +	return psize;
> +}
>  
>  void radix__tlb_flush(struct mmu_gather *tlb)
>  {
>  	struct mm_struct *mm = tlb->mm;
>  	radix__flush_tlb_mm(mm);
>  }
> +
> +void radix__flush_tlb_lpid_va(unsigned long lpid, unsigned long gpa,
> +			      unsigned long page_size)
> +{
> +	unsigned long rb,rs,prs,r;
> +	unsigned long ap;
> +	unsigned long ric = RIC_FLUSH_TLB;
> +
> +	ap = mmu_get_ap(radix_get_mmu_psize(page_size));
> +	rb = gpa & ~(PPC_BITMASK(52, 63));
> +	rb |= ap << PPC_BITLSHIFT(58);
> +	rs = lpid & ((1UL << 32) - 1);
> +	prs = 0; /* process scoped */
> +	r = 1;   /* raidx format */
> +
> +	asm volatile("ptesync": : :"memory");
> +	asm volatile(PPC_TLBIE_5(%0, %4, %3, %2, %1)
> +		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(rs) : "memory");
> +	asm volatile("eieio; tlbsync; ptesync": : :"memory");
> +}
> +EXPORT_SYMBOL(radix__flush_tlb_lpid_va);
> +
> +void radix__flush_tlb_lpid(unsigned long lpid)
> +{
> +	unsigned long rb,rs,prs,r;
> +	unsigned long ric = RIC_FLUSH_ALL;
> +
> +	rb = 0x2 << PPC_BITLSHIFT(53); /* IS = 2 */
> +	rs = lpid & ((1UL << 32) - 1);
> +	prs = 0; /* partition scoped */
> +	r = 1;   /* raidx format */
> +
> +	asm volatile("ptesync": : :"memory");
> +	asm volatile(PPC_TLBIE_5(%0, %4, %3, %2, %1)
> +		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(rs) : "memory");
> +	asm volatile("eieio; tlbsync; ptesync": : :"memory");
> +}
> +EXPORT_SYMBOL(radix__flush_tlb_lpid);
