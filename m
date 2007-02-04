Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 74D95DDE3D
	for <linuxppc-dev@ozlabs.org>; Sun,  4 Feb 2007 15:37:22 +1100 (EST)
Subject: Re: No Subject
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: kou.ishizaki@toshiba.co.jp
In-Reply-To: <200702010754.l117s2T8003383@toshiba.co.jp>
References: <200702010754.l117s2T8003383@toshiba.co.jp>
Content-Type: text/plain
Date: Sun, 04 Feb 2007 15:37:07 +1100
Message-Id: <1170563828.2620.16.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> We need to use different auto-neg initial settings between
> for 10/100Mbps ethernet switches and for Gbps ethernet switches.

That is strange ! What PHY chip are you using ? Are you sure it's not
just you not properly configuring the PHY ? Is the datasheet for the PHY
available somewhere ?

> Driver don't know which type of network switch is connected to
> network card, so we try both settings alternately in auto negtiation
> sequences by using a variable "is1000".

sungem has an autoneg sequence that falls back to forced speeds but it's
not useful on any modern setup. Your PHY should be perfectly capable to
autoneg on both 1000bT and 10/100bT...

> Furthermore, we have a problem that poll_link() may succeed even when
> the auto-neg initial setting is for different network switch type,
> and the network card does not work on this case. We retry auto-neg
> with the another initial setting on this case.

Ugh ? What is that initial setting bit exactly ? If the link is up, it
should work.

> >- spider_net_write_reg(card, SPIDER_NET_GMACST,
> >-        spider_net_read_reg(card, SPIDER_NET_GMACST));
> >- spider_net_write_reg(card, SPIDER_NET_GMACINTEN, 0x4);
> 
> These codes are enabling LINK status interrupt which is disabled
> at the beginning of auto-neg.
> Without this operation, auto negotiation works only when a connection
> detected for the first time, and auto negotiation will not work 
> when an ethernet cable is unpluged or pluged.

Most drivers poll the link rather than use an interrupt as those are
often unreliable.

> (3)
> >- mii_phy_probe(phy, phy->mii_id);
> It seems that PHY reset is necessary before auto negotiation,
> after a link once went down.

It shouldn't be... again, what PHY are you using ?

> We can't call directly reset routine from driver, so we call
> mii_phy_probe().

If you really need to reset it, then change sungem_phy.c to export the
reset function. But I'm surprised you need that. Another option is to
reset the PHY in your PHY's setup_aneg() function.

> We are still developping the patch as we noted, and we are considering
> to call mii_phy_probe() from spider_net_setup_aneg(), or to call
> reset_one_mii_phy() from bcm54xx_setup_aneg().
> 
> We think these (1)-(3) are necessary, but we are afraid that you removed
> them
> by a reason that they causes some trouble in Cell Blade. If so please
> tell us.

You might want to borrow the link state machine from sungem.c instead...
it tends to just work :-)

Ben.
