Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40r6QS1kMtzDqnw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 06:17:52 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4MKEDiR002774
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 16:17:49 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2j4r22wm3r-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 16:17:49 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 22 May 2018 14:17:47 -0600
Subject: Re: [RFC v5 2/6] powerpc/cpu: Conditionally acquire/release DRC index
To: Michael Bringmann <mwb@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: John Allen <jallen@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
References: <70c6aae1-6f91-45d5-361b-0d066101d3d0@linux.vnet.ibm.com>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Tue, 22 May 2018 15:17:38 -0500
MIME-Version: 1.0
In-Reply-To: <70c6aae1-6f91-45d5-361b-0d066101d3d0@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <f1b2b32c-d8bb-4e25-6272-1fc41ffe1502@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/21/2018 12:52 PM, Michael Bringmann wrote:
> powerpc/cpu: Modify dlpar_cpu_add and dlpar_cpu_remove to allow the
> skipping of DRC index acquire or release operations during the CPU
> add or remove operations.  This is intended to support subsequent
> changes to provide a 'CPU readd' operation.
> 
> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/hotplug-cpu.c |   71 +++++++++++++++-----------
>  1 file changed, 42 insertions(+), 29 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> index a408217..ec78cc6 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> @@ -474,7 +474,7 @@ static bool valid_cpu_drc_index(struct device_node *parent, u32 drc_index)
>  				&cdata);
>  }
> 
> -static ssize_t dlpar_cpu_add(u32 drc_index)
> +static ssize_t dlpar_cpu_add(u32 drc_index, bool acquire_drc)
>  {
>  	struct device_node *dn, *parent;
>  	int rc, saved_rc;
> @@ -499,19 +499,22 @@ static ssize_t dlpar_cpu_add(u32 drc_index)
>  		return -EINVAL;
>  	}
> 
> -	rc = dlpar_acquire_drc(drc_index);
> -	if (rc) {
> -		pr_warn("Failed to acquire DRC, rc: %d, drc index: %x\n",
> -			rc, drc_index);
> -		of_node_put(parent);
> -		return -EINVAL;
> +	if (acquire_drc) {
> +		rc = dlpar_acquire_drc(drc_index);
> +		if (rc) {
> +			pr_warn("Failed to acquire DRC, rc: %d, drc index: %x\n",
> +				rc, drc_index);
> +			of_node_put(parent);
> +			return -EINVAL;
> +		}
>  	}
> 
>  	dn = dlpar_configure_connector(cpu_to_be32(drc_index), parent);
>  	if (!dn) {
>  		pr_warn("Failed call to configure-connector, drc index: %x\n",
>  			drc_index);
> -		dlpar_release_drc(drc_index);
> +		if (acquire_drc)
> +			dlpar_release_drc(drc_index);
>  		of_node_put(parent);
>  		return -EINVAL;
>  	}
> @@ -526,8 +529,9 @@ static ssize_t dlpar_cpu_add(u32 drc_index)
>  		pr_warn("Failed to attach node %s, rc: %d, drc index: %x\n",
>  			dn->name, rc, drc_index);
> 
> -		rc = dlpar_release_drc(drc_index);
> -		if (!rc)
> +		if (acquire_drc)
> +			rc = dlpar_release_drc(drc_index);
> +		if (!rc || acquire_drc)
>  			dlpar_free_cc_nodes(dn);
> 
>  		return saved_rc;
> @@ -540,7 +544,7 @@ static ssize_t dlpar_cpu_add(u32 drc_index)
>  			dn->name, rc, drc_index);
> 
>  		rc = dlpar_detach_node(dn);
> -		if (!rc)
> +		if (!rc && acquire_drc)
>  			dlpar_release_drc(drc_index);
> 
>  		return saved_rc;
> @@ -608,7 +612,8 @@ static int dlpar_offline_cpu(struct device_node *dn)
> 
>  }
> 
> -static ssize_t dlpar_cpu_remove(struct device_node *dn, u32 drc_index)
> +static ssize_t dlpar_cpu_remove(struct device_node *dn, u32 drc_index,
> +				bool release_drc)
>  {
>  	int rc;
> 
> @@ -621,12 +626,14 @@ static ssize_t dlpar_cpu_remove(struct device_node *dn, u32 drc_index)
>  		return -EINVAL;
>  	}
> 
> -	rc = dlpar_release_drc(drc_index);
> -	if (rc) {
> -		pr_warn("Failed to release drc (%x) for CPU %s, rc: %d\n",
> -			drc_index, dn->name, rc);
> -		dlpar_online_cpu(dn);
> -		return rc;
> +	if (release_drc) {
> +		rc = dlpar_release_drc(drc_index);
> +		if (rc) {
> +			pr_warn("Failed to release drc (%x) for CPU %s, rc: %d\n",
> +				drc_index, dn->name, rc);
> +			dlpar_online_cpu(dn);
> +			return rc;
> +		}
>  	}
> 
>  	rc = dlpar_detach_node(dn);
> @@ -635,7 +642,10 @@ static ssize_t dlpar_cpu_remove(struct device_node *dn, u32 drc_index)
> 
>  		pr_warn("Failed to detach CPU %s, rc: %d", dn->name, rc);
> 
> -		rc = dlpar_acquire_drc(drc_index);
> +		if (release_drc)
> +			rc = dlpar_acquire_drc(drc_index);
> +		else
> +			rc = 0;
>  		if (!rc)
>  			dlpar_online_cpu(dn);
> 
> @@ -664,7 +674,7 @@ static struct device_node *cpu_drc_index_to_dn(u32 drc_index)
>  	return dn;
>  }
> 
> -static int dlpar_cpu_remove_by_index(u32 drc_index)
> +static int dlpar_cpu_remove_by_index(u32 drc_index, bool release_drc)
>  {
>  	struct device_node *dn;
>  	int rc;
> @@ -676,7 +686,7 @@ static int dlpar_cpu_remove_by_index(u32 drc_index)
>  		return -ENODEV;
>  	}
> 
> -	rc = dlpar_cpu_remove(dn, drc_index);
> +	rc = dlpar_cpu_remove(dn, drc_index, release_drc);
>  	of_node_put(dn);
>  	return rc;
>  }
> @@ -741,7 +751,7 @@ static int dlpar_cpu_remove_by_count(u32 cpus_to_remove)
>  	}
> 
>  	for (i = 0; i < cpus_to_remove; i++) {
> -		rc = dlpar_cpu_remove_by_index(cpu_drcs[i]);
> +		rc = dlpar_cpu_remove_by_index(cpu_drcs[i], true);
>  		if (rc)
>  			break;
> 
> @@ -752,7 +762,7 @@ static int dlpar_cpu_remove_by_count(u32 cpus_to_remove)
>  		pr_warn("CPU hot-remove failed, adding back removed CPUs\n");
> 
>  		for (i = 0; i < cpus_removed; i++)
> -			dlpar_cpu_add(cpu_drcs[i]);
> +			dlpar_cpu_add(cpu_drcs[i], true);
> 
>  		rc = -EINVAL;
>  	} else {
> @@ -843,7 +853,7 @@ static int dlpar_cpu_add_by_count(u32 cpus_to_add)
>  	}
> 
>  	for (i = 0; i < cpus_to_add; i++) {
> -		rc = dlpar_cpu_add(cpu_drcs[i]);
> +		rc = dlpar_cpu_add(cpu_drcs[i], true);
>  		if (rc)
>  			break;
> 
> @@ -854,7 +864,7 @@ static int dlpar_cpu_add_by_count(u32 cpus_to_add)
>  		pr_warn("CPU hot-add failed, removing any added CPUs\n");
> 
>  		for (i = 0; i < cpus_added; i++)
> -			dlpar_cpu_remove_by_index(cpu_drcs[i]);
> +			dlpar_cpu_remove_by_index(cpu_drcs[i], true);
> 
>  		rc = -EINVAL;
>  	} else {
> @@ -880,7 +890,7 @@ int dlpar_cpu(struct pseries_hp_errorlog *hp_elog)
>  		if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_COUNT)
>  			rc = dlpar_cpu_remove_by_count(count);
>  		else if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_INDEX)
> -			rc = dlpar_cpu_remove_by_index(drc_index);
> +			rc = dlpar_cpu_remove_by_index(drc_index, true);
>  		else
>  			rc = -EINVAL;
>  		break;
> @@ -888,7 +898,7 @@ int dlpar_cpu(struct pseries_hp_errorlog *hp_elog)
>  		if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_COUNT)
>  			rc = dlpar_cpu_add_by_count(count);
>  		else if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_INDEX)
> -			rc = dlpar_cpu_add(drc_index);
> +			rc = dlpar_cpu_add(drc_index, true);
>  		else
>  			rc = -EINVAL;
>  		break;
> @@ -913,7 +923,7 @@ static ssize_t dlpar_cpu_probe(const char *buf, size_t count)
>  	if (rc)
>  		return -EINVAL;
> 
> -	rc = dlpar_cpu_add(drc_index);
> +	rc = dlpar_cpu_add(drc_index, true);
> 
>  	return rc ? rc : count;
>  }
> @@ -934,7 +944,7 @@ static ssize_t dlpar_cpu_release(const char *buf, size_t count)
>  		return -EINVAL;
>  	}
> 
> -	rc = dlpar_cpu_remove(dn, drc_index);
> +	rc = dlpar_cpu_remove(dn, drc_index, true);
>  	of_node_put(dn);
> 
>  	return rc ? rc : count;
> @@ -948,6 +958,9 @@ static int pseries_smp_notifier(struct notifier_block *nb,
>  	struct of_reconfig_data *rd = data;
>  	int err = 0;
> 
> +	if (strcmp(rd->dn->type, "cpu"))
> +		return notifier_from_errno(err);> +

This last change doesn't seem to fit in this patch, should this be a part of a different patch?

-Nathan

>  	switch (action) {
>  	case OF_RECONFIG_ATTACH_NODE:
>  		err = pseries_add_processor(rd->dn);
> 
