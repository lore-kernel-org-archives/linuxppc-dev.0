Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A005010080A
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 May 2011 07:54:16 +1000 (EST)
Subject: Re: [PATCH 5/7] powerpc/mm: 64-bit: don't handle non-standard page
	sizes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20110518165025.1deddf00@schlenkerla.am.freescale.net>
References: <20110518210535.GD29524@schlenkerla.am.freescale.net>
	<1305754564.7481.4.camel@pasglop>
	<20110518165025.1deddf00@schlenkerla.am.freescale.net>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 19 May 2011 07:54:05 +1000
Message-ID: <1305755645.7481.11.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-05-18 at 16:50 -0500, Scott Wood wrote:
> On Thu, 19 May 2011 07:36:04 +1000
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > On Wed, 2011-05-18 at 16:05 -0500, Scott Wood wrote:
> > > I don't see where any non-standard page size will be set in the
> > > kernel page tables, so don't waste time checking for it.  It wouldn't
> > > work with TLB0 on an FSL MMU anyway, so if there's something I missed
> > > (or which is out-of-tree), it's relying on implementation-specific
> > > behavior.  If there's an out-of-tree need for occasional 4K mappings
> > > with CONFIG_PPC_64K_PAGES, perhaps this check could only be done when
> > > that is defined.
> > > 
> > > Signed-off-by: Scott Wood <scottwood@freescale.com>
> > > ---
> > 
> > Do you use that in the hugetlbfs code ? Can you publish that code ? It's
> > long overdue...
> 
> hugetlbfs entries don't get loaded by this code.  It branches to a slow
> path based on seeing a positive value in a pgd/pud/pmd entry.

BTW. The long overdue was aimed at David to get A2 hugetlbfs out :-)

Cheers,
Ben.
