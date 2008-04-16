Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5064BDE350
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 22:10:12 +1000 (EST)
Subject: Re: Phy read timeout in ibm_new_emac driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: M B <super.firetwister@googlemail.com>
In-Reply-To: <6a6049b80804160349q42120b4bs1c0db49ea5ad055d@mail.gmail.com>
References: <6a6049b80804160349q42120b4bs1c0db49ea5ad055d@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 16 Apr 2008 22:09:51 +1000
Message-Id: <1208347791.6958.279.camel@pasglop>
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


> My Micrel/Kendin KSZ8721BT on my ppc405EP board needs one us longer to
> finish. I was able to reproduce this all the time. So I wonder if the
> timeout of 100us is defined by the MII standard, or by the author of
> the driver?
> If it's a standard I've still a bad feeling if we just correct the
> timeout to 100us, maybe 110 should be fine. If it's not defined by the
> standard, I would add 50% to the timeout. It won't slow down other
> phys, but a scan on the phy bus might get slowed down.
> Same applies for __emac_mdio_write.
> 
> Oh and we could save a us by putting the udelay(1) after the if section ;-)

Increasing the timeout is fine. In fact, EMAC specifically can sleep in
it's MDIO access routines (it already takes mutexes) so maybe a good
option here is to use longer sleeping delays and less iterations.

Somebody knows off hand what the standard says the timeout should be ? I
can check that tomorrow, I don't have it at hand right now and it's
getting late but feel free to beat me to it :-) 

Cheers,
Ben.
