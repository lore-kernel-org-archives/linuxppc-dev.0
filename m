Return-Path: <Alexandre.Bounine@tundra.com>
Received: from atanerk.tundra.com (sentry.tundra.com [142.46.200.189])
	by ozlabs.org (Postfix) with ESMTP id ABA7867B3F
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jun 2006 04:58:47 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: [PATCH/2.6.17-rc4 4/10]Powerpc:  Add tsi108 pic support
Date: Tue, 6 Jun 2006 14:58:44 -0400
Message-ID: <8A1F97E8A7ACE847B1DB69DFDCBC6E807D6352@caribou.pc.tundra.com>
From: "Alexandre Bounine" <Alexandre.Bounine@tundra.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
	"Zang Roy-r61911" <tie-fei.zang@freescale.com>
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

I forgot to mention another argument in favor of adding separate =
MPIC_SPV_EOI and MPIC_CASC_NOEOI flags:

If we have MPIC with "broken" logic but standard register map we can use =
model ID =3D 0 for
the standard MPIC without creating additional data structure.

Regards,

Alex.

-----Original Message-----
From: Alexandre Bounine=20
Sent: Tuesday, June 06, 2006 10:46 AM
To: 'Benjamin Herrenschmidt'; Zang Roy-r61911
Cc: Kumar Gala; linuxppc-dev list; Yang Xin-Xin-r48390; Paul Mackerras
Subject: RE: [PATCH/2.6.17-rc4 4/10]Powerpc: Add tsi108 pic support

> -----Original Message-----
> From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org]
> Sent: Tuesday, June 06, 2006 6:17 AM
> To: Zang Roy-r61911
> Cc: Alexandre Bounine; Kumar Gala; linuxppc-dev list; Yang
> Xin-Xin-r48390; Paul Mackerras
> Subject: RE: [PATCH/2.6.17-rc4 4/10]Powerpc: Add tsi108 pic support
>=20
>=20
> On Tue, 2006-06-06 at 17:43 +0800, Zang Roy-r61911 wrote:
>=20
> > Update Tsi108 implementation of MPIC.
> > Any comment?=20
> >=20
> > Integrate Tundra Semiconductor tsi108 host bridge interrupt=20
> controller=20
> > to mpic arch.
>=20
> Looks much better :) Still a few things...=20
>

Sounds good. We are moving in right direction :)
=20
> > +	mpic =3D mpic_alloc(mpic_paddr,
> > +			MPIC_PRIMARY | MPIC_BIG_ENDIAN |=20
> MPIC_WANTS_RESET |
> > +			MPIC_SPV_EOI | MPIC_CASC_NOEOI |=20
> > +			MPIC_MOD_ID(MPIC_ID_TSI108),
> > +			0, /* num_sources used */
> > +			TSI108_IRQ_BASE,
> > +			0, /* num_sources used */
> > +			NR_IRQS - 4 /* XXXX */,
> > +			mpc7448_hpc2_pic_initsenses,
> > +			sizeof(mpc7448_hpc2_pic_initsenses),=20
> "Tsi108_PIC");
>=20
> That's a hell lot of new flags... I'm not sure we need that many or a
> single TSI108 one that encloses all the new ones. Also, I'm=20
> not sure we
> need that model ID encoding thing. Let's do things simple, besides, I
> don't want to encourage HW folks into doing the same kind of=20
> contraption
> in the future

More details in comments below.

>(btw, tell the TSI folks for me that they had a BAD BAD
> BAD idea to muck around with the base design that way, especially
> changing the register map in incompatible ways for no good reason).
>=20

Done!

