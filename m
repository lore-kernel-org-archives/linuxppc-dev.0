Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 360BCDDEC3
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Feb 2007 11:08:34 +1100 (EST)
Subject: Re: spidernet: dynamic phy setup code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
In-Reply-To: <200702021020.l12AKLrS011304@toshiba.co.jp>
References: <200702021020.l12AKLrS011304@toshiba.co.jp>
Content-Type: text/plain
Date: Mon, 05 Feb 2007 11:08:07 +1100
Message-Id: <1170634087.2620.69.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: netdev@vger.kernel.org, jgarzik@pobox.com, jim@jklewis.com,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> We use bcm5461. There is a possibility that we don't know the appropriate
> setting which is applicable for both type of switches.

Have you tested the existing 54xx code in sungem_phy.c ? We use that
with 5462 at least in K2 and all sorts of 54xx chips and it works
fine... Just setup the right advertisement bits and call setup_aneg in
the PHY ops. You don't even need to implement the "forced" fallback code
that is in sungem. It's not necessary with most broadcom PHYs as they do
that themselves, just setup aneg and poll the link from a timer, that's
it. Once you get a link, then setup your GMACMODE based on the link
speed.

I don't have the datasheet of the 5461 at hand but I doubt it's any
different... Like other Broadcom 54xx PHYs, it might need some special
initialization code to work around firmware bugs though...

> We didn't investigate for the detail, but we met the following phenomena.
> 1. When auto-neg starts with Gbps setting and ethernet card is connected to
>    a 100Mbps switch, LINK is not detected.
> 2. When auto-neg starts with 100/10Mbps setting and ethernet card is 
>    connected to Gbps switch, LINK is detected (poll_link() succeeds), but
>    the network is not available.

That is very strange... I would need to review your code in more details
or eventually have HW access to run my own experiments, but none of this
should happen if things are setup properly. Also avoid relying on the
link interrupt, it's a known cause of trouble. Just poll.

Ben.
