Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yBD3C39qzzDqlv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 21:33:10 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id m28so34469384pfi.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 03:33:10 -0700 (PDT)
Date: Tue, 10 Oct 2017 20:32:56 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/64s/radix: fix preempt imbalance in TLB flush
Message-ID: <20171010203256.3cb6701f@roar.ozlabs.ibm.com>
In-Reply-To: <d243ba10-5e46-c86a-be89-64737257e903@linux.vnet.ibm.com>
References: <20171010101641.5714-1-npiggin@gmail.com>
 <d243ba10-5e46-c86a-be89-64737257e903@linux.vnet.ibm.com>
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

On Tue, 10 Oct 2017 15:52:02 +0530
"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:

> On 10/10/2017 03:46 PM, Nicholas Piggin wrote:
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >   arch/powerpc/mm/tlb-radix.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
> > index b3e849c4886e..de414460287a 100644
> > --- a/arch/powerpc/mm/tlb-radix.c
> > +++ b/arch/powerpc/mm/tlb-radix.c
> > @@ -358,7 +358,7 @@ void radix__flush_tlb_collapsed_pmd(struct mm_struct *mm, unsigned long addr)
> >   	unsigned long ap = mmu_get_ap(mmu_virtual_psize);
> >   	unsigned long pid, end;
> > 
> > -
> > +	preempt_disable();
> >   	pid = mm ? mm->context.id : 0;
> >   	if (unlikely(pid == MMU_NO_CONTEXT))
> >   		goto no_context;
> > @@ -366,6 +366,7 @@ void radix__flush_tlb_collapsed_pmd(struct mm_struct *mm, unsigned long addr)
> >   	/* 4k page size, just blow the world */
> >   	if (PAGE_SIZE == 0x1000) {
> >   		radix__flush_all_mm(mm);
> > +		preempt_enable();
> >   		return;
> >   	}
> >   
> 
> Can't we do a preempt_disable before the if (local) check?. That way we 
> don't need that prempt_enable in that PAGE_SIZE==0x1000 path.We already 
> do disable/enable correctly in radix__flush_all_mm(mm)

Well this is just to fix the imbalance. Nested preempt doesn't matter
much, and these are all no-ops for !preempt kernel, unless you turn on
debugging.

I already proposed another patch to bring those local tests under
preempt disable but no response yet

https://patchwork.ozlabs.org/patch/811061/

Thanks,
Nick
