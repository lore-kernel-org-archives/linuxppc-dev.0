Return-Path: <r66093@freescale.com>
Received: from AM1EHSOBE005.bigfish.com (am1ehsobe005.messaging.microsoft.com
 [213.199.154.208])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 3A86AB6F65
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jan 2012 14:11:46 +1100 (EST)
Received: from mail92-am1 (localhost [127.0.0.1])	by mail92-am1-R.bigfish.com
 (Postfix) with ESMTP id 25564640410	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Jan 2012 03:11:40 +0000 (UTC)
Received: from AM1EHSMHS011.bigfish.com (unknown [10.3.201.249])	by
 mail92-am1.bigfish.com (Postfix) with ESMTP id 04626440043	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jan 2012 03:11:40 +0000 (UTC)
From: Huang Changming-R66093 <r66093@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH] DTS: fix the bug and add the chip compatible for eSDHC
Date: Wed, 4 Jan 2012 03:11:34 +0000
Message-ID: <8A2FC72B45BB5A4C9F801431E06AE48F1165E56C@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1324620659-7135-1-git-send-email-r66093@freescale.com>
 <4F01F721.7090407@freescale.com>
In-Reply-To: <4F01F721.7090407@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Tuesday, January 03, 2012 2:28 AM
> To: Huang Changming-R66093
> Cc: linuxppc-dev@lists.ozlabs.org; Huang Changming-R66093
> Subject: Re: [PATCH] DTS: fix the bug and add the chip compatible for
> eSDHC
>=20
> On 12/23/2011 12:10 AM, r66093@freescale.com wrote:
> > From: Jerry Huang <Chang-Ming.Huang@freescale.com>
> >
> > Accordint to latest kernel, the auto-cmd12 property should be
> > "sdhci,auto-cmd12", and according to the SDHC binding and the
> > workaround for the special chip, add the chip compatible for eSDHC:
> > "fsl,p1022-esdhc", "fsl,mpc8536-esdhc", "fsl,p2020-esdhc" and
> "fsl,p1010-esdhc".
> >
> > Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> > ---
> >  arch/powerpc/boot/dts/fsl/mpc8536si-post.dtsi |    4 ++++
> >  arch/powerpc/boot/dts/fsl/p1010si-post.dtsi   |    3 ++-
> >  arch/powerpc/boot/dts/fsl/p1022si-post.dtsi   |    3 ++-
> >  arch/powerpc/boot/dts/fsl/p2020si-post.dtsi   |    4 ++++
> >  4 files changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/powerpc/boot/dts/fsl/mpc8536si-post.dtsi
> > b/arch/powerpc/boot/dts/fsl/mpc8536si-post.dtsi
> > index 89af626..44e0ed9 100644
> > --- a/arch/powerpc/boot/dts/fsl/mpc8536si-post.dtsi
> > +++ b/arch/powerpc/boot/dts/fsl/mpc8536si-post.dtsi
> > @@ -236,6 +236,10 @@
> >  	};
> >
> >  /include/ "pq3-esdhc-0.dtsi"
> > +	sdhc@2e000 {
> > +		compatible =3D "fsl,esdhc", "fsl,mpc8536-esdhc";
> > +	};
>=20
> More-specific compatible entries should come first.

I don't understand you, why more-specific compatible entries should come?
The Documentation/devicetree/bindings/mmc/fsl-esdhc.txt has introduced it:
  - compatible : should be
    "fsl,<chip>-esdhc", "fsl,esdhc"
I don't think I should introduce new entries.
