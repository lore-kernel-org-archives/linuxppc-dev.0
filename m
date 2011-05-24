Return-Path: <mingo@elte.hu>
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2B2DAB6F91
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 25 May 2011 06:08:47 +1000 (EST)
Date: Tue, 24 May 2011 22:08:15 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Will Drewry <wad@chromium.org>
Subject: Re: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call
	filtering
Message-ID: <20110524200815.GD27634@elte.hu>
References: <1305563026.5456.19.camel@gandalf.stny.rr.com>
	<20110516165249.GB10929@elte.hu>
	<1305565422.5456.21.camel@gandalf.stny.rr.com>
	<20110517124212.GB21441@elte.hu>
	<1305637528.5456.723.camel@gandalf.stny.rr.com>
	<20110517131902.GF21441@elte.hu>
	<BANLkTikBK3-KZ10eErQ6Eex_L6Qe2aZang@mail.gmail.com>
	<1305807728.11267.25.camel@gandalf.stny.rr.com>
	<BANLkTiki8aQJbFkKOFC+s6xAEiuVyMM5MQ@mail.gmail.com>
	<BANLkTim9UyYAGhg06vCFLxkYPX18cPymEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BANLkTim9UyYAGhg06vCFLxkYPX18cPymEQ@mail.gmail.com>
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
	Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
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


* Will Drewry <wad@chromium.org> wrote:

> The change avoids defining a new trace call type or a huge number of internal 
> changes and hides seccomp.mode=2 from ABI-exposure in prctl, but the attack 
> surface is non-trivial to verify, and I'm not sure if this ABI change makes 
> sense. It amounts to:
> 
>  include/linux/ftrace_event.h  |    4 +-
>  include/linux/perf_event.h    |   10 +++++---
>  kernel/perf_event.c           |   49 +++++++++++++++++++++++++++++++++++++---
>  kernel/seccomp.c              |    8 ++++++
>  kernel/trace/trace_syscalls.c |   27 +++++++++++++++++-----
>  5 files changed, 82 insertions(+), 16 deletions(-)
> 
> And can be found here: http://static.dataspill.org/perf_secure/v1/

Wow, i'm very impressed how few changes you needed to do to support this!

So, firstly, i don't think we should change perf_tp_event() at all - the 
'observer' codepaths should be unaffected.

But there could be a perf_tp_event_ret() or perf_tp_event_check() entry that 
code like seccomp which wants to use event results can use.

Also, i'm not sure about the seccomp details and assumptions that were moved 
into the perf core. How about passing in a helper function to 
perf_tp_event_check(), where seccomp would define its seccomp specific helper 
function?

That looks sufficiently flexible. That helper function could be an 'extra 
filter' kind of thing, right?

Also, regarding the ABI and the attr.err_on_discard and attr.require_secure 
bits, they look a bit too specific as well.

attr.err_on_discard: with the filter helper function passed in this is probably 
not needed anymore, right?

attr.require_secure: this is basically used to *force* the creation of 
security-controlling filters, right? It seems to me that this could be done via 
a seccomp ABI extension as well, without adding this to the perf ABI. That 
seccomp call could check whether the right events are created and move the task 
to mode 2 only if that prereq is met - or something like that.

> If there is any interest at all, I can post it properly to this giant
> CC list. [...]

I'd suggest to trim the Cc: list aggressively - anyone interested in the 
discussion can pick it up on lkml - and i strongly suspect that most of the Cc: 
participants would want to be off the Cc: :-)

Thanks,

	Ingo
