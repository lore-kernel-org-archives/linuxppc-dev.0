Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 12D7D67A5C
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Jun 2006 20:17:13 +1000 (EST)
Subject: RE: [PATCH/2.6.17-rc4 4/10]Powerpc:  Add tsi108 pic support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
In-Reply-To: <9FCDBA58F226D911B202000BDBAD4673067CD108@zch01exm40.ap.freescale.net>
References: <9FCDBA58F226D911B202000BDBAD4673067CD108@zch01exm40.ap.freescale.net>
Content-Type: text/plain
Date: Tue, 06 Jun 2006 20:17:03 +1000
Message-Id: <1149589023.27572.52.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Alexandre Bounine <Alexandre.Bounine@tundra.com>,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>,
	Paul Mackerras <paulus@samba.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-06-06 at 17:43 +0800, Zang Roy-r61911 wrote:

> Update Tsi108 implementation of MPIC.
> Any comment? 
> 
> Integrate Tundra Semiconductor tsi108 host bridge interrupt controller 
> to mpic arch.

Looks much better :) Still a few things... 

> +	mpic = mpic_alloc(mpic_paddr,
> +			MPIC_PRIMARY | MPIC_BIG_ENDIAN | MPIC_WANTS_RESET |
> +			MPIC_SPV_EOI | MPIC_CASC_NOEOI | 
> +			MPIC_MOD_ID(MPIC_ID_TSI108),
> +			0, /* num_sources used */
> +			TSI108_IRQ_BASE,
> +			0, /* num_sources used */
> +			NR_IRQS - 4 /* XXXX */,
> +			mpc7448_hpc2_pic_initsenses,
> +			sizeof(mpc7448_hpc2_pic_initsenses), "Tsi108_PIC");

That's a hell lot of new flags... I'm not sure we need that many or a
single TSI108 one that encloses all the new ones. Also, I'm not sure we
need that model ID encoding thing. Let's do things simple, besides, I
don't want to encourage HW folks into doing the same kind of contraption
in the future (btw, tell the TSI folks for me that they had a BAD BAD
BAD idea to muck around with the base design that way, especially
changing the register map in incompatible ways for no good reason).

> +	/* Configure MPIC outputs to CPU0 */
> +	tsi108_write_reg(TSI108_MPIC_OFFSET + 0x30c, 0);
>  }

It doesn't use the standard multiple processor outputs mecanism of
MPIC ?
 
> +static struct mpic_info mpic_infos[] = {
> +	[0] = {	/* Original OpenPIC compatible MPIC */
> +	.greg_base	= MPIC_GREG_BASE,
> +	.greg_frr0	= MPIC_GREG_FEATURE_0,
> +	.greg_config0	= MPIC_GREG_GLOBAL_CONF_0,
> +	.greg_vendor_id	= MPIC_GREG_VENDOR_ID,
> +	.greg_ipi_vp0	= MPIC_GREG_IPI_VECTOR_PRI_0,
> +	.greg_ipi_stride	= MPIC_GREG_IPI_STRIDE,
> +	.greg_spurious	= MPIC_GREG_SPURIOUS,
> +	.greg_tfrr	= MPIC_GREG_TIMER_FREQ,
> +

   .../...

It's a bit sad to have to go all the way to doing such tables, but I
suspect it's probably the best way to handle it at this point. Send more
nastygrams to the HW folks for me.

>  	mpic->num_sources = 0; /* so far */
>  	mpic->senses = senses;
>  	mpic->senses_count = senses_count;
> +	mpic->hw_set = &mpic_infos[MPIC_GET_MOD_ID(flags)];

Well... the model ID thing might not be that a bad idea in the end :) I
need to think about it. I might have to deal with yet another MPIC that
has another regiser map (yeah yeah, TSI aren't the only ones to not get
it)... 

  .../...

> @@ -963,7 +1043,7 @@ int mpic_get_one_irq(struct mpic *mpic, 
>  {
>  	u32 irq;
>  
> -	irq = mpic_cpu_read(MPIC_CPU_INTACK) & MPIC_VECPRI_VECTOR_MASK;
> +	irq = mpic_cpu_read(mpic->hw_set->cpu_intack) & mpic->hw_set->irq_vpr_vector;
>  #ifdef DEBUG_LOW
>  	DBG("%s: get_one_irq(): %d\n", mpic->name, irq);
>  #endif
> @@ -972,11 +1052,18 @@ #ifdef DEBUG_LOW
>  		DBG("%s: cascading ...\n", mpic->name);
>  #endif
>  		irq = mpic->cascade(regs, mpic->cascade_data);
> -		mpic_eoi(mpic);
> +#ifdef DEBUG_LOW
> +		DBG("%s: cascaded irq: %d\n", mpic->name, irq);
> +#endif
> +		if (!(mpic->flags & MPIC_CASC_NOEOI))
> +			mpic_eoi(mpic);
>  		return irq;
>  	}

Can you tell me why you need the above ? (Why you aren't EOI'ing the
cascade ?) Note that the cascade handling is going away from mpic anyway
with the port to genirq that I'll publish later this week for 2.6.18 and
it will almost be handled as a normal interrupt...

> -	if (unlikely(irq == MPIC_VEC_SPURRIOUS))
> +	if (unlikely(irq == MPIC_VEC_SPURRIOUS)) {
> +		if (mpic->flags & MPIC_SPV_EOI)
> +			mpic_eoi(mpic);
>  		return -1;
> +	}

I think the above thing could just test the model ID. It's unlikely that
another implementation need the same "feature", so just test the model
ID rather than adding a flag and if we ever have another model with the
same "feature", then we'll go back to adding a flag :)

Cheers,
Ben.
