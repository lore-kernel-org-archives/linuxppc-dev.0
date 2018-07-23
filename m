Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Z82T0rWxzDqrX
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2018 03:42:24 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6NHd8RI040391
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jul 2018 13:42:22 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kdkgtgdbn-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jul 2018 13:42:22 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 23 Jul 2018 13:42:20 -0400
Subject: Re: [PATCH v07 1/9] hotplug/cpu: Conditionally acquire/release DRC
 index
To: Michael Bringmann <mwb@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: John Allen <jallen@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
References: <a7e202c1-177f-db1b-912f-8773a551feec@linux.vnet.ibm.com>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 12:42:14 -0500
MIME-Version: 1.0
In-Reply-To: <a7e202c1-177f-db1b-912f-8773a551feec@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <a7e92a8f-2bb9-95e7-78ca-b7440f80c7f7@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/13/2018 03:17 PM, Michael Bringmann wrote:
> powerpc/cpu: Modify dlpar_cpu_add and dlpar_cpu_remove to allow the
> skipping of DRC index acquire or release operations during the CPU
> add or remove operations.  This is intended to support subsequent
> changes to provide a 'CPU readd' operation.
> 
> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
> ---
> Changes in patch:
>    -- Move new validity check added to pseries_smp_notifier
>       to another patch
>    -- Revise one of checks for 'acquire_drc' in dlpar_cpu_add.
>    -- Revise one of checks for 'release_drc' in dlpar_cpu_remove.
> ---
>   arch/powerpc/platforms/pseries/hotplug-cpu.c |   71 +++++++++++++++-----------
>   1 file changed, 40 insertions(+), 31 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> index 6ef77ca..7ede3b0 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> @@ -432,7 +432,7 @@ static bool valid_cpu_drc_index(struct device_node *parent, u32 drc_index)
>   	return found;
>   }
> 
> -static ssize_t dlpar_cpu_add(u32 drc_index)
> +static ssize_t dlpar_cpu_add(u32 drc_index, bool acquire_drc)
>   {
>   	struct device_node *dn, *parent;
>   	int rc, saved_rc;
> @@ -457,19 +457,22 @@ static ssize_t dlpar_cpu_add(u32 drc_index)
>   		return -EINVAL;
>   	}
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
>   	}
> 
>   	dn = dlpar_configure_connector(cpu_to_be32(drc_index), parent);
>   	if (!dn) {
>   		pr_warn("Failed call to configure-connector, drc index: %x\n",
>   			drc_index);
> -		dlpar_release_drc(drc_index);
> +		if (acquire_drc)
> +			dlpar_release_drc(drc_index);
>   		of_node_put(parent);
>   		return -EINVAL;
>   	}
> @@ -484,9 +487,11 @@ static ssize_t dlpar_cpu_add(u32 drc_index)
>   		pr_warn("Failed to attach node %s, rc: %d, drc index: %x\n",
>   			dn->name, rc, drc_index);
> 
> -		rc = dlpar_release_drc(drc_index);
> -		if (!rc)
> -			dlpar_free_cc_nodes(dn);
> +		if (acquire_drc) {
> +			rc = dlpar_release_drc(drc_index);
> +			if (!rc)
> +				dlpar_free_cc_nodes(dn);
> +		}
> 
>   		return saved_rc;
>   	}
> @@ -498,7 +503,7 @@ static ssize_t dlpar_cpu_add(u32 drc_index)
>   			dn->name, rc, drc_index);
> 
>   		rc = dlpar_detach_node(dn);
> -		if (!rc)
> +		if (!rc && acquire_drc)
>   			dlpar_release_drc(drc_index);
> 
>   		return saved_rc;
> @@ -566,7 +571,8 @@ static int dlpar_offline_cpu(struct device_node *dn)
> 
>   }
> 
> -static ssize_t dlpar_cpu_remove(struct device_node *dn, u32 drc_index)
> +static ssize_t dlpar_cpu_remove(struct device_node *dn, u32 drc_index,
> +				bool release_drc)
>   {
>   	int rc;
> 
> @@ -579,12 +585,14 @@ static ssize_t dlpar_cpu_remove(struct device_node *dn, u32 drc_index)
>   		return -EINVAL;
>   	}
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
>   	}
> 
>   	rc = dlpar_detach_node(dn);
> @@ -593,8 +601,9 @@ static ssize_t dlpar_cpu_remove(struct device_node *dn, u32 drc_index)
> 
>   		pr_warn("Failed to detach CPU %s, rc: %d", dn->name, rc);
> 
> -		rc = dlpar_acquire_drc(drc_index);
> -		if (!rc)
> +		if (release_drc)
> +			rc = dlpar_acquire_drc(drc_index);
> +		if (!release_drc || !rc)
>   			dlpar_online_cpu(dn);

