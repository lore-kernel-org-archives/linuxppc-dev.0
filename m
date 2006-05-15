Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6571A67B5C
	for <linuxppc-dev@ozlabs.org>; Mon, 15 May 2006 16:23:38 +1000 (EST)
Subject: Re: Load average 1.0 on idle machine
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dan Malek <dan@embeddedalley.com>
In-Reply-To: <D0930F4F-DF46-47FF-B33C-0BE313CC81DB@embeddedalley.com>
References: <87wtcplejw.fsf@blackdown.de>
	<17510.55656.607530.491585@zot.electricrain.com>
	<1147657558.21291.65.camel@localhost.localdomain>
	<D0930F4F-DF46-47FF-B33C-0BE313CC81DB@embeddedalley.com>
Content-Type: text/plain
Date: Mon, 15 May 2006 16:23:27 +1000
Message-Id: <1147674207.21291.101.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, "Brian D. Carlstrom" <bdc@carlstrom.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-05-15 at 02:08 -0400, Dan Malek wrote:
> On May 14, 2006, at 9:45 PM, Benjamin Herrenschmidt wrote:
> 
> > ....   For now, consider
> > the load avergage value bogus :)
> 
> It's not bogus :-)  If you happen to schedule periodic
> tasks that are sampled with load average computes,
> or sleep them "uninterrupible", they are counted in
> the load average.

The thermal control runs every second and sleeps with "interruptible"...
so it should not have such a laod average imho :) Now it's possible that
what it does during that "second" is long enough to end up not sleeping
that much (though it's also sleeping while doing i2c accesses, but that
is uninterruptible for obvious reasons at the i2c driver level).

Ben
