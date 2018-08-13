Return-Path: <npiggin@gmail.com>
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41pz2L1fpSzDrYj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Aug 2018 00:41:45 +1000 (AEST)
Received: by mail-pf1-x444.google.com with SMTP id j26-v6so7741405pfi.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Aug 2018 07:41:45 -0700 (PDT)
Date: Tue, 14 Aug 2018 00:41:36 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, "Gautham R . Shenoy"
 <ego@linux.vnet.ibm.com>, kvm-ppc@vger.kernel.org, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>, Akshay Adiga
 <akshay.adiga@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 1/2] powerpc/64s: move machine check SLB flushing to
 mm/slb.c
Message-ID: <20180814004136.6ad6b356@roar.ozlabs.ibm.com>
In-Reply-To: <a216c87b-99ac-3a64-1c92-9e90ac28c8b6@linux.vnet.ibm.com>
References: <20180810064249.13724-1-npiggin@gmail.com>
 <a216c87b-99ac-3a64-1c92-9e90ac28c8b6@linux.vnet.ibm.com>
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

On Mon, 13 Aug 2018 09:57:33 +0530
Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:

> On 08/10/2018 12:12 PM, Nicholas Piggin wrote:
> > The machine check code that flushes and restores bolted segments in
> > real mode belongs in mm/slb.c. This will also be used by pseries
> > machine check and idle code in future changes.
> > 
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > 
> > Since v1:
> > - Restore the test for slb_shadow (mpe)
> > ---
> >  arch/powerpc/include/asm/book3s/64/mmu-hash.h |  3 ++
> >  arch/powerpc/kernel/mce_power.c               | 26 +++++--------
> >  arch/powerpc/mm/slb.c                         | 39 +++++++++++++++++++
> >  3 files changed, 51 insertions(+), 17 deletions(-)
> > 
> > diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> > index 2f74bdc805e0..d4e398185b3a 100644
> > --- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> > +++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> > @@ -497,6 +497,9 @@ extern void hpte_init_native(void);
> > 
> >  extern void slb_initialize(void);
> >  extern void slb_flush_and_rebolt(void);
> > +extern void slb_flush_all_realmode(void);
> > +extern void __slb_restore_bolted_realmode(void);
> > +extern void slb_restore_bolted_realmode(void);
> > 
> >  extern void slb_vmalloc_update(void);
> >  extern void slb_set_size(u16 size);
> > diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
> > index d6756af6ec78..3497c8329c1d 100644
> > --- a/arch/powerpc/kernel/mce_power.c
> > +++ b/arch/powerpc/kernel/mce_power.c
> > @@ -62,11 +62,8 @@ static unsigned long addr_to_pfn(struct pt_regs *regs, unsigned long addr)
> >  #ifdef CONFIG_PPC_BOOK3S_64
> >  static void flush_and_reload_slb(void)
> >  {
> > -	struct slb_shadow *slb;
> > -	unsigned long i, n;
> > -
> >  	/* Invalidate all SLBs */
> > -	asm volatile("slbmte %0,%0; slbia" : : "r" (0));
> > +	slb_flush_all_realmode();
> > 
> >  #ifdef CONFIG_KVM_BOOK3S_HANDLER
> >  	/*
> > @@ -76,22 +73,17 @@ static void flush_and_reload_slb(void)
> >  	if (get_paca()->kvm_hstate.in_guest)
> >  		return;
> >  #endif
> > -
> > -	/* For host kernel, reload the SLBs from shadow SLB buffer. */
> > -	slb = get_slb_shadow();
> > -	if (!slb)
> > +	if (early_radix_enabled())
> >  		return;  
> 
> Would we ever get MCE for SLB errors when radix is enabled ?

Well I'm not 100% sure. I don't think the MMU should in radix mode,
but KVM will put guests into HPT mode and put entries into the SLB.
I'm not completely sure we would never get a MCE come through here.

> 
> > 
> > -	n = min_t(u32, be32_to_cpu(slb->persistent), SLB_MIN_SIZE);
> > -
> > -	/* Load up the SLB entries from shadow SLB */
> > -	for (i = 0; i < n; i++) {
> > -		unsigned long rb = be64_to_cpu(slb->save_area[i].esid);
> > -		unsigned long rs = be64_to_cpu(slb->save_area[i].vsid);
> > +	/*
> > +	 * This probably shouldn't happen, but it may be possible it's
> > +	 * called in early boot before SLB shadows are allocated.
> > +	 */
> > +	if (!get_slb_shadow())
> > +		return;  
> 
> Any reason you added above check here instead on mm/slb.c ? Should we
> move above check inside slb_restore_bolted_realmode() ? I guess mm/slb.c
> is right place for this check. This will also help pseries machine check
> to avoid calling this extra check explicitly.

I thought it was a corner case because the slb.c code should not
be called before it's initialised. I'd prefer these exceptional
machine check cases be tested in the MCE code. Anything else calling
flush_and_reload_slb so early would be a bad bug.

Thanks,
Nick
