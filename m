Return-Path: <B16395@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 83EB82C0086
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2012 19:26:43 +1000 (EST)
From: Sethi Varun-B16395 <B16395@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH 3/3 v2] powerpc/mpic: FSL MPIC error interrupt support.
Date: Tue, 10 Jul 2012 09:26:35 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D139BFF@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1341823643-15737-1-git-send-email-Varun.Sethi@freescale.com>
 <62D13F27-5E39-450E-953D-102DCA32AA9D@kernel.crashing.org>
In-Reply-To: <62D13F27-5E39-450E-953D-102DCA32AA9D@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Hamciuc Bogdan-BHAMCIU1 <bhamciu1@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



>=20
> > +	u32 eisr, eimr;
> > +	int errint;
> > +	unsigned int cascade_irq;
> > +
> > +	eisr =3D fsl_mpic_err_read(mpic->err_regs, eisr_offset);
> > +	eimr =3D fsl_mpic_err_read(mpic->err_regs, eimr_offset);
> > +
> > +	if (!(eisr & ~eimr))
> > +		return IRQ_NONE;
> > +
> > +	while (eisr) {
> > +		errint =3D __builtin_clz(eisr);
> > +		cascade_irq =3D irq_linear_revmap(mpic->irqhost,
> > +				 mpic->err_int_vecs[errint]);
> > +		WARN_ON(cascade_irq =3D=3D NO_IRQ);
> > +		if (cascade_irq !=3D NO_IRQ) {
> > +			generic_handle_irq(cascade_irq);
> > +		} else {
> > +			eimr |=3D  1 << (31 - errint);
> > +			fsl_mpic_err_write(mpic->err_regs, eimr_offset, eimr);
> > +		}
> > +		eisr &=3D ~(1 << (31 - errint));
> > +	}
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +int mpic_err_int_init(struct mpic *mpic, irq_hw_number_t irqnum) {
>=20
> Why can't we do this during mpic_init() time?
>=20
[Sethi Varun-B16395] Don't want to hard code the error interrupt number.

> > +	unsigned int virq;
> > +	unsigned int offset =3D MPIC_ERR_INT_EIMR;
>=20
> remove offset, just use MPIC_ERR_INT_EIMR in mpic_err_write
>=20
> > +	int ret;
> > +
> > +	virq =3D irq_create_mapping(mpic->irqhost, irqnum);
> > +	if (virq =3D=3D NO_IRQ) {
> > +		pr_err("Error interrupt setup failed\n");
> > +		return -ENOSPC;
> > +	}
> > +
> > +	fsl_mpic_err_write(mpic->err_regs, offset, ~0);
>=20
> Add a comment about what this line is doing
>
[Sethi Varun-B16395] We are masking all the error interrupts here. I
Will add a comment for this.
=20
> > +
> > +	ret =3D request_irq(virq, fsl_error_int_handler, IRQF_NO_THREAD,
> > +		    "mpic-error-int", mpic);
>=20
> Hmm, should we be using irq_set_chained_handler() instead of request_irq
>=20
> > +	if (ret) {
> > +		pr_err("Failed to register error interrupt handler\n");
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> > index 61c7225..7002ef3 100644
> > --- a/arch/powerpc/sysdev/mpic.c
> > +++ b/arch/powerpc/sysdev/mpic.c
> > @@ -1026,6 +1026,9 @@ static int mpic_host_map(struct irq_domain *h,
> unsigned int virq,
> > 		return 0;
> > 	}
> >
> > +	if (mpic_map_error_int(mpic, virq, hw))
> > +		return 0;
> > +
> > 	if (hw >=3D mpic->num_sources)
> > 		return -EINVAL;
> >
> > @@ -1085,7 +1088,24 @@ static int mpic_host_xlate(struct irq_domain *h,
> struct device_node *ct,
> > 		 */
> > 		switch (intspec[2]) {
> > 		case 0:
> > -		case 1: /* no EISR/EIMR support for now, treat as shared IRQ
> */
> > +			break;
> > +		case 1:
> > +			if (!(mpic->flags & MPIC_FSL_HAS_EIMR))
> > +				break;
> > +
> > +			if (intspec[3] >=3D ARRAY_SIZE(mpic->err_int_vecs))
> > +				return -EINVAL;
> > +
> > +			if (!mpic->err_int_config_done) {
> > +				int ret;
> > +				ret =3D mpic_err_int_init(mpic, intspec[0]);
> > +				if (ret)
> > +					return ret;
> > +				mpic->err_int_config_done =3D 1;
> > +			}
> > +
> > +			*out_hwirq =3D mpic->err_int_vecs[intspec[3]];
> > +
> > 			break;
> > 		case 2:
> > 			if (intspec[0] >=3D ARRAY_SIZE(mpic->ipi_vecs)) @@ -
> 1302,6 +1322,8 @@
> > struct mpic * __init mpic_alloc(struct device_node *node,
> > 	mpic_map(mpic, mpic->paddr, &mpic->tmregs, MPIC_INFO(TIMER_BASE),
> > 0x1000);
> >
> > 	if (mpic->flags & MPIC_FSL) {
> > +		u32 brr1, version;
> > +
> > 		/*
> > 		 * Yes, Freescale really did put global registers in the
> > 		 * magic per-cpu area -- and they don't even show up in the
> @@
> > -1309,6 +1331,17 @@ struct mpic * __init mpic_alloc(struct device_node
> *node,
> > 		 */
> > 		mpic_map(mpic, mpic->paddr, &mpic->thiscpuregs,
> > 			 MPIC_CPU_THISBASE, 0x1000);
> > +
> > +		brr1 =3D _mpic_read(mpic->reg_type, &mpic->thiscpuregs,
> > +				MPIC_FSL_BRR1);
> > +		version =3D brr1 & MPIC_FSL_BRR1_VER;
> > +
> > +		/* Error interrupt mask register (EIMR) is required for
> > +		 * handling individual device error interrupts. EIMR
> > +		 * was added in MPIC version 4.1.
> > +		 */
> > +		if (version >=3D 0x401)
> > +			mpic_setup_error_int(mpic, intvec_top - 12);
>=20
> Would really like not to have this magic 12, but a comment would be nice
> if we keep it where the 12 comes from
>
[Sethi Varun-B16395]Obtaining vector numbers beyond ipi and timers for the =
error interrupts.=20
Will add a comment.

-Varun
