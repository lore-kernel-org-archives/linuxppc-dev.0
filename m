Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 81DD0B6EED
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  9 Dec 2010 15:24:48 +1100 (EST)
Subject: Re: [RFC PATCH 6/7 v2] ppc/iommu: pass phb only to
	iommu_table_setparms_lpar
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nishanth Aravamudan <nacc@us.ibm.com>
In-Reply-To: <1288150518-4026-7-git-send-email-nacc@us.ibm.com>
References: <1288150518-4026-1-git-send-email-nacc@us.ibm.com>
	<1288150518-4026-7-git-send-email-nacc@us.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 09 Dec 2010 15:24:39 +1100
Message-ID: <1291868679.16694.221.camel@pasglop>
Mime-Version: 1.0
Cc: sonnyrao@us.ibm.com, miltonm@bga.com, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2010-10-26 at 20:35 -0700, Nishanth Aravamudan wrote:
> iommu_table_setparms_lpar needs either the phb or the subbusnumber
> (not both), pass the phb to make it similar to iommu_table_setparms.
> 
> Note: In cases where a caller was passing bus->number previously to
> iommu_table_setparms_lpar() rather than phb->bus->number, this can lead
> to a different value in tbl->it_busno. The only example of this was the
> removed pci_dma_dev_setup_pSeriesLP(), removed in "ppc/iommu: remove
> unneeded pci_dma_dev_setup_pSeriesLP".
> 
> Signed-off-by: Milton Miller <miltonm@bga.com>
> Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/iommu.c |    8 +++-----
>  1 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> index 9d564b9..45c6865 100644
> --- a/arch/powerpc/platforms/pseries/iommu.c
> +++ b/arch/powerpc/platforms/pseries/iommu.c
> @@ -323,14 +323,13 @@ static void iommu_table_setparms(struct pci_controller *phb,
>  static void iommu_table_setparms_lpar(struct pci_controller *phb,
>  				      struct device_node *dn,
>  				      struct iommu_table *tbl,
> -				      const void *dma_window,
> -				      int bussubno)
> +				      const void *dma_window)
>  {
>  	unsigned long offset, size;
>  
> -	tbl->it_busno  = bussubno;
>  	of_parse_dma_window(dn, dma_window, &tbl->it_index, &offset, &size);
>  
> +	tbl->it_busno = phb->bus->number;
>  	tbl->it_base   = 0;
>  	tbl->it_blocksize  = 16;
>  	tbl->it_type = TCE_PCI;
> @@ -534,8 +533,7 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
>  	if (!pci->iommu_table) {
>  		tbl = kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL,
>  				   pci->phb->node);
> -		iommu_table_setparms_lpar(pci->phb, pdn, tbl, dma_window,
> -			pci->phb->bus->number);
> +		iommu_table_setparms_lpar(pci->phb, pdn, tbl, dma_window);
>  		pci->iommu_table = iommu_init_table(tbl, pci->phb->node);
>  		pr_debug("  created table: %p\n", pci->iommu_table);
>  	} else {

There's another caller :-) I've fixed that up locally and will push with
the fix.

Cheers,
Ben.
