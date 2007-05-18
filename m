Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 31B65DDE2E
	for <linuxppc-dev@ozlabs.org>; Fri, 18 May 2007 17:09:07 +1000 (EST)
Subject: Re: [PATCH 2.6.21-rt2] PowerPC: decrementer clockevent driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dave Liu <r63238@freescale.com>
In-Reply-To: <1179466769.3658.0.camel@localhost.localdomain>
References: <200705172142.26739.sshtylyov@ru.mvista.com>
	<f9afbdb49bc1f935153305315770bccd@kernel.crashing.org>
	<464CB071.5050504@ru.mvista.com>
	<9095839480a9686d9c40aa6143edb804@kernel.crashing.org>
	<464CB460.40905@ru.mvista.com>
	<97d47c2261fe9cd3f1a6c864278a6ab6@kernel.crashing.org>
	<1179464690.32247.370.camel@localhost.localdomain>
	<1179466769.3658.0.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 18 May 2007 17:08:15 +1000
Message-Id: <1179472096.32247.394.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, tglx@linutronix.de, mingo@elte.hu,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-05-18 at 13:39 +0800, Dave Liu wrote:
> > > Yes, on some implementations there can be other conditions that
> > > make a decrementer exception go away; there is no contradiction
> > > here (thankfully).  My wording was sloppy.
> > 
> > Some CPUs have the DEC exceptions basically edge triggered (yeah I know
> 
> for example?
> 
> > it sucks). That's why, among others, the IRQ soft-disable code has code
> > to re-trigger DEC exceptions ASAP (by setting it to 1.. note that we
> > could probably use 0 here, we've been a bit conservative).

I'm not 100% certain... Paulus thinks all the old 6xx are like that, and
maybe POWER4. If I look at the oldest BookIV I can find (the 601), it
says that an exception is generated when the MSB transitions from 0 to
1. It's not clear wether the exception sticks while that bit is 1 or is
indeed considered as an "edge" event that gets cleared as soon as
delivered.

Ben.
