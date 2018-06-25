Return-Path: <aik@ozlabs.ru>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41DZ1Z0X35zF16W
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2018 13:10:39 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id r21-v6so5422587pgv.4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Jun 2018 20:10:39 -0700 (PDT)
Date: Mon, 25 Jun 2018 13:10:30 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: Timothy Pearson <tpearson@raptorengineering.com>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 1/7] powerpc/powernv/pci: Track largest available TCE order
Message-ID: <20180625131030.7aeb2446@aik.ozlabs.ibm.com>
In-Reply-To: <77952537.2569246.1529797950974.JavaMail.zimbra@raptorengineeringinc.com>
References: <77952537.2569246.1529797950974.JavaMail.zimbra@raptorengineeringinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 23 Jun 2018 18:52:30 -0500 (CDT)
Timothy Pearson <tpearson@raptorengineering.com> wrote:

>  per PHB
> 
> Knowing the largest possible TCE size of a PHB is useful, so get it out
> of the device tree.  This relies on the property being added in OPAL.
> 
> It is assumed that any PHB4 or later machine would be running firmware
> that implemented this property, and otherwise assumed to be PHB3, which
> has a maximum TCE order of 28 bits or 256MB TCEs.
> 
> This is used later in the series.
> 
> Signed-off-by: Russell Currey <ruscur@russell.cc>
> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c | 16 ++++++++++++++++
>  arch/powerpc/platforms/powernv/pci.h      |  3 +++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 5bd0eb6681bc..bcb3bfce072a 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -3873,11 +3873,13 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>  	struct resource r;
>  	const __be64 *prop64;
>  	const __be32 *prop32;
> +	struct property *prop;
>  	int len;
>  	unsigned int segno;
>  	u64 phb_id;
>  	void *aux;
>  	long rc;
> +	u32 val;
>  
>  	if (!of_device_is_available(np))
>  		return;
> @@ -4016,6 +4018,20 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>  	}
>  	phb->ioda.pe_array = aux + pemap_off;
>  
> +	phb->ioda.max_tce_order = 0;
> +	// Get TCE order from the DT.  If it's not present, assume P8
> +	if (!of_get_property(np, "ibm,supported-tce-sizes", NULL)) {
> +		phb->ioda.max_tce_order = 28; // assume P8 256mb TCEs
> +	} else {
> +		of_property_for_each_u32(np, "ibm,supported-tce-sizes", prop,
> +					 prop32, val) {
> +			if (val > phb->ioda.max_tce_order)
> +				phb->ioda.max_tce_order = val;
> +		}
> +		pr_debug("PHB%llx Found max TCE order of %d bits\n",
> +			 phb->opal_id, phb->ioda.max_tce_order);
> +	}
> +


7ef73cd39b4e28 stores this in pe->table_group.pgsizes, why duplicate
this?



>  	/*
>  	 * Choose PE number for root bus, which shouldn't have
>  	 * M64 resources consumed by its child devices. To pick
> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
> index eada4b6068cb..c9952def5e93 100644
> --- a/arch/powerpc/platforms/powernv/pci.h
> +++ b/arch/powerpc/platforms/powernv/pci.h
> @@ -173,6 +173,9 @@ struct pnv_phb {
>  		struct list_head	pe_list;
>  		struct mutex            pe_list_mutex;
>  
> +		/* Largest supported TCE order bits */
> +		uint8_t			max_tce_order;
> +
>  		/* Reverse map of PEs, indexed by {bus, devfn} */
>  		unsigned int		pe_rmap[0x10000];
>  	} ioda;
> -- 
> 2.17.1



--
Alexey
