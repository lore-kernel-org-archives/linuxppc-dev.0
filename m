Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.123]) by ozlabs.org (Postfix) with ESMTP id DE016B6F86
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 May 2011 22:22:17 +1000 (EST)
Subject: Re: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system
	call filtering
From: Steven Rostedt <rostedt@goodmis.org>
To: Will Drewry <wad@chromium.org>
In-Reply-To: <BANLkTikBK3-KZ10eErQ6Eex_L6Qe2aZang@mail.gmail.com>
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
Content-Type: text/plain; charset="ISO-8859-15"
Date: Thu, 19 May 2011 08:22:08 -0400
Message-ID: <1305807728.11267.25.camel@gandalf.stny.rr.com>
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
	Ingo Molnar <mingo@elte.hu>, "Serge E. Hallyn" <serge@hallyn.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>, kees.cook@canonical.com,
	Roland McGrath <roland@redhat.com>,
	Michal Marek <mmarek@suse.cz>, Michal Simek <monstr@monstr.eu>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Eric Paris <eparis@redhat.com>, Paul Mundt <lethal@linux-sh.org>,
	Tejun Heo <tj@kernel.org>, linux390@de.ibm.com,
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

On Wed, 2011-05-18 at 21:07 -0700, Will Drewry wrote:

> Do event_* that return non-void exist in the tree at all now?  I've
> looked at the various tracepoint macros as well as some of the other
> handlers (trace_function, perf_tp_event, etc) and I'm not seeing any
> places where a return value is honored nor could be.  At best, the
> perf_tp_event can be short-circuited it in the hlist_for_each, but
> it'd still need a way to bubble up a failure and result in not calling
> the trace/event that the hook precedes.

No, none of the current trace hooks have return values. That was what I
was talking about how to implement in my previous emails.

-- Steve
