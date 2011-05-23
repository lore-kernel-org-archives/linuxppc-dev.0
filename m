Return-Path: <B07421@freescale.com>
Received: from AM1EHSOBE002.bigfish.com (am1ehsobe002.messaging.microsoft.com
	[213.199.154.205])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5DBA7B6FA0
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 24 May 2011 05:03:12 +1000 (EST)
Date: Mon, 23 May 2011 13:54:33 -0500
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/7] powerpc/mm: 64-bit 4k: use a PMD-based virtual page
	table
Message-ID: <20110523135433.557e2d63@schlenkerla.am.freescale.net>
In-Reply-To: <1305929736.7481.188.camel@pasglop>
References: <20110518210528.GA29524@schlenkerla.am.freescale.net>
	<1305754435.7481.3.camel@pasglop>
	<20110520155719.32e51635@schlenkerla.am.freescale.net>
	<1305929736.7481.188.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 21 May 2011 08:15:36 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Fri, 2011-05-20 at 15:57 -0500, Scott Wood wrote:
> 
> > I see a 2% cost going from virtual pmd to full 4-level walk in the
> > benchmark mentioned above (some type of sort), and just under 3% in
> > page-stride lat_mem_rd from lmbench.
> > 
> > OTOH, the virtual pmd approach still leaves the possibility of taking a
> > bunch of virtual page table misses if non-localized accesses happen over a
> > very large chunk of address space (tens of GiB), and we'd have one fewer
> > type of TLB miss to worry about complexity-wise with a straight table walk.
> > 
> > Let me know what you'd prefer.
> 
> I'm tempted to kill the virtual linear feature alltogether.. it didn't
> buy us that much. Have you looked if you can snatch back some of those
> cycles with hand tuning of the level walker ?

That's after trying a bit of that (pulled the pgd load up before
normal_tlb_miss, and some other reordering).  Not sure how much more can be
squeezed out of it with such techniques, at least with e5500.

Hmm, in the normal miss case we know we're in the first EXTLB level,
right?  So we could cut out a load/mfspr by subtracting EXTLB from r12
to get the PACA (that load's latency is pretty well buried, but maybe we
could replace it with loading pgd, replacing it later if it's a kernel
region).  Maybe move pgd to the first EXTLB, so it's in the same cache line
as the state save data. The PACA cacheline containing pgd is probably
pretty hot in normal kernel code, but not so much in a long stretch of
userspace plus TLB misses (other than for pgd itself).

> Would it work/help to have a simple cache of the last pmd & address and
> compare just that ?

Maybe.

It would still slow down the case where you miss that cache -- not by as
much as a virtual page table miss (and it wouldn't compete for TLB entries
with actual user pages), but it would happen more often, since you'd only be
able to cache one pmd.

> Maybe in a SPRG or a known cache hot location like
> the PACA in a line that we already load anyways ?

A cache access is faster than a SPRG access on our chips (plus we
don't have many to spare, especially if we want to avoid swapping SPRG4-7 on
guest entry/exit in KVM), so I'd favor putting it in the PACA.

I'll try this stuff out and see what helps.

-Scott
