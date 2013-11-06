Return-Path: <alistair@popple.id.au>
Received: from ipmail06.adl2.internode.on.net (ipmail06.adl2.internode.on.net
 [IPv6:2001:44b8:8060:ff02:300:1:2:6])
 by ozlabs.org (Postfix) with ESMTP id 1ABE22C033E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Nov 2013 12:34:06 +1100 (EST)
From: Alistair Popple <alistair@popple.id.au>
To: Ben Hutchings <bhutchings@solarflare.com>
Subject: Re: [PATCH 3/7] IBM Akebono: Add support for a new PHY to the IBM
 emac driver
Date: Wed, 06 Nov 2013 12:34:30 +1100
Message-ID: <3555701.fBbreSn0Lp@mexican>
In-Reply-To: <1383693110.2868.17.camel@bwh-desktop.uk.level5networks.com>
References: <1383629471-16979-1-git-send-email-alistair@popple.id.au>
 <1383681240.4776.97.camel@pasglop>
 <1383693110.2868.17.camel@bwh-desktop.uk.level5networks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>,
 netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 5 Nov 2013 23:11:50 Ben Hutchings wrote:
> On Wed, 2013-11-06 at 06:54 +1100, Benjamin Herrenschmidt wrote:

[snip]

> > It's an SoC bit so there's little point making it generally
> > selectable by the user.
> 
> I think a better way to do this is:
> 
> config IBM_EMAC_RGMII_WOL
> 	bool "IBM EMAC RGMII wake-on-LAN support"
> 	depends on MY_WONDERFUL_NEW_SOC || COMPILE_TEST
> 	default y if MY_WONDERFUL_NEW_SOC
> 
> Then anyone making an API change that affects this driver can check that
> it still complies.

The method used in this patch is the same as what is currently used by the 
other IBM EMAC PHY interfaces (eg. config IBM_EMAC_ZMII etc). I'm happy to 
send a patch to update all of those as well for consistency but that would 
mean adding what each platform requires into EMACS Kconfig as well.

Personally I think it is nicer to keep the definitions of what each platform 
requires in one place (ie. arch/powerpc/platforms/44x/Kconfig) as it is 
consistent with what we do for other 44x drivers, however I am happy to use 
the above method if people think it's better.

Alternatively we could do something like this:

config IBM_EMAC_RGMII_WOL
        bool
        default y if COMPILE_TEST
        default n

This would leave the platform dependencies as they are currently but still 
allow compile testing.

Regards,

Alistair

> Ben.
> 
> > Alistair: The commit name should be different, it's not a PHY you are
> > adding, it's a PHY interface (the PHY itself is off chip).
