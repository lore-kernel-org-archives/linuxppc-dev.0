Return-Path: <ak@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 17BD767B1C
	for <linuxppc-dev@ozlabs.org>; Wed, 17 May 2006 21:09:27 +1000 (EST)
From: Andi Kleen <ak@suse.de>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH 01/09] robust VM per_cpu core
Date: Wed, 17 May 2006 13:08:54 +0200
References: <Pine.LNX.4.58.0605170547490.8408@gandalf.stny.rr.com>
	<200605171117.06060.ak@suse.de>
	<Pine.LNX.4.58.0605170640280.8408@gandalf.stny.rr.com>
In-Reply-To: <Pine.LNX.4.58.0605170640280.8408@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200605171308.56203.ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-mips@linux-mips.org,
	linux-ia64@vger.kernel.org,
	Martin Mares <mj@atrey.karlin.mff.cuni.cz>, spyro@f2s.com,
	Joe Taylor <joe@tensilica.com>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, sam@ravnborg.org,
	bjornw@axis.com, kenneth.w.chen@intel.com,
	Ingo Molnar <mingo@elte.hu>, kiran@scalex86.org,
	clameter@sgi.com, Nick Piggin <nickpiggin@yahoo.com.au>,
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

On Wednesday 17 May 2006 12:46, Steven Rostedt wrote:
> 
> On Wed, 17 May 2006, Andi Kleen wrote:
> 
> >
> > > As well as the following three functions:
> > >
> > > pud_t *pud_boot_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long addr,
> > >                      int cpu);
> > > pmd_t *pmd_boot_alloc(struct mm_struct *mm, pud_t *pud, unsigned long addr,
> > >                      int cpu);
> > > pte_t *pte_boot_alloc(struct mm_struct *mm, pmd_t *pmd, unsigned long addr,
> > >                      int cpu);
> >
> > I'm not sure you can just put them like this into generic code. Some
> > architectures are doing strange things with them.
> 
> Hmm, like what?

Mostly managing their software TLBs I think.
 
> >
> > And we already have boot_ioremap on some architectures. Why is that not
> > enough?
> 
> I thought about using boot_ioremap, but it seems to be an abuse.  Since
> I'm not mapping io, but actual memory pages. 

We already use it for memory, e.g. for mapping some BIOS tables.

> So the solution to that 
> seemed more of a hack.  I then would need to worry about grabbing pages
> that were node specific 

alloc_bootmem_node

> and getting the physical addresses.  

virt_to_phys() 

[ + hacks to handle 32bit NUMA unfortunately ]

-Andi
