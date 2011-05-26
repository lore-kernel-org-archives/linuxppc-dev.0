Return-Path: <mingo@elte.hu>
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 63225B6F9C
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 26 May 2011 18:44:30 +1000 (EST)
Date: Thu, 26 May 2011 10:43:41 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call
	filtering
Message-ID: <20110526084341.GD26775@elte.hu>
References: <20110517131902.GF21441@elte.hu>
	<BANLkTikBK3-KZ10eErQ6Eex_L6Qe2aZang@mail.gmail.com>
	<1305807728.11267.25.camel@gandalf.stny.rr.com>
	<BANLkTiki8aQJbFkKOFC+s6xAEiuVyMM5MQ@mail.gmail.com>
	<BANLkTim9UyYAGhg06vCFLxkYPX18cPymEQ@mail.gmail.com>
	<1306254027.18455.47.camel@twins> <20110524195435.GC27634@elte.hu>
	<alpine.LFD.2.02.1105242239230.3078@ionos>
	<20110525150153.GE29179@elte.hu>
	<alpine.LFD.2.02.1105251836030.3078@ionos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LFD.2.02.1105251836030.3078@ionos>
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


* Thomas Gleixner <tglx@linutronix.de> wrote:

> > > We do _NOT_ make any decision based on the trace point so 
> > > what's the "pre-existing" active role in the syscall entry 
> > > code?
> > 
> > The seccomp code we are discussing in this thread.
> 
> That's proposed code and has absolutely nothing to do with the 
> existing trace point semantics.

So because it's proposed code it does not exist?

If the feature is accepted (and given Linus's opinion it's not clear 
at all it's accepted in any form) then it's obviously a very 
legitimate technical concern whether we do:

	ret = seccomp_check_syscall_event(p1, p2, p3, p4, p5);
	if (ret)
		return -EACCES;

	... random code ...

	trace_syscall_event(p1, p2, p3, p4, p5);

Where seccomp_check_syscall_event() duplicates much of the machinery 
that is behind trace_syscall_event().

Or we do the more intelligent:

	ret = check_syscall_event(p1, p2, p3, p4, p5);
	if (ret)
		return -EACCES;

Where we have the happy side effects of:

  - less code at the call site

  - (a lot of!) shared infrastructure between the proposed seccomp 
    code and event filters.

  - we'd also be able to trace at security check boundaries - which
    has obvious bug analysis advantages.

In fact i do not see *any* advantages in keeping this needlessly 
bloaty and needlessly inconsistently sampled form of instrumentation:

	ret = seccomp_check_syscall_event(p1, p2, p3, p4, p5);
	if (ret)
		return -EACCES;

	... random code ...

	trace_syscall_event(p1, p2, p3, p4, p5);

Do you?

Thanks,

	Ingo
