Return-Path: <B38951@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe002.messaging.microsoft.com [216.32.180.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5B1E22C0092
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Apr 2013 17:35:22 +1100 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>, "galak@kernel.crashing.org"
 <galak@kernel.crashing.org>
Subject: RE: [PATCH 2/2] powerpc/85xx: workaround for chips with MSI
 hardware errata
Date: Tue, 2 Apr 2013 06:35:05 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D01C32364@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1364268527-32068-2-git-send-email-hongtao.jia@freescale.com>
 (from hongtao.jia@freescale.com on Mon Mar 25 22:28:47 2013)
 <1364594074.13310.13@snotra>
In-Reply-To: <1364594074.13310.13@snotra>
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
> Sent: Saturday, March 30, 2013 5:55 AM
> To: Jia Hongtao-B38951
> Cc: linuxppc-dev@lists.ozlabs.org; galak@kernel.crashing.org; Wood Scott-
> B07421; Li Yang-R58472; Jia Hongtao-B38951
> Subject: Re: [PATCH 2/2] powerpc/85xx: workaround for chips with MSI
> hardware errata
>=20
> On 03/25/2013 10:28:47 PM, Jia Hongtao wrote:
> > The MPIC version 2.0 has a MSI errata (errata PIC1 of mpc8544), It
> > causes that neither MSI nor MSI-X can work fine. This is a workaround
> > to allow MSI-X to function properly.
> >
> > Signed-off-by: Liu Shuo <soniccat.liu@gmail.com>
> > Signed-off-by: Li Yang <leoli@freescale.com>
> > Signed-off-by: Jia Hongtao <hongtao.jia@freescale.com>
> > ---
> >  arch/powerpc/sysdev/fsl_msi.c | 47
> > ++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 44 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/powerpc/sysdev/fsl_msi.c
> > b/arch/powerpc/sysdev/fsl_msi.c index 178c994..d2f8040 100644
> > --- a/arch/powerpc/sysdev/fsl_msi.c
> > +++ b/arch/powerpc/sysdev/fsl_msi.c
> > @@ -28,6 +28,8 @@
> >  #include "fsl_msi.h"
> >  #include "fsl_pci.h"
> >
> > +#define MSI_HW_ERRATA_ENDIAN 0x00000010

It seems Kumar like put this just in fsl_msi.c.
Here is the comments from Kumar few days ago:

"Is there any reason to put this in fsl_msi.h rather than just in=20
fsl_msi.c itself?"

I think the all the #defines should be together.
Ether all in .h or all in .c.

In this case I prefer your idea.

>=20
> This should probably be kept in the same place as the other
> msi->features definitions (e.g. FSL_PIC_IP_*).
>=20
> > +/* MPIC version 2.0 has erratum PIC1 */ static int
> > +mpic_has_errata(void) {
> > +	if (mpic_primary_get_version() =3D=3D 0x0200)
> > +		return 1;
> > +
> > +	return 0;
> > +}
>=20
> mpic_has_erratum_pic1()

You are right.
Good advice.

>=20
> > +	if ((features->fsl_pic_ip & FSL_PIC_IP_MASK) =3D=3D
> > FSL_PIC_IP_MPIC) {
> > +		rc =3D mpic_has_errata();
> > +		if (rc > 0) {
> > +			msi->feature |=3D MSI_HW_ERRATA_ENDIAN;
> > +		} else if (rc < 0) {
> > +			err =3D rc;
> > +			goto error_out;
> > +		}
>=20
> When would mpic_has_errata() ever return a negative value (maybe
> mpic_primary_get_version could fail, but you don't allow for that in the
> interface)?
>=20
> If you're not going to add a way for errors to be returned back, just
> do:
>=20
> if (mpic_has_erratum_pic1())
> 	msi->feature |=3D MSI_HW_ERRATA_ENDIAN;
>=20
> -Scott

I will update the mpic_primary_get_version() and it will return 0 if failed=
.
Based on the new mpic_primary_get_version() I agree with this.

Thanks.
-Hongtao.
