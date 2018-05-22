Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40r6lJ2PxXzDqnw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 06:32:27 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4MKTJ3Z146494
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 16:32:25 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2j4p4gv7gw-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 16:32:25 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 22 May 2018 14:32:24 -0600
Subject: Re: [RFC v4 1/4] hotplug/drcinfo: Simplify parse ibm, drc-info structs
To: Michael Bringmann <mwb@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: John Allen <jallen@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
References: <66fd5dbd-4bca-274a-b0e0-c9d6b52e6567@linux.vnet.ibm.com>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Tue, 22 May 2018 15:32:20 -0500
MIME-Version: 1.0
In-Reply-To: <66fd5dbd-4bca-274a-b0e0-c9d6b52e6567@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <aef4c70a-2558-5322-1658-128ccc9a6278@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/22/2018 11:37 AM, Michael Bringmann wrote:
> Replace use of of_prop_next_u32() in when parsing 'ibm,drc-info'
> structure to simplify and reduce parsing code.
>

You mention that this patch is to fix the parsing of the drc-info struct, but you end up
making changes to the parsing code in pseries_energy.c and rpaphp_core.c. If there is a
bug in the parsing code in those files that should be submitted as a separate patch
outside of the drc-info fixups.

-Nathan
 
> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
> Fixes: 3f38000eda48 ("powerpc/firmware: Add definitions for new drc-info firmware feature" -- end of patch series applied to powerpc next)
> ---
> Changes in V4:
>   -- Rebased patch to 4.17-rc5 kernel
>   -- Replace of_prop_next_u32() by of_read_number()
> ---
>  arch/powerpc/platforms/pseries/of_helpers.c     |   20 +++++---------------
>  arch/powerpc/platforms/pseries/pseries_energy.c |   10 ++++------
>  drivers/pci/hotplug/rpaphp_core.c               |    5 ++---
>  3 files changed, 11 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/of_helpers.c b/arch/powerpc/platforms/pseries/of_helpers.c
> index 6df192f..11b2ef1 100644
> --- a/arch/powerpc/platforms/pseries/of_helpers.c
> +++ b/arch/powerpc/platforms/pseries/of_helpers.c
> @@ -65,29 +65,19 @@ int of_read_drc_info_cell(struct property **prop, const __be32 **curval,
> 
>  	/* Get drc-index-start:encode-int */
>  	p2 = (const __be32 *)p;
> -	p2 = of_prop_next_u32(*prop, p2, &data->drc_index_start);
> -	if (!p2)
> -		return -EINVAL;
> +	data->drc_index_start = of_read_number(p2++, 1);
> 
>  	/* Get drc-name-suffix-start:encode-int */
> -	p2 = of_prop_next_u32(*prop, p2, &data->drc_name_suffix_start);
> -	if (!p2)
> -		return -EINVAL;
> +	data->drc_name_suffix_start = of_read_number(p2++, 1);
> 
>  	/* Get number-sequential-elements:encode-int */
> -	p2 = of_prop_next_u32(*prop, p2, &data->num_sequential_elems);
> -	if (!p2)
> -		return -EINVAL;
> +	data->num_sequential_elems = of_read_number(p2++, 1);
> 
>  	/* Get sequential-increment:encode-int */
> -	p2 = of_prop_next_u32(*prop, p2, &data->sequential_inc);
> -	if (!p2)
> -		return -EINVAL;
> +	data->sequential_inc = of_read_number(p2++, 1);
> 
>  	/* Get drc-power-domain:encode-int */
> -	p2 = of_prop_next_u32(*prop, p2, &data->drc_power_domain);
> -	if (!p2)
> -		return -EINVAL;
> +	data->drc_power_domain = of_read_number(p2++, 1);
> 
>  	/* Should now know end of current entry */
>  	(*curval) = (void *)p2;
> diff --git a/arch/powerpc/platforms/pseries/pseries_energy.c b/arch/powerpc/platforms/pseries/pseries_energy.c
> index 6ed2212..5261975 100644
> --- a/arch/powerpc/platforms/pseries/pseries_energy.c
> +++ b/arch/powerpc/platforms/pseries/pseries_energy.c
> @@ -61,9 +61,8 @@ static u32 cpu_to_drc_index(int cpu)
>  		if (info == NULL)
>  			goto err_of_node_put;
> 
> -		value = of_prop_next_u32(info, NULL, &num_set_entries);
> -		if (!value)
> -			goto err_of_node_put;
> +		value = info->value;
> +		num_set_entries = of_read_number(value++, 1);
> 
>  		for (j = 0; j < num_set_entries; j++) {
> 
> @@ -123,9 +122,8 @@ static int drc_index_to_cpu(u32 drc_index)
>  		if (info == NULL)
>  			goto err_of_node_put;
> 
> -		value = of_prop_next_u32(info, NULL, &num_set_entries);
> -		if (!value)
> -			goto err_of_node_put;
> +		value = info->value;
> +		num_set_entries = of_read_number(value++, 1);
> 
>  		for (j = 0; j < num_set_entries; j++) {
> 
> diff --git a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
> index fb5e084..435c1a0 100644
> --- a/drivers/pci/hotplug/rpaphp_core.c
> +++ b/drivers/pci/hotplug/rpaphp_core.c
> @@ -236,9 +236,8 @@ static int rpaphp_check_drc_props_v2(struct device_node *dn, char *drc_name,
>  	if (info == NULL)
>  		return -EINVAL;
> 
> -	value = of_prop_next_u32(info, NULL, &entries);
> -	if (!value)
> -		return -EINVAL;
> +	value = info->value;
> +	entries = of_read_number(value++, 1);
> 
>  	for (j = 0; j < entries; j++) {
>  		of_read_drc_info_cell(&info, &value, &drc);
> 
