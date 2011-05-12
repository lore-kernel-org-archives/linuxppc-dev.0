Return-Path: <wad@chromium.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 27C9BB6F71
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 13 May 2011 02:26:27 +1000 (EST)
Received: by fxm5 with SMTP id 5so1352849fxm.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 12 May 2011 09:26:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110512130104.GA2912@elte.hu>
References: <1304017638.18763.205.camel@gandalf.stny.rr.com>
	<1305169376-2363-1-git-send-email-wad@chromium.org>
	<20110512074850.GA9937@elte.hu>
	<alpine.LRH.2.00.1105122133500.31507@tundra.namei.org>
	<20110512130104.GA2912@elte.hu>
Date: Thu, 12 May 2011 11:26:21 -0500
Message-ID: <BANLkTin74OSAi94jbcYf_tj04L247O4GOg@mail.gmail.com>
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
	linux-arm-kernel@lists.infradead.org, kees.cook@canonical.com,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>, microblaze-uclinux@itee.uq.edu.au,
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

[Thanks to everyone for the continued feedback and insights - I appreciate =
it!]

On Thu, May 12, 2011 at 8:01 AM, Ingo Molnar <mingo@elte.hu> wrote:
>
> * James Morris <jmorris@namei.org> wrote:
>
>> On Thu, 12 May 2011, Ingo Molnar wrote:
>>
>> > 2) Why should this concept not be made available wider, to allow the
>> > =A0 =A0restriction of not just system calls but other security relevan=
t components
>> > =A0 =A0of the kernel as well?
>>
>> Because the aim of this is to reduce the attack surface of the syscall
>> interface.
>
> What i suggest achieves the same, my argument is that we could aim it to =
be
> even more flexible and even more useful.
>
>> LSM is the correct level of abstraction for general security mediation,
>> because it allows you to take into account all relevant security informa=
tion
>> in a race-free context.
>
> I don't care about LSM though, i find it poorly designed.
>
> The approach implemented here, the ability for *unprivileged code* to def=
ine
> (the seeds of ...) flexible security policies, in a proper Linuxish way, =
which
> is inherited along the task parent/child hieararchy and which allows nest=
ing
> etc. is a *lot* more flexible.
>
> What Will implemented here is pretty huge in my opinion: it turns securit=
y from
> a root-only kind of weird hack into an essential component of its APIs,
> available to *any* app not just the select security policy/mechanism chos=
en by
> the distributor ...
>
> If implemented properly this could replace LSM in the long run.
>
> As a prctl() hack bound to seccomp (which, by all means, is a natural ext=
ension
> to the current seccomp ABI, so perfectly fine if we only want that scope)=
, that
> is much less likely to happen.
>
> And if we merge the seccomp interface prematurely then interest towards a=
 more
> flexible approach will disappear, so either we do it properly now or it w=
ill
> take some time for someone to come around and do it ...
>
> Also note that i do not consider the perf events ABI itself cast into sto=
ne -
> and we could very well add a new system call for this, independent of per=
f
> events. I just think that the seccomp scope itself is exciting but looks
> limited to what the real potential of this could be.

I agree with you on many of these points!  However, I don't think that
the views around LSMs, perf/ftrace infrastructure, or the current
seccomp filtering implementation are necessarily in conflict.  Here is
my understanding of how the different worlds fit together and where I
see this patchset living, along with where I could see future work
going.  Perhaps I'm being a trifle naive, but here goes anyway:

1. LSMs provide a global mechanism for hooking "security relevant"
events at a point where all the incoming user-sourced data has been
preprocessed and moved into userspace.  The hooks are called every
time one of those boundaries are crossed.
2. Perf and the ftrace infrastructure provide global function tracing
and system call hooks with direct access to the caller's registers
(and memory).
3. seccomp (as it exists today) provides a global system call entry
hook point with a binary per-process decision about whether to provide
"secure computing" behavior.

When I boil that down to abstractions, I see:
A. Globally scoped: LSMs, ftrace/perf
B. Locally/process scoped: seccomp

The result of that logical equivalence is that I see room for:
I. A per-process, locally scoped security event hooking interface (the
proposed changes in this patchset)
II. A globally scoped security event hooking interface _prior_ to
argument processing
III. A globally scoped security event hooking interface _post_
argument processing

II and III could be reduced further if I assume that ftrace/perf
provides (II) and a simple intermediary layer (hook entry/exit)
provides the argument processing steps that then call out a global
security policy system.

The driving motivation for this patchset is kernel attack surface
reduction, but that need arises because we lack a process-scoped
mechanism for making security decisions -- everything is global:
creds/DAC, containers, LSM, etc.   Adding ftrace filtering to agl's
original bitmask-seccomp proposal opens up the process-local security
world.  At present, it can limit the attack surface with simple binary
filters or apply limited security policy through the use of filter
strings.

Based on your mails, I see two main deficiencies in my proposed patchset:
a. Deep argument analysis: Any arguments that live in user memory
needs to be copied into the kernel, then checked, and substituted for
the actual system call, then have the original pointers restored (when
applicable) on system call exit.  There is a large overhead here and
the LSM hooks provide much of this support on a global level.
b. Lack of support for non-system call events.

For (a), if the long term view of ftrace/perf & LSMs is that LSM-like
functionality will live on top of the ftrace/perf infrastructure, then
adding support for the intermediary layer to analyze arguments will
come with time.  It's also likely that for process-local stuff (e.g.,)
a new predicate could be added to callback to a userspace supervisor,
or even a more generic ability for modules to register new
predicates/functions in the filtering engine itself -- like "fd =3D=3D 1
&& check_path(path) =3D=3D '/etc/safe.conf'" or "check_xattr(path,
expected)".  Of course, I'm just making stuff up right now :)

For (b), we could just add a field we don't use right now in the prctl
interface:
  prctl(PR_SET_SECCOMP_FILTER, int event_type, int
event_or_syscall_nr, char *filter)
[or something similar]

Then we can add process-local/scoped supported event types somewhere
down the road without an ABI change.

Tying it all together, it'd look like:
* Now -- add process-scoped security support: secocmp filter with
support for "future" event types
* Soon -- expand ftrace syscall hooks to hook more system calls
* Later -- expand ftrace filter language to support either deep
argument analysis and/or custom registered predicates
* Later, later -- implement a LSM-like hooking layer for "interesting"
event types on top of the ftrace hooks

That would yield process-scoped security controls and global security
controls and the ability to continue to create new and interesting
security modules.

All that said, I'm in over my head.  I've focused primarily on the
process-scoped security.  I think James, some of the LSM authors, and
out-of-tree security system maintainers would be good to help guide
direction toward the security view you have in mind to ensure the
flexibility desired exists.  And that's even assuming this sketch is
even vaguely interesting...

[snip]

> What i do here is to suggest *further* steps down the same road, now that=
 we
> see that this scheme can indeed be used to implement sandboxing ... I thi=
nk
> it's a valid line of inquiry.

I certainly agree that it's a valid line of inquiry, but I worry about
the massive scope expansion.  I know it hurts my head, but I'm hoping
the brain-dump above frames up how I think about this patch and your
line of inquiry.  ftrace hooking and the perf code certainly look a
lot like LSMs if I squint hard :)  But there is a substantial amount
of work to merge the worlds, and (thankfully) I don't think that
future directly impacts process-scoped security mechanisms even if
they can interact nicely.

thanks!
will
