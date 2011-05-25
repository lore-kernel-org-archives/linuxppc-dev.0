Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (www.linutronix.de [62.245.132.108])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 92600B6F94
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 26 May 2011 03:49:39 +1000 (EST)
Date: Wed, 25 May 2011 19:48:51 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call
	filtering
In-Reply-To: <20110525150153.GE29179@elte.hu>
Message-ID: <alpine.LFD.2.02.1105251836030.3078@ionos>
References: <20110517124212.GB21441@elte.hu>
	<1305637528.5456.723.camel@gandalf.stny.rr.com>
	<20110517131902.GF21441@elte.hu>
	<BANLkTikBK3-KZ10eErQ6Eex_L6Qe2aZang@mail.gmail.com>
	<1305807728.11267.25.camel@gandalf.stny.rr.com>
	<BANLkTiki8aQJbFkKOFC+s6xAEiuVyMM5MQ@mail.gmail.com>
	<BANLkTim9UyYAGhg06vCFLxkYPX18cPymEQ@mail.gmail.com>
	<1306254027.18455.47.camel@twins> <20110524195435.GC27634@elte.hu>
	<alpine.LFD.2.02.1105242239230.3078@ionos>
	<20110525150153.GE29179@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Oleg Nesterov <oleg@redhat.com>, David Howells <dhowells@redhat.com>,
	Paul Mackerras <paulus@samba.org>,
	Eric Paris <eparis@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	sparclinux@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
	linux-s390@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>, x86@kernel.org,
	James Morris <jmorris@namei.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>, kees.cook@canonical.com,
	"Serge E. Hallyn" <serge@hallyn.com>, Steven Rostedt <rostedt@goodmis.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	Michal Marek <mmarek@suse.cz>, Michal Simek <monstr@monstr.eu>,
	Will Drewry <wad@chromium.org>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
	Paul Mundt <lethal@linux-sh.org>, Tejun Heo <tj@kernel.org>,
	linux390@de.ibm.com, Andrew Morton <akpm@linux-foundation.org>,
	agl@chromium.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 25 May 2011, Ingo Molnar wrote:
> * Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Tue, 24 May 2011, Ingo Molnar wrote:
> > > * Peter Zijlstra <peterz@infradead.org> wrote:
> > > 
> > > > On Tue, 2011-05-24 at 10:59 -0500, Will Drewry wrote:
> > > > >  include/linux/ftrace_event.h  |    4 +-
> > > > >  include/linux/perf_event.h    |   10 +++++---
> > > > >  kernel/perf_event.c           |   49 +++++++++++++++++++++++++++++++++++++---
> > > > >  kernel/seccomp.c              |    8 ++++++
> > > > >  kernel/trace/trace_syscalls.c |   27 +++++++++++++++++-----
> > > > >  5 files changed, 82 insertions(+), 16 deletions(-) 
> > > > 
> > > > I strongly oppose to the perf core being mixed with any sekurity voodoo
> > > > (or any other active role for that matter).
> > > 
> > > I'd object to invisible side-effects as well, and vehemently so. But note how 
> > > intelligently it's used here: it's explicit in the code, it's used explicitly 
> > > in kernel/seccomp.c and the event generation place in 
> > > kernel/trace/trace_syscalls.c.
> > > 
> > > So this is a really flexible solution IMO and does not extend events with some 
> > > invisible 'active' role. It extends the *call site* with an open-coded active 
> > > role - which active role btw. already pre-existed.
> > 
> > We do _NOT_ make any decision based on the trace point so what's the
> > "pre-existing" active role in the syscall entry code?
> 
> The seccomp code we are discussing in this thread.

That's proposed code and has absolutely nothing to do with the
existing trace point semantics.
 
> > I'm all for code reuse and reuse of interfaces, but this is completely
> > wrong. Instrumentation and security decisions are two fundamentally
> > different things and we want them kept separate. Instrumentation is
> > not meant to make decisions. Just because we can does not mean that it
> > is a good idea.
> 
> Instrumentation does not 'make decisions': the calling site, which is 
> already emitting both the event and wants to do decisions based on 
> the data that also generates the event wants to do decisions.

You can repeat that as often as you want, it does not make it more
true. Fact is that the decision is made in the middle of the perf code.

> +     /* Transition the task if required. */
> +     if (ctx->type == task_context && event->attr.require_secure) {
> +#ifdef CONFIG_SECCOMP
> +		/* Don't allow perf events to escape mode = 1. */
> +		   if (!current->seccomp.mode)
> +			current->seccomp.mode = 2;
> +#endif
> +	}
 
and further down

> +   	    if (event->attr.err_on_discard)
> +		ok = -EACCES;
 
