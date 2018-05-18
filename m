Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40nf926g33zF2GY
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 May 2018 05:57:42 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4IJnBkJ010767
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 May 2018 15:57:39 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2j22waeapf-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 May 2018 15:57:39 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Fri, 18 May 2018 13:57:38 -0600
Subject: Re: [RFC v3 1/4] powerpc/hotplug/drcinfo: Fix bugs parsing
 ibm,drc-info structs
To: Michael Bringmann <mwb@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: John Allen <jallen@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
References: <5a950883-d06d-4cdc-2716-8c1ce25f394d@linux.vnet.ibm.com>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Fri, 18 May 2018 14:57:34 -0500
MIME-Version: 1.0
In-Reply-To: <5a950883-d06d-4cdc-2716-8c1ce25f394d@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <66c02d35-2bf4-67c1-1ba0-072e9ac6562c@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/17/2018 05:41 PM, Michael Bringmann wrote:
> [Replace/withdraw previous patch submission to ensure that testing
> of related patches on similar hardware progresses together.]
> 
> This patch fixes a memory parsing bug when using of_prop_next_u32
> calls at the start of a structure.  Depending upon the value of
> "cur" memory pointer argument to of_prop_next_u32, it will or it
> won't advance the value of the returned memory pointer by the
> size of one u32.  This patch corrects the code to deal with that
> indexing feature when parsing the ibm,drc-info structs for CPUs.
> Also, need to advance the pointer at the end of_read_drc_info_cell
> for same reason.
> 

I see that you provide an update for of_read_drc_info_cell to fix the
unexpected behavior you're seeing, but I'm not sure why you're updating
the code in pseries_energy.c and rpaphp_core.c? can you provide some
additional information as to why these functions also need to be updated.

> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
> Fixes: 3f38000eda48 ("powerpc/firmware: Add definitions for new drc-info firmware feature" -- end of patch series applied to powerpc next)
> ---
> Changes in V3:
>   -- Rebased patch to 4.17-rc5 kernel
> ---
>  arch/powerpc/platforms/pseries/of_helpers.c     |    5 ++---
>  arch/powerpc/platforms/pseries/pseries_energy.c |    2 ++
>  drivers/pci/hotplug/rpaphp_core.c               |    1 +
>  3 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/of_helpers.c b/arch/powerpc/platforms/pseries/of_helpers.c
> index 6df192f..20598b2 100644
> --- a/arch/powerpc/platforms/pseries/of_helpers.c
> +++ b/arch/powerpc/platforms/pseries/of_helpers.c
> @@ -65,9 +65,7 @@ int of_read_drc_info_cell(struct property **prop, const __be32 **curval,
> 
>  	/* Get drc-index-start:encode-int */
>  	p2 = (const __be32 *)p;
> -	p2 = of_prop_next_u32(*prop, p2, &data->drc_index_start);
> -	if (!p2)
> -		return -EINVAL;
> +	data->drc_index_start = of_read_number(p2, 1);

This appears to resolve advancing the pointer for the beginning of a struct.

> 
>  	/* Get drc-name-suffix-start:encode-int */
>  	p2 = of_prop_next_u32(*prop, p2, &data->drc_name_suffix_start);
> @@ -88,6 +86,7 @@ int of_read_drc_info_cell(struct property **prop, const __be32 **curval,
>  	p2 = of_prop_next_u32(*prop, p2, &data->drc_power_domain);
>  	if (!p2)
>  		return -EINVAL;
> +	p2++;

...but why is the advancement needed here? of_prop_next_u32 should have advanced it, correct?

-Nathan

> 
>  	/* Should now know end of current entry */
>  	(*curval) = (void *)p2;
> diff --git a/arch/powerpc/platforms/pseries/pseries_energy.c b/arch/powerpc/platforms/pseries/pseries_energy.c
> index 6ed2212..c7d84aa 100644
> --- a/arch/powerpc/platforms/pseries/pseries_energy.c
> +++ b/arch/powerpc/platforms/pseries/pseries_energy.c
> @@ -64,6 +64,7 @@ static u32 cpu_to_drc_index(int cpu)
>  		value = of_prop_next_u32(info, NULL, &num_set_entries);
>  		if (!value)
>  			goto err_of_node_put;
> +		value++;
> 
>  		for (j = 0; j < num_set_entries; j++) {
> 
> @@ -126,6 +127,7 @@ static int drc_index_to_cpu(u32 drc_index)
>  		value = of_prop_next_u32(info, NULL, &num_set_entries);
>  		if (!value)
>  			goto err_of_node_put;
> +		value++;
> 
>  		for (j = 0; j < num_set_entries; j++) {
> 
> diff --git a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
> index fb5e084..dccdf62 100644
> --- a/drivers/pci/hotplug/rpaphp_core.c
> +++ b/drivers/pci/hotplug/rpaphp_core.c
> @@ -239,6 +239,7 @@ static int rpaphp_check_drc_props_v2(struct device_node *dn, char *drc_name,
>  	value = of_prop_next_u32(info, NULL, &entries);
>  	if (!value)
>  		return -EINVAL;
> +	value++;
> 
>  	for (j = 0; j < entries; j++) {
>  		of_read_drc_info_cell(&info, &value, &drc);
> 
