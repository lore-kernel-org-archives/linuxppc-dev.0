Return-Path: <rostedt@goodmis.org>
Received: from ms-smtp-01.nyroc.rr.com (ms-smtp-01.nyroc.rr.com [24.24.2.55])
	by ozlabs.org (Postfix) with ESMTP id E1FD867B72
	for <linuxppc-dev@ozlabs.org>; Wed, 17 May 2006 20:46:08 +1000 (EST)
Date: Wed, 17 May 2006 06:46:01 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
To: Andi Kleen <ak@suse.de>
Subject: Re: [RFC PATCH 01/09] robust VM per_cpu core
In-Reply-To: <200605171117.06060.ak@suse.de>
Message-ID: <Pine.LNX.4.58.0605170640280.8408@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0605170547490.8408@gandalf.stny.rr.com>
	<Pine.LNX.4.58.0605170555190.8408@gandalf.stny.rr.com>
	<200605171117.06060.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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


On Wed, 17 May 2006, Andi Kleen wrote:

>
> > As well as the following three functions:
> >
> > pud_t *pud_boot_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long addr,
> >                      int cpu);
> > pmd_t *pmd_boot_alloc(struct mm_struct *mm, pud_t *pud, unsigned long addr,
> >                      int cpu);
> > pte_t *pte_boot_alloc(struct mm_struct *mm, pmd_t *pmd, unsigned long addr,
> >                      int cpu);
>
> I'm not sure you can just put them like this into generic code. Some
> architectures are doing strange things with them.

Hmm, like what?

>
> And we already have boot_ioremap on some architectures. Why is that not
> enough?

I thought about using boot_ioremap, but it seems to be an abuse.  Since
I'm not mapping io, but actual memory pages.  So the solution to that
seemed more of a hack.  I then would need to worry about grabbing pages
that were node specific and getting the physical addresses.  It just
looked like a cleaner solution to have an API that was for exactly what it
was meant for.

-- Steve
