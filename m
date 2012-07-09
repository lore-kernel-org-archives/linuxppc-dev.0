Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E15062C007A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2012 05:03:30 +1000 (EST)
Subject: Re: [PATCH 3/3 v2] powerpc/mpic: FSL MPIC error interrupt support.
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1341823643-15737-1-git-send-email-Varun.Sethi@freescale.com>
Date: Mon, 9 Jul 2012 14:03:33 -0500
Message-Id: <62D13F27-5E39-450E-953D-102DCA32AA9D@kernel.crashing.org>
References: <1341823643-15737-1-git-send-email-Varun.Sethi@freescale.com>
To: Varun Sethi <Varun.Sethi@freescale.com>
Cc: Bogdan Hamciuc <bogdan.hamciuc@freescale.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 9, 2012, at 3:47 AM, Varun Sethi wrote:

> All SOC device error interrupts are muxed and delivered to the core as =
a single
> MPIC error interrupt. Currently all the device drivers requiring =
access to device
> errors have to register for the MPIC error interrupt as a shared =
interrupt.
>=20
> With this patch we add interrupt demuxing capability in the mpic =
driver, allowing
> device drivers to register for their individual error interrupts. This =
is achieved
> by handling error interrupts in a cascaded fashion.
>=20
> MPIC error interrupt is handled by the "error_int_handler", which =
subsequently demuxes
> it using the EISR and delivers it to the respective drivers.=20
>=20
> The error interrupt capability is dependent on the MPIC EIMR register, =
which was
> introduced in FSL MPIC version 4.1 (P4080 rev2). So, error interrupt =
demuxing capability
> is dependent on the MPIC version and can be used for versions >=3D =
4.1.
>=20
> Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
> Signed-off-by: Bogdan Hamciuc <bogdan.hamciuc@freescale.com>
> [In the initial version of the patch we were using handle_simple_irq
> as the handler for cascaded error interrupts, this resulted
> in issues in case of threaded isrs (with RT kernel). This issue was
> debugged by Bogdan and decision was taken to use the handle_level_irq
> handler]
> ---
> arch/powerpc/include/asm/mpic.h    |   17 ++++
> arch/powerpc/sysdev/Makefile       |    2 +-
> arch/powerpc/sysdev/fsl_mpic_err.c |  157 =
++++++++++++++++++++++++++++++++++++
> arch/powerpc/sysdev/mpic.c         |   35 ++++++++-
> arch/powerpc/sysdev/mpic.h         |   22 +++++
> 5 files changed, 231 insertions(+), 2 deletions(-)
> create mode 100644 arch/powerpc/sysdev/fsl_mpic_err.c
>=20
> diff --git a/arch/powerpc/include/asm/mpic.h =
b/arch/powerpc/include/asm/mpic.h
> index e14d35d..71b42b9 100644
> --- a/arch/powerpc/include/asm/mpic.h
> +++ b/arch/powerpc/include/asm/mpic.h
> @@ -114,10 +114,17 @@
> #define MPIC_FSL_BRR1			0x00000
> #define 	MPIC_FSL_BRR1_VER			0x0000ffff
>=20
> +/*
> + * Error interrupt registers
> + */
> +
> +
> #define MPIC_MAX_IRQ_SOURCES	2048
> #define MPIC_MAX_CPUS		32
> #define MPIC_MAX_ISU		32
>=20
> +#define MPIC_MAX_ERR      32
> +
> /*
>  * Tsi108 implementation of MPIC has many differences from the =
original one
>  */
> @@ -270,6 +277,7 @@ struct mpic
> 	struct irq_chip		hc_ipi;
> #endif
> 	struct irq_chip		hc_tm;
> +	struct irq_chip		hc_err;
> 	const char		*name;
> 	/* Flags */
> 	unsigned int		flags;
> @@ -283,6 +291,8 @@ struct mpic
> 	/* vector numbers used for internal sources (ipi/timers) */
> 	unsigned int		ipi_vecs[4];
> 	unsigned int		timer_vecs[8];
> +	/* vector numbers used for FSL MPIC error interrupts */
> +	unsigned int		err_int_vecs[MPIC_MAX_ERR];
>=20
> 	/* Spurious vector to program into unused sources */
> 	unsigned int		spurious_vec;
> @@ -306,6 +316,11 @@ struct mpic
> 	struct mpic_reg_bank	cpuregs[MPIC_MAX_CPUS];
> 	struct mpic_reg_bank	isus[MPIC_MAX_ISU];
>=20
> +	/* ioremap'ed base for error interrupt registers */
> +	u32 __iomem	*err_regs;
> +	/* error interrupt config */
> +	u32			err_int_config_done;
> +
> 	/* Protected sources */
> 	unsigned long		*protected;
>=20
> @@ -370,6 +385,8 @@ struct mpic
> #define MPIC_NO_RESET			0x00004000
> /* Freescale MPIC (compatible includes "fsl,mpic") */
> #define MPIC_FSL			0x00008000
> +/* Freescale MPIC supports EIMR (error interrupt mask register)*/
> +#define MPIC_FSL_HAS_EIMR		0x00010000
>=20
> /* MPIC HW modification ID */
> #define MPIC_REGSET_MASK		0xf0000000
> diff --git a/arch/powerpc/sysdev/Makefile =
b/arch/powerpc/sysdev/Makefile
> index 1bd7ecb..a57600b 100644
> --- a/arch/powerpc/sysdev/Makefile
> +++ b/arch/powerpc/sysdev/Makefile
> @@ -15,7 +15,7 @@ obj-$(CONFIG_PPC_DCR_NATIVE)	+=3D dcr-low.o
> obj-$(CONFIG_PPC_PMI)		+=3D pmi.o
> obj-$(CONFIG_U3_DART)		+=3D dart_iommu.o
> obj-$(CONFIG_MMIO_NVRAM)	+=3D mmio_nvram.o
> -obj-$(CONFIG_FSL_SOC)		+=3D fsl_soc.o
> +obj-$(CONFIG_FSL_SOC)		+=3D fsl_soc.o fsl_mpic_err.o
> obj-$(CONFIG_FSL_PCI)		+=3D fsl_pci.o $(fsl-msi-obj-y)
> obj-$(CONFIG_FSL_PMC)		+=3D fsl_pmc.o
> obj-$(CONFIG_FSL_LBC)		+=3D fsl_lbc.o
> diff --git a/arch/powerpc/sysdev/fsl_mpic_err.c =
b/arch/powerpc/sysdev/fsl_mpic_err.c
> new file mode 100644
> index 0000000..f2d28f2
> --- /dev/null
> +++ b/arch/powerpc/sysdev/fsl_mpic_err.c
> @@ -0,0 +1,157 @@
> +/*
> + * Copyright (C) 2012 Freescale Semiconductor, Inc.
> + *
> + * Author: Varun Sethi <varun.sethi@freescale.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; version 2 of the
> + * License.
> + *
> + */
> +
> +#include <linux/irq.h>
> +#include <linux/smp.h>
> +#include <linux/interrupt.h>
> +
> +#include <asm/io.h>
> +#include <asm/irq.h>
> +#include <asm/mpic.h>
> +
> +#include "mpic.h"
> +
> +#define MPIC_ERR_INT_BASE	0x3900
> +#define MPIC_ERR_INT_EISR	0x0000
> +#define MPIC_ERR_INT_EIMR	0x0010
> +
> +static inline u32 fsl_mpic_err_read(u32 __iomem *base, unsigned int =
err_reg)

