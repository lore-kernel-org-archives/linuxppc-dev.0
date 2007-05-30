Return-Path: <tmbinc@elitedvb.net>
Received: from mail.multimedia-labs.de (mail.multimedia-labs.de
	[82.149.226.172])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.multimedia-labs.de",
	Issuer "Multimedia Labs CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 41F39DDFB9
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 22:08:37 +1000 (EST)
Message-ID: <465D68E5.7000005@elitedvb.net>
Date: Wed, 30 May 2007 14:07:01 +0200
From: Felix Domke <tmbinc@elitedvb.net>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Saving to 32 bits of GPRs in signal context
References: <1180423456.19517.124.camel@localhost.localdomain>	<B1348C8C-09B1-4906-BF89-CC4206F0CA0A@embeddedalley.com>	<1180425900.19517.136.camel@localhost.localdomain>	<20070529092658.GA32228@iram.es>	<08b3997ab86a819c63b5cb0afcdc0c9e@kernel.crashing.org>
	<1180474079.19517.188.camel@localhost.localdomain>
	<465C9F04.4070202@elitedvb.net>
	<6468abfee21ce75c5d86676350b09c88@kernel.crashing.org>
In-Reply-To: <6468abfee21ce75c5d86676350b09c88@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:
>>>> Just call them and trap the SEGV ;-)  You can check the
>>>> aux vector of course, or ask glibc -- but the SEGV way
>>>> is the only really portable way.  Strange world :-)
>>> SIGILL you mean ? :-)
>> Anyway, please don't. It is *not* portable.
> It is simple and *quite* portable.  [...]
>> [ffmpeg]
> To be fair, ffmpeg has had this test since before there
> were proper ways to detect AltiVec on Linux/glibc.
That's *exactly* my point:

If you don't provide a real, portable, useful way *now* for detecting
compatibility with 64bit insn, people (=ffmpeg, mplayer first) *will*
invent their own way of detecting it, possibly using SIGILL, faster than
you could imagine.

Please avoid that this time. And please declare the use of SIGILL for
detecting extensions as plainly wrong, not as a "bad workaround, but
still better than what's available". If you can't be sure that an
extension will work as expected (for example because there is just no
interface to query the OS for it), then simply don't use it. If this is
going to be a performance problem, bug the kernel people to fix it.

(Sorry, this is the point of view of myself a pure *user*. I don't want
to debug crashing programs with incorrect memcpy results because some
program decided on its own that it's safe to use this extension when it
wasn't.)

>> And: What will happen if you manage to run your code under an operating
>> system which doesn't even save the upper bits at all on interrupts? You
>> can't check for that with SIGILL.
> Sure you can, do some loop with a data-dependent branch
> in there that detects corruption of that high half reg.
> If you really want a SIGILL you can just generate one ;-)
> A test like this is never 100% of course.
Tell that those people who have a SIGILL check in their "production" code.

Felix
