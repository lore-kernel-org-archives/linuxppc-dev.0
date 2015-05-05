Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5DC0E1A078D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 May 2015 20:04:06 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] sdhci-of-esdhc: Support 8BIT bus width.
Date: Tue, 05 May 2015 12:03:58 +0200
Message-ID: <2759482.d3jNK4pMnc@wuerfel>
In-Reply-To: <1430774247.27859.62.camel@transmode.se>
References: <1430757092-15847-1-git-send-email-joakim.tjernlund@transmode.se>
 <2384804.XbcbTBBFP9@wuerfel> <1430774247.27859.62.camel@transmode.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday 04 May 2015 21:17:27 Joakim Tjernlund wrote:
> On Mon, 2015-05-04 at 19:31 +0200, Arnd Bergmann wrote:
> > On Monday 04 May 2015 18:31:31 Joakim Tjernlund wrote:
> > > @@ -252,6 +260,8 @@ static void esdhc_of_platform_init(struct sdhci_host *host)
> > >  
> > >         if (vvn > VENDOR_V_22)
> > >                 host->quirks &= ~SDHCI_QUIRK_NO_BUSY_IRQ;
> > > +
> > > +       host->mmc->caps |= MMC_CAP_8_BIT_DATA;
> > >  }
> > > 
> > 
> > Shouldn't this check the "bus-width" property before setting the width?
> > 
> > There might be an eMMC or SDIO with 4-bit interface connected.
> 
> This is for an eMMC chip we got and I THINK(this is new to me) that
> this only allows 8 bit negotiation but I might be way off.
>  
> Anyone knows for sure?
> 

Most mmc host controllers can work with both eMMC and SD cards or
some of the less common variants (SDIO, eSD, MMC, ...), and most of those
are not 8 bit wide.

	Arnd
