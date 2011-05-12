Return-Path: <fweisbec@gmail.com>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D0608B6F5A
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 12 May 2011 22:16:00 +1000 (EST)
Received: by ywg4 with SMTP id 4so549162ywg.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 12 May 2011 05:15:56 -0700 (PDT)
Date: Thu, 12 May 2011 14:15:42 +0200
From: Frederic Weisbecker <fweisbec@gmail.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system
	call filtering
Message-ID: <20110512121539.GA7410@nowhere>
References: <1304017638.18763.205.camel@gandalf.stny.rr.com>
	<1305169376-2363-1-git-send-email-wad@chromium.org>
	<20110512074850.GA9937@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110512074850.GA9937@elte.hu>
Cc: linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Oleg Nesterov <oleg@redhat.com>, David Howells <dhowells@redhat.com>,
	Paul Mackerras <paulus@samba.org>,
	Eric Paris <eparis@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	sparclinux@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
	linux-s390@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>, x86@kernel.org, jmorris@namei.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>,
	linux-arm-kernel@lists.infradead.org, kees.cook@canonical.com,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>, microblaze-uclinux@itee.uq.edu.au,
	Steven Rostedt <rostedt@goodmis.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>, Roland McGrath <roland@redhat.com>,
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

On Thu, May 12, 2011 at 09:48:50AM +0200, Ingo Molnar wrote:
> To restrict execution to system calls.
> 
> Two observations:
> 
> 1) We already have a specific ABI for this: you can set filters for events via 
>    an event fd.
> 
>    Why not extend that mechanism instead and improve *both* your sandboxing
>    bits and the events code? This new seccomp code has a lot more
>    to do with trace event filters than the minimal old seccomp code ...
> 
>    kernel/trace/trace_event_filter.c is 2000 lines of tricky code that
>    interprets the ASCII filter expressions. kernel/seccomp.c is 86 lines of
>    mostly trivial code.
> 
> 2) Why should this concept not be made available wider, to allow the 
>    restriction of not just system calls but other security relevant components 
>    of the kernel as well?
> 
>    This too, if you approach the problem via the events code, will be a natural 
>    end result, while if you approach it from the seccomp prctl angle it will be
>    a limited hack only.
> 
> Note, the end result will be the same - just using a different ABI.
> 
> So i really think the ABI itself should be closer related to the event code. 
> What this "seccomp" code does is that it uses specific syscall events to 
> restrict execution of certain event generating codepaths, such as system calls.
> 
> Thanks,
> 
> 	Ingo

What's positive with that approach is that the code is all there already.
Create a perf event for a given trace event, attach a filter to it.

What needs to be added is an override of the effect of the filter. By default
it's dropping the event, but there may be different flavours, including sending
a signal. All in one, extending the current code to allow that looks trivial.

The negative points are that

* trace events are supposed to stay passive and not act on the system, except
doing some endpoint things like writing to a buffer. We can't call do_exit()
from a tracepoint for example, preemption is disabled there.

* Also, is it actually relevant to extend that seccomp filtering to other events
than syscalls? Exposing kernel events to filtering sounds actually to me bringing
a new potential security issue. But with fine restrictions this can probably
be dealt with. Especially if by default only syscalls can be filtered

* I think Peter did not want to give such "active" role to perf in the system.
