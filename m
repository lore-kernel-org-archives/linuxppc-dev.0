Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 093521A04F3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2015 20:13:54 +1000 (AEST)
Date: Thu, 17 Sep 2015 12:13:15 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
cc: Scott Wood <scottwood@freescale.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [BUG] Revert 0b05e2d671c4 'powerpc/32: cacheable_memcpy becomes
 memcpy'
In-Reply-To: <20150916215435.48bee4d3@grimm.local.home>
Message-ID: <alpine.DEB.2.11.1509170911120.3951@nanos>
References: <alpine.DEB.2.11.1509161816310.3951@nanos>
 <1442420984.2909.179.camel@freescale.com>
 <alpine.DEB.2.11.1509162159110.3951@nanos>
 <20150916215435.48bee4d3@grimm.local.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 16 Sep 2015, Steven Rostedt wrote:
> On Wed, 16 Sep 2015 22:01:06 +0200 (CEST)
> Thomas Gleixner <tglx@linutronix.de> wrote:
> > So now I have to chase down that one:
> > 
> > [    0.230210] ftrace: allocating 16560 entries in 49 pages
> > [    0.273313] ------------[ cut here ]------------
> > [    0.278048] WARNING: at /home/tglx/work/kernel/tip/tip/kernel/trace/ftrace.c:1974
> 
> OK, so this is where ftrace converts the mcount to nops.
> 
> Just to be clear, there's nothing in the command line that enables any
> function tracing, is there?

Nothing on the command line.

> > Happens somewhere between the powerpc merge and rc1. System boots up
> > to userspace and then locks hard ....

Digging deeper. My assumption that it's a post powerpc merge failure
turned out to be wrong.

Some more data points. I see the above splat with

CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y

It goes away with 

CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=n

But the box still does not get to the login prompt.

CONFIG_FUNCTION_TRACER=n

makes it work again.

It's not observable before the ppc merge, but I can't identify the
culprit by bisection. bisection led into lala land.

Thanks,

	tglx
