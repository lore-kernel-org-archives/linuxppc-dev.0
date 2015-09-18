Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D92A51A2C84
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2015 20:01:57 +1000 (AEST)
Message-ID: <1442570517.5528.3.camel@ellerman.id.au>
Subject: Re: [BUG] Revert 0b05e2d671c4 'powerpc/32: cacheable_memcpy becomes
 memcpy'
From: Michael Ellerman <mpe@ellerman.id.au>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Scott Wood
 <scottwood@freescale.com>,  linuxppc-dev@lists.ozlabs.org
Date: Fri, 18 Sep 2015 20:01:57 +1000
In-Reply-To: <alpine.DEB.2.11.1509170911120.3951@nanos>
References: <alpine.DEB.2.11.1509161816310.3951@nanos>
 <1442420984.2909.179.camel@freescale.com>
 <alpine.DEB.2.11.1509162159110.3951@nanos>
 <20150916215435.48bee4d3@grimm.local.home>
 <alpine.DEB.2.11.1509170911120.3951@nanos>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-09-17 at 12:13 +0200, Thomas Gleixner wrote:
> On Wed, 16 Sep 2015, Steven Rostedt wrote:
> > On Wed, 16 Sep 2015 22:01:06 +0200 (CEST)
> > Thomas Gleixner <tglx@linutronix.de> wrote:
> > > So now I have to chase down that one:
> > > 
> > > [    0.230210] ftrace: allocating 16560 entries in 49 pages
> > > [    0.273313] ------------[ cut here ]------------
> > > [    0.278048] WARNING: at /home/tglx/work/kernel/tip/tip/kernel/trace/ftrace.c:1974
> > 
> 
> It's not observable before the ppc merge, but I can't identify the
> culprit by bisection. bisection led into lala land.

Weird.

Can you try:

  d690740f22f6 ("powerpc/powernv: Enable LEDS support")

That is the commit before my merge of Scott's tree, which had all the Freescale
& 32-bit stuff.

If that works, it would isolate it to only about 30 commits from Scott's tree.

cheers
