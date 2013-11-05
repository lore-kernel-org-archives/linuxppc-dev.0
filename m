Return-Path: <bhutchings@solarflare.com>
Received: from webmail.solarflare.com (webmail.solarflare.com [12.187.104.25])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "WEBMAIL.SOLARFLARE.COM",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 084922C0331
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Nov 2013 10:11:58 +1100 (EST)
Message-ID: <1383693110.2868.17.camel@bwh-desktop.uk.level5networks.com>
Subject: Re: [PATCH 3/7] IBM Akebono: Add support for a new PHY to the IBM
 emac driver
From: Ben Hutchings <bhutchings@solarflare.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 5 Nov 2013 23:11:50 +0000
In-Reply-To: <1383681240.4776.97.camel@pasglop>
References: <1383629471-16979-1-git-send-email-alistair@popple.id.au>
 <1383629471-16979-3-git-send-email-alistair@popple.id.au>
 <1383675404.2868.8.camel@bwh-desktop.uk.level5networks.com>
 <1383681240.4776.97.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Alistair Popple <alistair@popple.id.au>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-11-06 at 06:54 +1100, Benjamin Herrenschmidt wrote:
> On Tue, 2013-11-05 at 18:16 +0000, Ben Hutchings wrote:
> > On Tue, 2013-11-05 at 16:31 +1100, Alistair Popple wrote:
> > [...]
> > > --- a/drivers/net/ethernet/ibm/emac/Kconfig
> > > +++ b/drivers/net/ethernet/ibm/emac/Kconfig
> > > @@ -55,6 +55,10 @@ config IBM_EMAC_RGMII
> > >  	bool
> > >  	default n
> > >  
> > > +config IBM_EMAC_RGMII_WOL
> > > +	bool
> > > +	default n
> > > +
> > [...]
> > 
> > So no-one can even build-test this at present!
> 
> Patch 7/7 adds the select to the platform, isn't that sufficient ?

I suppose so, but I don't think that went to netdev.

> It's an SoC bit so there's little point making it generally
> selectable by the user.

I think a better way to do this is:

config IBM_EMAC_RGMII_WOL
	bool "IBM EMAC RGMII wake-on-LAN support"
	depends on MY_WONDERFUL_NEW_SOC || COMPILE_TEST
	default y if MY_WONDERFUL_NEW_SOC

Then anyone making an API change that affects this driver can check that
it still complies.

Ben.

> Alistair: The commit name should be different, it's not a PHY you are
> adding, it's a PHY interface (the PHY itself is off chip).


-- 
Ben Hutchings, Staff Engineer, Solarflare
Not speaking for my employer; that's the marketing department's job.
They asked us to note that Solarflare product names are trademarked.
