Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E2FB5B6FAF
 for <linuxppc-dev@ozlabs.org>; Fri, 27 Apr 2012 08:06:53 +1000 (EST)
Message-ID: <1335477999.21961.85.camel@pasglop>
Subject: Re: [PATCH 00/15] PowerMac i2c API conversions & windfarm updates
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@linux-m68k.org>
Date: Fri, 27 Apr 2012 08:06:39 +1000
In-Reply-To: <m2ehra67p5.fsf@igel.home>
References: <1334823416-9138-1-git-send-email-benh__1987.51832726902$1334826600$gmane$org@kernel.crashing.org>
 <m2397sz1er.fsf@igel.home> <1335343125.21961.33.camel@pasglop>
 <m2sjfs85pv.fsf@igel.home> <1335388465.21961.35.camel@pasglop>
 <m2aa1zxyt7.fsf@igel.home> <1335391128.21961.55.camel@pasglop>
 <m2liliam9w.fsf@igel.home> <1335431975.21961.75.camel@pasglop>
 <m2ehra67p5.fsf@igel.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: khali@linux-fr.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-04-26 at 13:41 +0200, Andreas Schwab wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> > In fact, can you change that define around and see if it makes it behave
> > more like therm_pm72 overall ? IE That's the only -known- difference
> > between the old and new driver (+/- a bug / typo / etc..)
> 
> Yes, that's make the difference for the cpu fan control.  Note that
> MacOS (at least 10.3, which is the only one I have) drives the fans the
> same way as the old driver.

Ok, I'll switch that back then. It seemed more sensible to read the
actual fan values rather than the programmed ones (in fact I wonder if I
can just skip the read alltogether then and use a cached value but that
means I won't be able to detect failed fans...), but if you say it
behaves better, let's keep it the way it was.

As for the tickle, I'm not sure yet how to proceed. I'll look into it,
try various things. We can maybe just remove the tickle but that means
that a completely idle machine might start ramping up as the FCU times
out.

Finally, setting the slot fan from sysfs should be doable reasonably
easily. Stay tuned and thanks a lot for testing ! :-)

Cheers,
Ben.
