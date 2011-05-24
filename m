Return-Path: <mingo@elte.hu>
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 265D3B6F9D
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 25 May 2011 06:11:32 +1000 (EST)
Date: Tue, 24 May 2011 22:10:53 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call
	filtering
Message-ID: <20110524201053.GE27634@elte.hu>
References: <1305565422.5456.21.camel@gandalf.stny.rr.com>
	<20110517124212.GB21441@elte.hu>
	<1305637528.5456.723.camel@gandalf.stny.rr.com>
	<20110517131902.GF21441@elte.hu>
	<BANLkTikBK3-KZ10eErQ6Eex_L6Qe2aZang@mail.gmail.com>
	<1305807728.11267.25.camel@gandalf.stny.rr.com>
	<BANLkTiki8aQJbFkKOFC+s6xAEiuVyMM5MQ@mail.gmail.com>
	<BANLkTim9UyYAGhg06vCFLxkYPX18cPymEQ@mail.gmail.com>
	<1306254027.18455.47.camel@twins> <20110524195435.GC27634@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110524195435.GC27634@elte.hu>
Cc: linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
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
	Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	Michal Marek <mmarek@suse.cz>, Michal Simek <monstr@monstr.eu>,
	Will Drewry <wad@chromium.org>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
	Paul Mundt <lethal@linux-sh.org>,
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


* Ingo Molnar <mingo@elte.hu> wrote:

> 
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
> So this is a really flexible solution IMO and does not extend events with 
> some invisible 'active' role. It extends the *call site* with an open-coded 
> active role - which active role btw. already pre-existed.

Also see my other mail - i think this seccomp code is too tied in to the perf 
core and ABI - but this is fixable IMO.

The fundamental notion that a generator subsystem of events can use filter 
results as well (such as kernel/trace/trace_syscalls.c.) for its own purposes 
is pretty robust though.

Thanks,

	Ingo
