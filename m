Return-Path: <galak@kernel.crashing.org>
Subject: Re: [PATCH 3/4] powerpc/mpic: Move internal interrupt source vector
 allocation to a separate function.
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1332850586-23610-1-git-send-email-Varun.Sethi@freescale.com>
Date: Tue, 27 Mar 2012 08:24:32 -0500
Message-Id: <84A55A49-747D-4C87-9E5C-E5C63C0CEDA7@kernel.crashing.org>
References: <1332850586-23610-1-git-send-email-Varun.Sethi@freescale.com>
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


On Mar 27, 2012, at 7:16 AM, Varun Sethi wrote:

> Allocate vector numbers for MPIC internal interrupt sources (IPIs and =
Timers) in a=20
> separate function.
>=20

Explain why you are making this change.

> Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
> ---
> arch/powerpc/include/asm/mpic.h |    7 +++++--
> arch/powerpc/sysdev/mpic.c      |   30 +++++++++++++++++-------------
> 2 files changed, 22 insertions(+), 15 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/mpic.h =
b/arch/powerpc/include/asm/mpic.h
> index 30e3b29..3929b4b 100644
> --- a/arch/powerpc/include/asm/mpic.h
> +++ b/arch/powerpc/include/asm/mpic.h
> @@ -118,6 +118,9 @@
> #define MPIC_MAX_CPUS		32
> #define MPIC_MAX_ISU		32
>=20
> +#define MPIC_MAX_TIMER    8
> +#define MPIC_MAX_IPI      4
> +
> /*
>  * Tsi108 implementation of MPIC has many differences from the =
original one
>  */
> @@ -284,8 +287,8 @@ struct mpic
> 	unsigned int		senses_count;
>=20
> 	/* vector numbers used for internal sources (ipi/timers) */
> -	unsigned int		ipi_vecs[4];
> -	unsigned int		timer_vecs[8];
> +	unsigned int		ipi_vecs[MPIC_MAX_IPI];
> +	unsigned int		timer_vecs[MPIC_MAX_TIMER];
>=20
> 	/* Spurious vector to program into unused sources */
> 	unsigned int		spurious_vec;
> diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> index 33520dd..c4da1d5 100644
> --- a/arch/powerpc/sysdev/mpic.c
> +++ b/arch/powerpc/sysdev/mpic.c
> @@ -996,7 +996,8 @@ static int mpic_host_map(struct irq_host *h, =
unsigned int virq,
> 	}
> #endif /* CONFIG_SMP */
>=20
> -	if (hw >=3D mpic->timer_vecs[0] && hw <=3D mpic->timer_vecs[7]) =
{
> +	if (hw >=3D mpic->timer_vecs[0] &&
> +	    hw <=3D mpic->timer_vecs[MPIC_MAX_TIMER - 1]) {
> 		WARN_ON(mpic->flags & MPIC_SECONDARY);
>=20
> 		DBG("mpic: mapping as timer\n");
> @@ -1133,6 +1134,19 @@ static struct irq_host_ops mpic_host_ops =3D {
> 	.xlate =3D mpic_host_xlate,
> };
>=20
> +static void mpic_alloc_int_sources(struct mpic *mpic, int intvec_top)
> +{
> +	int i, intvec;
> +
> +	intvec =3D intvec_top;
> +

local intvec is pointless.

> +	for (i =3D MPIC_MAX_IPI - 1; i >=3D 0; i--)
> +		mpic->ipi_vecs[i] =3D --intvec;
> +
> +	for (i =3D MPIC_MAX_TIMER - 1; i >=3D 0; i--)
> +		mpic->timer_vecs[i] =3D --intvec;
> +}
> +
> /*
>  * Exported functions
>  */
> @@ -1228,18 +1242,6 @@ struct mpic * __init mpic_alloc(struct =
device_node *node,
> 	else
> 		intvec_top =3D 255;
>=20
> -	mpic->timer_vecs[0] =3D intvec_top - 12;
> -	mpic->timer_vecs[1] =3D intvec_top - 11;
> -	mpic->timer_vecs[2] =3D intvec_top - 10;
> -	mpic->timer_vecs[3] =3D intvec_top - 9;
> -	mpic->timer_vecs[4] =3D intvec_top - 8;
> -	mpic->timer_vecs[5] =3D intvec_top - 7;
> -	mpic->timer_vecs[6] =3D intvec_top - 6;
> -	mpic->timer_vecs[7] =3D intvec_top - 5;
> -	mpic->ipi_vecs[0]   =3D intvec_top - 4;
> -	mpic->ipi_vecs[1]   =3D intvec_top - 3;
> -	mpic->ipi_vecs[2]   =3D intvec_top - 2;
> -	mpic->ipi_vecs[3]   =3D intvec_top - 1;
> 	mpic->spurious_vec  =3D intvec_top;
>=20
> 	/* Look for protected sources */
> @@ -1365,6 +1367,8 @@ struct mpic * __init mpic_alloc(struct =
device_node *node,
> 	mpic->isu_shift =3D 1 + __ilog2(mpic->isu_size - 1);
> 	mpic->isu_mask =3D (1 << mpic->isu_shift) - 1;
>=20
> +	mpic_alloc_int_sources(mpic, intvec_top);
> +
> 	mpic->irqhost =3D irq_alloc_host(mpic->node, =
IRQ_HOST_MAP_LINEAR,
> 				       last_irq + 1, &mpic_host_ops,
> 				       intvec_top + 1);
> --=20
> 1.7.2.2
>=20
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
