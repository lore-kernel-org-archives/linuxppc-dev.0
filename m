Return-Path: <srs0=immr=3l=kernel.crashing.org=benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vxGD65kgszDqHJ
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Apr 2017 12:25:26 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vxGD633Jjz8w3p
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Apr 2017 12:25:26 +1000 (AEST)
Message-ID: <1491186313.26047.31.camel@kernel.crashing.org>
Subject: Re: [PATCH 12/12] powerpc/kvm: Native usage of the XIVE interrupt
 controller
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org
Date: Mon, 03 Apr 2017 12:25:13 +1000
In-Reply-To: <20170328052633.kip4vdixwqsbkxcu@oak.ozlabs.ibm.com>
References: <20170320064914.4437-1-benh@kernel.crashing.org>
 <20170320064914.4437-12-benh@kernel.crashing.org>
 <20170328052633.kip4vdixwqsbkxcu@oak.ozlabs.ibm.com>
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

On Tue, 2017-03-28 at 16:26 +1100, Paul Mackerras wrote:
> 
> > --- a/arch/powerpc/include/asm/kvm_book3s_asm.h
> > +++ b/arch/powerpc/include/asm/kvm_book3s_asm.h
> > @@ -111,6 +111,8 @@ struct kvmppc_host_state {
> >  	struct kvm_vcpu *kvm_vcpu;
> >  	struct kvmppc_vcore *kvm_vcore;
> >  	void __iomem *xics_phys;
> > +	void __iomem *xive_tm_area_phys;
> > +	void __iomem *xive_tm_area_virt;
> 
> Does this cause the paca to become a cacheline larger?  (Not that
> there is much alternative to having these fields.)

It does, though as you said, there's little I can do here.

 .../...

> >  
> > +/* QW0 and QW1 of a context */
> > +union xive_qw01 {
> > +	struct {
> > +		u8	nsr;
> > +		u8	cppr;
> > +		u8	ipb;
> > +		u8	lsmfb;
> > +		u8	ack;
> > +		u8	inc;
> > +		u8	age;
> > +		u8	pipr;
> > +	};
> > +	__be64 qw;
> > +};
> 
> This is slightly confusing because a "QW" (quadword) would normally
> be 128 bits, but this union is 64 bits.

It's me being wrong. It's not QW0 and QW1, it's word 0 and 1 of the QW.

Word 2 is used for setting up the CAM and Word 3 is unused. I'll fixup
the naming.

> > 
> > +extern int kvmppc_xive_set_xive(struct kvm *kvm, u32 irq, u32
> > server,
> > +				u32 priority);
> > +extern int kvmppc_xive_get_xive(struct kvm *kvm, u32 irq, u32
> > *server,
> > +				u32 *priority);
> 
> Might be worth a comment here to explain that the first xive is
> eXternal Interrupt Virtualization Engine and the second xive is
> eXternal Interrupt Vector Entry.

Haha, indeed ;-) I'll add something.

> >  
> > +static inline void kvmppc_set_xive_tm_area_phys(int cpu, unsigned
> > long addr)
> > +{}
> 
> Shouldn't this be kvmppc_set_xive_tm_area to match the other
> definition?

Yup. Bit-rot from earlier versions of the patch that only had "phys"
(real mode only).

