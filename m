Return-Path: <wad@chromium.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CFC05100845
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 May 2011 14:07:21 +1000 (EST)
Received: by fxm5 with SMTP id 5so1910422fxm.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 18 May 2011 21:07:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110517131902.GF21441@elte.hu>
References: <20110513125452.GD3924@elte.hu> <1305292132.2466.26.camel@twins>
	<20110513131800.GA7883@elte.hu> <1305294935.2466.64.camel@twins>
	<20110513145737.GC32688@elte.hu>
	<1305563026.5456.19.camel@gandalf.stny.rr.com>
	<20110516165249.GB10929@elte.hu>
	<1305565422.5456.21.camel@gandalf.stny.rr.com>
	<20110517124212.GB21441@elte.hu>
	<1305637528.5456.723.camel@gandalf.stny.rr.com>
	<20110517131902.GF21441@elte.hu>
Date: Wed, 18 May 2011 21:07:15 -0700
Message-ID: <BANLkTikBK3-KZ10eErQ6Eex_L6Qe2aZang@mail.gmail.com>
Subject: Re: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call
	filtering
From: Will Drewry <wad@chromium.org>
To: Ingo Molnar <mingo@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1
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
	Ingo Molnar <mingo@redhat.com>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	kees.cook@canonical.com, "Serge E. Hallyn" <serge@hallyn.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>, Roland McGrath <roland@redhat.com>,
	Michal Marek <mmarek@suse.cz>, Michal Simek <monstr@monstr.eu>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Ralf Baechle <ralf@linux-mips.org>,
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

On Tue, May 17, 2011 at 6:19 AM, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Steven Rostedt <rostedt@goodmis.org> wrote:
>
>> On Tue, 2011-05-17 at 14:42 +0200, Ingo Molnar wrote:
>> > * Steven Rostedt <rostedt@goodmis.org> wrote:
>> >
>> > > On Mon, 2011-05-16 at 18:52 +0200, Ingo Molnar wrote:
>> > > > * Steven Rostedt <rostedt@goodmis.org> wrote:
>> > > >
>> > > > > I'm a bit nervous about the 'active' role of (trace_)events, bec=
ause of the
>> > > > > way multiple callbacks can be registered. How would:
>> > > > >
>> > > > > =A0 =A0 =A0 err =3D event_x();
>> > > > > =A0 =A0 =A0 if (err =3D=3D -EACCESS) {
>> > > > >
>> > > > > be handled? [...]
>> > > >
>> > > > The default behavior would be something obvious: to trigger all ca=
llbacks and
>> > > > use the first non-zero return value.
>> > >
>> > > But how do we know which callback that was from? There's no ordering=
 of what
>> > > callbacks are called first.
>> >
>> > We do not have to know that - nor do the calling sites care in general=
. Do you
>> > have some specific usecase in mind where the identity of the callback =
that
>> > generates a match matters?
>>
>> Maybe I'm confused. I was thinking that these event_*() are what we
>> currently call trace_*(), but the event_*(), I assume, can return a
>> value if a call back returns one.
>
> Yeah - and the call site can treat it as:
>
> =A0- Ugh, if i get an error i need to abort whatever i was about to do
>
> or (more advanced future use):
>
> =A0- If i get a positive value i need to re-evaluate the parameters that =
were
> =A0 passed in, they were changed

Do event_* that return non-void exist in the tree at all now?  I've
looked at the various tracepoint macros as well as some of the other
handlers (trace_function, perf_tp_event, etc) and I'm not seeing any
places where a return value is honored nor could be.  At best, the
perf_tp_event can be short-circuited it in the hlist_for_each, but
it'd still need a way to bubble up a failure and result in not calling
the trace/event that the hook precedes.

Am I missing something really obvious?  I don't feel I've gotten a
good handle on exactly how all the tracing code gets triggered, so
perhaps I'm still a level (or three) too shallow. (I can see the asm
hooks for trace functions and I can see where that translates to
registered calls - like trace_function - but I don't see how the
hooked calls can be trivially aborted).

As is, I'm not sure how the perf and ftrace infrastructure could be
reused cleanly without a fair number of hacks to the interface and a
good bit of reworking.  I can already see a number of challenges
around reusing the sys_perf_event_open interface and the fact that
reimplementing something even as simple as seccomp mode=3D1 seems to
require a fair amount of tweaking to avoid from being leaky.  (E.g.,
enabling all TRACE_EVENT()s for syscalls will miss unhooked syscalls
so either acceptance matching needs to be propagated up the stack
along with some seccomp-like task modality or seccomp-on-perf would
have to depend on sys_enter events with syscall number predicate
matching and fail when a filter discard applies to all active events.)

At present, I'm leaning back towards the v2 series (plus the requested
minor changes) for the benefit of code clarity and its fail-secure
behavior.  Even just considering the reduced case of seccomp mode 1
being implemented on the shared infrastructure, I feel like I missing
something that makes it viable.  Any clues?

If not, I don't think a seccomp mode 2 interface via prctl would be
intractable if the long term movement is to a ftrace/perf backend - it
just means that the in-kernel code would change to wrap whatever the
final design ended up being.

Thanks and sorry if I'm being dense!

>> Thus, we now have the ability to dynamically attach function calls to
>> arbitrary points in the kernel that can have an affect on the code that
>> called it. Right now, we only have the ability to attach function calls =
to
>> these locations that have passive affects (tracing/profiling).
>
> Well, they can only have the effect that the calling site accepts and han=
dles.
> So the 'effect' is not arbitrary and not defined by the callbacks, it is
> controlled and handled by the calling code.
>
> We do not want invisible side-effects, opaque hooks, etc.
>
> Instead of that we want (this is the getname() example i cited in the thr=
ead)
> explicit effects, like:
>
> =A0if (event_vfs_getname(result))
> =A0 =A0 =A0 =A0return ERR_PTR(-EPERM);
>
>> But you say, "nor do the calling sites care in general". Then what do
>> these calling sites do with the return code? Are we limiting these
>> actions to security only? Or can we have some other feature. [...]
>
> Yeah, not just security. One other example that came up recently is wheth=
er to
> panic the box on certain (bad) events such as NMI errors. This too could =
be
> made flexible via the event filter code: we already capture many events, =
so
> places that might conceivably do some policy could do so based on a filte=
r
> condition.

This sounds great - I just wish I could figure out how it'd work :)

>> [...] I can envision that we can make the Linux kernel quite dynamic her=
e
>> with "self modifying code". That is, anywhere we have "hooks", perhaps w=
e
>> could replace them with dynamic switches (jump labels). Maybe events wou=
ld
>> not be the best use, but they could be a generic one.
>
> events and explicit function calls and explicit side-effects are pretty m=
uch
> the only thing that are acceptable. We do not want opaque hooks and arbit=
rary
> side-effects.
>
>> Knowing what callback returned the result would be beneficial. Right now=
, you
>> are saying if the call back return anything, just abort the call, not kn=
owing
>> what callback was called.
>
> Yeah, and that's a feature: that way a number of conditions can be attach=
ed.
> Multiple security frameworks may have effect on a task or multiple tools =
might
> set policy action on a given event.
>
> Thanks,
>
> =A0 =A0 =A0 =A0Ingo
>
