Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B9FD8B6FB7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jun 2012 09:03:21 +1000 (EST)
Message-ID: <1339369393.24838.101.camel@pasglop>
Subject: Re: PowerMac PMU programming
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Justin Hibbits <chmeeedalf@gmail.com>
Date: Mon, 11 Jun 2012 09:03:13 +1000
In-Reply-To: <20120610092932.38857c77@narn.knownspace>
References: <20120610092932.38857c77@narn.knownspace>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2012-06-10 at 09:29 -0400, Justin Hibbits wrote:
> Hello,
> 
> I'm working on various PMU bits for FreeBSD (I know, not related to
> Linux), but running into some problems, which the Linux crowd may be
> able to help with, as it's already solved for Linux.  I've managed to
> get it to sleep for performing the sleep operation and for the CPU speed
> switch on MPC7455-based machines, but it goes catatonic, not waking
> up.  I've installed the reset vector pointer at 0x0080, which both OS X
> and Linux do, and flush the caches, but no luck.  During development of
> the Linux driver was this ever encountered?  Any assistance would be
> greatly appreciated, I've been banging my head against this off and on
> for about 8 months now.
> 
> Thanks for any assistance.  I'm not subscribed to the list, so please
> keep my address in replies.

Yes it was :-) pretty much any bug even minor during that process will
cause just that :-)

One thing paulus did that helped us a lot initially was write a little
synchronous version of the PMU send command and use it to blink the PMU
LED very early on when resuming from sleep, which allows us to debug a
bit.

It takes quite a bit of work (see the code in radeonfb) to get the
graphics back, so most of the time you come back with nothing on screen.

If your machine is not a laptop, there are other possible
considerations, such as the need to restore the PCI-PCI bridge that
might be above the macio chip very early on, before you try to restore
macio itself (we don't do that in Linux at this stage).

Cheers,
Ben.
 
