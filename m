Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (dsl027-180-168.sfo1.dsl.speakeasy.net
	[216.27.180.168]) by ozlabs.org (Postfix) with ESMTP id 77FCB67B67
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Aug 2006 08:51:15 +1000 (EST)
Date: Fri, 18 Aug 2006 15:51:16 -0700 (PDT)
Message-Id: <20060818.155116.112621100.davem@davemloft.net>
To: linas@austin.ibm.com
Subject: Re: [PATCH 2/4]: powerpc/cell spidernet low watermark patch.
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060818224618.GN26889@austin.ibm.com>
References: <20060818192356.GD26889@austin.ibm.com>
	<20060818.142513.29571851.davem@davemloft.net>
	<20060818224618.GN26889@austin.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: arnd@arndb.de, jklewis@us.ibm.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, netdev@vger.kernel.org, Jens.Osterkamp@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: linas@austin.ibm.com (Linas Vepstas)
Date: Fri, 18 Aug 2006 17:46:18 -0500

> > We're not saying to use the RX interrupt as the trigger for
> > RX and TX work.  Rather, either of RX or TX interrupt will
> > schedule the NAPI poll.
> 
> And, for a lark, this is exactly what I did. Just to see.
> Because there are so few ack packets, there are very few 
> RX interrupts -- not enough to get NAPI to actually keep
> the device busy.

You're misreading me.  TX interrupts are intended to be "enabled" and
trigger NAPI polls.  TX IRQ enabled, enabled :-)

If you want to eliminate them if the kernel keeps hopping into
the ->hard_start_xmit() via hw interrupt mitigation or whatever,
that's fine.  But if you do need to do TX interrupt processing,
do it in NAPI ->poll().

> I'm somewhat disoriened from this conversation. Its presumably
> clear that low-watermark mechanisms are superior to NAPI. 
> >From what I gather, NAPI was invented to deal with cheap 
> or low-function hardware; it adds nothing to this particular
> situation. Why are we talking about this?

NAPI is meant to give fairness to all devices receiving packets
in the system, particularly in times of high load or overload.

And equally importantly, it allows you to run the majority of your
interrupt handler in software IRQ context.  This allows not only your
locking to be simpler, but it also allows things like oprofile to
monitor almost your entire IRQ processing path even with just timer
interrupt based oprofile profiling.

I see you moving TX reclaim into tasklets and stuff.  I've vehemently
against that because you wouldn't need it in order to move TX
processing into software interrupts if you did it all in NAPI
->poll().
