Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 610012BEA0
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Nov 2004 09:03:56 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Colin Leroy <colin@colino.net>
In-Reply-To: <20041126200754.1123e8f8@jack.colino.net>
References: <1101439228.4633.74.camel@gaston>
	<20041126200754.1123e8f8@jack.colino.net>
Content-Type: text/plain
Date: Sat, 27 Nov 2004 09:03:30 +1100
Message-Id: <1101506610.28048.23.camel@gaston>
Mime-Version: 1.0
Cc: "David S. Miller" <davem@redhat.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] sungem rework & wake on lan
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2004-11-26 at 20:07 +0100, Colin Leroy wrote:
> On 26 Nov 2004 at 14h11, Benjamin Herrenschmidt wrote:
> 
> Hi Ben, 
> 
>  	if (found_mii_phy(gp) && gp->phy_mii.def->ops->suspend)
> -		gp->phy_mii.def->ops->suspend(&gp->phy_mii, 0 /* wake on lan options */);
> +		gp->phy_mii.def->ops->suspend(&gp->phy_mii);
> 
> Shouldn't this if() have an "&& !wol" clause ?
> At least it doesn't work without it, and works with it, here on 5221 PHY.
> 
> Thanks for your work. Will post a patch applying to 2.6.9+sleep_patch soon 
> for the possibly interested people.

You are right. It happens to work in both case with the 5201 I have
here, but that may be because the superisolate code doesn't quite work
on it ...

Anyway, I do _not_ intend to keep the driver in this state. I dislike
the fact that I have to udelay() between 10 and 100usec (depending on
the machine) at IRQ time with a spinlock held every second when polling
for the link.

I will move the link poll to task level so it can schedule instead. But
the problem is complex. There is a problem with kenrel autoconfig
(ipconfig) which doesn't schedule and should probably be fixed. Also to
do what I want to do (which is to also switch the clock off when the
iface is up, but the link down), I'll have locking issues with set_mtu()
and set_multicast() calls which happen to be called with a spinlock
held.

Ben.
