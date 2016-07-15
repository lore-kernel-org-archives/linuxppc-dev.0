Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0030.hostedemail.com
 [216.40.44.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rrL2b0dq0zDqFR
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 14:59:18 +1000 (AEST)
Message-ID: <1468558752.8745.52.camel@perches.com>
Subject: Re: [PATCH] powernv: Use __printf in pe_level_printk
From: Joe Perches <joe@perches.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Thu, 14 Jul 2016 21:59:12 -0700
In-Reply-To: <87eg6vbjr2.fsf@@concordia.ellerman.id.au>
References: <b204dbb1d8d13998eb8dee4dabbc91a0ee4b38b4.1468511136.git.joe@perches.com>
 <87eg6vbjr2.fsf@@concordia.ellerman.id.au>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-07-15 at 14:36 +1000, Michael Ellerman wrote:
> Joe Perches <joe@perches.com> writes:
> 
> > 
> > Make the compiler detect format and argument mismatches.
> > 
> > Signed-off-by: Joe Perches <joe@perches.com>
> > ---
> >  arch/powerpc/platforms/powernv/pci.h | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/powerpc/platforms/powernv/pci.h
> > b/arch/powerpc/platforms/powernv/pci.h
> > index 3a97990..1c1a586 100644
> > --- a/arch/powerpc/platforms/powernv/pci.h
> > +++ b/arch/powerpc/platforms/powernv/pci.h
> > @@ -213,6 +213,7 @@ extern void pnv_pci_dma_bus_setup(struct pci_bus
> > *bus);
> >  extern int pnv_setup_msi_irqs(struct pci_dev *pdev, int nvec, int
> > type);
> >  extern void pnv_teardown_msi_irqs(struct pci_dev *pdev);
> >  
> > +__printf(3, 4)
> >  extern void pe_level_printk(const struct pnv_ioda_pe *pe, const
> > char *level,
> >  			    const char *fmt, ...);
> Thanks, but it breaks the build due to lots of new warnings.
> 
> We'll have to fix those before merging it.

Good.  Are you going to fix those?

I thought I did a powerpc defconfig build of arch/powerpc/
and I believe it finished without error, but I'm pleased
it found some defects.

I think it's now marked "rejected" in patchwork.
Perhaps it'd better to mark it "deferred" instead.
