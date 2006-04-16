Return-Path: <rostedt@goodmis.org>
Received: from ms-smtp-03.nyroc.rr.com (ms-smtp-03.nyroc.rr.com [24.24.2.57])
	by ozlabs.org (Postfix) with ESMTP id 1122067A40
	for <linuxppc-dev@ozlabs.org>; Sun, 16 Apr 2006 13:54:07 +1000 (EST)
Date: Sat, 15 Apr 2006 23:53:00 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH 00/05] robust per_cpu allocation for modules
In-Reply-To: <4441B02D.4000405@yahoo.com.au>
Message-ID: <Pine.LNX.4.58.0604152323560.16853@gandalf.stny.rr.com>
References: <1145049535.1336.128.camel@localhost.localdomain>
	<4440855A.7040203@yahoo.com.au>
	<Pine.LNX.4.58.0604151609340.11302@gandalf.stny.rr.com>
	<4441B02D.4000405@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andrew Morton <akpm@osdl.org>, linux-mips@linux-mips.org,
	David Mosberger-Tang <davidm@hpl.hp.com>, linux-ia64@vger.kernel.org,
	Martin Mares <mj@atrey.karlin.mff.cuni.cz>, spyro@f2s.com,
	Joe Taylor <joe@tensilica.com>, Andi Kleen <ak@suse.de>,
	linuxppc-dev@ozlabs.org, paulus@samba.org,
	benedict.gaster@superh.com, bjornw@axis.com,
	Ingo Molnar <mingo@elte.hu>, grundler@parisc-linux.org,
	starvik@axis.com, Linus Torvalds <torvalds@osdl.org>,
	Thomas Gleixner <tglx@linutronix.de>, rth@twiddle.net,
	Chris Zankel <chris@zankel.net>, tony.luck@intel.com,
	LKML <linux-kernel@vger.kernel.org>, ralf@linux-mips.org,
	Marc Gauthier <marc@tensilica.com>, lethal@linux-sh.org,
	schwidefsky@de.ibm.com, linux390@de.ibm.com, davem@davemloft.net,
	parisc-linux@parisc-linux.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sun, 16 Apr 2006, Nick Piggin wrote:

> Steven Rostedt wrote:
> >
> > It's not just about saving memory, but also to make it more robust. But
> > that's another story.
>
> But making it slower isn't going to be popular.

You're right and I've been thinking of modifications to fix that.
These patches were to shake up ideas.

>
> Why is your module using so much per-cpu memory, anyway?

Wasn't my module anyway. The problem appeared in the -rt patch set, when
tracing was turned on.  Some module was affected, and grew it's per_cpu
size by quite a bit. In fact we had to increase PERCPU_ENOUGH_ROOM by up
to something like 300K.

>
> >
> > Since both the offset array, and the variables are mainly read only (only
> > written on boot up), added the fact that the added variables are in their
> > own section.  Couldn't something be done to help pre load this in a local
> > cache, or something similar?
>
> It it would still add to the dependent loads on the critical path, so
> it now prevents the compiler/programmer/oooe engine from speculatively
> loading the __per_cpu_offset.
>
> And it does increase cache footprint of per-cpu accesses, which are
> supposed to be really light and substitute for [NR_CPUS] arrays.
>
> I don't think it would have been hard for the original author to make
> it robust... just not both fast and robust. PERCPU_ENOUGH_ROOM seems
> like an ugly hack at first glance, but I'm fairly sure it was a result
> of design choices.
>

Yeah, and I discovered the reasons for those choices as I worked on this.
I've put a little more thought into this and still think there's a
solution to not slow things down.

Since the per_cpu_offset section is still smaller than the
PERCPU_ENOUGH_ROOM and robust, I could still copy it into a per cpu memory
field, and even add the __per_cpu_offset to it.  This would still save
quite a bit of space.

So now I'm asking for advice on some ideas that can be a work around to
keep the robustness and speed.

Is there a way (for archs that support it) to allocate memory in a per cpu
manner. So each CPU would have its own variable table in the memory that
is best of it.  Then have a field (like the pda in x86_64) to point to
this section, and use the linker offsets to index and find the per_cpu
variables.

So this solution still has one more redirection than the current solution
(per_cpu_offset__##var -> __per_cpu_offset -> actual_var where as the
current solution is __per_cpu_offset -> actual_var), but all the loads
would be done from memory that would only be specified for a particular
CPU.

The generic case would still be the same as the patches I already sent,
but the archs that can support it, can have something like the above.

Would something like that be acceptible?

Thanks,

-- Steve
