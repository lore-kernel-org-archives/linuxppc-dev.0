Return-Path: <B07421@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe001.messaging.microsoft.com [213.199.154.204])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3489C2C013C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2013 04:50:57 +1100 (EST)
Date: Tue, 2 Apr 2013 12:49:34 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2] powerpc/85xx: workaround for chips with MSI
 hardware errata
To: Jia Hongtao-B38951 <B38951@freescale.com>
References: <1364268527-32068-2-git-send-email-hongtao.jia@freescale.com>
 <1364594074.13310.13@snotra>
 <412C8208B4A0464FA894C5F0C278CD5D01C32364@039-SN1MPN1-003.039d.mgd.msft.net>
In-Reply-To: <412C8208B4A0464FA894C5F0C278CD5D01C32364@039-SN1MPN1-003.039d.mgd.msft.net>
 (from B38951@freescale.com on Tue Apr  2 01:35:05 2013)
Message-ID: <1364924974.24520.8@snotra>
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

On 04/02/2013 01:35:05 AM, Jia Hongtao-B38951 wrote:
>=20
>=20
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Saturday, March 30, 2013 5:55 AM
> > To: Jia Hongtao-B38951
> > Cc: linuxppc-dev@lists.ozlabs.org; galak@kernel.crashing.org; Wood =20
> Scott-
> > B07421; Li Yang-R58472; Jia Hongtao-B38951
> > Subject: Re: [PATCH 2/2] powerpc/85xx: workaround for chips with MSI
> > hardware errata
> >
> > On 03/25/2013 10:28:47 PM, Jia Hongtao wrote:
> > > The MPIC version 2.0 has a MSI errata (errata PIC1 of mpc8544), It
> > > causes that neither MSI nor MSI-X can work fine. This is a =20
> workaround
> > > to allow MSI-X to function properly.
> > >
> > > Signed-off-by: Liu Shuo <soniccat.liu@gmail.com>
> > > Signed-off-by: Li Yang <leoli@freescale.com>
> > > Signed-off-by: Jia Hongtao <hongtao.jia@freescale.com>
> > > ---
> > >  arch/powerpc/sysdev/fsl_msi.c | 47
> > > ++++++++++++++++++++++++++++++++++++++++---
> > >  1 file changed, 44 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/arch/powerpc/sysdev/fsl_msi.c
> > > b/arch/powerpc/sysdev/fsl_msi.c index 178c994..d2f8040 100644
> > > --- a/arch/powerpc/sysdev/fsl_msi.c
> > > +++ b/arch/powerpc/sysdev/fsl_msi.c
> > > @@ -28,6 +28,8 @@
> > >  #include "fsl_msi.h"
> > >  #include "fsl_pci.h"
> > >
> > > +#define MSI_HW_ERRATA_ENDIAN 0x00000010
>=20
> It seems Kumar like put this just in fsl_msi.c.
> Here is the comments from Kumar few days ago:
>=20
> "Is there any reason to put this in fsl_msi.h rather than just in
> fsl_msi.c itself?"
>=20
> I think the all the #defines should be together.
> Ether all in .h or all in .c.
>=20
> In this case I prefer your idea.

I don't care which file they go in (though .c is probably better if =20
they don't need wider visibility), just as long as they're together.

-Scott=
