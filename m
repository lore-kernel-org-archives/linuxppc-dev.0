Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A2641B6EE9
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 May 2011 07:46:57 +1000 (EST)
Date: Wed, 18 May 2011 16:46:45 -0500
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/7] powerpc/mm: 64-bit 4k: use page-sized PMDs
Message-ID: <20110518164645.0ae83ad5@schlenkerla.am.freescale.net>
In-Reply-To: <1305754361.7481.2.camel@pasglop>
References: <20110518210453.GA29500@schlenkerla.am.freescale.net>
	<1305754361.7481.2.camel@pasglop>
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

On Thu, 19 May 2011 07:32:41 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Wed, 2011-05-18 at 16:04 -0500, Scott Wood wrote:
> > This allows a virtual page table to be used at the PMD rather than
> > the PTE level.
> > 
> > Rather than adjust the constant in pgd_index() (or ignore it, as
> > too-large values don't hurt as long as overly large addresses aren't
> > passed in), go back to using PTRS_PER_PGD.  The overflow comment seems to
> > apply to a very old implementation of free_pgtables that used pgd_index()
> > (unfortunately the commit message, if you seek it out in the historic
> > tree, doesn't mention any details about the overflow).  The existing
> > value was numerically indentical to the old 4K-page PTRS_PER_PGD, so
> > using it shouldn't produce an overflow where it's not otherwise possible.
> > 
> > Also get rid of the incorrect comment at the top of pgtable-ppc64-4k.h.
> 
> Why do you want to create a virtual page table at the PMD level ? Also,
> you are changing the geometry of the page tables which I think we don't
> want. We chose that geometry so that the levels match the segment sizes
> on server, I think it may have an impact with the hugetlbfs code (check
> with David), it also was meant as a way to implement shared page tables
> on hash64 tho we never published that.

The number of virtual page table misses were very high on certain loads.
Cutting back to a virtual PMD eliminates most of that for the benchmark I
tested, though it could still be painful for access patterns that are
extremely spread out through the 64-bit address space.  I'll try a full
4-level walk and see what the performance is like; I was aiming for a
compromise between random access and linear/localized access.

Why does it need to match segment sizes on server?

As for hugetlbfs, it merged easily enough with Becky's patches (you'll have
to ask her when they'll be published).

-Scott
