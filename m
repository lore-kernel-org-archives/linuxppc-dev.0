Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x243.google.com (mail-pa0-x243.google.com
 [IPv6:2607:f8b0:400e:c03::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sJ23v0qjHzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Aug 2016 04:22:35 +1000 (AEST)
Received: by mail-pa0-x243.google.com with SMTP id hh10so8493708pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 11:22:34 -0700 (PDT)
Date: Tue, 23 Aug 2016 04:22:25 +1000
From: Balbir Singh <bsingharora@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V2 2/5] powerpc/mm: Add radix flush all with IS=3
Message-ID: <20160822182225.GA21403@350D>
Reply-To: bsingharora@gmail.com
References: <1471596759-3396-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1471596759-3396-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1471823733.19495.88.camel@kernel.crashing.org>
 <87shtxib9a.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <87shtxib9a.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 22, 2016 at 11:41:13AM +0530, Aneesh Kumar K.V wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> > On Fri, 2016-08-19 at 14:22 +0530, Aneesh Kumar K.V wrote:
> >> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> >> ---
> >>  arch/powerpc/include/asm/book3s/64/tlbflush-radix.h |  1 +
> >>  arch/powerpc/mm/tlb-radix.c                         | 15
> >> +++++++++++++++
> >>  2 files changed, 16 insertions(+)
> >
> > Don't we need two ? One for partition scoped and one for process scoped
> > ?
> 
> 
> With invalid selector value 3 (IS = 3), we will invalidate all entries
> when executed with MSR[HV] = 1. I guess that should take out all the
> translation cache, including implementation dependent one ?
>

I think Ben might be right, we probably need two. We probably want
to invlidate the process scoped ones first followed by partition
scope. I could not find anything in the documentation that said
partition scope flush implied process scope flush.
 
> Also note thar PRS = 0. ie, we are partition scoped. ie, we are doing
> invalidate with
> 
> PRS =0, IS = 3 HV = 1 RIC = 2
> 
> >
> >> diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
> >> b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
> >> index 65037762b120..a9e19cb2f7c5 100644
> >> --- a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
> >> +++ b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
> >> @@ -41,4 +41,5 @@ extern void radix__flush_tlb_page_psize(struct
> >> mm_struct *mm, unsigned long vmad
> >>  extern void radix__flush_tlb_lpid_va(unsigned long lpid, unsigned
> >> long gpa,
> >>  				     unsigned long page_size);
> >>  extern void radix__flush_tlb_lpid(unsigned long lpid);
> >> +extern void radix__flush_tlb_all(void);
> >>  #endif
> >> diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-
> >> radix.c
> >> index 48df05ef5231..517feb47ebe4 100644
> >> --- a/arch/powerpc/mm/tlb-radix.c
> >> +++ b/arch/powerpc/mm/tlb-radix.c
> >> @@ -400,3 +400,18 @@ void radix__flush_pmd_tlb_range(struct
> >> vm_area_struct *vma,
> >>  	radix__flush_tlb_range_psize(vma->vm_mm, start, end,
> >> MMU_PAGE_2M);
> >>  }
> >>  EXPORT_SYMBOL(radix__flush_pmd_tlb_range);
> >> +
> >> +void radix__flush_tlb_all(void)
> >> +{
> >> +	unsigned long rb,prs,r;
> >> +	unsigned long ric = RIC_FLUSH_ALL;
> >> +
> >> +	rb = 0x3 << PPC_BITLSHIFT(53); /* IS = 3 */
> >> +	prs = 0; /* partition scoped */
> >> +	r = 1;   /* raidx format */
		^^ radix
> >> +
> >> +	asm volatile("ptesync": : :"memory");
> >> +	asm volatile(PPC_TLBIE_5(%0, %4, %3, %2, %1)
> >> +		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(0)
> >> : "memory");
> >> +	asm volatile("eieio; tlbsync; ptesync": : :"memory");
> >> +}
> 


Balbir Singh.
