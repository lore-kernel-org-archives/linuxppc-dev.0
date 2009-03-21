Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.122]) by ozlabs.org (Postfix) with ESMTP id 9C7C3DDE1A
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Mar 2009 03:41:44 +1100 (EST)
Date: Sat, 21 Mar 2009 12:41:42 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] tracing: Fix TRACING_SUPPORT dependency
In-Reply-To: <20090321163328.GH11183@elte.hu>
Message-ID: <alpine.DEB.2.00.0903211239170.13615@gandalf.stny.rr.com>
References: <20090320150914.GA22769@oksana.dev.rtsoft.ru>
	<20090320190428.GD6224@elte.hu>
	<20090320193904.GA13707@oksana.dev.rtsoft.ru>
	<20090320195743.GA25147@elte.hu>
	<20090320202247.GA30654@oksana.dev.rtsoft.ru>
	<20090321161814.GC11183@elte.hu>
	<alpine.DEB.2.00.0903211230580.13615@gandalf.stny.rr.com>
	<20090321163328.GH11183@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Steven Rostedt <srostedt@redhat.com>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sat, 21 Mar 2009, Ingo Molnar wrote:
> > > 
> > > Hm, do all the tracers even compile on ppc32 with your patch?
> > > 
> > > We had periodic build failures on weird, unmaintained architectures 
> > > that had no irqflags-tracing support and hence didnt know the 
> > > raw_irqs_save/restore primitives ...
> > > 
> > > I'm not trying to make things more difficult for you (and we can 
> > > apply your patch if it builds fine and does not cause problems 
> > > elsewhere), but there were some real downsides to not having proper 
> > > irq APIs ...
> > 
> > Note, the issue is not with the hooks into local_irq_save/restore, 
> > but with the entry.S code. That code is very sensitive where the 
> > irqs are enabled and disabled.
> 
> i know. What i'm talking about is that non-lockdep architectures 
> have the habit of not defining raw_local_irq_save() - which the 
> tracing core relies on.

Since we know that's not an issue with PPC32, perhaps we should add (I 
hate to do this)...


	depends on TRACE_IRQFLAGS_SUPPORT || PPC32

And document that the "|| PPC32" should go when PowerPC32 gets its act
together.  :-/

-- Steve
