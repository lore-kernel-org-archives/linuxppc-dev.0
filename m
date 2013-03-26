Return-Path: <B38951@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BA9F82C0091
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2013 15:16:25 +1100 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: RE: [PATCH 1/2] powerpc/MPIC: Add get_version API both for internal
 and external use
Date: Tue, 26 Mar 2013 04:16:18 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D01C1C5AA@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1364268527-32068-1-git-send-email-hongtao.jia@freescale.com>
 <20130326041426.GC22382@concordia>
In-Reply-To: <20130326041426.GC22382@concordia>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Michael Ellerman [mailto:michael@ellerman.id.au]
> Sent: Tuesday, March 26, 2013 12:14 PM
> To: Jia Hongtao-B38951
> Cc: linuxppc-dev@lists.ozlabs.org; galak@kernel.crashing.org; Wood Scott-
> B07421
> Subject: Re: [PATCH 1/2] powerpc/MPIC: Add get_version API both for
> internal and external use
>=20
> On Tue, Mar 26, 2013 at 11:28:46AM +0800, Jia Hongtao wrote:
> > MPIC version is useful information for both mpic_alloc() and
> mpic_init().
> > The patch provide an API to get MPIC version for reusing the code.
> > Also, some other IP block may need MPIC version for their own use.
> > The API for external use is also provided.
> >
> > Signed-off-by: Jia Hongtao <hongtao.jia@freescale.com>
> > Signed-off-by: Li Yang <leoli@freescale.com>
> > ---
> >  arch/powerpc/include/asm/mpic.h |  3 +++
> >  arch/powerpc/sysdev/mpic.c      | 30 +++++++++++++++++++++++-------
> >  2 files changed, 26 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/powerpc/include/asm/mpic.h
> > b/arch/powerpc/include/asm/mpic.h index c0f9ef9..95053d6 100644
> > --- a/arch/powerpc/include/asm/mpic.h
> > +++ b/arch/powerpc/include/asm/mpic.h
> > @@ -393,6 +393,9 @@ struct mpic
> >  #define	MPIC_REGSET_STANDARD		MPIC_REGSET(0)	/* Original
> MPIC */
> >  #define	MPIC_REGSET_TSI108		MPIC_REGSET(1)	/* Tsi108/109
> PIC */
> >
> > +/* Get the mpic version */
> > +extern u32 mpic_primary_get_version(void);
> > +
> >  /* Allocate the controller structure and setup the linux irq descs
> >   * for the range if interrupts passed in. No HW initialization is
> >   * actually performed.
> > diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> > index d30e6a6..d6b6fb6 100644
> > --- a/arch/powerpc/sysdev/mpic.c
> > +++ b/arch/powerpc/sysdev/mpic.c
> > @@ -1165,10 +1165,31 @@ static struct irq_domain_ops mpic_host_ops =3D =
{
> >  	.xlate =3D mpic_host_xlate,
> >  };
> >
> > +static u32 mpic_get_version(struct mpic *mpic) {
> > +	u32 brr1;
> > +
> > +	brr1 =3D _mpic_read(mpic->reg_type, &mpic->thiscpuregs,
> > +			MPIC_FSL_BRR1);
> > +
> > +	return brr1 & MPIC_FSL_BRR1_VER;
> > +}
> > +
> >  /*
> >   * Exported functions
> >   */
> >
> > +u32 mpic_primary_get_version(void)
> > +{
> > +	u32 brr1;
> > +	struct mpic *mpic =3D mpic_primary;
> > +
> > +	brr1 =3D _mpic_read(mpic->reg_type, &mpic->thiscpuregs,
> > +			MPIC_FSL_BRR1);
> > +
> > +	return brr1 & MPIC_FSL_BRR1_VER;
> > +}
>=20
> Why doesn't mpic_primary_get_version() call mpic_get_version() ?
>=20
> cheers

Good idea.

Thanks.
-Hongtao.
