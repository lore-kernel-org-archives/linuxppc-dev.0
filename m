Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4021ADDDF7
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Dec 2007 09:21:47 +1100 (EST)
Subject: Re: [PATCH 15/24] powerpc: early debug forces console log level to max
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: T Ziomek <ctz001@email.mot.com>
In-Reply-To: <Pine.LNX.4.64.0711301605540.5450@gauley.ddna.labs.mot.com>
References: <20071130061200.4BAF9DDFAE@ozlabs.org>
	<Pine.LNX.4.64.0711301306520.5450@gauley.ddna.labs.mot.com>
	<1196456185.13230.100.camel@pasglop>
	<Pine.LNX.4.64.0711301605540.5450@gauley.ddna.labs.mot.com>
Content-Type: text/plain
Date: Sat, 01 Dec 2007 09:15:28 +1100
Message-Id: <1196460928.13230.111.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2007-11-30 at 16:11 -0600, T Ziomek wrote:
> > Possibly, though you aren't supposed to leave EARLY_DEBUG enabled
> > once you are done debugging :-)
> 
> I'm probably not the only person that would turn it on when needed,
> think
> "well, no harm in leaving it on for the rest of my development, and it
> might be handy; just turn it off when we're done".
> 
> It's these kind of non-obvious but undocumented things that make a lot
> of
> OSS code a pain to work with for non-experts [1].  What's the harm in
> giving folks a heads-up?

There is no harm, I didn't say I wasn't going to document it, you do
have a point there, I was just mentioning by the way, that leaving
EARLY_DEBUG is generally not a good idea in production.

One of the things that arhc/powerpc provides is the ability for you to
have a single kernel image boot boards with different 4xx processors for
example, or different fsl booke processors. You lose that if you leave
early debug on as it usually contain hard coded addresses for a given
board.

This is typically useful if you have several revisions / versions of
your product, which could use different processor revisions or even
model, and want a single kernel image to support them.

Ben.
