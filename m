Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id EC65BB6FA1
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2012 19:19:50 +1000 (EST)
Message-ID: <1335431975.21961.75.camel@pasglop>
Subject: Re: [PATCH 00/15] PowerMac i2c API conversions & windfarm updates
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@linux-m68k.org>
Date: Thu, 26 Apr 2012 19:19:35 +1000
In-Reply-To: <m2liliam9w.fsf@igel.home>
References: <1334823416-9138-1-git-send-email-benh__1987.51832726902$1334826600$gmane$org@kernel.crashing.org>
 <m2397sz1er.fsf@igel.home> <1335343125.21961.33.camel@pasglop>
 <m2sjfs85pv.fsf@igel.home> <1335388465.21961.35.camel@pasglop>
 <m2aa1zxyt7.fsf@igel.home> <1335391128.21961.55.camel@pasglop>
 <m2liliam9w.fsf@igel.home>
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

On Thu, 2012-04-26 at 11:13 +0200, Andreas Schwab wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> > What if you just comment out the tickle code ?
> 
> I haven't tried it yet, but I suspect it won't tickle the fcu any more
> since wf_control_set avoids writing an unchanged value (unlike the old
> driver).

Sure, the question is whether that fixes the "annoyance" :-)

I don't think we really need to tickle the FCU as long as we have that
#define set in windfarm_fcu to use the actual fan values rather than the
programmed one.

In fact, can you change that define around and see if it makes it behave
more like therm_pm72 overall ? IE That's the only -known- difference
between the old and new driver (+/- a bug / typo / etc..)

Cheers,
Ben.
