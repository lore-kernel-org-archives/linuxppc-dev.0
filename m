Return-Path: <nickpiggin@yahoo.com.au>
Received: from smtp109.mail.mud.yahoo.com (smtp109.mail.mud.yahoo.com
	[209.191.85.219]) by ozlabs.org (Postfix) with SMTP id 161B867A03
	for <linuxppc-dev@ozlabs.org>; Sun, 16 Apr 2006 04:58:21 +1000 (EST)
Message-ID: <4440855A.7040203@yahoo.com.au>
Date: Sat, 15 Apr 2006 15:32:10 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 00/05] robust per_cpu allocation for modules
References: <1145049535.1336.128.camel@localhost.localdomain>
In-Reply-To: <1145049535.1336.128.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
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

Steven Rostedt wrote:

>  would now create a variable called per_cpu_offset__myint in
> the .data.percpu_offset section.  This variable will point to the (if
> defined in the kernel) __per_cpu_offset[] array.  If this was a module
> variable, it would point to the module per_cpu_offset[] array which is
> created when the modules is loaded.

If I'm following you correctly, this adds another dependent load
to a per-CPU data access, and from memory that isn't node-affine.

If so, I think people with SMP and NUMA kernels would care more
about performance and scalability than the few k of memory this
saves.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
