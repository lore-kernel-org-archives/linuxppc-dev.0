Return-Path: <galak@kernel.crashing.org>
Subject: Re: [PATCH 4/4] powerpc/mpic: FSL MPIC error interrupt support.
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1332850633-23661-1-git-send-email-Varun.Sethi@freescale.com>
Date: Tue, 27 Mar 2012 08:59:58 -0500
Message-Id: <7F9EFF8D-82E4-414E-BB76-24BE84F2D8BC@kernel.crashing.org>
References: <1332850633-23661-1-git-send-email-Varun.Sethi@freescale.com>
To: Varun Sethi <Varun.Sethi@freescale.com>
Cc: Linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 27, 2012, at 7:17 AM, Varun Sethi wrote:

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
> ---

This isn't quite right.  Doing the 'request_irq' on behalf of the driver =
isn't treating the error interrupts as a real cascade, in addition to =
how you are hooking things up.

I think you need to add proper irq_domain_ops, etc.  Thus when we map =
the virq the proper thing can happen.

I'd also suggest maybe thinking about pulling this code into an =
mpic_fsl.c

> arch/powerpc/include/asm/mpic.h |   18 +++++
> arch/powerpc/sysdev/mpic.c      |  155 =
++++++++++++++++++++++++++++++++++++++-
> 2 files changed, 171 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/mpic.h =
b/arch/powerpc/include/asm/mpic.h
> index 3929b4b..db51015 100644
> --- a/arch/powerpc/include/asm/mpic.h
> +++ b/arch/powerpc/include/asm/mpic.h
> @@ -114,12 +114,21 @@
> #define MPIC_FSL_BRR1			0x00000
> #define 	MPIC_FSL_BRR1_VER			0x0000ffff
>=20
> +/*
> + * Error interrupt registers
> + */
> +
> +#define MPIC_ERR_INT_BASE	0x3900
> +#define MPIC_ERR_INT_EISR	0x0000
> +#define MPIC_ERR_INT_EIMR	0x0010
> +
> #define MPIC_MAX_IRQ_SOURCES	2048
> #define MPIC_MAX_CPUS		32
> #define MPIC_MAX_ISU		32
>=20
> #define MPIC_MAX_TIMER    8
> #define MPIC_MAX_IPI      4
> +#define MPIC_MAX_ERR      32

Should probably be 64

> /*
>  * Tsi108 implementation of MPIC has many differences from the =
original one
> @@ -273,6 +282,7 @@ struct mpic
> 	struct irq_chip		hc_ipi;
> #endif
> 	struct irq_chip		hc_tm;
> +	struct irq_chip		hc_err;
> 	const char		*name;
> 	/* Flags */
> 	unsigned int		flags;
> @@ -289,6 +299,8 @@ struct mpic
> 	/* vector numbers used for internal sources (ipi/timers) */
> 	unsigned int		ipi_vecs[MPIC_MAX_IPI];
> 	unsigned int		timer_vecs[MPIC_MAX_TIMER];
> +	/* vector numbers used for FSL MPIC error interrupts */
> +	unsigned int		err_int_vecs[MPIC_MAX_ERR];
>=20
> 	/* Spurious vector to program into unused sources */
> 	unsigned int		spurious_vec;
> @@ -311,6 +323,10 @@ struct mpic
> 	struct mpic_reg_bank	tmregs;
> 	struct mpic_reg_bank	cpuregs[MPIC_MAX_CPUS];
> 	struct mpic_reg_bank	isus[MPIC_MAX_ISU];
> +	struct mpic_reg_bank	err_regs;
> +
> +	/* error interrupt config */
> +	u32			err_int_config_done;
>=20
> 	/* Protected sources */
> 	unsigned long		*protected;
> @@ -376,6 +392,8 @@ struct mpic
> #define MPIC_NO_RESET			0x00004000
> /* Freescale MPIC (compatible includes "fsl,mpic") */
> #define MPIC_FSL			0x00008000
> +/* Freescale MPIC supports EIMR (error interrupt mask register)*/
> +#define MPIC_FSL_HAS_EIMR		0x00010000
>=20
> /* MPIC HW modification ID */
> #define MPIC_REGSET_MASK		0xf0000000

> diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> index c4da1d5..b0ff465 100644
> --- a/arch/powerpc/sysdev/mpic.c
> +++ b/arch/powerpc/sysdev/mpic.c
> @@ -221,6 +221,17 @@ static inline void _mpic_ipi_write(struct mpic =
*mpic, unsigned int ipi, u32 valu
> 	_mpic_write(mpic->reg_type, &mpic->gregs, offset, value);
> }
>=20
> +static inline u32 _mpic_err_read(struct mpic *mpic, unsigned int =
err_reg)
> +{
> +	return _mpic_read(mpic->reg_type, &mpic->err_regs, err_reg);
> +}
> +
> +static inline void _mpic_err_write(struct mpic *mpic, unsigned int =
err_reg,
> +				   u32 value)
> +{
> +	_mpic_write(mpic->reg_type, &mpic->err_regs, err_reg, value);
> +}
> +
> static inline unsigned int mpic_tm_offset(struct mpic *mpic, unsigned =
int tm)
> {
> 	return (tm >> 2) * MPIC_TIMER_GROUP_STRIDE +
> @@ -295,6 +306,8 @@ static inline void _mpic_irq_write(struct mpic =
*mpic, unsigned int src_no,
> #define mpic_ipi_write(i,v)	_mpic_ipi_write(mpic,(i),(v))
> #define mpic_tm_read(i)		_mpic_tm_read(mpic,(i))
> #define mpic_tm_write(i,v)	_mpic_tm_write(mpic,(i),(v))
> +#define mpic_err_read(i)	_mpic_err_read(mpic, (i))
> +#define mpic_err_write(i, v)	_mpic_err_write(mpic, (i), (v))
> #define mpic_cpu_read(i)	_mpic_cpu_read(mpic,(i))
> #define mpic_cpu_write(i,v)	_mpic_cpu_write(mpic,(i),(v))
> #define mpic_irq_read(s,r)	_mpic_irq_read(mpic,(s),(r))
> @@ -821,6 +834,86 @@ static void mpic_mask_tm(struct irq_data *d)
> 	mpic_tm_read(src);
> }
>=20
> +static void mpic_mask_err(struct irq_data *d)
> +{
> +	u32 eimr;
> +	struct mpic *mpic =3D mpic_from_irq_data(d);
> +	unsigned int src =3D virq_to_hw(d->irq) - mpic->err_int_vecs[0];
> +	unsigned int err_reg_offset =3D MPIC_INFO(ERR_INT_EIMR);
> +
> +	eimr =3D mpic_err_read(err_reg_offset);
> +	eimr |=3D (0x80000000 >> src);

This seems funny, add a comment about src # and bit # being opposite.  =
Maybe do:

	eimr |=3D (1 << (31 - src));

> +	mpic_err_write(err_reg_offset, eimr);
> +}
> +
> +static void mpic_unmask_err(struct irq_data *d)
> +{
> +	u32 eimr;
> +	struct mpic *mpic =3D mpic_from_irq_data(d);
> +	unsigned int src =3D virq_to_hw(d->irq) - mpic->err_int_vecs[0];
> +	unsigned int err_reg_offset =3D MPIC_INFO(ERR_INT_EIMR);
> +
> +	eimr =3D mpic_err_read(err_reg_offset);
> +	eimr &=3D ~(0x80000000 >> src);

same as above

> +	mpic_err_write(err_reg_offset, eimr);
> +}
> +
> +static irqreturn_t error_int_handler(int irq, void *data)
> +{
> +	struct mpic *mpic =3D (struct mpic *) data;
> +	unsigned int eisr_offset =3D MPIC_INFO(ERR_INT_EISR);
> +	unsigned int eimr_offset =3D MPIC_INFO(ERR_INT_EIMR);
> +	u32 eisr, eimr;
> +	int errint;
> +	unsigned int cascade_irq;
> +
> +	eisr =3D mpic_err_read(eisr_offset);
> +	eimr =3D mpic_err_read(eimr_offset);
> +
> +	if (!(eisr & ~eimr))
> +		return IRQ_NONE;
> +
> +	while (eisr) {
> +		errint =3D __ffs(eisr);
> +		cascade_irq =3D irq_linear_revmap(mpic->irqhost,
> +				 mpic->err_int_vecs[31 - errint]);

Should 31, be replaced w/MPIC_MAX_ERR - 1 ?

> +		WARN_ON(cascade_irq =3D=3D NO_IRQ);
> +		if (cascade_irq !=3D NO_IRQ) {
> +			generic_handle_irq(cascade_irq);
> +		} else {
> +			eimr |=3D  1 << errint;
> +			mpic_err_write(eimr_offset, eimr);
> +		}
> +		eisr &=3D ~(1 << errint);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int mpic_err_int_init(struct mpic *mpic, irq_hw_number_t =
irqnum)
> +{
> +	unsigned int virq;
> +	unsigned int offset =3D MPIC_INFO(ERR_INT_EIMR);
> +	int ret;
> +
> +	virq =3D irq_create_mapping(mpic->irqhost, irqnum);
> +	if (virq =3D=3D NO_IRQ) {
> +		pr_err("Error interrupt setup failed\n");
> +		return -ENOSPC;
> +	}
> +
> +	mpic_err_write(offset, ~0);
> +
> +	ret =3D request_irq(virq, error_int_handler, IRQF_NO_THREAD,
> +		    "mpic-error-int", mpic);
> +	if (ret) {
> +		pr_err("Failed to register error interrupt handler\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> int mpic_set_affinity(struct irq_data *d, const struct cpumask =
*cpumask,
> 		      bool force)
> {
> @@ -947,6 +1040,12 @@ static struct irq_chip mpic_ipi_chip =3D {
> };
> #endif /* CONFIG_SMP */
>=20
> +static struct irq_chip mpic_err_chip =3D {
> +	.irq_disable	=3D mpic_mask_err,
> +	.irq_mask	=3D mpic_mask_err,
> +	.irq_unmask	=3D mpic_unmask_err,
> +};
> +
> static struct irq_chip mpic_tm_chip =3D {
> 	.irq_mask	=3D mpic_mask_tm,
> 	.irq_unmask	=3D mpic_unmask_tm,
> @@ -984,8 +1083,19 @@ static int mpic_host_map(struct irq_host *h, =
unsigned int virq,
> 	if (mpic->protected && test_bit(hw, mpic->protected))
> 		return -EINVAL;
>=20
> +	if ((mpic->flags & MPIC_FSL_HAS_EIMR) &&
> +	    hw >=3D mpic->err_int_vecs[0]) {
> +		WARN_ON(mpic->flags & MPIC_SECONDARY);
> +
> +		DBG("mpic: mapping as Error Interrupt\n");
> +		irq_set_chip_data(virq, mpic);
> +		irq_set_chip_and_handler(virq, &mpic->hc_err,
> +					 handle_simple_irq);
> +		return 0;
> +	}
> #ifdef CONFIG_SMP
> -	else if (hw >=3D mpic->ipi_vecs[0]) {
> +	if (hw >=3D mpic->ipi_vecs[0] &&
> +	    hw <=3D mpic->ipi_vecs[MPIC_MAX_IPI - 1]) {
> 		WARN_ON(mpic->flags & MPIC_SECONDARY);
>=20
> 		DBG("mpic: mapping as IPI\n");
> @@ -1066,7 +1176,23 @@ static int mpic_host_xlate(struct irq_host *h, =
struct device_node *ct,
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
> 			break;
> 		case 2:
> 			if (intspec[0] >=3D ARRAY_SIZE(mpic->ipi_vecs))
> @@ -1140,6 +1266,11 @@ static void mpic_alloc_int_sources(struct mpic =
*mpic, int intvec_top)
>=20
> 	intvec =3D intvec_top;
>=20
> +	if (mpic->flags & MPIC_FSL_HAS_EIMR) {
> +		for (i =3D MPIC_MAX_ERR - 1; i >=3D 0; i--)
> +			mpic->err_int_vecs[i] =3D --intvec;
> +	}
> +
> 	for (i =3D MPIC_MAX_IPI - 1; i >=3D 0; i--)
> 		mpic->ipi_vecs[i] =3D --intvec;
>=20
> @@ -1284,6 +1415,8 @@ struct mpic * __init mpic_alloc(struct =
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
> @@ -1291,6 +1424,24 @@ struct mpic * __init mpic_alloc(struct =
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
> +		if (version >=3D 0x401) {
> +			mpic->hc_err =3D mpic_err_chip;
> +			mpic->hc_err.name =3D mpic->name;
> +			/* Map error interrupt registers */
> +			mpic_map(mpic, mpic->paddr, &mpic->err_regs,
> +				 MPIC_INFO(ERR_INT_BASE), 0x1000);
> +			mpic->flags |=3D MPIC_FSL_HAS_EIMR;
> +		}
> +
> 	}
>=20
> 	/* Reset */
> --=20
> 1.7.2.2
>=20
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
