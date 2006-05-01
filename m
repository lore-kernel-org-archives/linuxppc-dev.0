Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 00BE567B82
	for <linuxppc-dev@ozlabs.org>; Mon,  1 May 2006 19:36:05 +1000 (EST)
Subject: Re: [PATCH] convert powermac ide blink to new led infrastructure
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1146475513.24172.10.camel@localhost>
References: <1146235779.19164.109.camel@localhost>
	<1146237326.19164.111.camel@localhost>
	<1146466608.30710.36.camel@localhost.localdomain>
	<1146473959.24172.4.camel@localhost>
	<1146474648.30710.48.camel@localhost.localdomain>
	<1146475513.24172.10.camel@localhost>
Content-Type: text/plain
Date: Mon, 01 May 2006 19:35:58 +1000
Message-Id: <1146476158.30710.51.camel@localhost.localdomain>
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

On Mon, 2006-05-01 at 11:25 +0200, Johannes Berg wrote:
> On Mon, 2006-05-01 at 19:10 +1000, Benjamin Herrenschmidt wrote:
> 
> > Yes, there is a callback, that's the "done" function, but you can also
> > poll/check on request->complete though in this case, polling is not
> > recommended, the LED stuff should be as low latency as possible.
> 
> I suppose then what I'll do is request a done callback, and when an LED
> update comes in while not done, just save it into a new 'next state
> should be' variable, which is compared when done so that at worst I
> loose events, but not the final status.
> 
> Can I use pmu_request from within the done callback with the same
> structure? Probably not a good idea right? I can schedule_work then.

No need to schedule work, it should work fine to re-queue

Ben.
