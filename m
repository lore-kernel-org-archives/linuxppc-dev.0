Return-Path: <B38951@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0C64F2C011A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Apr 2013 17:19:58 +1100 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH V2] powerpc/MPIC: Add get_version API both for internal
 and external use
Date: Tue, 2 Apr 2013 06:19:24 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D01C3233E@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1364275690-26790-1-git-send-email-hongtao.jia@freescale.com>
 <1364593919.13310.12@snotra> <1364594122.13310.14@snotra>
In-Reply-To: <1364594122.13310.14@snotra>
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
> To: Wood Scott-B07421
> Cc: Jia Hongtao-B38951; linuxppc-dev@lists.ozlabs.org;
> galak@kernel.crashing.org; Wood Scott-B07421; Li Yang-R58472; Jia
> Hongtao-B38951
> Subject: Re: [PATCH V2] powerpc/MPIC: Add get_version API both for
> internal and external use
>=20
> On 03/29/2013 04:51:59 PM, Scott Wood wrote:
> > On 03/26/2013 12:28:10 AM, Jia Hongtao wrote:
> >> diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> >> index d30e6a6..c893a4b 100644
> >> --- a/arch/powerpc/sysdev/mpic.c
> >> +++ b/arch/powerpc/sysdev/mpic.c
> >> @@ -1165,10 +1165,27 @@ static struct irq_domain_ops mpic_host_ops =3D
> >> {
> >>  	.xlate =3D mpic_host_xlate,
> >>  };
> >>
> >> +static u32 mpic_get_version(struct mpic *mpic) {
> >> +	u32 brr1;
> >> +
> >> +	brr1 =3D _mpic_read(mpic->reg_type, &mpic->thiscpuregs,
> >> +			MPIC_FSL_BRR1);
> >> +
> >> +	return brr1 & MPIC_FSL_BRR1_VER;
> >> +}
> >> +
> >>  /*
> >>   * Exported functions
> >>   */
> >>
> >> +u32 mpic_primary_get_version(void)
> >> +{
> >> +	struct mpic *mpic =3D mpic_primary;
> >> +
> >> +	return mpic_get_version(mpic);
> >> +}
> >
> > So this just crashes if there is no mpic_primary or it's a non-FSL
> > MPIC?
>=20
> ...and since it's specifically checking for the FSL version, "fsl"
> should be in the name.
>=20
> -Scott

Right, I will update it with next version.

- Hongtao.
