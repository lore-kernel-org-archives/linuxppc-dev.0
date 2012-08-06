Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 527332C0081
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Aug 2012 01:52:53 +1000 (EST)
Subject: Re: [PATCH 3/3 v4] powerpc/mpic: FSL MPIC error interrupt support.
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1344257045-11200-1-git-send-email-Varun.Sethi@freescale.com>
Date: Mon, 6 Aug 2012 10:52:42 -0500
Message-Id: <FAD36277-EA2D-49D7-BD98-2F132CA886AA@kernel.crashing.org>
References: <1344257045-11200-1-git-send-email-Varun.Sethi@freescale.com>
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


On Aug 6, 2012, at 7:44 AM, Varun Sethi wrote:

> All SOC device error interrupts are muxed and delivered to the core
> as a single MPIC error interrupt. Currently all the device drivers
> requiring access to device errors have to register for the MPIC error
> interrupt as a shared interrupt.
>=20
> With this patch we add interrupt demuxing capability in the mpic =
driver,
> allowing device drivers to register for their individual error =
interrupts.
> This is achieved by handling error interrupts in a cascaded fashion.
>=20
> MPIC error interrupt is handled by the "error_int_handler", which
> subsequently demuxes it using the EISR and delivers it to the =
respective
> drivers.=20
>=20
> The error interrupt capability is dependent on the MPIC EIMR register,
> which was introduced in FSL MPIC version 4.1 (P4080 rev2). So, error
> interrupt demuxing capability is dependent on the MPIC version and can
> be used for versions >=3D 4.1.
>=20
> Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
> Signed-off-by: Bogdan Hamciuc <bogdan.hamciuc@freescale.com>
> [In the initial version of the patch we were using handle_simple_irq
> as the handler for cascaded error interrupts, this resulted
> in issues in case of threaded isrs (with RT kernel). This issue was
> debugged by Bogdan and decision was taken to use the handle_level_irq
> handler]
> ---
> arch/powerpc/include/asm/mpic.h    |   16 ++++
> arch/powerpc/sysdev/Makefile       |    2 +-
> arch/powerpc/sysdev/fsl_mpic_err.c |  153 =
++++++++++++++++++++++++++++++++++++
> arch/powerpc/sysdev/mpic.c         |   45 ++++++++++-
> arch/powerpc/sysdev/mpic.h         |   22 +++++
> 5 files changed, 236 insertions(+), 2 deletions(-)
> create mode 100644 arch/powerpc/sysdev/fsl_mpic_err.c
>=20
> diff --git a/arch/powerpc/include/asm/mpic.h =
b/arch/powerpc/include/asm/mpic.h
> index e14d35d..6c8e53b 100644
> --- a/arch/powerpc/include/asm/mpic.h
> +++ b/arch/powerpc/include/asm/mpic.h
> @@ -118,6 +118,9 @@
> #define MPIC_MAX_CPUS		32
> #define MPIC_MAX_ISU		32
>=20
> +#define MPIC_MAX_ERR      32
> +#define MPIC_FSL_ERR_INT  16
> +
> /*
>  * Tsi108 implementation of MPIC has many differences from the =
original one
>  */
> @@ -270,6 +273,7 @@ struct mpic
> 	struct irq_chip		hc_ipi;
> #endif
> 	struct irq_chip		hc_tm;
> +	struct irq_chip		hc_err;
> 	const char		*name;
> 	/* Flags */
> 	unsigned int		flags;
> @@ -283,6 +287,8 @@ struct mpic
> 	/* vector numbers used for internal sources (ipi/timers) */
> 	unsigned int		ipi_vecs[4];
> 	unsigned int		timer_vecs[8];
> +	/* vector numbers used for FSL MPIC error interrupts */
> +	unsigned int		err_int_vecs[MPIC_MAX_ERR];
>=20
> 	/* Spurious vector to program into unused sources */
> 	unsigned int		spurious_vec;
> @@ -306,6 +312,11 @@ struct mpic
> 	struct mpic_reg_bank	cpuregs[MPIC_MAX_CPUS];
> 	struct mpic_reg_bank	isus[MPIC_MAX_ISU];
>=20
> +	/* ioremap'ed base for error interrupt registers */
> +	u32 __iomem	*err_regs;
> +	/* error interrupt config */
> +	u32			err_int_config_done;

I thought we were going to remove this as it don't really provide any =
value.

> +
> 	/* Protected sources */
> 	unsigned long		*protected;
>=20
> @@ -370,6 +381,11 @@ struct mpic
> #define MPIC_NO_RESET			0x00004000
> /* Freescale MPIC (compatible includes "fsl,mpic") */
> #define MPIC_FSL			0x00008000
> +/* Freescale MPIC supports EIMR (error interrupt mask register).
> + * This flag is set for MPIC version >=3D 4.1 (version determined
> + * from the BRR1 register).
> +*/
> +#define MPIC_FSL_HAS_EIMR		0x00010000
>=20
> /* MPIC HW modification ID */
> #define MPIC_REGSET_MASK		0xf0000000

- k=
