Return-Path: <LeoLi@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 700CCDDF3D
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Aug 2008 13:35:26 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m773ZKFS010156
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Aug 2008 20:35:20 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m773ZI0v023923
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Aug 2008 22:35:19 -0500 (CDT)
Subject: Re: [PATCH 4/6] powerpc: add USB peripheral support to MPC8272ADS
From: Li Yang <leoli@freescale.com>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20080806171949.GA3138@ld0162-tx32.am.freescale.net>
References: <1218006285-27138-1-git-send-email-leoli@freescale.com>
	<1218006285-27138-2-git-send-email-leoli@freescale.com>
	<1218006285-27138-3-git-send-email-leoli@freescale.com>
	<1218006285-27138-4-git-send-email-leoli@freescale.com>
	<20080806171949.GA3138@ld0162-tx32.am.freescale.net>
Content-Type: text/plain
Date: Thu, 07 Aug 2008 11:50:14 +0800
Message-Id: <1218081014.29628.9.camel@Gundam>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: leoli@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-08-06 at 12:19 -0500, Scott Wood wrote:
> On Wed, Aug 06, 2008 at 03:04:43PM +0800, Li Yang wrote:
> > Signed-off-by: Li Yang <leoli@freescale.com>
> > ---
> >  arch/powerpc/boot/dts/mpc8272ads.dts      |    8 ++++++++
> >  arch/powerpc/platforms/82xx/mpc8272_ads.c |   25 +++++++++++++++++++++++++
> >  arch/powerpc/platforms/82xx/pq2ads.h      |    3 +++
> >  3 files changed, 36 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/powerpc/boot/dts/mpc8272ads.dts b/arch/powerpc/boot/dts/mpc8272ads.dts
> > index b2ce4c0..75cc94c 100644
> > --- a/arch/powerpc/boot/dts/mpc8272ads.dts
> > +++ b/arch/powerpc/boot/dts/mpc8272ads.dts
> > @@ -256,6 +256,14 @@
> >  				#address-cells = <1>;
> >  				#size-cells = <0>;
> >  			};
> > +
> > +			usb@11b60 {
> > +				compatible = "fsl,qe_udc";
> 
> "fsl,mpc8272-usb", "fsl,cpm2-usb".
> 
> Where is fsl,qe_udc documented or used (other than in the BCSR setup)?
> What does "udc" mean (the only reference to it in the 8272 manual is
> under ATM)?

udc is a common name for USB device mode drivers to work with Linux
gadget.  We will have two separate drivers for USB host and device.
Probably we can have two compatibles "fsl,qe_udc" and "fsl,qe-usb-host"

- Leo
