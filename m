Return-Path: <mingo@elte.hu>
Received: from mx3.mail.elte.hu (mx3.mail.elte.hu [157.181.1.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7990E1007D5
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 12 May 2011 23:02:04 +1000 (EST)
Date: Thu, 12 May 2011 15:01:04 +0200
From: Ingo Molnar <mingo@elte.hu>
To: James Morris <jmorris@namei.org>
Subject: Re: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call
	filtering
Message-ID: <20110512130104.GA2912@elte.hu>
References: <1304017638.18763.205.camel@gandalf.stny.rr.com>
	<1305169376-2363-1-git-send-email-wad@chromium.org>
	<20110512074850.GA9937@elte.hu>
	<alpine.LRH.2.00.1105122133500.31507@tundra.namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LRH.2.00.1105122133500.31507@tundra.namei.org>
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


* James Morris <jmorris@namei.org> wrote:

> On Thu, 12 May 2011, Ingo Molnar wrote:
> 
> > 2) Why should this concept not be made available wider, to allow the 
> >    restriction of not just system calls but other security relevant components 
> >    of the kernel as well?
> 
> Because the aim of this is to reduce the attack surface of the syscall 
> interface.

What i suggest achieves the same, my argument is that we could aim it to be 
even more flexible and even more useful.

> LSM is the correct level of abstraction for general security mediation, 
> because it allows you to take into account all relevant security information 
> in a race-free context.

I don't care about LSM though, i find it poorly designed.

The approach implemented here, the ability for *unprivileged code* to define 
(the seeds of ...) flexible security policies, in a proper Linuxish way, which 
is inherited along the task parent/child hieararchy and which allows nesting 
etc. is a *lot* more flexible.

What Will implemented here is pretty huge in my opinion: it turns security from 
a root-only kind of weird hack into an essential component of its APIs, 
available to *any* app not just the select security policy/mechanism chosen by 
the distributor ...

If implemented properly this could replace LSM in the long run.

As a prctl() hack bound to seccomp (which, by all means, is a natural extension 
to the current seccomp ABI, so perfectly fine if we only want that scope), that 
is much less likely to happen.

And if we merge the seccomp interface prematurely then interest towards a more 
flexible approach will disappear, so either we do it properly now or it will 
take some time for someone to come around and do it ...

Also note that i do not consider the perf events ABI itself cast into stone - 
and we could very well add a new system call for this, independent of perf 
events. I just think that the seccomp scope itself is exciting but looks 
limited to what the real potential of this could be.

> >    This too, if you approach the problem via the events code, will be a natural 
> >    end result, while if you approach it from the seccomp prctl angle it will be
> >    a limited hack only.
> 
> I'd say it's a well-defined and readily understandable feature.

Note, it was me who suggested this very event-filter-engine design a year ago, 
when the first submission still used a crude bitmap of allowed seccomp 
syscalls:

  http://lwn.net/Articles/332974/

Funnily enough, back then you wrote this:

  " I'm concerned that we're seeing yet another security scheme being designed on 
    the fly, without a well-formed threat model, and without taking into account 
    lessons learned from the seemingly endless parade of similar, failed schemes. "

so when and how did your opinion of this scheme turn from it being an "endless 
parade of failed schemes" to it being a "well-defined and readily 
understandable feature"? :-)

The idea itself has not changed since last year, what happened is that the 
filter engine got a couple of new features and Will has separated it out and 
has implemented a working prototype for sandboxing.

What i do here is to suggest *further* steps down the same road, now that we 
see that this scheme can indeed be used to implement sandboxing ... I think 
it's a valid line of inquiry.

Thanks,

	Ingo
