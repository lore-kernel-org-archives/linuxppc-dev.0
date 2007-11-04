Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0CFA3DDE48
	for <linuxppc-dev@ozlabs.org>; Sun,  4 Nov 2007 14:39:05 +1100 (EST)
Subject: Re: [PATCH] net: Add 405EX support to new EMAC driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20071102160304.GA5277@lixom.net>
References: <200711020814.43524.sr@denx.de> <20071102160304.GA5277@lixom.net>
Content-Type: text/plain
Date: Sun, 04 Nov 2007 14:37:59 +1100
Message-Id: <1194147479.6511.11.camel@pasglop>
Mime-Version: 1.0
Cc: netdev@vger.kernel.org, Stefan Roese <sr@denx.de>, linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2007-11-02 at 11:03 -0500, Olof Johansson wrote:
> On Fri, Nov 02, 2007 at 08:14:43AM +0100, Stefan Roese wrote:
> > This patch adds support for the 405EX to the new EMAC driver. Some as on
> > AXON, the 405EX handles the MDIO via the RGMII bridge.
> 
> Hi,
> 
> This isn't feedback on your patch as much as on "new-emac" in general:
> 
> Isn't this the case where there should really be device tree properties
> instead? If you had an "ibm,emac-has-axon-stacr" property in the device
> node, then you don't have to modify the driver for every new board out
> there. Same for the other device properties, of course.
> 
> I thought this was what having the device tree was all about. :(

Somewhat yeah. There are subtle variations here or there we haven't
totally indenfified... It might be a better option in our case here to
add "has-mdio" to the rgmii nodes indeed.

Part of the problem with those cells is that the chip folks keep
changing things subtly from one rev to another though, it's not even
totally clear to me yet whether the RGMII registers are totally
compatible betwee axon and 405ex, which is why I've pretty much stuck to
"compatible" properties to identify the variants.

The device-tree can do both. It's still better than no device-tree since
at least you know what cell variant is in there.

As for the STACR, Axon isn't the first one to have that bit flipped, I
think we should name the property differently, something like
"stacr-oc-inverted".

We can still use properties that way for new things in fact. As for EMAC
on cell, well, I can always put some fixup somewhere.

Ben. 
