Subject: Re: [PATCH] fix TLB handling for 8xx on linuxppc-2.5
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pantelis Antoniou <panto@intracom.gr>
Cc: Dan Malek <dan@embeddededge.com>,
	Tom Rini <trini@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <1086040829.1930.66.camel@gaston>
References: <40BB42EF.10805@intracom.gr>  <1086040829.1930.66.camel@gaston>
Content-Type: text/plain
Message-Id: <1086041131.2248.68.camel@gaston>
Mime-Version: 1.0
Date: Tue, 01 Jun 2004 08:05:31 +1000
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> I don't like the above. Things should be dealt with differently.
>
> The TLB handler itself should only care about _setting_ _PAGE_HWWRITE I
> think when it's missing (oh, and dirty of course). The clearing should
> be done on a per-PTE basis in ptep_get_and_clear_*, ptep_clear_*, etc...
> along with the necessary TLB invalidate (hrm... can we invalidate
> selectively instead of the whole thing ?)

Actually... I think the various flush_tlb_* calls should be enough on
those CPUs anyway...

> The tlbia in update_mmu_cache() doesn't look good. More like a
> workaround for breakage in the implementation.
>
> Paul, any comment ?
>
> Ben.
>
> > +#define LAZY_DTLB_FIX			\
> > +	rlwinm  r12,r10,0,23,25;	\
> > +	cmpwi   r12,0xc0;		\
> > +	bne+    0f;			\
> > +	ori     r10,r10,0x100;		\
> > +	b	1f;			\
> > + 0:	cmpwi   r12,0x100;		\
> > +	bne+    1f;			\
> > +	rlwinm  r10,r10,0,24,22;	\
> > + 1:
> > +
> > +/*
> >   * Note: code which follows this uses cr0.eq (set if from kernel),
> >   * r11, r12 (SRR0), and r9 (SRR1).
> >   *
> > @@ -348,7 +366,6 @@
> >  	mtspr	MD_TWC, r11	/* Load pte table base address */
> >  	mfspr	r11, MD_TWC	/* ....and get the pte address */
> >  	lwz	r10, 0(r11)	/* Get the pte */
> > -
> >  	ori	r10, r10, _PAGE_ACCESSED
> >  	stw	r10, 0(r11)
> >
> > @@ -398,6 +415,7 @@
> >  	mfcr	r10
> >  	stw	r10, 0(r0)
> >  	stw	r11, 4(r0)
> > +	stw	r12, 16(r0)
> >  	mfspr	r10, M_TWB	/* Get level 1 table entry address */
> >
> >  	/* If we are faulting a kernel address, we have to use the
> > @@ -440,6 +458,7 @@
> >  	mtspr	MD_TWC, r11
> >
> >  	mfspr	r11, MD_TWC	/* get the pte address again */
> > +	LAZY_DTLB_FIX
> >  	ori	r10, r10, _PAGE_ACCESSED
> >  	stw	r10, 0(r11)
> >
> > @@ -463,6 +482,7 @@
> >  	lwz	r11, 0(r0)
> >  	mtcr	r11
> >  	lwz	r11, 4(r0)
> > +	lwz	r12, 16(r0)
> >  #ifdef CONFIG_8xx_CPU6
> >  	lwz	r3, 8(r0)
> >  #endif
> > @@ -472,6 +492,7 @@
> >  	lwz	r11, 0(r0)
> >  	mtcr	r11
> >  	lwz	r11, 4(r0)
> > +	lwz	r12, 16(r0)
> >  #ifdef CONFIG_8xx_CPU6
> >  	lwz	r3, 8(r0)
> >  #endif
> > @@ -505,6 +526,7 @@
> >  	mfcr	r10
> >  	stw	r10, 0(r0)
> >  	stw	r11, 4(r0)
> > +	stw	r12, 16(r0)
> >
> >  	/* First, make sure this was a store operation.
> >  	*/
> > @@ -574,6 +596,7 @@
> >  	*/
> >  	ori	r10, r10, _PAGE_DIRTY|_PAGE_ACCESSED|_PAGE_HWWRITE
> >  	mfspr	r11, MD_TWC		/* Get pte address again */
> > +	LAZY_DTLB_FIX
> >  	stw	r10, 0(r11)		/* and update pte in table */
> >
> >  	/* The Linux PTE won't go exactly into the MMU TLB.
> > @@ -596,6 +619,7 @@
> >  	lwz	r11, 0(r0)
> >  	mtcr	r11
> >  	lwz	r11, 4(r0)
> > +	lwz	r12, 16(r0)
> >  #ifdef CONFIG_8xx_CPU6
> >  	lwz	r3, 8(r0)
> >  #endif
> > @@ -605,6 +629,7 @@
> >  	lwz	r11, 0(r0)
> >  	mtcr	r11
> >  	lwz	r11, 4(r0)
> > +	lwz	r12, 16(r0)
> >  #ifdef CONFIG_8xx_CPU6
> >  	lwz	r3, 8(r0)
> >  #endif
> > diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linuxppc_2.5/arch/ppc/kernel/misc.S linuxppc_2.5-intracom/arch/ppc/kernel/misc.S
> > --- linuxppc_2.5/arch/ppc/kernel/misc.S	Mon May 31 10:52:30 2004
> > +++ linuxppc_2.5-intracom/arch/ppc/kernel/misc.S	Mon May 31 17:24:05 2004
> > @@ -565,10 +565,12 @@
> >   * flush_icache_range(unsigned long start, unsigned long stop)
> >   */
> >  _GLOBAL(flush_icache_range)
> > +#if !defined(CONFIG_8xx)
> >  	mfspr	r5,PVR
> >  	rlwinm	r5,r5,16,16,31
> >  	cmpi	0,r5,1
> >  	beqlr				/* for 601, do nothing */
> > +#endif
> >  	li	r5,L1_CACHE_LINE_SIZE-1
> >  	andc	r3,r3,r5
> >  	subf	r4,r3,r4
> > @@ -683,10 +685,12 @@
> >   *	void __flush_dcache_icache(void *page)
> >   */
> >  _GLOBAL(__flush_dcache_icache)
> > +#if !defined(CONFIG_8xx)
> >  	mfspr	r5,PVR
> >  	rlwinm	r5,r5,16,16,31
> >  	cmpi	0,r5,1
> >  	beqlr					/* for 601, do nothing */
> > +#endif
> >  	rlwinm	r3,r3,0,0,19			/* Get page base address */
> >  	li	r4,4096/L1_CACHE_LINE_SIZE	/* Number of lines in a page */
> >  	mtctr	r4
> > @@ -712,10 +716,12 @@
> >   *	void __flush_dcache_icache_phys(unsigned long physaddr)
> >   */
> >  _GLOBAL(__flush_dcache_icache_phys)
> > +#if !defined(CONFIG_8xx)
> >  	mfspr	r5,PVR
> >  	rlwinm	r5,r5,16,16,31
> >  	cmpi	0,r5,1
> >  	beqlr					/* for 601, do nothing */
> > +#endif
> >  	mfmsr	r10
> >  	rlwinm	r0,r10,0,28,26			/* clear DR */
> >  	mtmsr	r0
> > diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linuxppc_2.5/arch/ppc/mm/init.c linuxppc_2.5-intracom/arch/ppc/mm/init.c
> > --- linuxppc_2.5/arch/ppc/mm/init.c	Mon May 31 10:52:30 2004
> > +++ linuxppc_2.5-intracom/arch/ppc/mm/init.c	Mon May 31 17:24:05 2004
> > @@ -605,7 +605,6 @@
> >  	kunmap(page);
> >  }
> >
> > -#ifndef update_mmu_cache
> >  /*
> >   * This is called at the end of handling a user page fault, when the
> >   * fault has been handled by updating a PTE in the linux page tables.
> > @@ -641,6 +640,7 @@
> >  		if (!pmd_none(*pmd))
> >  			add_hash_page(mm->context, address, pmd_val(*pmd));
> >  	}
> > +#else
> > +	__tlbia();
> >  #endif
> >  }
> > -#endif
> > diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linuxppc_2.5/include/asm-ppc/tlbflush.h linuxppc_2.5-intracom/include/asm-ppc/tlbflush.h
> > --- linuxppc_2.5/include/asm-ppc/tlbflush.h	Mon May 31 10:53:26 2004
> > +++ linuxppc_2.5-intracom/include/asm-ppc/tlbflush.h	Mon May 31 17:24:16 2004
> > @@ -50,7 +50,8 @@
> >  static inline void flush_tlb_kernel_range(unsigned long start,
> >  				unsigned long end)
> >  	{ __tlbia(); }
> > -#define update_mmu_cache(vma, addr, pte)	do { } while(0)
> > +/* #define update_mmu_cache(vma, addr, pte)	do { } while(0) */
> > +extern void update_mmu_cache(struct vm_area_struct *, unsigned long, pte_t);
> >
> >  #else	/* 6xx, 7xx, 7xxx cpus */
> >  struct mm_struct;
--
Benjamin Herrenschmidt <benh@kernel.crashing.org>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
