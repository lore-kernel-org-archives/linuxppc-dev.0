Return-Path: <bhelgaas@google.com>
Received: from mail-pa0-f49.google.com (mail-pa0-f49.google.com
 [209.85.220.49])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id AB08D14013D
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Apr 2014 03:50:20 +1000 (EST)
Received: by mail-pa0-f49.google.com with SMTP id lj1so3421048pab.36
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Apr 2014 10:50:17 -0700 (PDT)
Date: Fri, 25 Apr 2014 11:50:12 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Subject: Re: [PATCH] PCI/hotplug/rphahp: Fix endianess issues
Message-ID: <20140425175012.GG32246@google.com>
References: <20140410130213.8435.16459.stgit@nimbus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140410130213.8435.16459.stgit@nimbus>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 mdroth@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 10, 2014 at 03:02:13PM +0200, Laurent Dufour wrote:
> Numerical values stored in the device tree are encoded in Big Endian and
> should be byte swapped when running in Little Endian.
> 
> RPA hot plug module should convert those values as well.
> 
> Note that in rpaphp_get_drc_props the comparison between indexes[i+1] and
> *index is done using the BE values (whatever is the current endianess).
> This doesn't matter since we are checking for equality here. This way only
> the returned value is byte swapped.
> 
> RPA also made RTAS calls which implies BE values to be used. According to
> the patch done in RTAS (http://patchwork.ozlabs.org/patch/336865), no
> additional conversion is required in RPA.
> 
> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>

I applied this to pci/hotplug for v3.16, thanks!

> ---
>  drivers/pci/hotplug/rpaphp_core.c |   15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
> index 4796c15..984d708 100644
> --- a/drivers/pci/hotplug/rpaphp_core.c
> +++ b/drivers/pci/hotplug/rpaphp_core.c
> @@ -223,16 +223,16 @@ int rpaphp_get_drc_props(struct device_node *dn, int *drc_index,
>  	type_tmp = (char *) &types[1];
>  
>  	/* Iterate through parent properties, looking for my-drc-index */
> -	for (i = 0; i < indexes[0]; i++) {
> +	for (i = 0; i < be32_to_cpu(indexes[0]); i++) {
>  		if ((unsigned int) indexes[i + 1] == *my_index) {
>  			if (drc_name)
>  				*drc_name = name_tmp;
>  			if (drc_type)
>  				*drc_type = type_tmp;
>  			if (drc_index)
> -				*drc_index = *my_index;
> +				*drc_index = be32_to_cpu(*my_index);
>  			if (drc_power_domain)
> -				*drc_power_domain = domains[i+1];
> +				*drc_power_domain = be32_to_cpu(domains[i+1]);
>  			return 0;
>  		}
>  		name_tmp += (strlen(name_tmp) + 1);
> @@ -321,16 +321,19 @@ int rpaphp_add_slot(struct device_node *dn)
>  	/* register PCI devices */
>  	name = (char *) &names[1];
>  	type = (char *) &types[1];
> -	for (i = 0; i < indexes[0]; i++) {
> +	for (i = 0; i < be32_to_cpu(indexes[0]); i++) {
> +		int index;
>  
> -		slot = alloc_slot_struct(dn, indexes[i + 1], name, power_domains[i + 1]);
> +		index = be32_to_cpu(indexes[i + 1]);
> +		slot = alloc_slot_struct(dn, index, name,
> +					 be32_to_cpu(power_domains[i + 1]));
>  		if (!slot)
>  			return -ENOMEM;
>  
>  		slot->type = simple_strtoul(type, NULL, 10);
>  
>  		dbg("Found drc-index:0x%x drc-name:%s drc-type:%s\n",
> -				indexes[i + 1], name, type);
> +				index, name, type);
>  
>  		retval = rpaphp_enable_slot(slot);
>  		if (!retval)
> 
