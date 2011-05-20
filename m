Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE003.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DE36EB6F76
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 21 May 2011 06:57:34 +1000 (EST)
Date: Fri, 20 May 2011 15:57:19 -0500
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/7] powerpc/mm: 64-bit 4k: use a PMD-based virtual page
	table
Message-ID: <20110520155719.32e51635@schlenkerla.am.freescale.net>
In-Reply-To: <1305754435.7481.3.camel@pasglop>
References: <20110518210528.GA29524@schlenkerla.am.freescale.net>
	<1305754435.7481.3.camel@pasglop>
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

On Thu, 19 May 2011 07:33:55 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Wed, 2011-05-18 at 16:05 -0500, Scott Wood wrote:
> > Loads with non-linear access patterns were producing a very high
> > ratio of recursive pt faults to regular tlb misses.  Rather than
> > choose between a 4-level table walk or a 1-level virtual page table
> > lookup, use a hybrid scheme with a virtual linear pmd, followed by a
> > 2-level lookup in the normal handler.
> > 
> > This adds about 5 cycles (assuming no cache misses, and e5500 timing)
> > to a normal TLB miss, but greatly reduces the recursive fault rate
> > for loads which don't have locality within 2 MiB regions but do have
> > significant locality within 1 GiB regions.  Improvements of close to 50%
> > were seen on such benchmarks.
> 
> Can you publish benchmarks that compare these two with no virtual at all
> (4 full loads) ?

I see a 2% cost going from virtual pmd to full 4-level walk in the
benchmark mentioned above (some type of sort), and just under 3% in
page-stride lat_mem_rd from lmbench.

OTOH, the virtual pmd approach still leaves the possibility of taking a
bunch of virtual page table misses if non-localized accesses happen over a
very large chunk of address space (tens of GiB), and we'd have one fewer
type of TLB miss to worry about complexity-wise with a straight table walk.

Let me know what you'd prefer.

-Scott
