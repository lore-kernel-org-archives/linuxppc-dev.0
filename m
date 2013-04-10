Return-Path: <B38951@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe004.messaging.microsoft.com [216.32.180.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 22C692C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2013 13:26:56 +1000 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH V4] powerpc/MPIC: Add get_version API both for internal
 and external use
Date: Wed, 10 Apr 2013 03:26:17 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D01C355EB@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1365386514-14647-1-git-send-email-hongtao.jia@freescale.com>
 <1365561148.29365.0@snotra>
 <412C8208B4A0464FA894C5F0C278CD5D01C3557B@039-SN1MPN1-003.039d.mgd.msft.net>
 <1365563255.29365.1@snotra>
 <412C8208B4A0464FA894C5F0C278CD5D01C35599@039-SN1MPN1-003.039d.mgd.msft.net>
 <1365563520.29365.2@snotra>
 <412C8208B4A0464FA894C5F0C278CD5D01C355B5@039-SN1MPN1-003.039d.mgd.msft.net>
 <1365564008.29365.3@snotra>
In-Reply-To: <1365564008.29365.3@snotra>
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
> Sent: Wednesday, April 10, 2013 11:20 AM
> To: Jia Hongtao-B38951
> Cc: Wood Scott-B07421; linuxppc-dev@lists.ozlabs.org;
> galak@kernel.crashing.org; Li Yang-R58472
> Subject: Re: [PATCH V4] powerpc/MPIC: Add get_version API both for
> internal and external use
>=20
> On 04/09/2013 10:14:06 PM, Jia Hongtao-B38951 wrote:
> >
> >
> > > -----Original Message-----
> > > From: Wood Scott-B07421
> > > Sent: Wednesday, April 10, 2013 11:12 AM
> > > To: Jia Hongtao-B38951
> > > Cc: Wood Scott-B07421; linuxppc-dev@lists.ozlabs.org;
> > > galak@kernel.crashing.org; Li Yang-R58472
> > > Subject: Re: [PATCH V4] powerpc/MPIC: Add get_version API both for
> > > internal and external use
> > >
> > > On 04/09/2013 10:10:37 PM, Jia Hongtao-B38951 wrote:
> > > >
> > > >
> > > > > -----Original Message-----
> > > > > From: Wood Scott-B07421
> > > > > Sent: Wednesday, April 10, 2013 11:08 AM
> > > > > To: Jia Hongtao-B38951
> > > > > Cc: Wood Scott-B07421; linuxppc-dev@lists.ozlabs.org;
> > > > > galak@kernel.crashing.org; Li Yang-R58472
> > > > > Subject: Re: [PATCH V4] powerpc/MPIC: Add get_version API both
> > for
> > > > > internal and external use
> > > > >
> > > > > On 04/09/2013 10:04:44 PM, Jia Hongtao-B38951 wrote:
> > > > > > Since all the functions including mpic_alloc() and
> > mpic_init() do
> > > > the
> > > > > > check for MPIC_FSL before using fsl_mpic_get_version() I'd
> > like
> > > > to add
> > > > > > check just for fsl_mpic_primary_get_version().
> > > > > >
> > > > > > It will be like this:
> > > > > > u32 fsl_mpic_primary_get_version(void)
> > > > > > {
> > > > > >         struct mpic *mpic =3D mpic_primary;
> > > > > >
> > > > > >         if (mpic && (mpic->flags & MPIC_FSL))
> > > > > >                 return fsl_mpic_get_version(mpic);
> > > > > >
> > > > > >         return 0;
> > > > > > }
> > > > > >
> > > > > > Could we reach an agreement here?
> > > > >
> > > > > Is there any particular reason?  It would be more robust and
> > more
> > > > > consistent if the check were done in fsl_mpic_get_version().
> > > > >
> > > > > -Scott
> > > >
> > > > I found out that all the functions using fsl_mpic_get_version()
> > have
> > > > already done the check. Adding the check in fsl_mpic_get_version()
> > > > will cause duplicate check there. This is my consideration.
> > >
> > > Does that duplicate check cause any harm?
> > >
> > > -Scott
> >
> > No harm at all just not necessary.
>=20
> Not *necessary*, but makes it more robust and more consistent.
>=20
> > I wonder if I could add check in fsl_mpic_get_version() and remove
> > all the
> > check from functions in which using fsl_mpic_get_version()?
>=20
> One of the two places that calls it is the place that maps thiscpuregs
> in the first place, so no. :-)

Reasonable enough.
I will just add check in fsl_mpic_get_version().

Thanks.
-Hongtao.

>=20
> The check in mpic_init() for the number of timers could perhaps have
> the check removed if we're comfortable equating a version of zero with
> a non-FSL MPIC.  This really isn't something that's worth worrying
> about, though.
>=20
> -Scott
