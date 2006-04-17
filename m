Return-Path: <rusty@rustcorp.com.au>
Subject: Re: [PATCH 00/05] robust per_cpu allocation for modules
From: Rusty Russell <rusty@rustcorp.com.au>
To: Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <1145194804.27407.103.camel@localhost.localdomain>
References: <1145049535.1336.128.camel@localhost.localdomain>
	<4440855A.7040203@yahoo.com.au>
	<Pine.LNX.4.58.0604151609340.11302@gandalf.stny.rr.com>
	<4441B02D.4000405@yahoo.com.au>
	<Pine.LNX.4.58.0604152323560.16853@gandalf.stny.rr.com>
	<17473.60411.690686.714791@cargo.ozlabs.ibm.com>
	<1145194804.27407.103.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 17 Apr 2006 16:47:24 +1000
Message-Id: <1145256445.28600.34.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, linux-mips@linux-mips.org,
	David Mosberger-Tang <davidm@hpl.hp.com>, linux-ia64@vger.kernel.org,
	Martin Mares <mj@atrey.karlin.mff.cuni.cz>, spyro@f2s.com,
	Joe Taylor <joe@tensilica.com>, Andi Kleen <ak@suse.de>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	benedict.gaster@superh.com, bjornw@axis.com, Ingo Molnar <mingo@elte.hu>,
	Nick Piggin <nickpiggin@yahoo.com.au>, grundler@parisc-linux.org,
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

On Sun, 2006-04-16 at 09:40 -0400, Steven Rostedt wrote:
> The reason that this is done, is that the per_cpu macro cant know
> whether or not the per_cpu variable was declared in a kernel or in a
> module.  So the __pre_cpu_offset[] array offset can't be used if the
> module allocation is in its own separate area. Remember that this offset
> array stores the difference from where the variable originally was and
> where it is now for each cpu.

Actually, the reason this is done is because the per_cpu_offset[] is
designed to be replaced by a register or an expression on archs which
care, and this is simple.  The main problem is that so many archs want
different things, it's a very UN task to build infrastructure.

I have always recommended using the same scheme to implement real
dynamic per-cpu allocation (which would then replace the mini-allocator
inside the module code).  In fact, I had such an implementation which I
reduced to the module case (dynamic per-cpu was too far-out at the
time).

The arch would allocate a virtual memory hole for each CPU, and map
pages as required (this is the simplest of several potential schemes).
This gives the "same space between CPUs" property which is required for
the ptr + per-cpu-offset scheme.  An arch would supply functions like:

	/* Returns address of new memory chunk(s)
         * (add __per_cpu_offset to get virtual addresses). */
	unsigned long alloc_percpu_memory(unsigned long *size);

	/* Set by ia64 to reserve the first chunk for percpu vars
	 * in modules only.
	#define __MODULE_RESERVE_FIRST_CHUNK

And an allocator would work on top of these.

I'm glad someone is looking at this again!
Rusty.
-- 
 ccontrol: http://ozlabs.org/~rusty/ccontrol
