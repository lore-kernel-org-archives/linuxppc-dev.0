Return-Path: <jens@de.ibm.com>
Received: from mtagate7.de.ibm.com (mtagate7.de.ibm.com [195.212.29.156])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate7.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2DF35DDE3E
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Feb 2007 22:04:35 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate7.de.ibm.com (8.13.8/8.13.8) with ESMTP id l11B4Vdl026254
	for <linuxppc-dev@ozlabs.org>; Thu, 1 Feb 2007 11:04:31 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.2) with
	ESMTP id l11B4VRl1663176
	for <linuxppc-dev@ozlabs.org>; Thu, 1 Feb 2007 12:04:31 +0100
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l11B4V73024611
	for <linuxppc-dev@ozlabs.org>; Thu, 1 Feb 2007 12:04:31 +0100
From: Jens Osterkamp <jens@de.ibm.com>
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Subject: Re: [Cbe-oss-dev] spidernet: dynamic phy setup code
Date: Thu, 1 Feb 2007 12:04:30 +0100
References: <200702010805.l11853LX014768@toshiba.co.jp>
In-Reply-To: <200702010805.l11853LX014768@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702011204.30526.jens@de.ibm.com>
Cc: jim@jklewis.com, linuxppc-dev@ozlabs.org, jgarzik@pobox.com,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Ishizaki-san,

> This patch partially works on celleb but remains 
> following several problems.
> 1. It doesn't recover once an ethernet cable which is
>    connected to a spider_net card is unpluged. 

My understanding is that you are using the LINK interrupt to detect this.
For the blade this is not connected but reenabling it wont hurt, I hope.

> 2. It doesn't work when the spider_net card is connected to 
>    a 100Mbps ethernet switch.
> 
> To solve these problems, we need to restore some codes
> you removed from your patch.
> 
> (1)
> >- if (card->aneg_count > 10) {
> >-  /* timeout */
> >-  card->aneg_count = 0;
> >-  is1000 = !is1000;
> >-  goto re_setup;
> 
> >- if (phy->speed == 1000 && !is1000) {
> >-  is1000 = 1;
> >-  goto re_setup;
> >- } else if(phy->speed != 1000 && is1000) {
> >-  is1000 = 0;
> >-  goto re_setup;
> >- }
> 
> We need to use different auto-neg initial settings between
> for 10/100Mbps ethernet switches and for Gbps ethernet switches.
> Driver don't know which type of network switch is connected to
> network card, so we try both settings alternately in auto negtiation
> sequences by using a variable "is1000".

I still dont see why you need different settings for different speed switches.
This is getting to a point where access to some hardware would be handy.
What exact phy are using anyway ?

> Furthermore, we have a problem that poll_link() may succeed even when
> the auto-neg initial setting is for different network switch type,
> and the network card does not work on this case. We retry auto-neg
> with the another initial setting on this case.

See above, could you give some more details why this is the case. Or maybe Ben
knows more about this ?

> #We are commented that "is1000" should be in spider_net_card.
> #We fixed it in another patch. Please refer the following.
> #http://ozlabs.org/pipermail/linuxppc-dev/2007-January/030203.html
> 
> But we don't think this is the best solution, and we are still
> developing 
> our spidernet driver. If you have a good alternative idea, please tell
> us.
> 
> (2)
> >- spider_net_write_reg(card, SPIDER_NET_GMACST,
> >-        spider_net_read_reg(card, SPIDER_NET_GMACST));
> >- spider_net_write_reg(card, SPIDER_NET_GMACINTEN, 0x4);
> 
> These codes are enabling LINK status interrupt which is disabled
> at the beginning of auto-neg.
> Without this operation, auto negotiation works only when a connection
> detected for the first time, and auto negotiation will not work 
> when an ethernet cable is unpluged or pluged.

I will reenable it and see wether it affects us. The pin is not connected so
we should never enter this part of the code.

> (3)
> >- mii_phy_probe(phy, phy->mii_id);
> It seems that PHY reset is necessary before auto negotiation,
> after a link once went down.
> We can't call directly reset routine from driver, so we call
> mii_phy_probe().
> We are still developping the patch as we noted, and we are considering
> to call mii_phy_probe() from spider_net_setup_aneg(), or to call
> reset_one_mii_phy() from bcm54xx_setup_aneg().

IMHO using mii_phy_probe is the right way to do this.

> We think these (1)-(3) are necessary, but we are afraid that you removed
> them
> by a reason that they causes some trouble in Cell Blade. If so please
> tell us.

I'll do some investigations and let you know of the results.

Jens
