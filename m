Return-Path: <B16395@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe010.messaging.microsoft.com [216.32.180.30])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AC34B2C007D
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Aug 2012 04:52:33 +1000 (EST)
From: Sethi Varun-B16395 <B16395@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH 3/3 v3] powerpc/mpic: FSL MPIC error interrupt support.
Date: Fri, 3 Aug 2012 18:52:17 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D15AAB5@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1343745764-3788-1-git-send-email-Varun.Sethi@freescale.com>
 <609EA81E-EC64-4539-B36B-E57525CE2492@kernel.crashing.org>
In-Reply-To: <609EA81E-EC64-4539-B36B-E57525CE2492@kernel.crashing.org>
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



> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Friday, August 03, 2012 6:49 PM
> To: Sethi Varun-B16395
> Cc: linuxppc-dev@lists.ozlabs.org; Hamciuc Bogdan-BHAMCIU1
> Subject: Re: [PATCH 3/3 v3] powerpc/mpic: FSL MPIC error interrupt
> support.
>=20
>=20
> On Jul 31, 2012, at 9:42 AM, Varun Sethi wrote:
>=20
> > All SOC device error interrupts are muxed and delivered to the core as
> > a single MPIC error interrupt. Currently all the device drivers
> > requiring access to device errors have to register for the MPIC error
> interrupt as a shared interrupt.
> >
> > With this patch we add interrupt demuxing capability in the mpic
> > driver, allowing device drivers to register for their individual error
> > interrupts. This is achieved by handling error interrupts in a cascaded
> fashion.
> >
> > MPIC error interrupt is handled by the "error_int_handler", which
> > subsequently demuxes it using the EISR and delivers it to the
> respective drivers.
> >
> > The error interrupt capability is dependent on the MPIC EIMR register,
> > which was introduced in FSL MPIC version 4.1 (P4080 rev2). So, error
> > interrupt demuxing capability is dependent on the MPIC version and can
> be used for versions >=3D 4.1.
> >
> > Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
> > Signed-off-by: Bogdan Hamciuc <bogdan.hamciuc@freescale.com> [In the
> > initial version of the patch we were using handle_simple_irq as the
> > handler for cascaded error interrupts, this resulted in issues in case
> > of threaded isrs (with RT kernel). This issue was debugged by Bogdan
> > and decision was taken to use the handle_level_irq handler]
>=20
> [ fix commit message to wrap at 75 char columns ]
>=20
> >
> > ---
> > arch/powerpc/include/asm/mpic.h    |   13 +++
> > arch/powerpc/sysdev/Makefile       |    2 +-
> > arch/powerpc/sysdev/fsl_mpic_err.c |  152
> ++++++++++++++++++++++++++++++++++++
> > arch/powerpc/sysdev/mpic.c         |   41 ++++++++++-
> > arch/powerpc/sysdev/mpic.h         |   22 +++++
> > 5 files changed, 228 insertions(+), 2 deletions(-) create mode 100644
> > arch/powerpc/sysdev/fsl_mpic_err.c
> >
> > diff --git a/arch/powerpc/include/asm/mpic.h
> > b/arch/powerpc/include/asm/mpic.h index e14d35d..5cc8000 100644
> > --- a/arch/powerpc/include/asm/mpic.h
> > +++ b/arch/powerpc/include/asm/mpic.h
> > @@ -118,6 +118,9 @@
> > #define MPIC_MAX_CPUS		32
> > #define MPIC_MAX_ISU		32
> >
> > +#define MPIC_MAX_ERR      32
> > +#define MPIC_FSL_ERR_INT  16
> > +
> > /*
> > * Tsi108 implementation of MPIC has many differences from the original
> > one */ @@ -270,6 +273,7 @@ struct mpic
> > 	struct irq_chip		hc_ipi;
> > #endif
> > 	struct irq_chip		hc_tm;
> > +	struct irq_chip		hc_err;
> > 	const char		*name;
> > 	/* Flags */
> > 	unsigned int		flags;
> > @@ -283,6 +287,8 @@ struct mpic
> > 	/* vector numbers used for internal sources (ipi/timers) */
> > 	unsigned int		ipi_vecs[4];
> > 	unsigned int		timer_vecs[8];
> > +	/* vector numbers used for FSL MPIC error interrupts */
> > +	unsigned int		err_int_vecs[MPIC_MAX_ERR];
> >
> > 	/* Spurious vector to program into unused sources */
> > 	unsigned int		spurious_vec;
> > @@ -306,6 +312,11 @@ struct mpic
> > 	struct mpic_reg_bank	cpuregs[MPIC_MAX_CPUS];
> > 	struct mpic_reg_bank	isus[MPIC_MAX_ISU];
> >
> > +	/* ioremap'ed base for error interrupt registers */
> > +	u32 __iomem	*err_regs;
> > +	/* error interrupt config */
> > +	u32			err_int_config_done;
> > +
>=20
> Is this really needed ?
[Sethi Varun-B16395] check for verifying if mpic_err_int_init was successfu=
l or not.

