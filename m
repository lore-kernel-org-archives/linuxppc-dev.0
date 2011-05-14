Return-Path: <wad@chromium.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 139D3B6EF3
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 15 May 2011 06:58:02 +1000 (EST)
Received: by fxm5 with SMTP id 5so2652255fxm.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 14 May 2011 13:57:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110514073015.GB9307@elte.hu>
References: <1304017638.18763.205.camel@gandalf.stny.rr.com>
	<1305169376-2363-1-git-send-email-wad@chromium.org>
	<20110512074850.GA9937@elte.hu>
	<alpine.LRH.2.00.1105122133500.31507@tundra.namei.org>
	<20110512130104.GA2912@elte.hu>
	<alpine.LRH.2.00.1105131018040.3047@tundra.namei.org>
	<20110513121034.GG21022@elte.hu>
	<1305299455.2076.26.camel@localhost.localdomain>
	<20110514073015.GB9307@elte.hu>
Date: Sat, 14 May 2011 15:57:55 -0500
Message-ID: <BANLkTi=1CBKevjg3+fYFZF9zWtQVw-W9hQ@mail.gmail.com>
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
	Ingo Molnar <mingo@redhat.com>, kees.cook@canonical.com,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
	Michal Marek <mmarek@suse.cz>, Michal Simek <monstr@monstr.eu>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Ralf Baechle <ralf@linux-mips.org>, Paul Mundt <lethal@linux-sh.org>,
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

On Sat, May 14, 2011 at 2:30 AM, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Eric Paris <eparis@redhat.com> wrote:
>
>> [dropping microblaze and roland]
>>
>> lOn Fri, 2011-05-13 at 14:10 +0200, Ingo Molnar wrote:
>> > * James Morris <jmorris@namei.org> wrote:
>>
>> > It is a simple and sensible security feature, agreed? It allows most c=
ode to
>> > run well and link to countless libraries - but no access to other file=
s is
>> > allowed.
>>
>> It's simple enough and sounds reasonable, but you can read all the discu=
ssion
>> about AppArmour why many people don't really think it's the best. [...]
>
> I have to say most of the participants of the AppArmour flamefests were d=
ead
> wrong, and it wasnt the AppArmour folks who were wrong ...
>
> The straight ASCII VFS namespace *makes sense*, and yes, the raw physical
> objects space that SELinux uses makes sense as well.
>
> And no, i do not subscribe to the dogma that it is not possible to secure=
 the
> ASCII VFS namespace: it evidently is possible, if you know and handle the
> ambiguitites. It is also obviously true that the ASCII VFS namespaces we =
use
> every day are a *lot* more intuitive than the labeled physical objects sp=
ace
> ...
>
> What all the security flamewars missed is the simple fact that being intu=
itive
> matters a *lot* not just to not annoy users, but also to broaden the effe=
ctive
> number of security-conscious developers ...
>
>> > Unfortunately this audit callback cannot be used for my purposes, beca=
use
>> > the event is single-purpose for auditd and because it allows no feedba=
ck
>> > (no deny/accept discretion for the security policy).
>> >
>> > But if had this simple event there:
>> >
>> > =A0 =A0 err =3D event_vfs_getname(result);
>>
>> Wow it sounds so easy. =A0Now lets keep extending your train of thought
>> until we can actually provide the security provided by SELinux. =A0What =
do
>> we end up with? =A0We end up with an event hook right next to every LSM
>> hook. =A0You know, the LSM hooks were placed where they are for a reason=
.
>> Because those were the locations inside the kernel where you actually
>> have information about the task doing an operation and the objects
>> (files, sockets, directories, other tasks, etc) they are doing an
>> operation on.
>>
>> Honestly all you are talking about it remaking the LSM with 2 sets of
>> hooks instead if 1. =A0Why? [...]
>
> Not at all. I am taking about using *one* set of events, to keep the intr=
usion
> at the lowest possible level.
>
> LSM could make use of them as well.
>
> Obviously for pragmatic reasons that might not be feasible initially.
>
>> [...] =A0It seems much easier that if you want the language of the filte=
r
>> engine you would just make a new LSM that uses the filter engine for it'=
s
>> policy language rather than the language created by SELinux or SMACK or =
name
>> your LSM implementation.
>
> Correct, that is what i suggested.
>
> Note that performance is a primary concern, so if certain filters are ver=
y
> popular then in practice this would come with support for a couple of 'bu=
ilt
> in' (pre-optimized) filters that the kernel can accelerate directly, so t=
hat we
> do not incure the cost of executing the filter preds for really common-se=
nse
> security policies that almost everyone is using.
>
> I.e. in the end we'd *roughly* end up with the same performance and secur=
ity as
> we are today (i mean, SELinux and the other LSMs did a nice job of collec=
ting
> the things that apps should be careful about), but the crutial difference=
 isnt
