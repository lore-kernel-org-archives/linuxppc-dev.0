Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C52A22C009A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2013 19:19:10 +1000 (EST)
Message-ID: <1375262326.3743.4.camel@pasglop>
Subject: Re: [PATCH 4/5] powerpc/powernv: Pick up correct number of PEs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Wed, 31 Jul 2013 19:18:46 +1000
In-Reply-To: <1375260424-20777-4-git-send-email-shangw@linux.vnet.ibm.com>
References: <1375260424-20777-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1375260424-20777-4-git-send-email-shangw@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-07-31 at 16:47 +0800, Gavin Shan wrote:
> Usually, the property "ibm,opal-num-pes" of PHB dev-tree node
> indicates the number of total PEs. If that property isn't existing
> or valid, we should fall back to pick the correct number of total
> PEs according to PHB type: IODA1 or IODA2.

Is that correct ? Don't we get the total number of PEs from a config
register on the bridge ? I didn't think the IODA architecture specified
the total number of PE of a given implementation...

For example, does Torrent implement 128 ?

I'd rather stick to safe here, if the firmware doesn't say, just use
one.

Now some of the PHB registers are actually architected in IODA afaik, so
we could just go look but let's not make a precedent here.

Cheers,
Ben.

> Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c |   11 +++++++----
>  1 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 829047b..6386bb4 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -1172,11 +1172,14 @@ void __init pnv_pci_init_ioda_phb(struct device_node *np,
>  
>  	/* Initialize more IODA stuff */
>  	prop32 = of_get_property(np, "ibm,opal-num-pes", NULL);
> -	if (!prop32)
> -		phb->ioda.total_pe = 1;
> -	else
> +	if (prop32)
>  		phb->ioda.total_pe = *prop32;
> -
> +	else if (phb->type == PNV_PHB_IODA1)
> +		phb->ioda.total_pe = 128;
> +	else if (phb->type == PNV_PHB_IODA2)
> +		phb->ioda.total_pe = 256;
> +	else
> +		phb->ioda.total_pe = 1;
>  	phb->ioda.m32_size = resource_size(&hose->mem_resources[0]);
>  	/* FW Has already off top 64k of M32 space (MSI space) */
>  	phb->ioda.m32_size += 0x10000;
