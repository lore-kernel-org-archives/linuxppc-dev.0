Return-Path: <wad@chromium.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9119FB718C
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 20 May 2011 07:05:21 +1000 (EST)
Received: by fxm5 with SMTP id 5so2597592fxm.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 May 2011 14:05:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1305807728.11267.25.camel@gandalf.stny.rr.com>
References: <20110513125452.GD3924@elte.hu> <1305292132.2466.26.camel@twins>
	<20110513131800.GA7883@elte.hu> <1305294935.2466.64.camel@twins>
	<20110513145737.GC32688@elte.hu>
	<1305563026.5456.19.camel@gandalf.stny.rr.com>
	<20110516165249.GB10929@elte.hu>
	<1305565422.5456.21.camel@gandalf.stny.rr.com>
	<20110517124212.GB21441@elte.hu>
	<1305637528.5456.723.camel@gandalf.stny.rr.com>
	<20110517131902.GF21441@elte.hu>
	<BANLkTikBK3-KZ10eErQ6Eex_L6Qe2aZang@mail.gmail.com>
	<1305807728.11267.25.camel@gandalf.stny.rr.com>
Date: Thu, 19 May 2011 16:05:14 -0500
Message-ID: <BANLkTiki8aQJbFkKOFC+s6xAEiuVyMM5MQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call
	filtering
From: Will Drewry <wad@chromium.org>
To: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>,
	Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <fweisbec@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Oleg Nesterov <oleg@redhat.com>, David Howells <dhowells@redhat.com>,
	Paul Mackerras <paulus@samba.org>, Ralf Baechle <ralf@linux-mips.org>,
	"H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
	Jiri Slaby <jslaby@suse.cz>, linux-s390@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>, x86@kernel.org,
	James Morris <jmorris@namei.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>, kees.cook@canonical.com,
	"Serge E. Hallyn" <serge@hallyn.com>, Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	Michal Marek <mmarek@suse.cz>, Michal Simek <monstr@monstr.eu>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Eric Paris <eparis@redhat.com>, Paul Mundt <lethal@linux-sh.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
	Andrew Morton <akpm@linux-foundation.org>, agl@chromium.org,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 19, 2011 at 7:22 AM, Steven Rostedt <rostedt@goodmis.org> wrote=
:
> On Wed, 2011-05-18 at 21:07 -0700, Will Drewry wrote:
>
>> Do event_* that return non-void exist in the tree at all now? =A0I've
>> looked at the various tracepoint macros as well as some of the other
>> handlers (trace_function, perf_tp_event, etc) and I'm not seeing any
>> places where a return value is honored nor could be. =A0At best, the
>> perf_tp_event can be short-circuited it in the hlist_for_each, but
>> it'd still need a way to bubble up a failure and result in not calling
>> the trace/event that the hook precedes.
>
> No, none of the current trace hooks have return values. That was what I
> was talking about how to implement in my previous emails.

Led on by complete ignorance, I think I'm finally beginning to untwist
the different pieces of the tracing infrastructure.  Unfortunately,
that means I took a few wrong turns along the way...

I think function tracing looks something like this:

ftrace_call has been injected into at a specific callsite.  Upon hit:
1. ftrace_call triggers
2. does some checks then calls ftrace_trace_function (via mcount instrs)
3. ftrace_trace_function may be a single func or a list. For a list it
will be: ftrace_list_func
4. ftrace_list_func calls each registered hook for that function in a
while loop ignoring return values
5. registered hook funcs may then track the call, farm it out to
specific sub-handlers, etc.

This seems to be a red herring for my use case :/ though this helped
me understand your back and forth (Ingo & Steve) regarding dynamic
versus explicit events.


System call tracing is done via kernel/tracepoint.c events fed in via
arch/[arch]/kernel/ptrace.c where it calls trace_sys_enter.  This
yields direct sys_enter and sys_exit event sources (and an event class
to hook up per-system call events).  This means that
ftrace_syscall_enter() does the event prep prior to doing a filter
check comparing the ftrace_event object for the given syscall_nr to
the event data.  perf_sysenter_enter() is similar but it pushes the
info over to perf_tp_event to be matched not against the global
syscall event entry, but against any sub-event in the linked list on
that syscall's event.

