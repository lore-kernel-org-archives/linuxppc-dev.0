Return-Path: <B16395@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe010.messaging.microsoft.com [216.32.180.30])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2A9CE2C00A9
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Aug 2012 02:22:59 +1000 (EST)
From: Sethi Varun-B16395 <B16395@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH 3/3 v4] powerpc/mpic: FSL MPIC error interrupt support.
Date: Mon, 6 Aug 2012 16:22:50 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D15BA0D@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1344257045-11200-1-git-send-email-Varun.Sethi@freescale.com>
 <FAD36277-EA2D-49D7-BD98-2F132CA886AA@kernel.crashing.org>
In-Reply-To: <FAD36277-EA2D-49D7-BD98-2F132CA886AA@kernel.crashing.org>
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
> Sent: Monday, August 06, 2012 9:23 PM
> To: Sethi Varun-B16395
> Cc: linuxppc-dev@lists.ozlabs.org; Hamciuc Bogdan-BHAMCIU1
> Subject: Re: [PATCH 3/3 v4] powerpc/mpic: FSL MPIC error interrupt
> support.
>=20
>=20
> On Aug 6, 2012, at 7:44 AM, Varun Sethi wrote:
>=20
> > All SOC device error interrupts are muxed and delivered to the core as
> > a single MPIC error interrupt. Currently all the device drivers
> > requiring access to device errors have to register for the MPIC error
> > interrupt as a shared interrupt.
> >
> > With this patch we add interrupt demuxing capability in the mpic
> > driver, allowing device drivers to register for their individual error
> interrupts.
> > This is achieved by handling error interrupts in a cascaded fashion.
> >
> > MPIC error interrupt is handled by the "error_int_handler", which
> > subsequently demuxes it using the EISR and delivers it to the
> > respective drivers.
> >
> > The error interrupt capability is dependent on the MPIC EIMR register,
> > which was introduced in FSL MPIC version 4.1 (P4080 rev2). So, error
> > interrupt demuxing capability is dependent on the MPIC version and can
> > be used for versions >=3D 4.1.
> >
> > Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
> > Signed-off-by: Bogdan Hamciuc <bogdan.hamciuc@freescale.com> [In the
> > initial version of the patch we were using handle_simple_irq as the
> > handler for cascaded error interrupts, this resulted in issues in case
> > of threaded isrs (with RT kernel). This issue was debugged by Bogdan
> > and decision was taken to use the handle_level_irq handler]
> > ---
> > arch/powerpc/include/asm/mpic.h    |   16 ++++
> > arch/powerpc/sysdev/Makefile       |    2 +-
> > arch/powerpc/sysdev/fsl_mpic_err.c |  153
> ++++++++++++++++++++++++++++++++++++
> > arch/powerpc/sysdev/mpic.c         |   45 ++++++++++-
> > arch/powerpc/sysdev/mpic.h         |   22 +++++
> > 5 files changed, 236 insertions(+), 2 deletions(-) create mode 100644
> > arch/powerpc/sysdev/fsl_mpic_err.c
> >
> > diff --git a/arch/powerpc/include/asm/mpic.h
> > b/arch/powerpc/include/asm/mpic.h index e14d35d..6c8e53b 100644
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
> >  * Tsi108 implementation of MPIC has many differences from the
> > original one  */ @@ -270,6 +273,7 @@ struct mpic
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
>=20
> I thought we were going to remove this as it don't really provide any
> value.
>=20
[Sethi Varun-B16395] We need a way to determine that irq handle got registe=
red for=20
Mpic error interrupt, only then can we go ahead and assign individual (casc=
aded)
error interrupts. Initially we were doing the same thing while translating=
=20
error interrupt specifier, now we are registering the handler in mpic_init.

-Varun=20
