Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.123]) by ozlabs.org (Postfix) with ESMTP id A7047B6EF7
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 17 May 2011 02:23:53 +1000 (EST)
Subject: Re: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system
	call filtering
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20110513145737.GC32688@elte.hu>
References: <alpine.LRH.2.00.1105131018040.3047@tundra.namei.org>
	<20110513121034.GG21022@elte.hu> <1305289146.2466.8.camel@twins>
	<20110513122646.GA3924@elte.hu> <1305290370.2466.14.camel@twins>
	<1305290612.2466.17.camel@twins> <20110513125452.GD3924@elte.hu>
	<1305292132.2466.26.camel@twins> <20110513131800.GA7883@elte.hu>
	<1305294935.2466.64.camel@twins>  <20110513145737.GC32688@elte.hu>
Content-Type: text/plain; charset="ISO-8859-15"
Date: Mon, 16 May 2011 12:23:46 -0400
Message-ID: <1305563026.5456.19.camel@gandalf.stny.rr.com>
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
	kees.cook@canonical.com, "Serge E. Hallyn" <serge@hallyn.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>, Roland McGrath <roland@redhat.com>,
	Michal Marek <mmarek@suse.cz>, Michal Simek <monstr@monstr.eu>,
	Will Drewry <wad@chromium.org>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, Eric Paris <eparis@redhat.com>,
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

On Fri, 2011-05-13 at 16:57 +0200, Ingo Molnar wrote:

> > > > Then there's the whole indirection argument, if you don't need
> > > > indirection, its often better to not use it, I myself much prefer code
> > > > to look like:
> > > > 
> > > >    foo1(bar);
> > > >    foo2(bar);
> > > >    foo3(bar);
> > > > 
> > > > Than:
> > > > 
> > > >    foo_notifier(bar);
> > > > 
> > > > Simply because its much clearer who all are involved without me having
> > > > to grep around to see who registers for foo_notifier and wth they do
> > > > with it. It also makes it much harder to sneak in another user, whereas
> > > > its nearly impossible to find new notifier users.
> > > > 
> > > > Its also much faster, no extra memory accesses, no indirect function
> > > > calls, no other muck.
> > > 
> > > But i suspect this question has been settled, given the fact that even pure 
> > > observer events need and already process a chain of events? Am i missing 
> > > something about your argument?
> > 
> > I'm saying that there's reasons to not use notifiers passive or active.
> > 
> > Mostly the whole notifier/indirection muck comes up once you want
> > modules to make use of the thing, because then you need dynamic
> > management of the callback list.
> 
> But your argument assumes that we'd have a chain of functions to call, like 
> regular notifiers.
> 
> While the natural model here would be to have a list of registered event 
> structs for that point, with different filters but basically the same callback 
> mechanism (a call into the filter engine in essence).
> 
> Also note that the common case would be no event registered - and we'd 
> automatically optimize that case via the existing jump labels optimization.

I agree that I prefer the "notifier" type over having direct function
calls. Yes, it's easier to read and figure out what functions are
called, but notifiers can be optimized for the default case where
nothing is called (jump-label nop).

> 
> > (Then again, I'm fairly glad we don't have explicit callbacks in kernel/cpu.c 
> > for all the cpu-hotplug callbacks :-)
> > 
> > Anyway, I oppose for the existing events to gain an active role.
> 
> Why if 'being active' is optional and useful?

I'm a bit nervous about the 'active' role of (trace_)events, because of
the way multiple callbacks can be registered. How would:

	err = event_x();
	if (err == -EACCESS) {

be handled? Would we need a way to prioritize which call back gets the
return value? One way I guess would be to add a check_event option,
where you pass in an ENUM of the event you want:

	event_x();
	err = check_event_x(MYEVENT);

If something registered itself as "MYEVENT" to event_x, then you get the
return code of MYEVENT. If the MYEVENT was not registered, a -ENODEV or
something could be returned. I'm sure we could even optimize it such a
way if no active events have been registered to event_x, that
check_event_x() will return -ENODEV without any branches.

-- Steve
