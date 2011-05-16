Return-Path: <mingo@elte.hu>
Received: from mx3.mail.elte.hu (mx3.mail.elte.hu [157.181.1.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F35A8B6EF3
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 16 May 2011 22:55:58 +1000 (EST)
Date: Mon, 16 May 2011 14:55:05 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Will Drewry <wad@chromium.org>
Subject: Re: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call
	filtering
Message-ID: <20110516125505.GE7128@elte.hu>
References: <1304017638.18763.205.camel@gandalf.stny.rr.com>
	<1305169376-2363-1-git-send-email-wad@chromium.org>
	<20110512074850.GA9937@elte.hu>
	<alpine.LRH.2.00.1105122133500.31507@tundra.namei.org>
	<20110512130104.GA2912@elte.hu>
	<BANLkTin74OSAi94jbcYf_tj04L247O4GOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BANLkTin74OSAi94jbcYf_tj04L247O4GOg@mail.gmail.com>
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


* Will Drewry <wad@chromium.org> wrote:

> I agree with you on many of these points!  However, I don't think that the 
> views around LSMs, perf/ftrace infrastructure, or the current seccomp 
> filtering implementation are necessarily in conflict.  Here is my 
> understanding of how the different worlds fit together and where I see this 
> patchset living, along with where I could see future work going.  Perhaps I'm 
> being a trifle naive, but here goes anyway:
> 
> 1. LSMs provide a global mechanism for hooking "security relevant"
> events at a point where all the incoming user-sourced data has been
> preprocessed and moved into userspace.  The hooks are called every
> time one of those boundaries are crossed.

> 2. Perf and the ftrace infrastructure provide global function tracing
> and system call hooks with direct access to the caller's registers
> (and memory).

No, perf events are not just global but per task as well. Nor are events 
limited to 'tracing' (generating a flow of events into a trace buffer) - they 
can just be themselves as well and count and generate callbacks.

The generic NMI watchdog uses that kind of event model for example, see 
kernel/watchdog.c and how it makes use of struct perf_event abstractions to do 
per CPU events (with no buffrs), or how kernel/hw_breakpoint.c uses it for per 
task events and integrates it with the ptrace hw-breakpoints code.

Ideally Peter's one particular suggestion is right IMO and we'd want to be able 
for a perf_event to just be a list of callbacks, attached to a task and barely 
more than a discoverable, named notifier chain in its slimmest form.

In practice it's fatter than that right now, but we should definitely factor 
out that aspect of it more clearly, both code-wise and API-wise. 
kernel/watchdog.c and kernel/hw_breakpoint.c shows that such factoring out is 
possible and desirable.

> 3. seccomp (as it exists today) provides a global system call entry
> hook point with a binary per-process decision about whether to provide
> "secure computing" behavior.
> 
> When I boil that down to abstractions, I see:
> A. Globally scoped: LSMs, ftrace/perf
> B. Locally/process scoped: seccomp

Ok, i see where you got the idea that you needed to cut your surface of 
abstraction at the filter engine / syscall enumeration level - i think you were 
thinking of it in the ftrace model of tracepoints, not in the perf model of 
events.

No, events are generic and as such per task as well, not just global.

I've replied to your other mail with more specific suggestions of how we could 
provide your feature using abstractions that share code more widely. Talking 
specifics will i hope help move the discussion forward! :-)

Thanks,

	Ingo
