Return-Path: <SRS0=2sc5=P6=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id 63897DDDE6
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Nov 2007 20:19:04 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: benh@kernel.crashing.org
Subject: Re: [PATCH] net: Add 405EX support to new EMAC driver
Date: Mon, 5 Nov 2007 10:19:03 +0100
References: <200711020814.43524.sr@denx.de> <20071102160304.GA5277@lixom.net>
	<1194147479.6511.11.camel@pasglop>
In-Reply-To: <1194147479.6511.11.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200711051019.04287.sr@denx.de>
Cc: Olof Johansson <olof@lixom.net>, netdev@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday 04 November 2007, Benjamin Herrenschmidt wrote:
> > Isn't this the case where there should really be device tree properties
> > instead? If you had an "ibm,emac-has-axon-stacr" property in the device
> > node, then you don't have to modify the driver for every new board out
> > there. Same for the other device properties, of course.
> >
> > I thought this was what having the device tree was all about. :(
>
> Somewhat yeah. There are subtle variations here or there we haven't
> totally indenfified... It might be a better option in our case here to
> add "has-mdio" to the rgmii nodes indeed.

So how exactly do you want me to handle this (I'm still new to this device 
tree stuff, so please bear with me)? Like this?

			RGMII0: emac-rgmii@ef601000 {
				device_type = "rgmii-interface";
				compatible = "ibm,rgmii-405ex", "ibm,rgmii";
				reg = <ef601000 8>;
				has-mdio;
			};

Or add this to the compatible property?

			RGMII0: emac-rgmii@ef601000 {
				device_type = "rgmii-interface";
				compatible = "ibm,rgmii-405ex", "ibm,rgmii", "ibm,has-mdio";
				reg = <ef601000 8>;
			};

> Part of the problem with those cells is that the chip folks keep
> changing things subtly from one rev to another though, it's not even
> totally clear to me yet whether the RGMII registers are totally
> compatible betwee axon and 405ex, which is why I've pretty much stuck to
> "compatible" properties to identify the variants.
>
> The device-tree can do both. It's still better than no device-tree since
> at least you know what cell variant is in there.
>
> As for the STACR, Axon isn't the first one to have that bit flipped, I
> think we should name the property differently, something like
> "stacr-oc-inverted".

It's not only the OC bit-flip on AXON, but also the different STACR register 
layout for read/write op-codes (STAOPC). This seems to be the same on all new 
EMAC core's like on AXON, 440EPx/GRx and 405EX. So "stacr-oc-inverted" is not 
enough here. This is what is needed for 440SPe, which "only" has the bit-flip 
and the "old" STAOPC layout.

So perhaps most flexible would be to add individual properties, 
like "stacr-oc-inverted" and "stacr-staopc-19-20". What do you think? And 
again the additional question: Should the be added as an new property or 
added to the compatible property?

Please advise. Thanks.

Best regards,
Stefan
