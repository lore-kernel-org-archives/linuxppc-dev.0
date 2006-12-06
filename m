Return-Path: <benh@kernel.crashing.org>
Subject: Re: shared config registers and locking
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Eugene Surovegin <ebs@ebshome.net>
In-Reply-To: <1165381847.5469.70.camel@localhost.localdomain>
References: <1165381847.5469.70.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 06 Dec 2006 16:16:29 +1100
Message-Id: <1165382189.5469.76.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> On my work in porting emac over to arch/powerpc (and make it work on SMP
> platforms since there's at least one coming, possibly too), I ended up
> with a problem with things like the workarounds for the EMAC loss of RX
> clock (CONFIG_IBM_EMAC_PHY_RX_CLK_FIX) that I think uncovers a more
> generic problem about access global system wide configuration registers
> in a race free way.

BTW, Eugene, in the specific case of this RX clock problem causing the
transmitter to stall...

I've had this problem with sungem in the past and a few other drivers
have to deal with it as well. The general approach seems to be a bit
different, and if you think it can work for EMAC, I'll implement it that
way in the driver I'm working on.

The idea is rather to try to find magic bits to force the chip clocks on
when there is no link, simply ack the fact that when there is no link,
nothing gets transmitted and thus ignore tx timeouts. Doing
netif_carrier_off() (which is the right thing to do when the link is
down anyway) should cause the net stack to ignore them.

Now, some chips (like GEM) have a problem recovering when the link
finally comes back up and thus can have the transmitter stuck. That's
why drivers like this will simply reset the TX side when the link is
back up.

That should be simpler and avoid the need for the workaround, don't you
think ?

Cheers,
Ben.