> > --- a/arch/powerpc/include/asm/xive.h
> > +++ b/arch/powerpc/include/asm/xive.h
> > @@ -55,7 +55,8 @@ struct xive_q {
> >  #define XIVE_ESB_SET_PQ_01	0xd00
> >  #define XIVE_ESB_SET_PQ_10	0xe00
> >  #define XIVE_ESB_SET_PQ_11	0xf00
> > -#define XIVE_ESB_MASK		XIVE_ESB_SET_PQ_01
> > +#define XIVE_ESB_SOFT_MASK	XIVE_ESB_SET_PQ_10
> > +#define XIVE_ESB_HARD_MASK	XIVE_ESB_SET_PQ_01
> 
> What's the difference between a "soft" mask and a "hard" mask?

I'll document, though I may not use the "aliases" anymore if it's
just confusing.  (Basically soft mask will remember in Q if
something happens while masked, hard mask will not).

> >  
> > -	kvmppc_xics_set_mapped(kvm, guest_gsi, desc-
> > >irq_data.hwirq);
> > +	if (xive_enabled())
> > +		rc = kvmppc_xive_set_mapped(kvm, guest_gsi, desc);
> > +	else
> > +		kvmppc_xics_set_mapped(kvm, guest_gsi, desc-
> > >irq_data.hwirq);
> > +	printk("set mapped for IRQ %d -> %d returned %d\n",
> > +	       host_irq, guest_gsi, rc);
> 
> This seems like a debugging thing that should be removed or turned
> into a DBG().

Yup, forgot about it.

@@ -398,6 +422,9 @@ static long kvmppc_read_one_intr(bool *again)
> >  	u8 host_ipi;
> >  	int64_t rc;
> >  
> > +	if (xive_enabled())
> > +		return 1;
> 
> Why not do this in kvmppc_read_intr() rather than here?

Dunno, probably missed that loop. I'll change it

> > paca */
> > +#ifdef CONFIG_KVM_XICS
> > +	/* We are exiting, pull the VP from the XIVE */
> > +	lwz	r0, VCPU_XIVE_PUSHED(r9)
> > +	cmpwi	cr0, r0, 0
> > +	beq	1f
> > +	li	r7, TM_SPC_PULL_OS_CTX
> > +	li	r6, TM_QW1_OS
> > +	mfmsr	r0
> > +	andi.	r0, r0, MSR_IR		/* in real
> > mode? */
> > +	beq	2f
> > +	ld	r10, HSTATE_XIVE_TM_AREA_VIRT(r13)
> > +	cmpldi	cr0, r10, 0
> > +	beq	1f
> > +	lwzx	r11, r7, r10
> > +	eieio
> > +	ldx	r11, r6, r10
> 
> I assume you meant to do these two loads into the same target
> register, but I don't know why, so a comment would be useful.

Right. We don't care about the result of the first one. It's
the special side-effect load to perform the pull. It doesn't
return useful info (the spec isn't clear there, so I should
document it). Once we have pulled, the TM OS area is frozen
so I can do a 64-bit load to get W0 and W1 & back them up.
 
> > +	b	3f
> > +2:	ld	r10, HSTATE_XIVE_TM_AREA_PHYS(r13)
> > +	cmpldi	cr0, r10, 0
> > +	beq	1f
> > +	lwzcix	r11, r7, r10
> > +	eieio
> > +	ldcix	r11, r6, r10
> > +3:	std	r11, VCPU_XIVE_SAVED_STATE(r9)
> > +	/* Fixup some of the state for the next load */
> > +	li	r10, 0
> > +	li	r0, 0xff
> > +	stw	r10, VCPU_XIVE_PUSHED(r9)
> > +	stb	r10, (VCPU_XIVE_SAVED_STATE+3)(r9)
> > +	stb	r0, (VCPU_XIVE_SAVED_STATE+4)(r9)
> > +1:
> > +#endif /* CONFIG_KVM_XICS */
> >  	/* Save more register state  */
> >  	mfdar	r6
> >  	mfdsisr	r7
> > @@ -2035,7 +2086,7 @@ hcall_real_table:
> >  	.long	DOTSYM(kvmppc_rm_h_eoi) - hcall_real_table
> >  	.long	DOTSYM(kvmppc_rm_h_cppr) - hcall_real_table
> >  	.long	DOTSYM(kvmppc_rm_h_ipi) - hcall_real_table
> > -	.long	0		/* 0x70 - H_IPOLL */
> > +	.long	DOTSYM(kvmppc_rm_h_ipoll) - hcall_real_table
> >  	.long	DOTSYM(kvmppc_rm_h_xirr) - hcall_real_table
> >  #else
> >  	.long	0		/* 0x64 - H_EOI */
> > @@ -2205,7 +2256,11 @@ hcall_real_table:
> >  	.long	0		/* 0x2f0 */
> >  	.long	0		/* 0x2f4 */
> >  	.long	0		/* 0x2f8 */
> > -	.long	0		/* 0x2fc */
> > +#ifdef CONFIG_KVM_XICS
> > +	.long	DOTSYM(kvmppc_rm_h_xirr_x) - hcall_real_table
> > +#else
> > +	.long	0		/* 0x2fc - H_XIRR_X*/
> > +#endif
> >  	.long	DOTSYM(kvmppc_h_random) - hcall_real_table
> >  	.globl	hcall_real_table_end
> >  hcall_real_table_end:
> > @@ -2980,6 +3035,7 @@ kvmppc_fix_pmao:
> >  	isync
> >  	blr
> >  
> > +
> 
> Gratuitous extra blank line.

Isn't it pretty ? :-)

> > 
> > +	/* Allocate the queue and retrieve infos on current node
> > for now */
> > +	qpage = (__be32 *)__get_free_pages(GFP_KERNEL, xive-
> > >q_alloc_order);
> 
> Possibly q_page_order would be a better name than q_alloc_order.

Maybe ... I'll add a comment too.

The rest of your comments don't need a reply :)

I'll respin.

Cheers,
Ben.
