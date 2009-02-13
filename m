Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.124]) by ozlabs.org (Postfix) with ESMTP id B89D8DDEF3
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2009 15:18:59 +1100 (EST)
Date: Thu, 12 Feb 2009 23:18:56 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/7][RFC] powerpc64: port of the function graph tracer
In-Reply-To: <1234498320.26036.33.camel@pasglop>
Message-ID: <alpine.DEB.1.10.0902122316130.15469@gandalf.stny.rr.com>
References: <20090212011051.265346435@goodmis.org>
	<20090212011342.880486000@goodmis.org>
	<1234498320.26036.33.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Frederic Weisbecker <fweisbec@gmail.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Steven Rostedt <srostedt@redhat.com>,
	Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 13 Feb 2009, Benjamin Herrenschmidt wrote:

> > On Wed, 2009-02-11 at 20:10 -0500, Steven Rostedt wrote:
> > 
> > +# timers used by tracing
> > +CFLAGS_REMOVE_time.o = -pg -mno-sched-epilog
> >  endif
> 
> That means no tracing of the timer interrupts etc... maybe we should
> just move the specific function that we don't want traced out to a
> separate file ? 

The function graph tracer calls cpu_clock, which calls sched_clock, 
to get the times. There's no protection against recursion here, since
we want to let interrupts still be recorded, and we do not need to disable
interrupts.

But if the cpu_clock calls something that is traced, it will recurse, and 
cause a lockup. What ever functions those are, we could annotate with
notrace. I just used the x86 blind method of 'dont trace this file'.


> 
> Appart from that, it looks ok, though I might have missed something :-)

Thanks,

-- Steve
