Return-Path: <nickpiggin@yahoo.com.au>
Received: from smtp104.mail.mud.yahoo.com (smtp104.mail.mud.yahoo.com
	[209.191.85.214]) by ozlabs.org (Postfix) with SMTP id 20089679F0
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Apr 2006 16:58:24 +1000 (EST)
Message-ID: <44448A60.4040903@yahoo.com.au>
Date: Tue, 18 Apr 2006 16:42:40 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 00/05] robust per_cpu allocation for modules
References: <1145049535.1336.128.camel@localhost.localdomain>
	<4440855A.7040203@yahoo.com.au>
	<Pine.LNX.4.64.0604170953390.29732@schroedinger.engr.sgi.com>
	<20060417220238.GD3945@localhost.localdomain>
	<Pine.LNX.4.58.0604171936040.24264@gandalf.stny.rr.com>
In-Reply-To: <Pine.LNX.4.58.0604171936040.24264@gandalf.stny.rr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Andrew Morton <akpm@osdl.org>, linux-mips@linux-mips.org,
	David Mosberger-Tang <davidm@hpl.hp.com>, linux-ia64@vger.kernel.org,
	Martin Mares <mj@atrey.karlin.mff.cuni.cz>, spyro@f2s.com,
	Joe Taylor <joe@tensilica.com>, Andi Kleen <ak@suse.de>,
	linuxppc-dev@ozlabs.org, paulus@samba.org,
	benedict.gaster@superh.com, bjornw@axis.com, Ingo Molnar <mingo@elte.hu>,
	Ravikiran G Thirumalai <kiran@scalex86.org>,
	Christoph Lameter <clameter@sgi.com>, grundler@parisc-linux.org,
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

> Understood, but I'm going to start looking in the way Rusty and Arnd
> suggested with the vmalloc approach. This would allow for saving of
> memory and dynamic allocation of module memory making it more robust. And
> all this without that evil extra indirection!

Remember that this approach could effectively just move the indirection to
the TLB / page tables (well, I say "moves" because large kernel mappings
are effectively free compared with 4K mappings).

So be careful about coding up a large amount of work before unleashing it:
I doubt you'll be able to find a solution that doesn't involve tradeoffs
somewhere (but wohoo if you can).

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
