Return-Path: <B07421@freescale.com>
Received: from CH1EHSOBE010.bigfish.com (ch1ehsobe004.messaging.microsoft.com
	[216.32.181.184]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 14C38B6FC5
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 18 Jun 2011 02:32:32 +1000 (EST)
Date: Fri, 17 Jun 2011 11:32:15 -0500
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/book3e-64: use a separate TLB handler when
	linear map is bolted
Message-ID: <20110617113215.56b3d6df@schlenkerla.am.freescale.net>
In-Reply-To: <1308276050.2516.129.camel@pasglop>
References: <20110603221232.GA29809@schlenkerla.am.freescale.net>
	<1308276050.2516.129.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 17 Jun 2011 12:00:50 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> Does this completely replace your previous series of 7 patches ? (IE.
> Should I ditch them in patchwork ?) Or does it apply on top of them ?

It replaces them.

> >  #define SET_IVOR(vector_number, vector_offset)	\
> > diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
> > index a73668a..9d9e444 100644
> > --- a/arch/powerpc/include/asm/mmu_context.h
> > +++ b/arch/powerpc/include/asm/mmu_context.h
> > @@ -54,6 +54,7 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
> >  	/* 64-bit Book3E keeps track of current PGD in the PACA */
> >  #ifdef CONFIG_PPC_BOOK3E_64
> >  	get_paca()->pgd = next->pgd;
> > +	get_paca()->extlb[0][EX_TLB_PGD / 8] = (unsigned long)next->pgd;
> >  #endif
> >  	/* Nothing else to do if we aren't actually switching */
> >  	if (prev == next)
> > @@ -110,6 +111,7 @@ static inline void enter_lazy_tlb(struct mm_struct *mm,
> >  	/* 64-bit Book3E keeps track of current PGD in the PACA */
> >  #ifdef CONFIG_PPC_BOOK3E_64
> >  	get_paca()->pgd = NULL;
> > +	get_paca()->extlb[0][EX_TLB_PGD / 8] = 0;
> >  #endif
> >  }
> 
> Why do you keep a copy of the pgd there since it's in the PACA already
> and you have r13 setup in your handlers ?

This cache line is already being used by the TLB miss handler.  The cache
line containing paca->pgd isn't otherwise used there.

> > +.macro tlb_prolog_bolted addr
> > +	mtspr	SPRN_SPRG_TLB_SCRATCH,r13
> > +	mfspr	r13,SPRN_SPRG_PACA
> > +	std	r10,PACA_EXTLB+EX_TLB_R10(r13)
> > +	mfcr	r10
> > +	std	r11,PACA_EXTLB+EX_TLB_R11(r13)
> > +	mfspr	r11,SPRN_SPRG_TLB_SCRATCH
> 
> Do you need that ? Can't you leave r13 in scratch the whole way and
> just pop it out in the error case when branching to DSI/ISI ? The only
> thing is that TLB_SCRATCH needs to be saved/restored by
> crit/debug/mcheck but thats worth saving cycles in the TLB miss handler
> no ?

Sounds right... I'll try it.

> > +	mfspr	r11,SPRN_ESR
> > +
> > +	srdi	r15,r16,60		/* get region */
> > +	rldicl.	r10,r16,64-PGTABLE_EADDR_SIZE,PGTABLE_EADDR_SIZE+4
> > +	bne-	dtlb_miss_fault_bolted
> 
> Ok so I'm not familiar with your pipeline here, but wouldn't it be
> better to move the srdi to after the bne above and make it srdi., thus
> avoiding the compare below ?
> 
> > +	rlwinm	r10,r11,32-19,27,27
> > +	rlwimi	r10,r11,32-16,19,19
> > +	cmpwi	r15,0
> > +	ori	r10,r10,_PAGE_PRESENT
> > +	oris	r11,r10,_PAGE_ACCESSED@h

The cmpwi will run in parallel with the rlwimi above on e5500, but
changing it shouldn't hurt, and it's one less instruction to sit in the
icache...

-Scott
