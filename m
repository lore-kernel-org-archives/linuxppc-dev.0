Return-Path: <alistair@popple.id.au>
Received: from ipmail04.adl6.internode.on.net (ipmail04.adl6.internode.on.net
 [IPv6:2001:44b8:8060:ff02:300:1:6:4])
 by ozlabs.org (Postfix) with ESMTP id 9C8482C0212
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Feb 2014 11:38:36 +1100 (EST)
From: Alistair Popple <alistair@popple.id.au>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/7] IBM Akebono: Add a SDHCI platform driver
Date: Mon, 24 Feb 2014 11:38:30 +1100
Message-ID: <278655068.asy5NBOYab@mexican>
In-Reply-To: <1773685.WfxOP0FuHM@wuerfel>
References: <1392964293-13687-1-git-send-email-alistair@popple.id.au>
 <1392964293-13687-2-git-send-email-alistair@popple.id.au>
 <1773685.WfxOP0FuHM@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: devicetree@vger.kernel.org, cjb@laptop.org, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 21 Feb 2014 15:14:30 Arnd Bergmann wrote:
> On Friday 21 February 2014 17:31:27 Alistair Popple wrote:
> > +config MMC_SDHCI_OF_476GTR
> > +	tristate "SDHCI OF support for the IBM PPC476GTR SoC"
> > +	depends on MMC_SDHCI_PLTFM
> > +	depends on PPC_OF
> > +	help
> > +	  This selects the Secure Digital Host Controller Interface (SDHCI)
> > +	  found on the PPC476GTR SoC.
> > +
> > +	  If you have a controller with this interface, say Y or M here.
> > +
> > +	  If unsure, say N.
> 
> Your driver doesn't actually do anything beyond what is in the common
> sdhci-pltfm.c infrastructure. IMHO you really shoulnd't need a SoC
> specific abstraction for it at all and instead add a generic
> platform driver registration into sdhci-pltfm.c. I'd suggest
> you use "generic-sdhci" (similar to what we do for usb-ohci and usb-ehci
> now) as the compatible string and change your device tree to claim
> compatibility with that and your soc-specific string.

That's a reasonable point. I guess I was just following the example set by the 
other sdhci-* drivers. However on review they're not as generic as this one so 
I will merge this into sdhci-pltfm.c as suggested.

- Alistair

> 	Arnd
