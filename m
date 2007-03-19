Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id C4816DDF89
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2007 08:51:18 +1100 (EST)
Date: Mon, 19 Mar 2007 22:51:15 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/5] powerpc: generic time suspend/resume code
In-Reply-To: <1174315651.5044.4.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.60.0703192236420.10137@poirot.grange>
References: <20070319105352.771599000@sipsolutions.net>
	<20070319105357.964696000@sipsolutions.net>
	<1174315651.5044.4.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Brownell <david-b@pacbell.net>, linuxppc-dev@ozlabs.org,
	Johannes Berg <johannes@sipsolutions.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 19 Mar 2007, Benjamin Herrenschmidt wrote:

> On Mon, 2007-03-19 at 11:53 +0100, Johannes Berg wrote:
> > plain text document attachment (001-time-resume.patch)
> > This patch removes the time suspend/restore code that was done through
> > a PMU notifier in arch/platforms/powermac/time.c.
> > 
> > Instead, introduce arch/powerpc/sysdev/timer.c which creates a sys
> > device and handles time of day suspend/resume through that.
> > 
> > This should probably be replaced by using the generic RTC framework
> > but for now it gets rid of the arcane powermac specific hack.
> > 
> > Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
> 
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Not sure I'm convinced it's a good thing to do...

As far as I understand it duplicates the functionality proposed in this 
thread:

http://lists.linux-foundation.org/pipermail/linux-pm/2007-February/thread.html#4949

and by committing it now we'll delay the powerpc migration to generic rtc. 
How about this: you give me a week before committing this (and any 
depending) patches, in 1 week I send an email with an estimate whether I'd 
be able to do the convertion (without being able to test - others will 
have to do that) and how long I expect to need for that. If we find it 
acceptible, we'll do that, if not - in one week we still can commit these 
patches - 2.6.21 either will not be there yet by then or the window will 
still be open...

David, what's the status of that your patch?

Notice also, that my linkstation suspend patch in its present form also 
uses the previous version of this patch from Johannes', but I'd rather 
delay its acceptance upstream and directly go for the ultimate solution.

Thanks
Guennadi
---
Guennadi Liakhovetski
