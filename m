Return-Path: <rostedt@goodmis.org>
Received: from ms-smtp-03.nyroc.rr.com (ms-smtp-03.nyroc.rr.com [24.24.2.57])
	by ozlabs.org (Postfix) with ESMTP id 4F50167A75
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 17:00:16 +1000 (EST)
Date: Thu, 18 May 2006 03:00:03 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: [RFC PATCH 00/09] robust VM per_cpu variables
In-Reply-To: <Pine.LNX.4.64.0605171038160.13767@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0605180229050.30044@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0605170547490.8408@gandalf.stny.rr.com>
	<Pine.LNX.4.64.0605170744360.13021@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0605171104100.13160@gandalf.stny.rr.com>
	<Pine.LNX.4.64.0605170846190.13337@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0605171152190.15798@gandalf.stny.rr.com>
	<Pine.LNX.4.64.0605171038160.13767@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andrew Morton <akpm@osdl.org>, linux-mips@linux-mips.org,
	David Mosberger-Tang <davidm@hpl.hp.com>, linux-ia64@vger.kernel.org,
	Martin Mares <mj@atrey.karlin.mff.cuni.cz>, spyro@f2s.com,
	Joe Taylor <joe@tensilica.com>, Andi Kleen <ak@suse.de>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	benedict.gaster@superh.com, sam@ravnborg.org, bjornw@axis.com,
	kenneth.w.chen@intel.com, Ingo Molnar <mingo@elte.hu>,
	kiran@scalex86.org, Nick Piggin <nickpiggin@yahoo.com.au>,
	grundler@parisc-linux.org, arnd@arndb.de,
	Rusty Russell <rusty@rustcorp.com.au>, starvik@axis.com,
	Linus Torvalds <torvalds@osdl.org>,
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


On Wed, 17 May 2006, Christoph Lameter wrote:

> On Wed, 17 May 2006, Steven Rostedt wrote:
>
> > > Well I'd like to see a comprehensive solution including a fix for the
> > > problems with allocper_cpu() allocations (allocper_cpu has to allocate
> > > memory for potential processors... which could be a lot on
> > > some types of systems and its allocated somewhere not on the nodes of the
> > > processor since they may not yet be online).
> >
> > OK, now you're beyond what I'm working with ;)  No hot plug CPUs for me.
> > Well, at least not yet!
>
> You need to at least consider how this could be handled by the per_cpu
> memory manangement. The VM thingie with dynamic per cpu memory would allow
> a fixup of allocpercpu.
>

Last night, while aimlessly wondering the streets of Karlsruhe, I thought
of some ideas.  Maybe not very good ideas, but ideas never-the-less.

How about a hybrid?  Have the normal in kernel code use what is there
today, with the indirection.  Have modules and add on CPUs use an
allocated vm area.

Here's the thought:

  Have the boot time per_cpu variables (BTPCV) allocated like it is today.
  But make sure that they are paged align.

  Store away the initial values of per_cpu variables (PCV), for systems
  with hot pluggable CPUs.

  For modules, have a VM dedicated area. The assumption is that the
  modules will not have more PCVs than the kernel. Hopefully the PCVs
  of a module will not strain the TLB too much.  As long as the modules
  PCVs are separated per cpu the same as the BTPCV then this will work.
  We can even use the extra space that was added in the alignment,
  if the modules PCV section is small enough to fit.

  Now for allocated PCV for a hot plugged CPU.  We can dynamically
  allocate them when the CPU is loaded, and copy in the saved BTPCV.

The hotplug CPU handling might be hard to work with the module handling,
but both should be simple by themselves.  So if we concentrate on just the
hotplug first, then this might actually benefit you.

So, Allocate a page alligned BTPCV for each online CPU and copy the
section into them.  Keep the initial section around.

When a CPU comes on line, allocate the memory for the PCV in VM and copy
the saved BTPCV into it.  Then have the indirect pointer array (or CPU
private register/variable) point to this section.  It only puts strain on
the TLB of the newly online CPU, but it gives us the option of placing the
PCV into memory that we want (NUMA friendly).

So I should forget about the modules for now, and get a hotplug PCV
solution working.  All the archs would need to do is to give a VM address
where to store these variables. Hmm...

Thoughts?

-- Steve