This is likely wrong. At this point you're in a if (rc) so rc is already
non-zero. If release_drc is false this checks an invalid rc state.

-Nathan

> 
>   		return saved_rc;
> @@ -622,7 +631,7 @@ static struct device_node *cpu_drc_index_to_dn(u32 drc_index)
>   	return dn;
>   }
> 
> -static int dlpar_cpu_remove_by_index(u32 drc_index)
> +static int dlpar_cpu_remove_by_index(u32 drc_index, bool release_drc)
>   {
>   	struct device_node *dn;
>   	int rc;
> @@ -634,7 +643,7 @@ static int dlpar_cpu_remove_by_index(u32 drc_index)
>   		return -ENODEV;
>   	}
> 
> -	rc = dlpar_cpu_remove(dn, drc_index);
> +	rc = dlpar_cpu_remove(dn, drc_index, release_drc);
>   	of_node_put(dn);
>   	return rc;
>   }
> @@ -699,7 +708,7 @@ static int dlpar_cpu_remove_by_count(u32 cpus_to_remove)
>   	}
> 
>   	for (i = 0; i < cpus_to_remove; i++) {
> -		rc = dlpar_cpu_remove_by_index(cpu_drcs[i]);
> +		rc = dlpar_cpu_remove_by_index(cpu_drcs[i], true);
>   		if (rc)
>   			break;
> 
> @@ -710,7 +719,7 @@ static int dlpar_cpu_remove_by_count(u32 cpus_to_remove)
>   		pr_warn("CPU hot-remove failed, adding back removed CPUs\n");
> 
>   		for (i = 0; i < cpus_removed; i++)
> -			dlpar_cpu_add(cpu_drcs[i]);
> +			dlpar_cpu_add(cpu_drcs[i], true);
> 
>   		rc = -EINVAL;
>   	} else {
> @@ -780,7 +789,7 @@ static int dlpar_cpu_add_by_count(u32 cpus_to_add)
>   	}
> 
>   	for (i = 0; i < cpus_to_add; i++) {
> -		rc = dlpar_cpu_add(cpu_drcs[i]);
> +		rc = dlpar_cpu_add(cpu_drcs[i], true);
>   		if (rc)
>   			break;
> 
> @@ -791,7 +800,7 @@ static int dlpar_cpu_add_by_count(u32 cpus_to_add)
>   		pr_warn("CPU hot-add failed, removing any added CPUs\n");
> 
>   		for (i = 0; i < cpus_added; i++)
> -			dlpar_cpu_remove_by_index(cpu_drcs[i]);
> +			dlpar_cpu_remove_by_index(cpu_drcs[i], true);
> 
>   		rc = -EINVAL;
>   	} else {
> @@ -817,7 +826,7 @@ int dlpar_cpu(struct pseries_hp_errorlog *hp_elog)
>   		if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_COUNT)
>   			rc = dlpar_cpu_remove_by_count(count);
>   		else if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_INDEX)
> -			rc = dlpar_cpu_remove_by_index(drc_index);
> +			rc = dlpar_cpu_remove_by_index(drc_index, true);
>   		else
>   			rc = -EINVAL;
>   		break;
> @@ -825,7 +834,7 @@ int dlpar_cpu(struct pseries_hp_errorlog *hp_elog)
>   		if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_COUNT)
>   			rc = dlpar_cpu_add_by_count(count);
>   		else if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_INDEX)
> -			rc = dlpar_cpu_add(drc_index);
> +			rc = dlpar_cpu_add(drc_index, true);
>   		else
>   			rc = -EINVAL;
>   		break;
> @@ -850,7 +859,7 @@ static ssize_t dlpar_cpu_probe(const char *buf, size_t count)
>   	if (rc)
>   		return -EINVAL;
> 
> -	rc = dlpar_cpu_add(drc_index);
> +	rc = dlpar_cpu_add(drc_index, true);
> 
>   	return rc ? rc : count;
>   }
> @@ -871,7 +880,7 @@ static ssize_t dlpar_cpu_release(const char *buf, size_t count)
>   		return -EINVAL;
>   	}
> 
> -	rc = dlpar_cpu_remove(dn, drc_index);
> +	rc = dlpar_cpu_remove(dn, drc_index, true);
>   	of_node_put(dn);
> 
>   	return rc ? rc : count;
> 
