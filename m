Return-Path: <B07421@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0186.outbound.messaging.microsoft.com [213.199.154.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3B9922C00AC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2013 13:07:49 +1000 (EST)
Date: Tue, 9 Apr 2013 22:07:35 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH V4] powerpc/MPIC: Add get_version API both for internal
 and external use
To: Jia Hongtao-B38951 <B38951@freescale.com>
References: <1365386514-14647-1-git-send-email-hongtao.jia@freescale.com>
 <1365561148.29365.0@snotra>
 <412C8208B4A0464FA894C5F0C278CD5D01C3557B@039-SN1MPN1-003.039d.mgd.msft.net>
In-Reply-To: <412C8208B4A0464FA894C5F0C278CD5D01C3557B@039-SN1MPN1-003.039d.mgd.msft.net>
 (from B38951@freescale.com on Tue Apr  9 22:04:44 2013)
Message-ID: <1365563255.29365.1@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/09/2013 10:04:44 PM, Jia Hongtao-B38951 wrote:
>=20
>=20
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Wednesday, April 10, 2013 10:32 AM
> > To: Jia Hongtao-B38951
> > Cc: linuxppc-dev@lists.ozlabs.org; galak@kernel.crashing.org; Wood =20
> Scott-
> > B07421; Li Yang-R58472; Jia Hongtao-B38951
> > Subject: Re: [PATCH V4] powerpc/MPIC: Add get_version API both for
> > internal and external use
> >
> > On 04/07/2013 09:01:54 PM, Jia Hongtao wrote:
> > > diff --git a/arch/powerpc/sysdev/mpic.c =20
> b/arch/powerpc/sysdev/mpic.c
> > > index d30e6a6..48c8fae 100644
> > > --- a/arch/powerpc/sysdev/mpic.c
> > > +++ b/arch/powerpc/sysdev/mpic.c
> > > @@ -1165,10 +1165,30 @@ static struct irq_domain_ops =20
> mpic_host_ops =3D {
> > >  	.xlate =3D mpic_host_xlate,
> > >  };
> > >
> > > +static u32 fsl_mpic_get_version(struct mpic *mpic) {
> > > +	u32 brr1;
> > > +
> > > +	brr1 =3D _mpic_read(mpic->reg_type, &mpic->thiscpuregs,
> > > +			MPIC_FSL_BRR1);
> > > +
> > > +	return brr1 & MPIC_FSL_BRR1_VER;
> > > +}
> >
> > If it's not an FSL mpic, thiscpuregs->base will be NULL.  Please =20
> check
> > mpic->flags for MPIC_FSL.
> >
> > > +
> > >  /*
> > >   * Exported functions
> > >   */
> > >
> > > +u32 fsl_mpic_primary_get_version(void)
> > > +{
> > > +	struct mpic *mpic =3D mpic_primary;
> > > +
> > > +	if (mpic)
> > > +		return fsl_mpic_get_version(mpic);
> > > +
> > > +	return 0;
> > > +}
> >
> > ...especially since the external version doesn't check for it =20
> either.
> >
> > Otherwise, this and the MSI-X patch look OK to me.
> >
> > -Scott
>=20
>=20
> Since all the functions including mpic_alloc() and mpic_init() do the
> check for MPIC_FSL before using fsl_mpic_get_version() I'd like to add
> check just for fsl_mpic_primary_get_version().
>=20
> It will be like this:
> u32 fsl_mpic_primary_get_version(void)
> {
>         struct mpic *mpic =3D mpic_primary;
>=20
>         if (mpic && (mpic->flags & MPIC_FSL))
>                 return fsl_mpic_get_version(mpic);
>=20
>         return 0;
> }
>=20
> Could we reach an agreement here?

Is there any particular reason?  It would be more robust and more =20
consistent if the check were done in fsl_mpic_get_version().

-Scott=
