Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 75DF567B5D
	for <linuxppc-dev@ozlabs.org>; Mon,  1 May 2006 19:09:34 +1000 (EST)
Subject: Re: [PATCH] via-pmu: report powerbutton as proper input event
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1146473774.24172.2.camel@localhost>
References: <1146251713.5019.4.camel@localhost>
	<1146466716.30710.39.camel@localhost.localdomain>
	<1146473774.24172.2.camel@localhost>
Content-Type: text/plain
Date: Mon, 01 May 2006 19:09:26 +1000
Message-Id: <1146474566.30710.45.camel@localhost.localdomain>
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

On Mon, 2006-05-01 at 10:56 +0200, Johannes Berg wrote:
> On Mon, 2006-05-01 at 16:58 +1000, Benjamin Herrenschmidt wrote:
> > On Fri, 2006-04-28 at 21:15 +0200, Johannes Berg wrote:
> > > This patch adds an input device for the power button so that userspace gets
> > > notified about the user pressing it via the standard input layer.
> > 
> > Looks interesting. Waht about other buttons/events the PMU can report ?
> 
> What else does it report? As far as I know it doesn't have anything
> else, at least on my system.

Depends on the machine... earlier ones have the backlight there or
volume control.. then LID close could be an event too...

> > > +#define BUS_PMU			0x20
> > 
> > Magic numbers... BAD BAD BAD ... Somebody needs to LART the input layer
> > people.
> 
> It's not really a "magic" number since it doesn't really carry any
> information, or would you like string identifiers in each device
> descriptor? An enum would be just the same, in fact, the definition
> could be rewritten as an enum :)
> 
> > Do we need these here ? Why not an initcall self-contained in each
> > file ?
> 
> No heh, good point.
> 
> Thanks,
> johannes
