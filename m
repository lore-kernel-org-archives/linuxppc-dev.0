Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C290FDDF78
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Apr 2008 15:18:57 +1000 (EST)
Subject: Re: Phy read timeout in ibm_new_emac driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Markus Brunner <super.firetwister@googlemail.com>
In-Reply-To: <200804230706.32641.super.firetwister@gmail.com>
References: <6a6049b80804160349q42120b4bs1c0db49ea5ad055d@mail.gmail.com>
	<1208347791.6958.279.camel@pasglop>
	<200804230706.32641.super.firetwister@gmail.com>
Content-Type: text/plain
Date: Wed, 23 Apr 2008 15:18:48 +1000
Message-Id: <1208927928.9060.18.camel@pasglop>
Mime-Version: 1.0
Cc: netdev@vger.kernel.org, ppc-dev <linuxppc-dev@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2008-04-23 at 07:06 +0200, Markus Brunner wrote:
> On Wednesday 16 April 2008, Benjamin Herrenschmidt wrote:
> 
> > Somebody knows off hand what the standard says the timeout should be ?
> 
> Anyone?
> 
> I didn't find any documentation on the standard, but I had a look at other 
> drivers. 
> au1000_eth.c waits 20 ms (20 * 1ms) in mdio_read.
> bfin_mac.c waits 500 * 1us in mdio_poll. 
> In both functions the last delay before the timeout is useless, like in 
> new_emac. Not nice, but timeouts shouldn't occur anyway.
> 
> new emac probably doesn't wait long enough, but 20ms seems to be a bit too 
> long.

I just send Jeff a patch doubling the timeouts.

Cheers,
Ben.
