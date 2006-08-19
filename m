Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D1611679A6
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Aug 2006 14:32:05 +1000 (EST)
Subject: Re: [PATCH 2/4]: powerpc/cell spidernet low watermark patch.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20060818.155116.112621100.davem@davemloft.net>
References: <20060818192356.GD26889@austin.ibm.com>
	<20060818.142513.29571851.davem@davemloft.net>
	<20060818224618.GN26889@austin.ibm.com>
	<20060818.155116.112621100.davem@davemloft.net>
Content-Type: text/plain
Date: Sat, 19 Aug 2006 14:31:20 +1000
Message-Id: <1155961881.5803.65.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: arnd@arndb.de, netdev@vger.kernel.org, jklewis@us.ibm.com,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Jens.Osterkamp@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-08-18 at 15:51 -0700, David Miller wrote:
> From: linas@austin.ibm.com (Linas Vepstas)
> Date: Fri, 18 Aug 2006 17:46:18 -0500
> 
> > > We're not saying to use the RX interrupt as the trigger for
> > > RX and TX work.  Rather, either of RX or TX interrupt will
> > > schedule the NAPI poll.
> > 
> > And, for a lark, this is exactly what I did. Just to see.
> > Because there are so few ack packets, there are very few 
> > RX interrupts -- not enough to get NAPI to actually keep
> > the device busy.
> 
> You're misreading me.  TX interrupts are intended to be "enabled" and
> trigger NAPI polls.  TX IRQ enabled, enabled :-)

Maybe be because you actually typed "disabled" in your previous
message ? :)

>> The idea is to use NAPI polling with TX interrupts disabled.

> If you want to eliminate them if the kernel keeps hopping into
> the ->hard_start_xmit() via hw interrupt mitigation or whatever,
> that's fine.  But if you do need to do TX interrupt processing,
> do it in NAPI ->poll().

Well, we do need to harvest descriptors of course, though I suppose that
can be done in hard_xmit as well. I'm not sure if there is any real
benefit in batching those.

> > I'm somewhat disoriened from this conversation. Its presumably
> > clear that low-watermark mechanisms are superior to NAPI. 
> > >From what I gather, NAPI was invented to deal with cheap 
> > or low-function hardware; it adds nothing to this particular
> > situation. Why are we talking about this?
> 
> NAPI is meant to give fairness to all devices receiving packets
> in the system, particularly in times of high load or overload.
> 
> And equally importantly, it allows you to run the majority of your
> interrupt handler in software IRQ context.

That is the most important point imho for the specific case of spidernet
on cell.

> This allows not only your
> locking to be simpler, but it also allows things like oprofile to
> monitor almost your entire IRQ processing path even with just timer
> interrupt based oprofile profiling.
> 
> I see you moving TX reclaim into tasklets and stuff.  I've vehemently
> against that because you wouldn't need it in order to move TX
> processing into software interrupts if you did it all in NAPI
> ->poll().

Ben.
