Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 947F467A77
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 27 Jun 2005 07:12:13 +1000 (EST)
Date: Sun, 26 Jun 2005 11:30:04 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Dan Malek <dan@embeddededge.com>
Message-ID: <20050626143004.GA5198@logos.cnet>
References: <20050625145318.GA32117@logos.cnet>
	<f14f5f5aebd45879c39c6ce69f29c004@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f14f5f5aebd45879c39c6ce69f29c004@embeddededge.com>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] 8xx: map_page() skip pinned region and tlbie debugging
	aid
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi Dan,

On Sat, Jun 25, 2005 at 06:24:47PM -0400, Dan Malek wrote:
> 
> On Jun 25, 2005, at 10:53 AM, Marcelo Tosatti wrote:
> 
> >Dan: I dont think ioremap() is an issue because it never works inside 
> >the
> >kernel's static virtual address space (which is the only one we're 
> >interested
> >in having pinned at the moment).
> 
> Take a close look at the initialization code.  I believe it also
> pins the IMMR space, which is subject to ioremap().

OK. Now that makes me think that the IMMR pinned entry is also always
thrashed by the tlbie at map_page() :(

The IMMR space is a 16kB window (correct?), so I wonder if it might
be better to the use occupied pinned slot for another more accessed
region (an 8MB one preferably!).

> > source "drivers/Kconfig"
> >diff --git a/arch/ppc/kernel/misc.S b/arch/ppc/kernel/misc.S
> >--- a/arch/ppc/kernel/misc.S
> >+++ b/arch/ppc/kernel/misc.S
> >@@ -565,6 +565,19 @@ _GLOBAL(_tlbie)
> > 	SYNC_601
> > 	isync
> > #else /* CONFIG_SMP */
> >+#ifdef CONFIG_DEBUG_PIN_TLBIE
> >+/* check if the address being invalidated overlaps with the pinned 
> >region */
> >+	lis	r4,(pin_area_start)@ha
> >+	lwz	r5,(pin_area_start)@l(4)
> >+	cmplw	r3, r5
> >+	blt	11f
> >+	lis	r4,(pin_area_end)@ha
> >+	lwz	r5,(pin_area_end)@l(4)
> >+	cmplw	r3, r5
> >+	bge	11f
> >+	trap
> >+#endif
> >+11:
> > 	tlbie	r3
> > 	sync
> 
> We don't need this kind of assembly code on the 8xx.  Just define
> _tlbie as a macro (which has always been done) and write this debug
> stuff as C code.

OK, makes sense.

> >+#ifdef CONFIG_PIN_TLB
> >+unsigned long pin_area_start = KERNELBASE;
> >+unsigned long pin_area_end = KERNELBASE + 0x00800000;
> >+#endif
> 
> This only covers the kernel instruction space.  We pin 24M bytes
> of data plus 8M bytes of IMMR.

Ok, I'll represent the pinned regions by a node structure ordered on a 
linked list and use that for both map_page() and the tlbie debugging aid.

> >+#ifdef CONFIG_PIN_TLB
> >+			if (va < pin_area_start || va >= pin_area_end)
> >+#endif
> >+				flush_HPTE(0, va, pmd_val(*pd));
> 
> We really want to see this generate an error.  We shouldn't be
> calling this on any of the pinned spaces.  In the case of initially
> mapping the kernel space, we should set up the page tables but
> not call this far down that we get here.

But the page tables are setup at this level:

int
map_page(unsigned long va, phys_addr_t pa, int flags)
{
        pmd_t *pd;
        pte_t *pg;
        int err = -ENOMEM;

        spin_lock(&init_mm.page_table_lock);
        /* Use upper 10 bits of VA to index the first level map */
        pd = pmd_offset(pgd_offset_k(va), va);
        /* Use middle 10 bits of VA to index the second-level map */
        pg = pte_alloc_kernel(&init_mm, pd, va);
        if (pg != 0) {
                err = 0;
                set_pte(pg, pfn_pte(pa >> PAGE_SHIFT, __pgprot(flags)));
                if (mem_init_done)
#ifdef CONFIG_PIN_TLB
                        if (va < pin_area_start || va > pin_area_end)
#endif
                                flush_HPTE(0, va, pmd_val(*pd));
