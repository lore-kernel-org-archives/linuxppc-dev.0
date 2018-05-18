Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40ndX40cMszF2Fh
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 May 2018 05:29:07 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4IJSwt8114704
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 May 2018 15:29:05 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2j23sru136-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 May 2018 15:29:04 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Fri, 18 May 2018 13:29:04 -0600
Subject: Re: [RFC v4 2/3] powerpc migration/cpu: Associativity & cpu changes
To: Michael Bringmann <mwb@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: John Allen <jallen@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
References: <17dadef4-f7f3-f5b4-8ead-f194dd5cdf2b@linux.vnet.ibm.com>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Fri, 18 May 2018 14:28:58 -0500
MIME-Version: 1.0
In-Reply-To: <17dadef4-f7f3-f5b4-8ead-f194dd5cdf2b@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <1bddc982-3f91-e4b2-4a96-619734ee6bd9@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/17/2018 05:26 PM, Michael Bringmann wrote:
> powerpc migration/cpu: Now apply changes to the associativity of cpus
> for the topology of LPARS in Post Migration events.  Recognize more
> changes to the associativity of memory blocks described by the
> 'cpu' properties when processing the topology of LPARS in Post Migration
> events.  Previous efforts only recognized whether a memory block's
> assignment had changed in the property.  Changes here include:
> 
> * Provide hotplug CPU 'readd by index' operation
> * Checking for changes in cpu associativity and making 'readd' calls
>   when differences are observed.
> * Queue up  changes to CPU properties so that they may take place
>   after all PowerPC device-tree changes have been applied i.e. after
>   the device hotplug is released in the mobility code.

This kinda feels like three different patches in one. any reason to not split
this into three patches? Perhaps at the least split the last item into it's
own patch.

> 
> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
> ---
> Changes include:
>   -- Rearrange patches to co-locate CPU property-related changes.
>   -- Modify dlpar_cpu_add & dlpar_cpu_remove to skip DRC index acquire
>      or release operations during the CPU readd process.
>   -- Correct a bug in DRC index selection for queued operation.
>   -- Rebase to 4.17-rc5 kernel
> ---
>  arch/powerpc/platforms/pseries/hotplug-cpu.c |  123 +++++++++++++++++++-------
>  arch/powerpc/platforms/pseries/mobility.c    |    3 +
>  2 files changed, 95 insertions(+), 31 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> index a408217..23d4cb8 100644
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

