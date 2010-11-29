Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A168C1007D7
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 29 Nov 2010 13:44:59 +1100 (EST)
Subject: Re: [RFC PATCH 3/7 v2] ppc: do not search for dma-window property
	on dlpar remove
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nishanth Aravamudan <nacc@us.ibm.com>
In-Reply-To: <1288150518-4026-4-git-send-email-nacc@us.ibm.com>
References: <1288150518-4026-1-git-send-email-nacc@us.ibm.com>
	<1288150518-4026-4-git-send-email-nacc@us.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 29 Nov 2010 12:38:41 +1100
Message-ID: <1290994721.32570.219.camel@pasglop>
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
> The iommu_table pointer in the pci auxiliary struct of device_node has
> not been used by the iommu ops since the dma refactor of
> 12d04eef927bf61328af2c7cbe756c96f98ac3bf, however this code still uses
> it to find tables for dlpar. By only setting the PCI_DN iommu_table
> pointer on nodes with dma window properties, we will be able to quickly
> find the node for later checks, and can remove the table without looking
> for the the dma window property on dlpar remove.

The answer might well be yes but are we sure this works with busses &
devices that don't have a dma,window ? ie. we always properly look for
parents when assigning pci devices arch_data iommu table ? Did you test
it ? :-) (Best way is to find a card with a P2P bridge on it).

Cheers,
Ben. 

> Signed-off-by: Milton Miller <miltonm@bga.com>
> Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/iommu.c |    6 +-----
>  1 files changed, 1 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> index 9184db3..8ab32da 100644
> --- a/arch/powerpc/platforms/pseries/iommu.c
> +++ b/arch/powerpc/platforms/pseries/iommu.c
> @@ -455,9 +455,6 @@ static void pci_dma_bus_setup_pSeriesLP(struct pci_bus *bus)
>  		ppci->iommu_table = iommu_init_table(tbl, ppci->phb->node);
>  		pr_debug("  created table: %p\n", ppci->iommu_table);
>  	}
> -
> -	if (pdn != dn)
> -		PCI_DN(dn)->iommu_table = ppci->iommu_table;
>  }
>  
> @@ -571,8 +568,7 @@ static int iommu_reconfig_notifier(struct notifier_block *nb, unsigned long acti
>  
>  	switch (action) {
>  	case PSERIES_RECONFIG_REMOVE:
> -		if (pci && pci->iommu_table &&
> -		    of_get_property(np, "ibm,dma-window", NULL))
> +		if (pci && pci->iommu_table)
>  			iommu_free_table(pci->iommu_table, np->full_name);
>  		break;
>  	default:
