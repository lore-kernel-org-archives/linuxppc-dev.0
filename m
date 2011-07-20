Return-Path: <sr@denx.de>
Received: from mo-p05-ob6.rzone.de (mo-p05-ob6.rzone.de
	[IPv6:2a01:238:20a:202:53f5::1])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 19956B6F75
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Jul 2011 17:18:51 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] net: ibm_newemac: Don't start autonegotiation when
	disabled in BMCR (genmii)
Date: Wed, 20 Jul 2011 09:18:34 +0200
References: <1311072604-24840-1-git-send-email-sr@denx.de>
	<201107191359.57421.sr@denx.de>
	<1311078570.25044.421.camel@pasglop>
In-Reply-To: <1311078570.25044.421.camel@pasglop>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201107200918.34873.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 19 July 2011 14:29:30 Benjamin Herrenschmidt wrote:
> > I feel that this BMCR_ANENABLE bit should be evaluated, but I have no
> > strong preference here. If you prefer that this should be handled via a
> > new dt property (phy-aneg = "disabled" ?), I can implement it this way.
> > Just let me know.
> 
> Don't we already have some bindings for PHY with a fixed setting ? I
> don't remember off hand, we need to dbl check.

The only related PHY property I found is "fixed-link" used in fs_enet-main.c. 
None in the emac driver. Here the description for "fixed-link":

Documentation/devicetree/bindings/net/fsl-tsec-phy.txt:

  - fixed-link : <a b c d e> where a is emulated phy id - choose any,
    but unique to the all specified fixed-links, b is duplex - 0 half,
    1 full, c is link speed - d#10/d#100/d#1000, d is pause - 0 no
    pause, 1 pause, e is asym_pause - 0 no asym_pause, 1 asym_pause.

But what I really want to achieve, is to skip auto-negotiation (use the 
strapped configuration). And not to define this fixed configuration (again) in 
the device-tree. So I would prefer something like phy-aneg = "disabled".

What do you think?

Thanks,
Stefan
