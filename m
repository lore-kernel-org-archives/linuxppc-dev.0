Return-Path: <alistair@popple.id.au>
Received: from ipmail06.adl2.internode.on.net (ipmail06.adl2.internode.on.net
 [150.101.137.129])
 by lists.ozlabs.org (Postfix) with ESMTP id 3qzVqD1fJ3zDr3r
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 15:59:04 +1000 (AEST)
From: Alistair Popple <alistair@popple.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Dan Carpenter <dan.carpenter@oracle.com>, Daniel Axtens <dja@axtens.net>,
 David Gibson <david@gibson.dropbear.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Russell Currey <ruscur@russell.cc>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH kernel v4 08/11] powerpc/powernv/ioda2: Export debug
 helper pe_level_printk()
Date: Tue, 03 May 2016 15:58:59 +1000
Message-ID: <69636501.hBkSflmio0@new-mexico>
In-Reply-To: <4159435.eIvAFi7xxQ@new-mexico>
References: <1461920124-21719-1-git-send-email-aik@ozlabs.ru>
 <1461920124-21719-9-git-send-email-aik@ozlabs.ru>
 <4159435.eIvAFi7xxQ@new-mexico>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 3 May 2016 15:46:33 Alistair Popple wrote:
> There's one call to pr_warn() in pnv_npu_disable_bypass() that could 
arguably 
> be converted to pe_warn(), but we can clean that up later as the patch looks 
> fine and I'm assuming subsequent patches make use of these.

And inevitably the next patch in the series cleans that up anyway. Feel free 
to ignore the noise above :-)

> Reviewed-By: Alistair Popple <alistair@popple.id.au>
> 
> On Fri, 29 Apr 2016 18:55:21 Alexey Kardashevskiy wrote:
> > This exports debugging helper pe_level_printk() and corresponding macroses
> > so they can be used in npu-dma.c.
> > 
> > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > ---
> >  arch/powerpc/platforms/powernv/pci-ioda.c | 9 +--------
> >  arch/powerpc/platforms/powernv/pci.h      | 9 +++++++++
> >  2 files changed, 10 insertions(+), 8 deletions(-)
> > 
> > diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c 
> b/arch/powerpc/platforms/powernv/pci-ioda.c
> > index 272521e..db7695f 100644
> > --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> > +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> > @@ -56,7 +56,7 @@
> >  
> >  static void pnv_pci_ioda2_table_free_pages(struct iommu_table *tbl);
> >  
> > -static void pe_level_printk(const struct pnv_ioda_pe *pe, const char 
> *level,
> > +void pe_level_printk(const struct pnv_ioda_pe *pe, const char *level,
> >  			    const char *fmt, ...)
> >  {
> >  	struct va_format vaf;
> > @@ -87,13 +87,6 @@ static void pe_level_printk(const struct pnv_ioda_pe 
*pe, 
> const char *level,
> >  	va_end(args);
> >  }
> >  
> > -#define pe_err(pe, fmt, ...)					\
> > -	pe_level_printk(pe, KERN_ERR, fmt, ##__VA_ARGS__)
> > -#define pe_warn(pe, fmt, ...)					\
> > -	pe_level_printk(pe, KERN_WARNING, fmt, ##__VA_ARGS__)
> > -#define pe_info(pe, fmt, ...)					\
> > -	pe_level_printk(pe, KERN_INFO, fmt, ##__VA_ARGS__)
> > -
> >  static bool pnv_iommu_bypass_disabled __read_mostly;
> >  
> >  static int __init iommu_setup(char *str)
> > diff --git a/arch/powerpc/platforms/powernv/pci.h 
> b/arch/powerpc/platforms/powernv/pci.h
> > index d574a9d..485e5b1 100644
> > --- a/arch/powerpc/platforms/powernv/pci.h
> > +++ b/arch/powerpc/platforms/powernv/pci.h
> > @@ -236,6 +236,15 @@ extern void pnv_pci_dma_bus_setup(struct pci_bus 
*bus);
> >  extern int pnv_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type);
> >  extern void pnv_teardown_msi_irqs(struct pci_dev *pdev);
> >  
> > +extern void pe_level_printk(const struct pnv_ioda_pe *pe, const char 
> *level,
> > +			    const char *fmt, ...);
> > +#define pe_err(pe, fmt, ...)					\
> > +	pe_level_printk(pe, KERN_ERR, fmt, ##__VA_ARGS__)
> > +#define pe_warn(pe, fmt, ...)					\
> > +	pe_level_printk(pe, KERN_WARNING, fmt, ##__VA_ARGS__)
> > +#define pe_info(pe, fmt, ...)					\
> > +	pe_level_printk(pe, KERN_INFO, fmt, ##__VA_ARGS__)
> > +
> >  /* Nvlink functions */
> >  extern void pnv_npu_init_dma_pe(struct pnv_ioda_pe *npe);
> >  extern void pnv_npu_setup_dma_pe(struct pnv_ioda_pe *npe);
> > 
