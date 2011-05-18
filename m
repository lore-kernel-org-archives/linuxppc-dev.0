Return-Path: <B07421@freescale.com>
Received: from DB3EHSOBE004.bigfish.com (db3ehsobe004.messaging.microsoft.com
	[213.199.154.142])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B154AB6F68
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 May 2011 07:50:36 +1000 (EST)
Date: Wed, 18 May 2011 16:50:25 -0500
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 5/7] powerpc/mm: 64-bit: don't handle non-standard page
	sizes
Message-ID: <20110518165025.1deddf00@schlenkerla.am.freescale.net>
In-Reply-To: <1305754564.7481.4.camel@pasglop>
References: <20110518210535.GD29524@schlenkerla.am.freescale.net>
	<1305754564.7481.4.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org, David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 19 May 2011 07:36:04 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Wed, 2011-05-18 at 16:05 -0500, Scott Wood wrote:
> > I don't see where any non-standard page size will be set in the
> > kernel page tables, so don't waste time checking for it.  It wouldn't
> > work with TLB0 on an FSL MMU anyway, so if there's something I missed
> > (or which is out-of-tree), it's relying on implementation-specific
> > behavior.  If there's an out-of-tree need for occasional 4K mappings
> > with CONFIG_PPC_64K_PAGES, perhaps this check could only be done when
> > that is defined.
> > 
> > Signed-off-by: Scott Wood <scottwood@freescale.com>
> > ---
> 
> Do you use that in the hugetlbfs code ? Can you publish that code ? It's
> long overdue...

hugetlbfs entries don't get loaded by this code.  It branches to a slow
path based on seeing a positive value in a pgd/pud/pmd entry.

-Scott
