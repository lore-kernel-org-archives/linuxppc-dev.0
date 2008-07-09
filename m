Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 00077DDE23
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jul 2008 19:24:20 +1000 (EST)
Subject: Re: AZFS file system proposal
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Maxim Shchetynin <maxim@linux.vnet.ibm.com>
In-Reply-To: <20080709111402.5af92580@mercedes-benz.boeblingen.de.ibm.com>
References: <20080618160629.6cd749a8@mercedes-benz.boeblingen.de.ibm.com>
	<200807011659.33413.arnd@arndb.de> <1215593918.8970.363.camel@pasglop>
	<20080709111402.5af92580@mercedes-benz.boeblingen.de.ibm.com>
Content-Type: text/plain
Date: Wed, 09 Jul 2008 19:23:34 +1000
Message-Id: <1215595414.8970.366.camel@pasglop>
Mime-Version: 1.0
Cc: linux-fsdevel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-07-09 at 11:14 +0200, Maxim Shchetynin wrote:
> Am Wed, 09 Jul 2008 18:58:38 +1000
> schrieb Benjamin Herrenschmidt <benh@kernel.crashing.org>:
> 
> > On Tue, 2008-07-01 at 16:59 +0200, Arnd Bergmann wrote:
> > > I wouldn't hold up merging the file system for this problem, but
> > > until it is solved, the Kconfig entry should probably have
> > > a "depends on PPC".
> > 
> > Better, use an ifdef for powerpc flags, and #else to pgprot_noncached.
> 
> Thank you Ben. Then, how about this?
> 
> azfs_mmap(struct file *file, struct vm_area_struct *vma)
> {
> ...
> ...
> ...
> #ifdef CONFIG_PPC
> 	pgprot_t page_prot;
> #endif
> ...
> ...
> ...
> #ifdef CONFIG_PPC
> 	page_prot = pgprot_val(vma->vm_page_prot);
> 	page_prot |= (_PAGE_NO_CACHE | _PAGE_RW);
> 	page_prot &= ~_PAGE_GUARDED;
> 	vma->vm_page_prot = __pgprot(page_prot);
> #else
> 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> #endif
> ...

I'd rather do

	pgprot_t  prot;

#ifdef CONFIG_PPC
	prot = <whatever>
#else
	prot = pgprot_noncached(...)
#endif
	vma->vm_page_prot = prot;

To limit the number of ifdef's

Cheers,
Ben.
