Return-Path: <ruscur@russell.cc>
Received: from russell.cc (russell.cc [IPv6:2404:9400:2:0:216:3eff:fee0:3370])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8C6211A17EB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jan 2016 14:56:19 +1100 (AEDT)
Message-ID: <1453262173.1201.2.camel@russell.cc>
Subject: Re: [PATCH] powerpc/eeh: Fix PE location code
From: Russell Currey <ruscur@russell.cc>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Date: Wed, 20 Jan 2016 14:56:13 +1100
In-Reply-To: <1449033932-27307-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1449033932-27307-1-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-12-02 at 16:25 +1100, Gavin Shan wrote:
> In eeh_pe_loc_get(), the PE location code is retrieved from the
> "ibm,loc-code" property of the device node for the bridge of the
> PE's primary bus. It's not correct because the property indicates
> the parent PE's location code.
> 
> This reads the correct PE location code from "ibm,io-base-loc-code"
> or "ibm,slot-location-code" property of PE parent bus's device node.
> 
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---

Tested-by: Russell Currey <ruscur@russell.cc>

>  arch/powerpc/kernel/eeh_pe.c | 33 +++++++++++++++------------------
>  1 file changed, 15 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
> index 8654cb1..ca9e537 100644
> --- a/arch/powerpc/kernel/eeh_pe.c
> +++ b/arch/powerpc/kernel/eeh_pe.c
> @@ -883,32 +883,29 @@ void eeh_pe_restore_bars(struct eeh_pe *pe)
>  const char *eeh_pe_loc_get(struct eeh_pe *pe)
>  {
>  	struct pci_bus *bus = eeh_pe_bus_get(pe);
> -	struct device_node *dn = pci_bus_to_OF_node(bus);
> +	struct device_node *dn;
>  	const char *loc = NULL;
>  
> -	if (!dn)
> -		goto out;
> +	while (bus) {
> +		dn = pci_bus_to_OF_node(bus);
> +		if (!dn) {
> +			bus = bus->parent;
> +			continue;
> +		}
>  
> -	/* PHB PE or root PE ? */
> -	if (pci_is_root_bus(bus)) {
> -		loc = of_get_property(dn, "ibm,loc-code", NULL);
> -		if (!loc)
> +		if (pci_is_root_bus(bus))
>  			loc = of_get_property(dn, "ibm,io-base-loc-
> code", NULL);
> +		else
> +			loc = of_get_property(dn, "ibm,slot-location-
> code",
> +					      NULL);
> +
>  		if (loc)
> -			goto out;
> +			return loc;
>  
> -		/* Check the root port */
> -		dn = dn->child;
> -		if (!dn)
> -			goto out;
> +		bus = bus->parent;
>  	}
>  
> -	loc = of_get_property(dn, "ibm,loc-code", NULL);
> -	if (!loc)
> -		loc = of_get_property(dn, "ibm,slot-location-code",
> NULL);
> -
> -out:
> -	return loc ? loc : "N/A";
> +	return "N/A";
>  }
>  
>  /**
