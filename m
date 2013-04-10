Return-Path: <B38951@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe004.messaging.microsoft.com [207.46.163.27])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A772B2C0092
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2013 12:35:18 +1000 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH V4] powerpc/MPIC: Add get_version API both for internal
 and external use
Date: Wed, 10 Apr 2013 02:35:13 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D01C35559@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1365386514-14647-1-git-send-email-hongtao.jia@freescale.com>
 <1365561148.29365.0@snotra>
In-Reply-To: <1365561148.29365.0@snotra>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Wednesday, April 10, 2013 10:32 AM
> To: Jia Hongtao-B38951
> Cc: linuxppc-dev@lists.ozlabs.org; galak@kernel.crashing.org; Wood Scott-
> B07421; Li Yang-R58472; Jia Hongtao-B38951
> Subject: Re: [PATCH V4] powerpc/MPIC: Add get_version API both for
> internal and external use
>=20
> On 04/07/2013 09:01:54 PM, Jia Hongtao wrote:
> > diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> > index d30e6a6..48c8fae 100644
> > --- a/arch/powerpc/sysdev/mpic.c
> > +++ b/arch/powerpc/sysdev/mpic.c
> > @@ -1165,10 +1165,30 @@ static struct irq_domain_ops mpic_host_ops =3D =
{
> >  	.xlate =3D mpic_host_xlate,
> >  };
> >
> > +static u32 fsl_mpic_get_version(struct mpic *mpic) {
> > +	u32 brr1;
> > +
> > +	brr1 =3D _mpic_read(mpic->reg_type, &mpic->thiscpuregs,
> > +			MPIC_FSL_BRR1);
> > +
> > +	return brr1 & MPIC_FSL_BRR1_VER;
> > +}
>=20
> If it's not an FSL mpic, thiscpuregs->base will be NULL.  Please check
> mpic->flags for MPIC_FSL.

I will add the check soon.

>=20
> > +
> >  /*
> >   * Exported functions
> >   */
> >
> > +u32 fsl_mpic_primary_get_version(void)
> > +{
> > +	struct mpic *mpic =3D mpic_primary;
> > +
> > +	if (mpic)
> > +		return fsl_mpic_get_version(mpic);
> > +
> > +	return 0;
> > +}
>=20
> ...especially since the external version doesn't check for it either.
>=20
> Otherwise, this and the MSI-X patch look OK to me.
>=20
> -Scott

Thanks.
-Hongtao.