> just the advantages i menioned, but the fact that the *development model*=
 of
> security modules would be a *lot* more extensible.
>
> So security efforts could move to a whole different level: they could mov=
e into
> key apps and they could integrate with the general mind-set of developers=
.
>
> At least Will as an application framework developer cares, so that hope i=
s
> justified i think.
>
>> > =A0- unprivileged: =A0application-definable, allowing the embedding of=
 security
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 policy in *apps* as well, not just=
 the system
>> >
>> > =A0- flexible: =A0 =A0 =A0can be added/removed runtime unprivileged, a=
nd cheaply so
>> >
>> > =A0- transparent: =A0 does not impact executing code that meets the po=
licy
>> >
>> > =A0- nestable: =A0 =A0 =A0it is inherited by child tasks and is fundam=
entally stackable,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 multiple policies will have the co=
mbined effect and they
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 are transparent to each other. So =
if a child task within a
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sandbox adds *more* checks then th=
ose add to the already
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 existing set of checks. We only na=
rrow permissions, never
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 extend them.
>> >
>> > =A0- generic: =A0 =A0 =A0 allowing observation and (safe) control of s=
ecurity relevant
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 parameters not just at the system =
call boundary but at other
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 relevant places of kernel executio=
n as well: which
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 points/callbacks could also be use=
d for other types of event
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 extraction such as perf. It could =
even be shared with audit ...
>>
>> I'm not arguing that any of these things are bad things. =A0What you des=
cribe
>> is a new LSM that uses a discretionary access control model but with the
>> granularity and flexibility that has traditionally only existed in the
>> mandatory access control security modules previously implemented in the
>> kernel.
>>
>> I won't argue that's a bad idea, there's no reason in my mind that a pro=
cess
>> shouldn't be allowed to control it's own access decisions in a more flex=
ible
>> way than rwx bits. =A0Then again, I certainly don't see a reason that th=
is
>> syscall hardening patch should be held up while a whole new concept in
>> computer security is contemplated...
>
> Note, i'm not actually asking for the moon, a pony and more.
>
> I fully submit that we are yet far away from being able to do a full LSM =
via
> this mechanism.
>
> What i'm asking for is that because the syscall point steps taken by Will=
 look
> very promising so it would be nice to do *that* in a slightly more flexib=
le
> scheme that does not condemn it to be limited to the syscall boundary and=
 such
> ...

What do you suggest here?

>From my brief exploration of the ftrace/perf (and seccomp) code, I
don't see a clean way of integrating over the existing interfaces to
the ftrace framework (e.g., the global perf event pump seems to be a
mismatch), but I may be missing something obvious.   In my view,
implementing this nestled between the seccomp/ftrace world provides a
stepping stone forward without being too restrictive.  No matter how
we change security events in the future, system calls will always be
the first line of attack surface reduction.  It could just mean that,
in the long term, accessing the "security event filtering" framework
is done through another new interface with seccomp providing only a
targeted syscall filtering featureset that may one day be deprecated
(if that day ever comes).

If there's a clear way to cleanly expand this interface that I'm
missing, I'd love to know - thanks!
will

> Also, to answer you, do you say that by my argument someone should have s=
tood
> up and said 'no' to the LSM mess that was introduced a couple of years ag=
o and
> which caused so many problems:
>
> =A0- kernel inefficiencies and user-space overhead
>
> =A0- stalled security efforts
>
> =A0- infighting
>
> =A0- friction, fragmentation, overmodularization
>
> =A0- non-stackability
>
> =A0- security annoyances on the Linux desktop
>
> =A0- probably *less* Linux security
>
> and should have asked them to do something better designed instead?
>
> Thanks,
>
> =A0 =A0 =A0 =A0Ingo
>
