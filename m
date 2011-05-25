Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (www.linutronix.de [62.245.132.108])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3A6A8B6F92
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 25 May 2011 20:35:44 +1000 (EST)
Date: Wed, 25 May 2011 12:35:03 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call
	filtering
In-Reply-To: <20110524195435.GC27634@elte.hu>
Message-ID: <alpine.LFD.2.02.1105242239230.3078@ionos>
References: <20110516165249.GB10929@elte.hu>
	<1305565422.5456.21.camel@gandalf.stny.rr.com>
	<20110517124212.GB21441@elte.hu>
	<1305637528.5456.723.camel@gandalf.stny.rr.com>
	<20110517131902.GF21441@elte.hu>
	<BANLkTikBK3-KZ10eErQ6Eex_L6Qe2aZang@mail.gmail.com>
	<1305807728.11267.25.camel@gandalf.stny.rr.com>
	<BANLkTiki8aQJbFkKOFC+s6xAEiuVyMM5MQ@mail.gmail.com>
	<BANLkTim9UyYAGhg06vCFLxkYPX18cPymEQ@mail.gmail.com>
	<1306254027.18455.47.camel@twins> <20110524195435.GC27634@elte.hu>
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

On Tue, 24 May 2011, Ingo Molnar wrote:
> * Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Tue, 2011-05-24 at 10:59 -0500, Will Drewry wrote:
> > >  include/linux/ftrace_event.h  |    4 +-
> > >  include/linux/perf_event.h    |   10 +++++---
> > >  kernel/perf_event.c           |   49 +++++++++++++++++++++++++++++++++++++---
> > >  kernel/seccomp.c              |    8 ++++++
> > >  kernel/trace/trace_syscalls.c |   27 +++++++++++++++++-----
> > >  5 files changed, 82 insertions(+), 16 deletions(-) 
> > 
> > I strongly oppose to the perf core being mixed with any sekurity voodoo
> > (or any other active role for that matter).
> 
> I'd object to invisible side-effects as well, and vehemently so. But note how 
> intelligently it's used here: it's explicit in the code, it's used explicitly 
> in kernel/seccomp.c and the event generation place in 
> kernel/trace/trace_syscalls.c.
> 
> So this is a really flexible solution IMO and does not extend events with some 
> invisible 'active' role. It extends the *call site* with an open-coded active 
> role - which active role btw. already pre-existed.

We do _NOT_ make any decision based on the trace point so what's the
"pre-existing" active role in the syscall entry code?

I'm all for code reuse and reuse of interfaces, but this is completely
wrong. Instrumentation and security decisions are two fundamentally
different things and we want them kept separate. Instrumentation is
not meant to make decisions. Just because we can does not mean that it
is a good idea.

So what the current approach does is:

 - abuse the existing ftrace syscall hook by adding a return value to
   the tracepoint.

   So we need to propagate that for every tracepoint just because we
   have a single user.

 - abuse the perf per task mechanism

   Just because we have per task context in perf does not mean that we
   pull everything and the world which requires per task context into
   perf. The security folks have per task context already so security
   related stuff wants to go there.

 - abuse the perf/ftrace interfaces

   One of the arguments was that perf and ftrace have permission which
   are not available from the existing security interfaces. That's not
   at all a good reason to abuse these interfaces. Let the security
   folks sort out the problem on their end and do not impose any
   expectations on perf/ftrace which we have to carry around forever.

Yes, it can be made working with a relatively small patch, but it has
a very nasty side effect: 

  You add another user space visible ABI to the existing perf/ftrace
  mess which needs to be supported forever.

Brilliant, we have already two ABIs (perf/ftrace) to support and at
the same time we urgently need to solve the problem of better
integration of those two. So adding a third completely unrelated
component with a guaranteed ABI is just making this even more complex.

We can factor out the filtering code and let the security dudes reuse
it for their own purposes. That makes them to have their own
interfaces and does not impose any restrictions upon the tracing/perf
ones. And really security stuff wants to be integrated into the
existing security frameworks and not duct taped into perf/trace just
because it's a conveniant hack around limitiations of the existing
security stuff.

You really should stop to see everything as a nail just because the
only tool you have handy is the perf hammer. perf is about
instrumentation and we don't want to violate the oldest principle of
unix to have simple tools which do one thing and do it good.

Even swiss army knifes have the restriction that you can use only one
tool at a time unless you want to stick the corkscrew through your
palm when you try to cut bread.

Thanks,

	tglx
