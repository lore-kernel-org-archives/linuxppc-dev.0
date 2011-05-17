Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.123]) by ozlabs.org (Postfix) with ESMTP id DB571B6EF3
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 17 May 2011 23:05:37 +1000 (EST)
Subject: Re: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system
	call filtering
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20110517124212.GB21441@elte.hu>
References: <1305290370.2466.14.camel@twins>
	<1305290612.2466.17.camel@twins> <20110513125452.GD3924@elte.hu>
	<1305292132.2466.26.camel@twins> <20110513131800.GA7883@elte.hu>
	<1305294935.2466.64.camel@twins> <20110513145737.GC32688@elte.hu>
	<1305563026.5456.19.camel@gandalf.stny.rr.com>
	<20110516165249.GB10929@elte.hu>
	<1305565422.5456.21.camel@gandalf.stny.rr.com>
	<20110517124212.GB21441@elte.hu>
Content-Type: text/plain; charset="ISO-8859-15"
Date: Tue, 17 May 2011 09:05:28 -0400
Message-ID: <1305637528.5456.723.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Cc: linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Oleg Nesterov <oleg@redhat.com>, David Howells <dhowells@redhat.com>,
	Paul Mackerras <paulus@samba.org>, Ralf Baechle <ralf@linux-mips.org>,
	"H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
	Jiri Slaby <jslaby@suse.cz>, linux-s390@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>, x86@kernel.org,
	James Morris <jmorris@namei.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	kees.cook@canonical.com, "Serge E. Hallyn" <serge@hallyn.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>, Roland McGrath <roland@redhat.com>,
	Michal Marek <mmarek@suse.cz>, Michal Simek <monstr@monstr.eu>,
	Will Drewry <wad@chromium.org>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, Eric Paris <eparis@redhat.com>,
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

On Tue, 2011-05-17 at 14:42 +0200, Ingo Molnar wrote:
> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Mon, 2011-05-16 at 18:52 +0200, Ingo Molnar wrote:
> > > * Steven Rostedt <rostedt@goodmis.org> wrote:
> > > 
> > > > I'm a bit nervous about the 'active' role of (trace_)events, because of the 
> > > > way multiple callbacks can be registered. How would:
> > > > 
> > > > 	err = event_x();
> > > > 	if (err == -EACCESS) {
> > > > 
> > > > be handled? [...]
> > > 
> > > The default behavior would be something obvious: to trigger all callbacks and 
> > > use the first non-zero return value.
> > 
> > But how do we know which callback that was from? There's no ordering of what 
> > callbacks are called first.
> 
> We do not have to know that - nor do the calling sites care in general. Do you 
> have some specific usecase in mind where the identity of the callback that 
> generates a match matters?

Maybe I'm confused. I was thinking that these event_*() are what we
currently call trace_*(), but the event_*(), I assume, can return a
value if a call back returns one.

Thus, we now have the ability to dynamically attach function calls to
arbitrary points in the kernel that can have an affect on the code that
called it. Right now, we only have the ability to attach function calls
to these locations that have passive affects (tracing/profiling).

But you say, "nor do the calling sites care in general". Then what do
these calling sites do with the return code? Are we limiting these
actions to security only? Or can we have some other feature. I can
envision that we can make the Linux kernel quite dynamic here with "self
modifying code". That is, anywhere we have "hooks", perhaps we could
replace them with dynamic switches (jump labels). Maybe events would not
be the best use, but they could be a generic one.

Knowing what callback returned the result would be beneficial. Right
now, you are saying if the call back return anything, just abort the
call, not knowing what callback was called.

-- Steve