> Those decisions *will be made* and you cannot prevent that, the only 
> open question is can it reuse code intelligently, which code it is 
> btw. already calling for observation reasons?

The tracepoint is called for observation reasons and now you make it a
decision function. That's what I call abuse.

> ( Note that pure observers wont be affected and note that pure 
>   observation call sites are not affected either. )

Hahaha, they still have to run through the additional code when
seccomp is enabled and we still have to propagate the return value
down to the point where the tracepoint itself is. You call that not
affected?
 
> > So what the current approach does is:
> > 
> >  - abuse the existing ftrace syscall hook by adding a return value to
> >    the tracepoint.
> > 
> >    So we need to propagate that for every tracepoint just because we
> >    have a single user.
> 
> This is a technical criticism i share with you and i think it can be 
> fixed - i outlined it to Will yesterday.
> 
> And no, if done cleanly it's not 'abuse' to reuse code. Could we wait 
> for the first clean iteration of this patch instead of rushing 
> judgement prematurely?

There is no way to do it cleanly. It always comes for the price that
you add additional code into the tracing code path. And there are
other people who try hard to remove stuff to recude the overhead which
is caused by instrumentation.

> >  - abuse the perf per task mechanism
> > 
> >    Just because we have per task context in perf does not mean that we
> >    pull everything and the world which requires per task context into
> >    perf. The security folks have per task context already so security
> >    related stuff wants to go there.
> 
> We do not pull 'everything and the world' in, but code that wants to 
> process events in places that already emit events surely sounds 
> related to me :-)

We have enough places where different independent parts of the kernel
want to hook into for obvious reasons.

We have notifiers for those where performance does not matter much and
we have separate calls into the independent functions where it matters
or where we need to evaluate the results in specific ways.

So now you turn instrumentation into a security mechanism, which
"works" nicely for a particular purpose, i.e. decision on a particular
syscall number. Now, how do you make that work when a decision has to
be made on more than a simple match, e.g. syscall number + arguments ?

Not at all, unless you add more complexity and arbitrary callbacks
into the instrumentation code.

> > Brilliant, we have already two ABIs (perf/ftrace) to support and at
> > the same time we urgently need to solve the problem of better
> > integration of those two. So adding a third completely unrelated
> > component with a guaranteed ABI is just making this even more complex.
> 
> So your solution is to add yet another ABI for seccomp and to keep 
> seccomp a limited hack forever, just because you are not interested 
> in security?

Well, I'm interested in security, but I'm neither interested in
security decisions inside instrumentation code nor in security models
which are limited hacks by definition unless you want to add callback
complexities to the instrumentation code.

It all looks nice and charming with this minimalistic use case, but
add real features to it and it gets messy in a split second and you
can't hold that off once you started to allow A. And you clearly
stated that you want to have more trace point based security features
than the simple syscall number filtering.

> I think we want fewer ABIs and more flexible/reusable facilities.

I'm all for that, but security and instrumentation are different
beasts.
 
> > We can factor out the filtering code and let the security dudes 
> > reuse it for their own purposes. That makes them to have their own 
> > interfaces and does not impose any restrictions upon the 
> > tracing/perf ones. And really security stuff wants to be integrated 
> > into the existing security frameworks and not duct taped into 
> > perf/trace just because it's a conveniant hack around limitiations 
> > of the existing security stuff.
> 
> You are missing what i tried to point out in earlier discussions: 
> from a security design POV this isnt just about the system call 
> boundary. If this seccomp variant is based on events then it could 
> grow proper security checks in other places as well, in places where 
> we have some sort of object observation event anyway.

Right, that requires callbacks and more stuff to do object based
observation and ties a trace point into a place where it might not
make sense after a while, but the security decision wants to stay at
that place. The syscall example is so tempting because it's simplistic
and easy to solve, but every extension to that model is going to
create a nightmare.

You are duct taping stuff together which has totally different
semantics and requirements. And your only argument is reuse of
existing code. That's a good argument in principle, but there is a
fundamental difference between intelligent reuse and enforcing it just
for reuse sake.

> So this is opens up possibilities to reuse and unify code on a very 
> broad basis.

By making a total mess out of it? 

> So yes, over-integration is obviously wrong - but so is needless 
> fragmentation.

Right. And this falls into the category of over-integration. We have
people working on security and they are working on stacked security
models, so where is the justification to start another security
framework inside the instrumentation code which is completely non
interoperable with the existing ones?

> If anything then that should tell you something that events and 
> seccomp are not just casually related ...

They happen to have the hook at the same point in the source and for
pure coincidence it works because the problem to solve is extremly
simplistic. And that's why the diffstat is minimalistic, but that does
not prove anything.

Thanks,

	tglx
