Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id E199C67A6C
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Apr 2006 01:35:35 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 00/05] robust per_cpu allocation for modules
Date: Sun, 16 Apr 2006 17:34:18 +0200
References: <1145049535.1336.128.camel@localhost.localdomain>
	<17473.60411.690686.714791@cargo.ozlabs.ibm.com>
	<1145194804.27407.103.camel@localhost.localdomain>
In-Reply-To: <1145194804.27407.103.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200604161734.20256.arnd@arndb.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-mips@linux-mips.org,
	David Mosberger-Tang <davidm@hpl.hp.com>, linux-ia64@vger.kernel.org,
	Martin Mares <mj@atrey.karlin.mff.cuni.cz>, spyro@f2s.com,
	Joe Taylor <joe@tensilica.com>, Andi Kleen <ak@suse.de>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	benedict.gaster@superh.com, bjornw@axis.com, Ingo Molnar <mingo@elte.hu>,
	Nick Piggin <nickpiggin@yahoo.com.au>, grundler@parisc-linux.org,
	rusty@rustcorp.com.au, starvik@axis.com,
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

On Sunday 16 April 2006 15:40, Steven Rostedt wrote:
> I'll think more about this, but maybe someone else has some crazy ideas
> that can find a solution to this that is both fast and robust.

Ok, you asked for a crazy idea, you're going to get it ;-)

You could take a fixed range from the vmalloc area (e.g. 1MB per cpu)
and use that to remap pages on demand when you need per cpu data.

#define PER_CPU_BASE 0xe000000000000000UL /* arch dependant */
#define PER_CPU_SHIFT 0x100000UL
#define __per_cpu_offset(__cpu) (PER_CPU_BASE + PER_CPU_STRIDE * (__cpu))
#define per_cpu(var, cpu) (*RELOC_HIDE(&per_cpu__##var, __per_cpu_offset(cpu)))
#define __get_cpu_var(var) per_cpu(var, smp_processor_id())

This is a lot like the current sparc64 implementation already is.

The tricky part here is the remapping of pages. You'd need to 
alloc_pages_node() new pages whenever the already reserved space is
not enough for the module you want to load and then map_vm_area()
them into the space reserved for them.

Advantages of this solution are:
- no dependant load access for per_cpu()
- might be flexible enough to implement a faster per_cpu_ptr()
- can be combined with ia64-style per-cpu remapping

Disadvantages are:
- you can't use huge tlbs for mapping per cpu data like the
  regular linear mapping -> may be slower on some archs
- does not work in real mode, so percpu data can't be used
  inside exception handlers on some architectures.
- memory consumption is rather high when PAGE_SIZE is large

	Arnd <><
