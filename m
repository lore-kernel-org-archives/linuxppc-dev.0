Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 494C367B3B
	for <linuxppc-dev@ozlabs.org>; Mon,  1 May 2006 19:10:54 +1000 (EST)
Subject: Re: [PATCH] convert powermac ide blink to new led infrastructure
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1146473959.24172.4.camel@localhost>
References: <1146235779.19164.109.camel@localhost>
	<1146237326.19164.111.camel@localhost>
	<1146466608.30710.36.camel@localhost.localdomain>
	<1146473959.24172.4.camel@localhost>
Content-Type: text/plain
Date: Mon, 01 May 2006 19:10:47 +1000
Message-Id: <1146474648.30710.48.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-05-01 at 10:59 +0200, Johannes Berg wrote:
> On Mon, 2006-05-01 at 16:56 +1000, Benjamin Herrenschmidt wrote:
> 
> > Hrm... you find out the hard way in general ... we'll have to be careful
> > with this one, maybe have the PMU driver stop the LED after the device
> > suspend dance or do a sysdev with a suspend/resume and make sure that
> > any pending LED request is complete. Also, your code isn't testing if
> > the PMU request is still in progress before possibly sending another
> > one ... that's a bit dangerous (and may cause the LED to get "stuck").
> > You can re-use a request once it's complete though. In addition, my PMU
> > code was written to minimize spinlock usage in the hot path... There
> > might be a way to do the same here.
> 
> I don't really understand how the PMU works hence wasn't really sure
> what the whole request thing does. Do we get an interrupt when it
> completes or something? If so, could I get at that notification via the
> request structure?

Yes, there is a callback, that's the "done" function, but you can also
poll/check on request->complete though in this case, polling is not
recommended, the LED stuff should be as low latency as possible.

> I'll take a closer look and rework this, I think it's worthwhile even if
> it requires some more effort.
> 
> johannes
