Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 904D367A3F
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Jun 2006 08:06:29 +1000 (EST)
Subject: RE: [PATCH/2.6.17-rc4 4/10]Powerpc:  Add tsi108 pic support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexandre Bounine <Alexandre.Bounine@tundra.com>
In-Reply-To: <8A1F97E8A7ACE847B1DB69DFDCBC6E807D633A@caribou.pc.tundra.com>
References: <8A1F97E8A7ACE847B1DB69DFDCBC6E807D633A@caribou.pc.tundra.com>
Content-Type: text/plain
Date: Fri, 02 Jun 2006 08:06:17 +1000
Message-Id: <1149199577.16202.14.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-06-01 at 16:45 -0400, Alexandre Bounine wrote:
> All differences in the Tsi108/109 PIC code from the standard MPIC are caused by the HW behavior. The Tsi108/109 PIC looks like standard OpenPIC but, in fact, is different in registers mapping and behavior. Its logic is close but not exactly as MPIC.  
> 
> Here are replies on comments to the code:
> 
> 1.Why do you have to check if its a LEVEL irq?
> 
> Check for LEVEL irqs is required in the ack/end pair to enable nested interrupt servicing and
> does not hang when core (local) interrupts are re-enabled in the ISR. Otherwise we have to use 
> SA_INTERRUPT flag for all level signaled interrupts.

Can you be more precise about what exactly happens and why ? Unless you
EOI handling is broken of course, there should be no need to do anything
other than a single eoi in end(), period.

> 2. if the PIC works like other openpic's you dont need an 'ack' we  
> handle it via 'end'
> 
> Tsi108/109 needs it.

What for ? Please, give the low level details.

> 3. why the changes to where we do mpic_eoi for TSI108?
> The Tsi108 PIC requires EOI for spurious interrupt (as all other interrupt sources).

Ok, that is acceptable.

> The do_IRQ() does not call end routine for spurious interrupts.  
> 
> The MPIC code patch for Tsi108/109 demonstrates HW differences and why we originally considered having separate code for Tsi108 pic.

Please tell me more about the HW differences :)

Ben.
 