This seems like it would be more readable if everything were inside the
if (acquire_drc) block.

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
> @@ -608,12 +612,13 @@ static int dlpar_offline_cpu(struct device_node *dn)
> 
>  }
> 
> -static ssize_t dlpar_cpu_remove(struct device_node *dn, u32 drc_index)
> +static ssize_t dlpar_cpu_remove(struct device_node *dn, u32 drc_index,
> +				bool release_drc)
>  {
>  	int rc;
> 
> -	pr_debug("Attempting to remove CPU %s, drc index: %x\n",
> -		 dn->name, drc_index);
> +	pr_debug("Attempting to remove CPU %s, drc index: %x (%d)\n",
> +		 dn->name, drc_index, release_drc);
> 
>  	rc = dlpar_offline_cpu(dn);
>  	if (rc) {
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
> @@ -635,7 +642,8 @@ static ssize_t dlpar_cpu_remove(struct device_node *dn, u32 drc_index)
> 
>  		pr_warn("Failed to detach CPU %s, rc: %d", dn->name, rc);
> 
> -		rc = dlpar_acquire_drc(drc_index);
> +		if (release_drc)
> +			rc = dlpar_acquire_drc(drc_index);
>  		if (!rc)
>  			dlpar_online_cpu(dn);
> 
> @@ -664,7 +672,7 @@ static struct device_node *cpu_drc_index_to_dn(u32 drc_index)
>  	return dn;
>  }
> 
> -static int dlpar_cpu_remove_by_index(u32 drc_index)
> +static int dlpar_cpu_remove_by_index(u32 drc_index, bool release_drc)
>  {
>  	struct device_node *dn;
>  	int rc;
> @@ -676,10 +684,30 @@ static int dlpar_cpu_remove_by_index(u32 drc_index)
>  		return -ENODEV;
>  	}
> 
> -	rc = dlpar_cpu_remove(dn, drc_index);
> +	rc = dlpar_cpu_remove(dn, drc_index, release_drc);
>  	of_node_put(dn);
>  	return rc;
>  }
> + 
> +static int dlpar_cpu_readd_by_index(u32 drc_index)
> +{
> +	int rc = 0;

No need to initialize to 0 here.

> +
> +	pr_info("Attempting to re-add CPU, drc index %x\n", drc_index);
> +
> +	rc = dlpar_cpu_remove_by_index(drc_index, false);
> +	if (!rc)
> +		rc = dlpar_cpu_add(drc_index, false);
> +
> +	if (rc)
> +		pr_info("Failed to update cpu at drc_index %lx\n",
> +				(unsigned long int)drc_index);
> +	else
> +		pr_info("CPU at drc_index %lx was updated\n",
> +				(unsigned long int)drc_index);
> +
> +	return rc;
> +}
> 
>  static int find_dlpar_cpus_to_remove(u32 *cpu_drcs, int cpus_to_remove)
>  {
> @@ -741,7 +769,7 @@ static int dlpar_cpu_remove_by_count(u32 cpus_to_remove)
>  	}
> 
>  	for (i = 0; i < cpus_to_remove; i++) {
> -		rc = dlpar_cpu_remove_by_index(cpu_drcs[i]);
> +		rc = dlpar_cpu_remove_by_index(cpu_drcs[i], true);
>  		if (rc)
>  			break;
> 
> @@ -752,7 +780,7 @@ static int dlpar_cpu_remove_by_count(u32 cpus_to_remove)
>  		pr_warn("CPU hot-remove failed, adding back removed CPUs\n");
> 
>  		for (i = 0; i < cpus_removed; i++)
> -			dlpar_cpu_add(cpu_drcs[i]);
> +			dlpar_cpu_add(cpu_drcs[i], true);
> 
>  		rc = -EINVAL;
>  	} else {
> @@ -843,7 +871,7 @@ static int dlpar_cpu_add_by_count(u32 cpus_to_add)
>  	}
> 
>  	for (i = 0; i < cpus_to_add; i++) {
> -		rc = dlpar_cpu_add(cpu_drcs[i]);
> +		rc = dlpar_cpu_add(cpu_drcs[i], true);
>  		if (rc)
>  			break;
> 
> @@ -854,7 +882,7 @@ static int dlpar_cpu_add_by_count(u32 cpus_to_add)
>  		pr_warn("CPU hot-add failed, removing any added CPUs\n");
> 
>  		for (i = 0; i < cpus_added; i++)
> -			dlpar_cpu_remove_by_index(cpu_drcs[i]);
> +			dlpar_cpu_remove_by_index(cpu_drcs[i], true);
> 
>  		rc = -EINVAL;
>  	} else {
> @@ -880,7 +908,7 @@ int dlpar_cpu(struct pseries_hp_errorlog *hp_elog)
>  		if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_COUNT)
>  			rc = dlpar_cpu_remove_by_count(count);
>  		else if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_INDEX)
> -			rc = dlpar_cpu_remove_by_index(drc_index);
> +			rc = dlpar_cpu_remove_by_index(drc_index, true);
>  		else
>  			rc = -EINVAL;
>  		break;
> @@ -888,10 +916,13 @@ int dlpar_cpu(struct pseries_hp_errorlog *hp_elog)
>  		if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_COUNT)
>  			rc = dlpar_cpu_add_by_count(count);
>  		else if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_INDEX)
> -			rc = dlpar_cpu_add(drc_index);
> +			rc = dlpar_cpu_add(drc_index, true);
>  		else
>  			rc = -EINVAL;
>  		break;
> +	case PSERIES_HP_ELOG_ACTION_READD:
> +		rc = dlpar_cpu_readd_by_index(drc_index);
> +		break;
>  	default:
>  		pr_err("Invalid action (%d) specified\n", hp_elog->action);
>  		rc = -EINVAL;
> @@ -913,7 +944,7 @@ static ssize_t dlpar_cpu_probe(const char *buf, size_t count)
>  	if (rc)
>  		return -EINVAL;
> 
> -	rc = dlpar_cpu_add(drc_index);
> +	rc = dlpar_cpu_add(drc_index, true);
> 
>  	return rc ? rc : count;
>  }
> @@ -934,7 +965,7 @@ static ssize_t dlpar_cpu_release(const char *buf, size_t count)
>  		return -EINVAL;
>  	}
> 
> -	rc = dlpar_cpu_remove(dn, drc_index);
> +	rc = dlpar_cpu_remove(dn, drc_index, true);
>  	of_node_put(dn);
> 
>  	return rc ? rc : count;
> @@ -942,12 +973,38 @@ static ssize_t dlpar_cpu_release(const char *buf, size_t count)
> 
>  #endif /* CONFIG_ARCH_CPU_PROBE_RELEASE */
> 
> +static int pseries_update_cpu(struct of_reconfig_data *pr)
> +{
> +	/* So far, we only handle the 'ibm,associativity' property,
> +	 * here.
> +	 */
> +	struct pseries_hp_errorlog *hp_elog;
> +
> +        hp_elog = kzalloc(sizeof(*hp_elog), GFP_KERNEL);
> +        if(!hp_elog)
> +                return -ENOMEM;

You seem to have some odd indentation here, may want to run this through checkpatch

Also, I think queue_hotplug_event() makes a copy of the hotplug event passed in. If
so you could just use a hp_elog struct on the stack and avoid the allocation.

-Nathan

> +
> +	hp_elog->resource = PSERIES_HP_ELOG_RESOURCE_CPU;
> +	hp_elog->action = PSERIES_HP_ELOG_ACTION_READD;
> +	hp_elog->id_type = PSERIES_HP_ELOG_ID_DRC_INDEX;
> +	hp_elog->_drc_u.drc_index = be32_to_cpu(pr->dn->phandle);
> +
> +	queue_hotplug_event(hp_elog, NULL, NULL);
> +
> +	kfree(hp_elog);
> +
> +	return 0;
> +}
> +
>  static int pseries_smp_notifier(struct notifier_block *nb,
>  				unsigned long action, void *data)
>  {
>  	struct of_reconfig_data *rd = data;
>  	int err = 0;
> 
> +	if (strcmp(rd->dn->type, "cpu"))
> +		return notifier_from_errno(err);
> +
>  	switch (action) {
>  	case OF_RECONFIG_ATTACH_NODE:
>  		err = pseries_add_processor(rd->dn);
> @@ -955,6 +1012,10 @@ static int pseries_smp_notifier(struct notifier_block *nb,
>  	case OF_RECONFIG_DETACH_NODE:
>  		pseries_remove_processor(rd->dn);
>  		break;
> +	case OF_RECONFIG_UPDATE_PROPERTY:
> +		if (!strcmp(rd->prop->name, "ibm,associativity"))
> +			err = pseries_update_cpu(rd);
> +		break;
>  	}
>  	return notifier_from_errno(err);
>  }
> diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
> index 8a8033a..6d98f84 100644
> --- a/arch/powerpc/platforms/pseries/mobility.c
> +++ b/arch/powerpc/platforms/pseries/mobility.c
> @@ -283,6 +283,8 @@ int pseries_devicetree_update(s32 scope)
>  	if (!rtas_buf)
>  		return -ENOMEM;
> 
> +	lock_device_hotplug();
> +
>  	do {
>  		rc = mobility_rtas_call(update_nodes_token, rtas_buf, scope);
>  		if (rc && rc != 1)
> @@ -321,6 +323,7 @@ int pseries_devicetree_update(s32 scope)
>  	} while (rc == 1);
> 
>  	kfree(rtas_buf);
> +	unlock_device_hotplug();
>  	return rc;
>  }
> 