>=20
> > 	/* Protected sources */
> > 	unsigned long		*protected;
> >
> > @@ -370,6 +381,8 @@ struct mpic
> > #define MPIC_NO_RESET			0x00004000
> > /* Freescale MPIC (compatible includes "fsl,mpic") */
> > #define MPIC_FSL			0x00008000
> > +/* Freescale MPIC supports EIMR (error interrupt mask register)*/
> > +#define MPIC_FSL_HAS_EIMR		0x00010000
>=20
> Can't we use BRR for this?
[Sethi Varun-B16395] This flag is set based on the BRR check. This is check=
ed at various places.

>=20
> >
> > /* MPIC HW modification ID */
> > #define MPIC_REGSET_MASK		0xf0000000
> > diff --git a/arch/powerpc/sysdev/Makefile
> > b/arch/powerpc/sysdev/Makefile index 1bd7ecb..a57600b 100644
> > --- a/arch/powerpc/sysdev/Makefile
> > +++ b/arch/powerpc/sysdev/Makefile
> > @@ -15,7 +15,7 @@ obj-$(CONFIG_PPC_DCR_NATIVE)	+=3D dcr-low.o
> > obj-$(CONFIG_PPC_PMI)		+=3D pmi.o
> > obj-$(CONFIG_U3_DART)		+=3D dart_iommu.o
> > obj-$(CONFIG_MMIO_NVRAM)	+=3D mmio_nvram.o
> > -obj-$(CONFIG_FSL_SOC)		+=3D fsl_soc.o
> > +obj-$(CONFIG_FSL_SOC)		+=3D fsl_soc.o fsl_mpic_err.o
> > obj-$(CONFIG_FSL_PCI)		+=3D fsl_pci.o $(fsl-msi-obj-y)
> > obj-$(CONFIG_FSL_PMC)		+=3D fsl_pmc.o
> > obj-$(CONFIG_FSL_LBC)		+=3D fsl_lbc.o
> > diff --git a/arch/powerpc/sysdev/fsl_mpic_err.c
> > b/arch/powerpc/sysdev/fsl_mpic_err.c
> > new file mode 100644
> > index 0000000..1ebfa36
> > --- /dev/null
> > +++ b/arch/powerpc/sysdev/fsl_mpic_err.c
> > @@ -0,0 +1,152 @@
> > +/*
> > + * Copyright (C) 2012 Freescale Semiconductor, Inc.
> > + *
> > + * Author: Varun Sethi <varun.sethi@freescale.com>
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License
> > + * as published by the Free Software Foundation; version 2 of the
> > + * License.
> > + *
> > + */
> > +
> > +#include <linux/irq.h>
> > +#include <linux/smp.h>
> > +#include <linux/interrupt.h>
> > +
> > +#include <asm/io.h>
> > +#include <asm/irq.h>
> > +#include <asm/mpic.h>
> > +
> > +#include "mpic.h"
> > +
> > +#define MPIC_ERR_INT_BASE	0x3900
> > +#define MPIC_ERR_INT_EISR	0x0000
> > +#define MPIC_ERR_INT_EIMR	0x0010
> > +
> > +static inline u32 mpic_fsl_err_read(u32 __iomem *base, unsigned int
> > +err_reg) {
> > +	return in_be32(base + (err_reg >> 2)); }
> > +
> > +static inline void mpic_fsl_err_write(u32 __iomem *base, u32 value) {
> > +	out_be32(base + (MPIC_ERR_INT_EIMR >> 2), value); }
> > +
> > +static void fsl_mpic_mask_err(struct irq_data *d) {
> > +	u32 eimr;
> > +	struct mpic *mpic =3D irq_data_get_irq_chip_data(d);
> > +	unsigned int src =3D virq_to_hw(d->irq) - mpic->err_int_vecs[0];
> > +
> > +	eimr =3D mpic_fsl_err_read(mpic->err_regs, MPIC_ERR_INT_EIMR);
> > +	eimr |=3D (1 << (31 - src));
> > +	mpic_fsl_err_write(mpic->err_regs, eimr); }
> > +
> > +static void fsl_mpic_unmask_err(struct irq_data *d) {
> > +	u32 eimr;
> > +	struct mpic *mpic =3D irq_data_get_irq_chip_data(d);
> > +	unsigned int src =3D virq_to_hw(d->irq) - mpic->err_int_vecs[0];
> > +
> > +	eimr =3D mpic_fsl_err_read(mpic->err_regs, MPIC_ERR_INT_EIMR);
> > +	eimr &=3D ~(1 << (31 - src));
> > +	mpic_fsl_err_write(mpic->err_regs, eimr); }
> > +
> > +static struct irq_chip fsl_mpic_err_chip =3D {
> > +	.irq_disable	=3D fsl_mpic_mask_err,
> > +	.irq_mask	=3D fsl_mpic_mask_err,
> > +	.irq_unmask	=3D fsl_mpic_unmask_err,
> > +};
> > +
> > +void mpic_setup_error_int(struct mpic *mpic, int intvec) {
> > +	int i;
> > +
> > +	mpic->err_regs =3D ioremap(mpic->paddr + MPIC_ERR_INT_BASE, 0x1000);
> > +	if (!mpic->err_regs) {
> > +		pr_err("could not map mpic error registers\n");
> > +		return;
>=20
> we should propagate an error back up if ioremap failed.
[Sethi Varun-B16395] Should we fail mpic_alloc when this fails?

>=20
> > +	}
> > +	mpic->hc_err =3D fsl_mpic_err_chip;
> > +	mpic->hc_err.name =3D mpic->name;
> > +	mpic->flags |=3D MPIC_FSL_HAS_EIMR;
> > +	/* allocate interrupt vectors for error interrupts */
> > +	for (i =3D MPIC_MAX_ERR - 1; i >=3D 0; i--)
> > +		mpic->err_int_vecs[i] =3D --intvec;
> > +
> > +}
> > +
> > +int mpic_map_error_int(struct mpic *mpic, unsigned int virq,
> > +irq_hw_number_t  hw) {
> > +	if ((mpic->flags & MPIC_FSL_HAS_EIMR) &&
> > +	    (hw >=3D mpic->err_int_vecs[0] &&
> > +	     hw <=3D mpic->err_int_vecs[MPIC_MAX_ERR - 1])) {
> > +		WARN_ON(mpic->flags & MPIC_SECONDARY);
> > +
> > +		pr_debug("mpic: mapping as Error Interrupt\n");
> > +		irq_set_chip_data(virq, mpic);
> > +		irq_set_chip_and_handler(virq, &mpic->hc_err,
> > +					 handle_level_irq);
> > +		return 1;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static irqreturn_t fsl_error_int_handler(int irq, void *data) {
> > +	struct mpic *mpic =3D (struct mpic *) data;
> > +	u32 eisr, eimr;
> > +	int errint;
> > +	unsigned int cascade_irq;
> > +
> > +	eisr =3D mpic_fsl_err_read(mpic->err_regs, MPIC_ERR_INT_EISR);
> > +	eimr =3D mpic_fsl_err_read(mpic->err_regs, MPIC_ERR_INT_EIMR);
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
> > +			mpic_fsl_err_write(mpic->err_regs, eimr);
> > +		}
> > +		eisr &=3D ~(1 << (31 - errint));
> > +	}
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +int mpic_err_int_init(struct mpic *mpic, irq_hw_number_t irqnum) {
> > +	unsigned int virq;
> > +	int ret;
> > +
> > +	virq =3D irq_create_mapping(mpic->irqhost, irqnum);
> > +	if (virq =3D=3D NO_IRQ) {
> > +		pr_err("Error interrupt setup failed\n");
> > +		return 0;
> > +	}
> > +
> > +	/* Mask all error interrupts */
> > +	mpic_fsl_err_write(mpic->err_regs, ~0);
> > +
> > +	ret =3D request_irq(virq, fsl_error_int_handler, IRQF_NO_THREAD,
> > +		    "mpic-error-int", mpic);
> > +	if (ret) {
> > +		pr_err("Failed to register error interrupt handler\n");
> > +		return 0;
> > +	}
> > +
> > +	return 1;
> > +}
> > diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> > index 7e32db7..2a0b632 100644
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
> > @@ -1085,7 +1088,16 @@ static int mpic_host_xlate(struct irq_domain *h,
> struct device_node *ct,
> > 		 */
> > 		switch (intspec[2]) {
> > 		case 0:
> > -		case 1: /* no EISR/EIMR support for now, treat as shared IRQ
> */
> > +			break;
> > +		case 1:
> > +			if (!mpic->err_int_config_done)
> > +				break;
> > +
>=20
> Under what case would we call mpic_host_xlate and have not called
> mpic_init?
>=20
[Sethi Varun-B16395] Never, but we shouldn't translate the error interrupt =
specifier
If mpic_err_int_init failed.

-Varun
