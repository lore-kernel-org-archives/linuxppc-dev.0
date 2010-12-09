Return-Path: <nacc@us.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2EF3FB70B0
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Dec 2010 03:16:24 +1100 (EST)
Received: from d01dlp01.pok.ibm.com (d01dlp01.pok.ibm.com [9.56.224.56])
	by e1.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id oB9G83Qf016213
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Dec 2010 11:08:10 -0500
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 8AD4972805B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  9 Dec 2010 11:16:20 -0500 (EST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	oB9GGKpf129068
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Dec 2010 11:16:20 -0500
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id oB9GGJkE026006
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Dec 2010 09:16:19 -0700
Date: Thu, 9 Dec 2010 08:16:00 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH 6/7 v2] ppc/iommu: pass phb only to
	iommu_table_setparms_lpar
Message-ID: <20101209161600.GA20966@us.ibm.com>
References: <1288150518-4026-1-git-send-email-nacc@us.ibm.com>
	<1288150518-4026-7-git-send-email-nacc@us.ibm.com>
	<1291868679.16694.221.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1291868679.16694.221.camel@pasglop>
Cc: linuxppc-dev@lists.ozlabs.org, sonnyrao@us.ibm.com,
	Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>, miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09.12.2010 [15:24:39 +1100], Benjamin Herrenschmidt wrote:
> On Tue, 2010-10-26 at 20:35 -0700, Nishanth Aravamudan wrote:
> > iommu_table_setparms_lpar needs either the phb or the subbusnumber
> > (not both), pass the phb to make it similar to iommu_table_setparms.
> > 
> > Note: In cases where a caller was passing bus->number previously to
> > iommu_table_setparms_lpar() rather than phb->bus->number, this can lead
> > to a different value in tbl->it_busno. The only example of this was the
> > removed pci_dma_dev_setup_pSeriesLP(), removed in "ppc/iommu: remove
> > unneeded pci_dma_dev_setup_pSeriesLP".
> > 
> > Signed-off-by: Milton Miller <miltonm@bga.com>
> > Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
> > ---
> >  arch/powerpc/platforms/pseries/iommu.c |    8 +++-----
> >  1 files changed, 3 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> > index 9d564b9..45c6865 100644
> > --- a/arch/powerpc/platforms/pseries/iommu.c
> > +++ b/arch/powerpc/platforms/pseries/iommu.c
> > @@ -323,14 +323,13 @@ static void iommu_table_setparms(struct pci_controller *phb,
> >  static void iommu_table_setparms_lpar(struct pci_controller *phb,
> >  				      struct device_node *dn,
> >  				      struct iommu_table *tbl,
> > -				      const void *dma_window,
> > -				      int bussubno)
> > +				      const void *dma_window)
> >  {
> >  	unsigned long offset, size;
> >  
> > -	tbl->it_busno  = bussubno;
> >  	of_parse_dma_window(dn, dma_window, &tbl->it_index, &offset, &size);
> >  
> > +	tbl->it_busno = phb->bus->number;
> >  	tbl->it_base   = 0;
> >  	tbl->it_blocksize  = 16;
> >  	tbl->it_type = TCE_PCI;
> > @@ -534,8 +533,7 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
> >  	if (!pci->iommu_table) {
> >  		tbl = kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL,
> >  				   pci->phb->node);
> > -		iommu_table_setparms_lpar(pci->phb, pdn, tbl, dma_window,
> > -			pci->phb->bus->number);
> > +		iommu_table_setparms_lpar(pci->phb, pdn, tbl, dma_window);
> >  		pci->iommu_table = iommu_init_table(tbl, pci->phb->node);
> >  		pr_debug("  created table: %p\n", pci->iommu_table);
> >  	} else {
> 
> There's another caller :-) I've fixed that up locally and will push with
> the fix.

Shoot! Thanks for catching that.

-Nish

-- 
Nishanth Aravamudan <nacc@us.ibm.com>
IBM Linux Technology Center
