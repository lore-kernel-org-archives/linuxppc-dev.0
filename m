Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sJwb212X5zDr7p
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Aug 2016 15:19:10 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id h186so486332pfg.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Aug 2016 22:19:10 -0700 (PDT)
Subject: Re: [PATCH V3] powerpc/mm: Add radix flush all with IS=3
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <1471596759-3396-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1471949868-542-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <99189d7b-56ed-02b6-d760-5b8dd9d6be2c@gmail.com>
Date: Wed, 24 Aug 2016 15:19:01 +1000
MIME-Version: 1.0
In-Reply-To: <1471949868-542-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 23/08/16 20:57, Aneesh Kumar K.V wrote:
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  .../powerpc/include/asm/book3s/64/tlbflush-radix.h |  1 +
>  arch/powerpc/mm/tlb-radix.c                        | 24 ++++++++++++++++++++++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
> index 65037762b120..a9e19cb2f7c5 100644
> --- a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
> +++ b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
> @@ -41,4 +41,5 @@ extern void radix__flush_tlb_page_psize(struct mm_struct *mm, unsigned long vmad
>  extern void radix__flush_tlb_lpid_va(unsigned long lpid, unsigned long gpa,
>  				     unsigned long page_size);
>  extern void radix__flush_tlb_lpid(unsigned long lpid);
> +extern void radix__flush_tlb_all(void);
>  #endif
> diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
> index 48df05ef5231..0e49ec541ab5 100644
> --- a/arch/powerpc/mm/tlb-radix.c
> +++ b/arch/powerpc/mm/tlb-radix.c
> @@ -400,3 +400,27 @@ void radix__flush_pmd_tlb_range(struct vm_area_struct *vma,
>  	radix__flush_tlb_range_psize(vma->vm_mm, start, end, MMU_PAGE_2M);
>  }
>  EXPORT_SYMBOL(radix__flush_pmd_tlb_range);
> +
> +void radix__flush_tlb_all(void)
> +{
> +	unsigned long rb,prs,r,rs;
> +	unsigned long ric = RIC_FLUSH_ALL;
> +
> +	rb = 0x3 << PPC_BITLSHIFT(53); /* IS = 3 */
> +	prs = 0; /* partition scoped */
> +	r = 1;   /* raidx format */

		^^ typo - radix

> +	rs = 1 & ((1UL << 32) - 1); /* any LPID value to flush guest mappings */
> +

For RIC=2 and IS=3, I think RS is ignored.. I don't think we need to
set RS to anything other than 0, please double check


> +	asm volatile("ptesync": : :"memory");
> +	/*
> +	 * now flush guest entries by passing PRS = 1 and LPID != 0
> +	 */
> +	asm volatile(PPC_TLBIE_5(%0, %4, %3, %2, %1)
> +		     : : "r"(rb), "i"(r), "i"(1), "i"(ric), "r"(rs) : "memory");
> +	/*
> +	 * now flush host entires by passing PRS = 0 and LPID == 0
> +	 */
> +	asm volatile(PPC_TLBIE_5(%0, %4, %3, %2, %1)
> +		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(0) : "memory");
> +	asm volatile("eieio; tlbsync; ptesync": : :"memory");
> +}
> 

Otherwise looks good



Balbir Singh.