Is that roughly an accurate representation of the two?  I wish I
hadn't gotten distracted along the function path, but at least I
learned something (and it is relevant to the larger scope of this
thread's discussion).


After doing that digging, it looks like providing hook call
pre-emption and return value propagation will be a unique and fun task
for each tracer and event subsystem.  If I look solely at tracepoints,
a generic change would be to make the trace_##subsys function return
an int (which I think was the event_vfs_getname proposal?).  The other
option is to change the trace_sys_enter proto to include a 'int
*retcode'.

That change would allow the propagation of some sort of policy
information.  To put it to use, seccomp mode 1 could be implemented on
top of trace_syscalls.  The following changes would need to happen:
1. dummy metadata should be inserted for all unhooked system calls
2. perf_trace_buf_submit would need to return an int or a new
TRACE_REG_SECCOMP_REGISTER handler would need to be setup in
syscall_enter_register.
3. If perf is abused, a "kill/fail_on_discard" bit would be added to
event->attrs.
4. perf_trace_buf_submit/perf_tp_event will return 0 for no matches,
'n' for the number of event matches, and -EACCES/? if a
'fail_on_discard' event is seen.
5. perf_syscall_enter would set *retcode =3D perf_trace_buf_submit()'s retc=
ode
6. trace_sys_enter() would need to be moved to be the first entry
arch/../kernel/ptrace.c for incoming syscalls
7. if trace_sys_enter() yields a negative return code, then
do_exit(SIGKILL) the process and return.

Entering into seccomp mode 1 would require adding a  "0" filter for
every system call number (which is why we need a dummy event call for
them since failing to check the bitmask can't be flagged
fail_on_discard) with the fail_on_discard bit.  For the three calls
that are allowed, a '1' filter would be set.

That would roughly implement seccomp mode 1.  It's pretty ugly and the
fact that every system call that's disallowed has to be blacklisted is
not ideal.  An alternate model would be to just use the seccomp mode
as we do today and let secure_computing() handle the return code of "#
of matches".  If it the # of matches is 0, it terminates. A
'fail_on_discard' bit then would only be good to stop further
tracepoint callback evaluation.  This approach would also *almost* nix
the need to provide dummy syscall hooks.  (Since sigreturn isn't
hooked on x86 because it uses ptregs fixup, a dummy would still be
needed to apply a "1" filter to.)

Even with that tweak to move to a whitelist model, the perf event
evaluation and tracepoint callback ordering is still not guaranteed.
Without changing tracepoint itself, all other TPs will still execute.
And for perf events, it'll be first-come-first-serve until a
fail_on_discard is hit.

After using seccomp mode=3D1 as the sample case to reduce scope, it's
possible to ignore it for now :) and look at the seccomp-filter/mode=3D2
case.  The same mechanism could be used to inject more expressive
filters.  This would be done over the sys_perf_event_open() interface
assuming the new attr is added to stop perf event list enumeration.
Assuming a whitelist model, a call to prctl(PR_SET_SECCOMP, 2) would
be needed (maybe with the ON_EXEC flag option too to mirror the
event->attr on-exec bit). That would yield the ability to register
perf events for system calls then use ioctl() to SET_FILTER on them.

Reducing the privileges of the filters after installation could be
done with another attribute bit like 'set_filter_ands'.  If that is
also set on the event, and a filter is installed to ensure that
sys_perf_event_open is blocked, then it should be reasonably sane.

I'd need to add a PERF_EVENT_IOC_GET_FILTER handler to allow
extracting the settings.

Clearly, I haven't written the code for that yet, though making the
change for a single platform shouldn't be too much code.

So that leaves me with some questions:
- Is this the type of reuse that was being encouraged?
- Does it really make sense to cram this through the perf interface
and events?  While the changed attributes are innocuous and
potentially reusable, it seems that a large amount of the perf
facilities are exposed that could have weird side effects, but I'm
sure I still don't fully grok the perf infrastructure.
- Does extending one tracepoint to provide return values via a pointer
make sense? I'd hesitate to make all tracepoint hooks return an int by
default.
- If all tracepoints returned an int, what would the standard value
look like - or would it need to be per tracepoint impl?
- How is ambiguity resolved if multiple perf_events are registered for
a syscall with different filters?  Maybe a 'stop_on_match'? though
ordering is still a problem then.
- Is there a way to affect a task-wide change without a seccomp flag
(or new task_struct entry) via the existing sys_perf_event_open
syscall?  I considered suggesting a attr bit call 'secure_computing'
that when an event with the bit is enabled, it automagically forces
the task into seccomp enforcement mode, but that, again, seemed
hackish.

While I like the idea of sharing the tracepoints infrastructure and
the trace_syscalls hooks as well as using a pre-existing interface
with very minor changes, I'm worried that the complexity of the
interface and of the infrastructure might undermine the ability to
continue meeting the desired security goals.  I had originally stayed
very close to the seccomp world because of how trivial it is to review
the code and verify its accuracy/effectiveness.  This approach leaves
a lot of gaps for kernel code to seep through and a fair amount of
ambiguity in what locked down syscall filters might look like.

To me, the best part of the above is that it shows that even if we go
with a prctl SET_SECCOMP_FILTER-style interface, it is completely
certain that if a perf/ftrace-based security infrastructure is on our
future, it will be entirely compatible -- even if the prctl()
interface is just the "simpler" interface at that point somewhere down
the road.


Regardless, I'll hack up a proof of concept based on the outline
above. Perhaps something more elegant will emerge once I start
tweaking the source, but I'm still seeing too many gaps to be
comfortable so far.


[[There is a whole other approach to this too. We could continue with
the prctl() interface and mirror the trace_sys_enter model for
secure_computing().   Instead of keeping a seccomp_t-based hlist of
events, they could be stored in a new hlist for seccomp_events in
struct ftrace_event_call.  The ftrace filters would be installed there
and the seccomp_syscall_enter() function could do the checks and pass
up some state data on the task's seccomp_t that indicates it needs to
do_exit().  That would likely reduce the amount of code in
seccomp_filter.c pretty seriously (though not entirely
beneficially).]]


Thanks again for all the feedback and insights! I really hope we can
come to an agreeable approach for implementing kernel attack surface
reduction.
will
