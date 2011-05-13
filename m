Return-Path: <mingo@elte.hu>
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 261EBB6EEC
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 14 May 2011 00:58:24 +1000 (EST)
Date: Fri, 13 May 2011 16:57:37 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call
	filtering
Message-ID: <20110513145737.GC32688@elte.hu>
References: <alpine.LRH.2.00.1105131018040.3047@tundra.namei.org>
	<20110513121034.GG21022@elte.hu> <1305289146.2466.8.camel@twins>
	<20110513122646.GA3924@elte.hu> <1305290370.2466.14.camel@twins>
	<1305290612.2466.17.camel@twins> <20110513125452.GD3924@elte.hu>
	<1305292132.2466.26.camel@twins> <20110513131800.GA7883@elte.hu>
	<1305294935.2466.64.camel@twins>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1305294935.2466.64.camel@twins>
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
	Ingo Molnar <mingo@redhat.com>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	kees.cook@canonical.com, "Serge E. Hallyn" <serge@hallyn.com>,
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


* Peter Zijlstra <peterz@infradead.org> wrote:

> Cut the microblaze list since its bouncy.
> 
> On Fri, 2011-05-13 at 15:18 +0200, Ingo Molnar wrote:
> > * Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > On Fri, 2011-05-13 at 14:54 +0200, Ingo Molnar wrote:
> > > > I think the sanest semantics is to run all active callbacks as well.
> > > > 
> > > > For example if this is used for three stacked security policies - as if 3 LSM 
> > > > modules were stacked at once. We'd call all three, and we'd determine that at 
> > > > least one failed - and we'd return a failure. 
> > > 
> > > But that only works for boolean functions where you can return the
> > > multi-bit-or of the result. What if you need to return the specific
> > > error code.
> > 
> > Do you mean that one filter returns -EINVAL while the other -EACCES?
> > 
> > Seems like a non-problem to me, we'd return the first nonzero value.
> 
> Assuming the first is -EINVAL, what then is the value in computing the
> -EACCESS? Sounds like a massive waste of time to me.

No, because the common case is no rejection - this is a security mechanism. So 
in the normal case we would execute all 3 anyway, just to determine that all 
return 0.

Are you really worried about the abnormal case of one of them returning an 
error and us calculating all 3 return values?

> > > Also, there's bound to be other cases where people will want to employ
> > > this, look at all the various notifier chain muck we've got, it already
> > > deals with much of this -- simply because users need it.
> > 
> > Do you mean it would be easy to abuse it? What kind of abuse are you most 
> > worried about?
> 
> I'm not worried about abuse, I'm saying that going by the existing
> notifier pattern always visiting all entries on the callback list is
> undesired.

That is because many notifier chains are used in an 'event consuming' manner - 
they are responding to things like hardware events and are called in an 
interrupt-handler alike fashion most of the time.

> > > Then there's the whole indirection argument, if you don't need
> > > indirection, its often better to not use it, I myself much prefer code
> > > to look like:
> > > 
> > >    foo1(bar);
> > >    foo2(bar);
> > >    foo3(bar);
> > > 
> > > Than:
> > > 
> > >    foo_notifier(bar);
> > > 
> > > Simply because its much clearer who all are involved without me having
> > > to grep around to see who registers for foo_notifier and wth they do
> > > with it. It also makes it much harder to sneak in another user, whereas
> > > its nearly impossible to find new notifier users.
> > > 
> > > Its also much faster, no extra memory accesses, no indirect function
> > > calls, no other muck.
> > 
> > But i suspect this question has been settled, given the fact that even pure 
> > observer events need and already process a chain of events? Am i missing 
> > something about your argument?
> 
> I'm saying that there's reasons to not use notifiers passive or active.
> 
> Mostly the whole notifier/indirection muck comes up once you want
> modules to make use of the thing, because then you need dynamic
> management of the callback list.

But your argument assumes that we'd have a chain of functions to call, like 
regular notifiers.

While the natural model here would be to have a list of registered event 
structs for that point, with different filters but basically the same callback 
mechanism (a call into the filter engine in essence).

Also note that the common case would be no event registered - and we'd 
automatically optimize that case via the existing jump labels optimization.

> (Then again, I'm fairly glad we don't have explicit callbacks in kernel/cpu.c 
> for all the cpu-hotplug callbacks :-)
> 
> Anyway, I oppose for the existing events to gain an active role.

Why if 'being active' is optional and useful?

Thanks,

	Ingo
