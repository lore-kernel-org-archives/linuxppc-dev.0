Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4419A679EA
	for <linuxppc-dev@ozlabs.org>; Mon,  1 May 2006 16:57:01 +1000 (EST)
Subject: Re: [PATCH] convert powermac ide blink to new led infrastructure
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1146237326.19164.111.camel@localhost>
References: <1146235779.19164.109.camel@localhost>
	<1146237326.19164.111.camel@localhost>
Content-Type: text/plain
Date: Mon, 01 May 2006 16:56:48 +1000
Message-Id: <1146466608.30710.36.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	debian-powerpc <debian-powerpc@lists.debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-04-28 at 17:15 +0200, Johannes Berg wrote:
> [resent slightly different patch that adds a comment over the original
> version]
> 
> This patch removes the old pmac ide led blink code and
> adds generic LED subsystem support for the LED.
> 
> Ben: I removed the retry code that was present in the original. I guess
> LEDs aren't really too important but if it really is necessary please
> tell me and I'll add it back.
> 
> Also, I don't have any suspend handling things. It doesn't appear to be
> necessary, how do I find out?

Hrm... you find out the hard way in general ... we'll have to be careful
with this one, maybe have the PMU driver stop the LED after the device
suspend dance or do a sysdev with a suspend/resume and make sure that
any pending LED request is complete. Also, your code isn't testing if
the PMU request is still in progress before possibly sending another
one ... that's a bit dangerous (and may cause the LED to get "stuck").
You can re-use a request once it's complete though. In addition, my PMU
code was written to minimize spinlock usage in the hot path... There
might be a way to do the same here.

Ben.
