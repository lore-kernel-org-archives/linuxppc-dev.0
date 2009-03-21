Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.123]) by ozlabs.org (Postfix) with ESMTP id 0A0CFDDDFA
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Mar 2009 03:31:40 +1100 (EST)
Date: Sat, 21 Mar 2009 12:31:37 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] tracing: Fix TRACING_SUPPORT dependency
In-Reply-To: <20090321161814.GC11183@elte.hu>
Message-ID: <alpine.DEB.2.00.0903211230580.13615@gandalf.stny.rr.com>
References: <20090320150914.GA22769@oksana.dev.rtsoft.ru>
	<20090320190428.GD6224@elte.hu>
	<20090320193904.GA13707@oksana.dev.rtsoft.ru>
	<20090320195743.GA25147@elte.hu>
	<20090320202247.GA30654@oksana.dev.rtsoft.ru>
	<20090321161814.GC11183@elte.hu>
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

> 
> * Anton Vorontsov <avorontsov@ru.mvista.com> wrote:
> 
> > On Fri, Mar 20, 2009 at 08:57:43PM +0100, Ingo Molnar wrote:
> > > 
> > > * Anton Vorontsov <avorontsov@ru.mvista.com> wrote:
> > > 
> > > > On Fri, Mar 20, 2009 at 08:04:28PM +0100, Ingo Molnar wrote:
> > > > > 
> > > > > * Anton Vorontsov <avorontsov@ru.mvista.com> wrote:
> > > > > 
> > > > > > commit 40ada30f9621fbd831ac2437b9a2a399aad34b00 ("tracing: clean 
> > > > > > up menu"), despite the "clean up" in its purpose, introduced 
> > > > > > behavioural change for Kconfig symbols: we no longer able to 
> > > > > > select tracing support on PPC32 (because IRQFLAGS_SUPPORT isn't 
> > > > > > yet implemented).
> > > > > 
> > > > > Could you please solve this by implementing proper 
> > > > > irqflag-tracing support? It's been available upstream for almost 
> > > > > three years. It's needed for lockdep support as well, etc.
> > > > 
> > > > Breaking things via clean up patches is an interesting method of 
> > > > encouraging something to implement. ;-)
> > > >
> > > > Surely I'll look into implementing irqflags tracing, but 
> > > > considering that no one ever needed this for almost three years, 
> > > > [...]
> > > 
> > > Weird, there's no lockdep support?
> > 
> > *ashamed*: apparently no such support currently exist for PPC32. ;-)
> 
> Hm, do all the tracers even compile on ppc32 with your patch?
> 
> We had periodic build failures on weird, unmaintained architectures 
> that had no irqflags-tracing support and hence didnt know the 
> raw_irqs_save/restore primitives ...
> 
> I'm not trying to make things more difficult for you (and we can 
> apply your patch if it builds fine and does not cause problems 
> elsewhere), but there were some real downsides to not having proper 
> irq APIs ...

Note, the issue is not with the hooks into local_irq_save/restore, but 
with the entry.S code. That code is very sensitive where the irqs are 
enabled and disabled.

-- Steve
