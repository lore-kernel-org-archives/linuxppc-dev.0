Return-Path: <christoph@schroedinger.engr.sgi.com>
Received: from omx2.sgi.com (omx2-ext.sgi.com [192.48.171.19])
	by ozlabs.org (Postfix) with ESMTP id A23CE679FB
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 00:54:21 +1000 (EST)
Date: Wed, 17 May 2006 07:52:38 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH 00/09] robust VM per_cpu variables
In-Reply-To: <Pine.LNX.4.58.0605170547490.8408@gandalf.stny.rr.com>
Message-ID: <Pine.LNX.4.64.0605170744360.13021@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0605170547490.8408@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: Christoph Lameter <christoph@schroedinger.engr.sgi.com>
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

On Wed, 17 May 2006, Steven Rostedt wrote:

> My first attempt to fix this introduced another dereference, to allow
> for modules to allocate their own memory.  This was quickly shot down,
> and for good reason, because dereferences kill performance, and don't
> play nice with large SMP systems that depend on per_cpu being fast.

> I now place the per_cpu variables into VM, such that the pages are
> only allocated when needed. All the architecture needs to do is
> supply a VM address range, size for each CPU to use (note this
> implementation expects all the VM CPU areas to be together), and
> three functions to allow for allocating page tables at bootup.

So now instead of an explicit indirection we use an implicit one 
through the page tables for this. This happens during early boot which 
requires additional page table functions? And it requires the use of an 
additional TLB entry? I guess that the additional TLB pressure alone will 
result in a performance drop of 3%?

See http://www.gelato.unsw.edu.au/archives/linux-ia64/0602/17311.html
