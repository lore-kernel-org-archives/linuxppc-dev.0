Return-Path: <B16395@freescale.com>
From: Sethi Varun-B16395 <B16395@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH 3/4] powerpc/mpic: Move internal interrupt source vector
 allocation to a separate function.
Date: Tue, 27 Mar 2012 13:52:36 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D0B11BA@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1332850586-23610-1-git-send-email-Varun.Sethi@freescale.com>
 <84A55A49-747D-4C87-9E5C-E5C63C0CEDA7@kernel.crashing.org>
In-Reply-To: <84A55A49-747D-4C87-9E5C-E5C63C0CEDA7@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "Linuxppc-dev@lists.ozlabs.org" <Linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Tuesday, March 27, 2012 6:55 PM
> To: Sethi Varun-B16395
> Cc: Linuxppc-dev@lists.ozlabs.org
> Subject: Re: [PATCH 3/4] powerpc/mpic: Move internal interrupt source
> vector allocation to a separate function.
>=20
>=20
> On Mar 27, 2012, at 7:16 AM, Varun Sethi wrote:
>=20
> > Allocate vector numbers for MPIC internal interrupt sources (IPIs and
> > Timers) in a separate function.
> >
>=20
> Explain why you are making this change.


[Sethi Varun-B16395] With the current code it becomes fairly difficult to
add new internal interrupt sources. In my case I had to add 32 additional
interrupt sources corresponding to the MPIC error interrupts. It's more
convenient doing the internal interrupt source allocation using a loop.


>=20
> > Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
> > ---
> > arch/powerpc/include/asm/mpic.h |    7 +++++--
> > arch/powerpc/sysdev/mpic.c      |   30 +++++++++++++++++-------------
> > 2 files changed, 22 insertions(+), 15 deletions(-)
> >
> > diff --git a/arch/powerpc/include/asm/mpic.h
> > b/arch/powerpc/include/asm/mpic.h index 30e3b29..3929b4b 100644
> > --- a/arch/powerpc/include/asm/mpic.h
> > +++ b/arch/powerpc/include/asm/mpic.h
> > @@ -118,6 +118,9 @@
> > #define MPIC_MAX_CPUS		32
> > #define MPIC_MAX_ISU		32
> >
> > +#define MPIC_MAX_TIMER    8
> > +#define MPIC_MAX_IPI      4
> > +
> > /*
> >  * Tsi108 implementation of MPIC has many differences from the
> > original one  */ @@ -284,8 +287,8 @@ struct mpic
> > 	unsigned int		senses_count;
> >
> > 	/* vector numbers used for internal sources (ipi/timers) */
> > -	unsigned int		ipi_vecs[4];
> > -	unsigned int		timer_vecs[8];
> > +	unsigned int		ipi_vecs[MPIC_MAX_IPI];
> > +	unsigned int		timer_vecs[MPIC_MAX_TIMER];
> >
> > 	/* Spurious vector to program into unused sources */
> > 	unsigned int		spurious_vec;
> > diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> > index 33520dd..c4da1d5 100644
> > --- a/arch/powerpc/sysdev/mpic.c
> > +++ b/arch/powerpc/sysdev/mpic.c
> > @@ -996,7 +996,8 @@ static int mpic_host_map(struct irq_host *h,
> unsigned int virq,
> > 	}
> > #endif /* CONFIG_SMP */
> >
> > -	if (hw >=3D mpic->timer_vecs[0] && hw <=3D mpic->timer_vecs[7]) {
> > +	if (hw >=3D mpic->timer_vecs[0] &&
> > +	    hw <=3D mpic->timer_vecs[MPIC_MAX_TIMER - 1]) {
> > 		WARN_ON(mpic->flags & MPIC_SECONDARY);
> >
> > 		DBG("mpic: mapping as timer\n");
> > @@ -1133,6 +1134,19 @@ static struct irq_host_ops mpic_host_ops =3D {
> > 	.xlate =3D mpic_host_xlate,
> > };
> >
> > +static void mpic_alloc_int_sources(struct mpic *mpic, int intvec_top)
> > +{
> > +	int i, intvec;
> > +
> > +	intvec =3D intvec_top;
> > +
>=20
> local intvec is pointless.

[Sethi Varun-B16395] ok.

-Varun
=20
