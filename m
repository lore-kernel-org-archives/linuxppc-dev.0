Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0105.outbound.protection.outlook.com [157.56.111.105])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9609E1A03C6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 06:22:21 +1000 (AEST)
Message-ID: <1431634919.3868.204.camel@freescale.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-pltfm: enable interrupt mode to detect card
From: Scott Wood <scottwood@freescale.com>
To: Lu Yangbo-B47093 <yangbo.lu@freescale.com>
Date: Thu, 14 May 2015 15:21:59 -0500
In-Reply-To: <BY1PR0301MB1192B4134746A153763312A9F2D80@BY1PR0301MB1192.namprd03.prod.outlook.com>
References: <1431505246-40102-1-git-send-email-yangbo.lu@freescale.com>
 <1431535027.3868.44.camel@freescale.com>
 <BY1PR0301MB1192B4134746A153763312A9F2D80@BY1PR0301MB1192.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-05-14 at 01:29 -0500, Lu Yangbo-B47093 wrote:
> 
> 
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Thursday, May 14, 2015 12:37 AM
> > To: Lu Yangbo-B47093
> > Cc: linuxppc-dev@lists.ozlabs.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH 2/2] mmc: sdhci-pltfm: enable interrupt mode to
> > detect card
> > 
> > On Wed, 2015-05-13 at 16:20 +0800, Yangbo Lu wrote:
> > > Enable interrupt mode to detect card instead of polling mode for
> > > P1020/P4080/P5020/P5040/T1040 by removing the quirk
> > > SDHCI_QUIRK_BROKEN_CARD_DETECTION. This could improve data
> > > transferring performance and avoid the call trace caused by polling
> > > card status sometime.
> > >
> > > Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
> > > ---
> > >  drivers/mmc/host/sdhci-pltfm.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/drivers/mmc/host/sdhci-pltfm.c
> > > b/drivers/mmc/host/sdhci-pltfm.c index c5b01d6..62f4049 100644
> > > --- a/drivers/mmc/host/sdhci-pltfm.c
> > > +++ b/drivers/mmc/host/sdhci-pltfm.c
> > > @@ -102,6 +102,13 @@ void sdhci_get_of_property(struct platform_device
> > *pdev)
> > >  		    of_device_is_compatible(np, "fsl,mpc8536-esdhc"))
> > >  			host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
> > >
> > > +		if (of_device_is_compatible(np, "fsl,p5040-esdhc") ||
> > > +			of_device_is_compatible(np, "fsl,p5020-esdhc") ||
> > > +			of_device_is_compatible(np, "fsl,p4080-esdhc") ||
> > > +			of_device_is_compatible(np, "fsl,p1020-esdhc") ||
> > > +			of_device_is_compatible(np, "fsl,t1040-esdhc"))
> > > +			host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
> > 
> > Please don't line up continuation lines with the if-body.  All of the
> > "of_device_is_compatibles" should start in the same column.
> Ok, thanks.
> > 
> > Given that you need to modify the device tree for this, why not just use
> > SVR?
> The drivers/mmc/host/sdhci-pltfm.c is not only used by freescale platform. So we couldn’t to use SVR here.
> Thanks. 

I'm sure there'd be ways of rearranging it to make it work, but OK.

Please send these patches to the MMC list and maintainer (and CC me).  I
can ACK the first one or apply it separately.

-Scott
