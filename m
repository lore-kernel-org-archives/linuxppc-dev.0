Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [208.106.21.240])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id B562767BDD
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Dec 2006 17:13:09 +1100 (EST)
Date: Tue, 5 Dec 2006 22:06:25 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: shared config registers and locking
Message-ID: <20061206060625.GA30005@gate.ebshome.net>
References: <1165381847.5469.70.camel@localhost.localdomain>
	<1165382189.5469.76.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1165382189.5469.76.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Dec 06, 2006 at 04:16:29PM +1100, Benjamin Herrenschmidt wrote:
> > On my work in porting emac over to arch/powerpc (and make it work on SMP
> > platforms since there's at least one coming, possibly too), I ended up
> > with a problem with things like the workarounds for the EMAC loss of RX
> > clock (CONFIG_IBM_EMAC_PHY_RX_CLK_FIX) that I think uncovers a more
> > generic problem about access global system wide configuration registers
> > in a race free way.
> 
> BTW, Eugene, in the specific case of this RX clock problem causing the
> transmitter to stall...
> 
> I've had this problem with sungem in the past and a few other drivers
> have to deal with it as well. The general approach seems to be a bit
> different, and if you think it can work for EMAC, I'll implement it that
> way in the driver I'm working on.
> 
> The idea is rather to try to find magic bits to force the chip clocks on
> when there is no link, simply ack the fact that when there is no link,
> nothing gets transmitted and thus ignore tx timeouts. Doing
> netif_carrier_off() (which is the right thing to do when the link is
> down anyway) should cause the net stack to ignore them.
> 
> Now, some chips (like GEM) have a problem recovering when the link
> finally comes back up and thus can have the transmitter stuck. That's
> why drivers like this will simply reset the TX side when the link is
> back up.
> 
> That should be simpler and avoid the need for the workaround, don't you
> think ?

No, it's not simpler. This just does not handle the problem this 
workaround was implemented for.

You don't understand what this workaround does. It has nothing to do 
with TX path at all. It deals with RX one and the fact that in that 
particular MAC design whole RX domain is clocked from this clock, 
meaning some parts of EMAC just simply stop working. For some modes 
(e.g. SMII) this problem will not arise as this clock is always 
present, there are other cases when it's not needed (like sane PHY).

For example, how do you handle PHY detection if you cannot talk to the 
PHY?

Ben, my suggestion, before you start "forking" and "cleaning up" this 
code, understand what it does.

-- 
Eugene