> > +	/* Configure MPIC outputs to CPU0 */
> > +	tsi108_write_reg(TSI108_MPIC_OFFSET + 0x30c, 0);
> >  }
>=20
> It doesn't use the standard multiple processor outputs mecanism of
> MPIC ?
> =20
> > +static struct mpic_info mpic_infos[] =3D {
> > +	[0] =3D {	/* Original OpenPIC compatible MPIC */
> > +	.greg_base	=3D MPIC_GREG_BASE,
> > +	.greg_frr0	=3D MPIC_GREG_FEATURE_0,
> > +	.greg_config0	=3D MPIC_GREG_GLOBAL_CONF_0,
> > +	.greg_vendor_id	=3D MPIC_GREG_VENDOR_ID,
> > +	.greg_ipi_vp0	=3D MPIC_GREG_IPI_VECTOR_PRI_0,
> > +	.greg_ipi_stride	=3D MPIC_GREG_IPI_STRIDE,
> > +	.greg_spurious	=3D MPIC_GREG_SPURIOUS,
> > +	.greg_tfrr	=3D MPIC_GREG_TIMER_FREQ,
> > +
>=20
>    .../...
>=20
> It's a bit sad to have to go all the way to doing such tables, but I
> suspect it's probably the best way to handle it at this=20
> point.

> Send more
> nastygrams to the HW folks for me.
>=20

Done:)

> >  	mpic->num_sources =3D 0; /* so far */
> >  	mpic->senses =3D senses;
> >  	mpic->senses_count =3D senses_count;
> > +	mpic->hw_set =3D &mpic_infos[MPIC_GET_MOD_ID(flags)];
>=20
> Well... the model ID thing might not be that a bad idea in=20
> the end :) I
> need to think about it. I might have to deal with yet another=20
> MPIC that
> has another regiser map (yeah yeah, TSI aren't the only ones=20
> to not get
> it)...=20
>

I'll tell this to HW guys as well :)=20

>   .../...
>=20
> > @@ -963,7 +1043,7 @@ int mpic_get_one_irq(struct mpic *mpic,=20
> >  {
> >  	u32 irq;
> > =20
> > -	irq =3D mpic_cpu_read(MPIC_CPU_INTACK) & MPIC_VECPRI_VECTOR_MASK;
> > +	irq =3D mpic_cpu_read(mpic->hw_set->cpu_intack) &=20
> mpic->hw_set->irq_vpr_vector;
> >  #ifdef DEBUG_LOW
> >  	DBG("%s: get_one_irq(): %d\n", mpic->name, irq);
> >  #endif
> > @@ -972,11 +1052,18 @@ #ifdef DEBUG_LOW
> >  		DBG("%s: cascading ...\n", mpic->name);
> >  #endif
> >  		irq =3D mpic->cascade(regs, mpic->cascade_data);
> > -		mpic_eoi(mpic);
> > +#ifdef DEBUG_LOW
> > +		DBG("%s: cascaded irq: %d\n", mpic->name, irq);
> > +#endif
> > +		if (!(mpic->flags & MPIC_CASC_NOEOI))
> > +			mpic_eoi(mpic);
> >  		return irq;
> >  	}
>=20
> Can you tell me why you need the above ? (Why you aren't EOI'ing the
> cascade ?) Note that the cascade handling is going away from=20
> mpic anyway
> with the port to genirq that I'll publish later this week for=20
> 2.6.18 and
> it will almost be handled as a normal interrupt...
>=20

We have a level-signalled irq from the cascaded PCI interrupt =
controller. If I do EOI at=20
this time, level request will not have chance to be cleared (unless all =
PCI interrupts have
an SA_INTERRUPT flag) and result in recurring interrupts.=20

I chose to have an individual flag instead of checking model ID to avoid =
multiple checks within ISR (in case if we have more that one mpic =
version requiring this option). I also expect that it may be useful for =
any external level-signalling cascades connected to MPIC.     =20

> > -	if (unlikely(irq =3D=3D MPIC_VEC_SPURRIOUS))
> > +	if (unlikely(irq =3D=3D MPIC_VEC_SPURRIOUS)) {
> > +		if (mpic->flags & MPIC_SPV_EOI)
> > +			mpic_eoi(mpic);
> >  		return -1;
> > +	}
>=20
> I think the above thing could just test the model ID. It's=20
> unlikely that
> another implementation need the same "feature", so just test the model
> ID rather than adding a flag and if we ever have another=20
> model with the
> same "feature", then we'll go back to adding a flag :)
>=20

Motivation is the same as above - I just do not want to have multiple ID =
checks here. I agree that it is driven by mpic type (model ID) only. I =
can remove this one if you do not expect any
new "broken" MPICs on horizon. =20

> Cheers,
> Ben.
>=20
Thanks for your feedback,
Alex.
>=20
>=20
