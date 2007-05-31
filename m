Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B9412DDF9E
	for <linuxppc-dev@ozlabs.org>; Thu, 31 May 2007 15:40:10 +1000 (EST)
Subject: Re: Saving to 32 bits of GPRs in signal context
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Felix Domke <tmbinc@elitedvb.net>
In-Reply-To: <465D68E5.7000005@elitedvb.net>
References: <1180423456.19517.124.camel@localhost.localdomain>
	<B1348C8C-09B1-4906-BF89-CC4206F0CA0A@embeddedalley.com>
	<1180425900.19517.136.camel@localhost.localdomain>
	<20070529092658.GA32228@iram.es>
	<08b3997ab86a819c63b5cb0afcdc0c9e@kernel.crashing.org>
	<1180474079.19517.188.camel@localhost.localdomain>
	<465C9F04.4070202@elitedvb.net>
	<6468abfee21ce75c5d86676350b09c88@kernel.crashing.org>
	<465D68E5.7000005@elitedvb.net>
Content-Type: text/plain
Date: Thu, 31 May 2007 15:39:59 +1000
Message-Id: <1180589999.19517.336.camel@localhost.localdomain>
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

On Wed, 2007-05-30 at 14:07 +0200, Felix Domke wrote:
> 
> If you don't provide a real, portable, useful way *now* for detecting
> compatibility with 64bit insn, people (=ffmpeg, mplayer first) *will*
> invent their own way of detecting it, possibly using SIGILL, faster
> than
> you could imagine.

I'm pretty sure I had the feature bits before mplayer did altivec, but
then, nobody cares about the feature bits because they exist only on
linux.

There is no portable way to do these things and there won't be because
apple doesn't care what linux does and glibc people don't care about
what apple do etc...

> Please avoid that this time. And please declare the use of SIGILL for
> detecting extensions as plainly wrong, not as a "bad workaround, but
> still better than what's available". If you can't be sure that an
> extension will work as expected (for example because there is just no
> interface to query the OS for it), then simply don't use it. If this
> is
> going to be a performance problem, bug the kernel people to fix it.
> 
> (Sorry, this is the point of view of myself a pure *user*. I don't
> want
> to debug crashing programs with incorrect memcpy results because some
> program decided on its own that it's safe to use this extension when
> it
> wasn't.)

Unfortunately, we can't just "declare" things and have people follow
us :-)

Ben.