rename to mpic_fsl_err_read (lets keep same naming convention as other =
read/write function)

> +{
> +	return in_be32(base + (err_reg >> 2));
> +}
> +
> +static inline void fsl_mpic_err_write(u32 __iomem *base, unsigned int =
err_reg,
> +				   u32 value)
> +{

rename to mpic_fsl_err_write (lets keep same naming convention as other =
read/write function)

> +	out_be32(base + (err_reg >> 2), value);
> +}
> +
> +static void fsl_mpic_mask_err(struct irq_data *d)
> +{
> +	u32 eimr;
> +	struct mpic *mpic =3D irq_data_get_irq_chip_data(d);
> +	unsigned int src =3D virq_to_hw(d->irq) - mpic->err_int_vecs[0];
> +	unsigned int err_reg_offset =3D MPIC_ERR_INT_EIMR;

remove err_reg_offset, just use MPIC_ERR_INT_EIMR directly.

> +
> +	eimr =3D fsl_mpic_err_read(mpic->err_regs, err_reg_offset);
> +	eimr |=3D (1 << (31 - src));
> +	fsl_mpic_err_write(mpic->err_regs, err_reg_offset, eimr);
> +}
> +
> +static void fsl_mpic_unmask_err(struct irq_data *d)
> +{
> +	u32 eimr;
> +	struct mpic *mpic =3D irq_data_get_irq_chip_data(d);
> +	unsigned int src =3D virq_to_hw(d->irq) - mpic->err_int_vecs[0];
> +	unsigned int err_reg_offset =3D MPIC_ERR_INT_EIMR;

remove err_reg_offset, just use MPIC_ERR_INT_EIMR directly.

> +
> +	eimr =3D fsl_mpic_err_read(mpic->err_regs, err_reg_offset);
> +	eimr &=3D ~(1 << (31 - src));
> +	fsl_mpic_err_write(mpic->err_regs, err_reg_offset, eimr);
> +}
> +
> +static struct irq_chip fsl_mpic_err_chip =3D {
> +	.irq_disable	=3D fsl_mpic_mask_err,
> +	.irq_mask	=3D fsl_mpic_mask_err,
> +	.irq_unmask	=3D fsl_mpic_unmask_err,
> +};
> +
> +void mpic_setup_error_int(struct mpic *mpic, int intvec)
> +{
> +	int i;
> +
> +	mpic->err_regs =3D ioremap(mpic->paddr + MPIC_ERR_INT_BASE, =
0x1000);
> +	if (!mpic->err_regs) {
> +		pr_err("could not map mpic error registers\n");
> +		return;
> +	}
> +	mpic->hc_err =3D fsl_mpic_err_chip;
> +	mpic->hc_err.name =3D mpic->name;
> +	mpic->flags |=3D MPIC_FSL_HAS_EIMR;
> +	/* allocate interrupt vectors for error interrupts */
> +	for (i =3D MPIC_MAX_ERR - 1; i >=3D 0; i--)
> +		mpic->err_int_vecs[i] =3D --intvec;
> +
> +}
> +
> +int mpic_map_error_int(struct mpic *mpic, unsigned int virq, =
irq_hw_number_t  hw)
> +{
> +	if ((mpic->flags & MPIC_FSL_HAS_EIMR) &&
> +	    (hw >=3D mpic->err_int_vecs[0] &&
> +	     hw <=3D mpic->err_int_vecs[MPIC_MAX_ERR - 1])) {
> +		WARN_ON(mpic->flags & MPIC_SECONDARY);
> +
> +		pr_debug("mpic: mapping as Error Interrupt\n");
> +		irq_set_chip_data(virq, mpic);
> +		irq_set_chip_and_handler(virq, &mpic->hc_err,
> +					 handle_level_irq);
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +static irqreturn_t fsl_error_int_handler(int irq, void *data)
> +{
> +	struct mpic *mpic =3D (struct mpic *) data;
> +	unsigned int eisr_offset =3D MPIC_ERR_INT_EISR;
> +	unsigned int eimr_offset =3D MPIC_ERR_INT_EIMR;

remove *_offset, just use MPIC_ERR_INT_* directly.

> +	u32 eisr, eimr;
> +	int errint;
> +	unsigned int cascade_irq;
> +
> +	eisr =3D fsl_mpic_err_read(mpic->err_regs, eisr_offset);
> +	eimr =3D fsl_mpic_err_read(mpic->err_regs, eimr_offset);
> +
> +	if (!(eisr & ~eimr))
> +		return IRQ_NONE;
> +
> +	while (eisr) {
> +		errint =3D __builtin_clz(eisr);
> +		cascade_irq =3D irq_linear_revmap(mpic->irqhost,
> +				 mpic->err_int_vecs[errint]);
> +		WARN_ON(cascade_irq =3D=3D NO_IRQ);
> +		if (cascade_irq !=3D NO_IRQ) {
> +			generic_handle_irq(cascade_irq);
> +		} else {
> +			eimr |=3D  1 << (31 - errint);
> +			fsl_mpic_err_write(mpic->err_regs, eimr_offset, =
eimr);
> +		}
> +		eisr &=3D ~(1 << (31 - errint));
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +int mpic_err_int_init(struct mpic *mpic, irq_hw_number_t irqnum)
> +{

Why can't we do this during mpic_init() time?

> +	unsigned int virq;
> +	unsigned int offset =3D MPIC_ERR_INT_EIMR;

remove offset, just use MPIC_ERR_INT_EIMR in mpic_err_write

> +	int ret;
> +
> +	virq =3D irq_create_mapping(mpic->irqhost, irqnum);
> +	if (virq =3D=3D NO_IRQ) {
> +		pr_err("Error interrupt setup failed\n");
> +		return -ENOSPC;
> +	}
> +
> +	fsl_mpic_err_write(mpic->err_regs, offset, ~0);

Add a comment about what this line is doing

> +
> +	ret =3D request_irq(virq, fsl_error_int_handler, IRQF_NO_THREAD,
> +		    "mpic-error-int", mpic);

Hmm, should we be using irq_set_chained_handler() instead of request_irq

> +	if (ret) {
> +		pr_err("Failed to register error interrupt handler\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> index 61c7225..7002ef3 100644
> --- a/arch/powerpc/sysdev/mpic.c
> +++ b/arch/powerpc/sysdev/mpic.c
> @@ -1026,6 +1026,9 @@ static int mpic_host_map(struct irq_domain *h, =
unsigned int virq,
> 		return 0;
> 	}
>=20
> +	if (mpic_map_error_int(mpic, virq, hw))
> +		return 0;
> +
> 	if (hw >=3D mpic->num_sources)
> 		return -EINVAL;
>=20
> @@ -1085,7 +1088,24 @@ static int mpic_host_xlate(struct irq_domain =
*h, struct device_node *ct,
> 		 */
> 		switch (intspec[2]) {
> 		case 0:
> -		case 1: /* no EISR/EIMR support for now, treat as shared =
IRQ */
> +			break;
> +		case 1:
> +			if (!(mpic->flags & MPIC_FSL_HAS_EIMR))
> +				break;
> +
> +			if (intspec[3] >=3D =
ARRAY_SIZE(mpic->err_int_vecs))
> +				return -EINVAL;
> +
> +			if (!mpic->err_int_config_done) {
> +				int ret;
> +				ret =3D mpic_err_int_init(mpic, =
intspec[0]);
> +				if (ret)
> +					return ret;
> +				mpic->err_int_config_done =3D 1;
> +			}
> +
> +			*out_hwirq =3D mpic->err_int_vecs[intspec[3]];
> +
> 			break;
> 		case 2:
> 			if (intspec[0] >=3D ARRAY_SIZE(mpic->ipi_vecs))
> @@ -1302,6 +1322,8 @@ struct mpic * __init mpic_alloc(struct =
device_node *node,
> 	mpic_map(mpic, mpic->paddr, &mpic->tmregs, =
MPIC_INFO(TIMER_BASE), 0x1000);
>=20
> 	if (mpic->flags & MPIC_FSL) {
> +		u32 brr1, version;
> +
> 		/*
> 		 * Yes, Freescale really did put global registers in the
> 		 * magic per-cpu area -- and they don't even show up in =
the
> @@ -1309,6 +1331,17 @@ struct mpic * __init mpic_alloc(struct =
device_node *node,
> 		 */
> 		mpic_map(mpic, mpic->paddr, &mpic->thiscpuregs,
> 			 MPIC_CPU_THISBASE, 0x1000);
> +
> +		brr1 =3D _mpic_read(mpic->reg_type, &mpic->thiscpuregs,
> +				MPIC_FSL_BRR1);
> +		version =3D brr1 & MPIC_FSL_BRR1_VER;
> +
> +		/* Error interrupt mask register (EIMR) is required for
> +		 * handling individual device error interrupts. EIMR
> +		 * was added in MPIC version 4.1.
> +		 */
> +		if (version >=3D 0x401)
> +			mpic_setup_error_int(mpic, intvec_top - 12);

Would really like not to have this magic 12, but a comment would be nice =
if we keep it where the 12 comes from

> 	}
>=20
> 	/* Reset */
> diff --git a/arch/powerpc/sysdev/mpic.h b/arch/powerpc/sysdev/mpic.h
> index 13f3e89..1a6995a 100644
> --- a/arch/powerpc/sysdev/mpic.h
> +++ b/arch/powerpc/sysdev/mpic.h
> @@ -40,4 +40,26 @@ extern int mpic_set_affinity(struct irq_data *d,
> 			     const struct cpumask *cpumask, bool force);
> extern void mpic_reset_core(int cpu);
>=20
> +#ifdef CONFIG_FSL_SOC
> +extern int mpic_map_error_int(struct mpic *mpic, unsigned int virq, =
irq_hw_number_t  hw);
> +extern int mpic_err_int_init(struct mpic *mpic, irq_hw_number_t =
irqnum);
> +extern void mpic_setup_error_int(struct mpic *mpic, int intvec);
> +#else
> +static inline int mpic_map_error_int(struct mpic *mpic, unsigned int =
virq, irq_hw_number_t  hw)
> +{
> +	return 0;
> +}
> +
> +
> +static inline int mpic_err_int_init(struct mpic *mpic, =
irq_hw_number_t irqnum)
> +{
> +	return -1;
> +}
> +
> +static inline void mpic_setup_error_int(struct mpic *mpic, int =
intvec)
> +{
> +	return;
> +}
> +#endif
> +
> #endif /* _POWERPC_SYSDEV_MPIC_H */
> --=20
> 1.7.2.2
>=20