> 
> 
> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Tuesday, May 30, 2006 3:18 PM
> To: Zang Roy-r61911
> Cc: Benjamin Herrenschmidt; linuxppc-dev list; Yang Xin-Xin-r48390; Paul
> Mackerras; Alexandre Bounine
> Subject: Re: [PATCH/2.6.17-rc4 4/10]Powerpc: Add tsi108 pic support
> 
> 
> 
> On May 29, 2006, at 10:28 PM, Zang Roy-r61911 wrote:
> 
> >>
> >> On Wed, 2006-05-17 at 18:14 +0800, Zang Roy-r61911 wrote:
> >>> Add Tundra Semiconductor tsi108 host bridge interrupt
> >> controller support.
> >>
> >> It looks a bit like an hacked up MPIC... Is it different
> >> enough to justify a separate driver ? Or would it be possible
> >> to define a TSI108 flag to pass the current mpic driver and
> >> add the necessary bits to it ?
> >>
> >
> > Tsi108 implementation of MPIC has many differences form the  
> > original one,  the following
> > code implements it with mpic. Any comment? The following patch is  
> > just based on
> > my previous send out patches.
> 
> In the future please provide it against the base, much easier to read.
> 
> > Integrate Tundra Semiconductor tsi108 host bridge interrupt controller
> > to mpic arch.
> >
> > Signed-off-by: Alexandre Bounine <alexandreb@tundra.com>
> >
> 
> [snip]
> 
> >
> > --- linux-2.6.17-rc4-tun/arch/powerpc/sysdev/mpic.c	2006-03-20  
> > 00:53:29.000000000 -0500
> > +++ linux-2.6.17-rc4-hpc2/arch/powerpc/sysdev/mpic.c	2006-05-29  
> > 16:07:03.000000000 -0400
> > @@ -81,7 +81,7 @@ static inline void _mpic_write(unsigned
> >  static inline u32 _mpic_ipi_read(struct mpic *mpic, unsigned int ipi)
> >  {
> >  	unsigned int be = (mpic->flags & MPIC_BIG_ENDIAN) != 0;
> > -	unsigned int offset = MPIC_GREG_IPI_VECTOR_PRI_0 + (ipi * 0x10);
> > +	unsigned int offset = MPIC_GREG_IPI_VECTOR_PRI_0 + (ipi *  
> > MPIC_GREG_IPI_STRIDE);
> >
> >  	if (mpic->flags & MPIC_BROKEN_IPI)
> >  		be = !be;
> > @@ -90,7 +90,7 @@ static inline u32 _mpic_ipi_read(struct
> >
> >  static inline void _mpic_ipi_write(struct mpic *mpic, unsigned int  
> > ipi, u32 value)
> >  {
> > -	unsigned int offset = MPIC_GREG_IPI_VECTOR_PRI_0 + (ipi * 0x10);
> > +	unsigned int offset = MPIC_GREG_IPI_VECTOR_PRI_0 + (ipi *  
> > MPIC_GREG_IPI_STRIDE);
> >
> >  	_mpic_write(mpic->flags & MPIC_BIG_ENDIAN, mpic->gregs, offset,  
> > value);
> >  }
> > @@ -393,7 +393,11 @@ static inline struct mpic * mpic_from_ir
> >  static inline void mpic_eoi(struct mpic *mpic)
> >  {
> >  	mpic_cpu_write(MPIC_CPU_EOI, 0);
> > +#ifndef CONFIG_TSI108_BRIDGE
> >  	(void)mpic_cpu_read(MPIC_CPU_WHOAMI);
> > +#else
> > +	(void)mpic_cpu_read(MPIC_CPU_OUTPUT);
> > +#endif
> >  }
> >
> >  #ifdef CONFIG_SMP
> > @@ -514,9 +518,26 @@ static void mpic_end_irq(unsigned int ir
> >  	}
> >  #endif /* CONFIG_MPIC_BROKEN_U3 */
> >
> > +#ifdef CONFIG_TSI108_BRIDGE
> > +	if ((irq_desc[irq].status & IRQ_LEVEL) != 0)
> > +#endif
> 
> Why do you have to check if its a LEVEL irq?
> 
> >  	mpic_eoi(mpic);
> >  }
> >
> > +#ifdef CONFIG_TSI108_BRIDGE
> > +static void mpic_ack_irq(unsigned int irq)
> > +{
> > +	struct mpic *mpic = mpic_from_irq(irq);
> > +
> > +#ifdef DEBUG_IRQ
> > +	DBG("%s: ack_irq: %d\n", mpic->name, irq);
> > +#endif
> > +
> > +	if ((irq_desc[irq].status & IRQ_LEVEL) == 0)
> > +		mpic_eoi(mpic);
> > +}
> > +#endif /* CONFIG_TSI108_BRIDGE */
> > +
> 
> if the PIC works like other openpic's you dont need an 'ack' we  
> handle it via 'end'
> 
> >  #ifdef CONFIG_SMP
> >
> >  static void mpic_enable_ipi(unsigned int irq)
> > @@ -596,6 +617,9 @@ struct mpic * __init mpic_alloc(unsigned
> >  	mpic->hc_irq.enable = mpic_enable_irq;
> >  	mpic->hc_irq.disable = mpic_disable_irq;
> >  	mpic->hc_irq.end = mpic_end_irq;
> > +#ifdef CONFIG_TSI108_BRIDGE
> > +	mpic->hc_irq.ack = mpic_ack_irq;
> > +#endif
> >  	if (flags & MPIC_PRIMARY)
> >  		mpic->hc_irq.set_affinity = mpic_set_affinity;
> >  #ifdef CONFIG_SMP
> > @@ -955,8 +979,13 @@ void mpic_send_ipi(unsigned int ipi_no,
> >  	DBG("%s: send_ipi(ipi_no: %d)\n", mpic->name, ipi_no);
> >  #endif
> >
> > +#ifndef CONFIG_TSI108_BRIDGE
> >  	mpic_cpu_write(MPIC_CPU_IPI_DISPATCH_0 + ipi_no * 0x10,
> >  		       mpic_physmask(cpu_mask & cpus_addr(cpu_online_map)[0]));
> > +#else /* CONFIG_TSI108_BRIDGE */
> > +	mpic_write(mpic->gregs, MPIC_CPU_IPI_DISPATCH,
> > +		       mpic_physmask(cpu_mask & cpus_addr(cpu_online_map)[0]));
> > +#endif /* !CONFIG_TSI108_BRIDGE */
> >  }
> >
> >  int mpic_get_one_irq(struct mpic *mpic, struct pt_regs *regs)
> > @@ -972,11 +1001,20 @@ int mpic_get_one_irq(struct mpic *mpic,
> >  		DBG("%s: cascading ...\n", mpic->name);
> >  #endif
> >  		irq = mpic->cascade(regs, mpic->cascade_data);
> > +#ifdef DEBUG_LOW
> > +		DBG("%s: cascaded irq: %d\n", mpic->name, irq);
> > +#endif
> > +#ifndef CONFIG_TSI108_BRIDGE
> >  		mpic_eoi(mpic);
> > +#endif
> >  		return irq;
> >  	}
> > -	if (unlikely(irq == MPIC_VEC_SPURRIOUS))
> > +	if (unlikely(irq == MPIC_VEC_SPURRIOUS)) {
> > +#ifdef CONFIG_TSI108_BRIDGE
> > +		mpic_eoi(mpic);
> > +#endif
> >  		return -1;
> > +	}
> 
> why the changes to where we do mpic_eoi for TSI108?
> 
> >  	if (irq < MPIC_VEC_IPI_0) {
> >  #ifdef DEBUG_IRQ
> >  		DBG("%s: irq %d\n", mpic->name, irq + mpic->irq_offset);
> 
> 
> 
> [snip]
