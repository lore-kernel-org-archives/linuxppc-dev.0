Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40VxR12RkVzF24D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2018 07:33:45 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3OLWqu6073602
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Apr 2018 17:33:43 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hj7kfdpdr-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Apr 2018 17:33:42 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Tue, 24 Apr 2018 15:33:42 -0600
Subject: Re: [RFC v2 1/3] hotplug/mobility: Apply assoc updates for Post
 Migration Topo
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: John Allen <jallen@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
References: <54713533-2d91-60f0-5901-02b41a2b948d@linux.vnet.ibm.com>
 <c2207993-e618-9192-b79e-c5519afdff1b@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Date: Tue, 24 Apr 2018 16:33:37 -0500
MIME-Version: 1.0
In-Reply-To: <c2207993-e618-9192-b79e-c5519afdff1b@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <2b3e4948-a21b-423b-fa74-f4ae3ebd5978@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

See comments below:

On 04/24/2018 11:56 AM, Nathan Fontenot wrote:
> On 02/26/2018 02:52 PM, Michael Bringmann wrote:
>> hotplug/mobility: Recognize more changes to the associativity of
>> memory blocks described by the 'ibm,dynamic-memory' and 'cpu'
>> properties when processing the topology of LPARS in Post Migration
>> events.  Previous efforts only recognized whether a memory block's
>> assignment had changed in the property.  Changes here include:
>>
>> * Checking the aa_index values of the old/new properties and 'readd'
>>   any block for which the setting has changed.
>> * Checking for changes in cpu associativity and making 'readd' calls
>>   when differences are observed.
> 
> As part of the post-migration updates do you need to hold a lock
> so that we don't attempt to process any of the cpu/memory changes
> while the device tree is being updated?
> 
> You may be able to grab the device hotplug lock for this.

The CPU Re-add process reuses the dlpar_cpu_remove / dlpar_cpu_add
code for POWERPC.  These functions end up invoking device_online() /
device_offline() which in turn end up invoking the 'cpus_write_lock/unlock'
around every kernel change to the CPU structures.  It was modeled
on the Memory Re-add process as we discussed a while back, which
also uses device_online and a corresponding write lock for each
LMB processed.

Do you see a need for a coarser granularity of locking around
all or a group of the cpu/memory changes?  The data structures
that the kernel outside of powerpc uses for CPUs and LMBs seem
to be quite well isolated from the device-tree properties.

> 
>>
>> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
>> ---
>> Changes in RFC:
>>   -- Simplify code to update CPU nodes during mobility checks.
>>      Remove functions to generate extra HP_ELOG messages in favor
>>      of direct function calls to dlpar_cpu_readd_by_index.
>>   -- Move check for "cpu" node type from pseries_update_cpu to
>>      pseries_smp_notifier in 'hotplug-cpu.c'
>>   -- Remove functions 'pseries_memory_readd_by_index' and
>>      'pseries_cpu_readd_by_index' as no longer needed outside of
>>      'mobility.c'.
>> ---
>>  arch/powerpc/platforms/pseries/hotplug-cpu.c    |   69 +++++++++++++++++++++++
>>  arch/powerpc/platforms/pseries/hotplug-memory.c |    6 ++
>>  2 files changed, 75 insertions(+)
>>
>> diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
>> index a7d14aa7..91ef22a 100644
>> --- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
>> +++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
>> @@ -636,6 +636,27 @@ static int dlpar_cpu_remove_by_index(u32 drc_index)
>>  	return rc;
>>  }
>>
>> +static int dlpar_cpu_readd_by_index(u32 drc_index)
>> +{
>> +	int rc = 0;
>> +
>> +	pr_info("Attempting to update CPU, drc index %x\n", drc_index);
> 
> Should make this say we are re-adding the CPU, it's a bit more specific as
> to what is really happening.

Okay.  I will update the notice from dlpar_memory_readd_by_index, as well.
> 
>> +
>> +	if (dlpar_cpu_remove_by_index(drc_index))
>> +		rc = -EINVAL;
>> +	else if (dlpar_cpu_add(drc_index))
>> +		rc = -EINVAL;
>> +
>> +	if (rc)
>> +		pr_info("Failed to update cpu at drc_index %lx\n",
>> +				(unsigned long int)drc_index);
>> +	else
>> +		pr_info("CPU at drc_index %lx was updated\n",
>> +				(unsigned long int)drc_index);
>> +
>> +	return rc;
>> +}
>> +
>>  static int find_dlpar_cpus_to_remove(u32 *cpu_drcs, int cpus_to_remove)
>>  {
>>  	struct device_node *dn;
>> @@ -826,6 +847,9 @@ int dlpar_cpu(struct pseries_hp_errorlog *hp_elog)
>>  		else
>>  			rc = -EINVAL;
>>  		break;
>> +	case PSERIES_HP_ELOG_ACTION_READD:
>> +		rc = dlpar_cpu_readd_by_index(drc_index);
>> +		break;
>>  	default:
>>  		pr_err("Invalid action (%d) specified\n", hp_elog->action);
>>  		rc = -EINVAL;
>> @@ -876,12 +900,53 @@ static ssize_t dlpar_cpu_release(const char *buf, size_t count)
>>
>>  #endif /* CONFIG_ARCH_CPU_PROBE_RELEASE */
>>
>> +static int pseries_update_cpu(struct of_reconfig_data *pr)
>> +{
>> +	u32 old_entries, new_entries;
>> +	__be32 *p, *old_assoc, *new_assoc;
>> +	int rc = 0;
>> +
>> +	/* So far, we only handle the 'ibm,associativity' property,
>> +	 * here.
>> +	 * The first int of the property is the number of domains
>> +	 * described.  This is followed by an array of level values.
>> +	 */
>> +	p = (__be32 *) pr->old_prop->value;
>> +	if (!p)
>> +		return -EINVAL;
>> +	old_entries = be32_to_cpu(*p++);
>> +	old_assoc = p;
>> +
>> +	p = (__be32 *)pr->prop->value;
>> +	if (!p)
>> +		return -EINVAL;
>> +	new_entries = be32_to_cpu(*p++);
>> +	new_assoc = p;
>> +
>> +	if (old_entries == new_entries) {
>> +		int sz = old_entries * sizeof(int);
>> +
>> +		if (!memcmp(old_assoc, new_assoc, sz))
>> +			rc = dlpar_cpu_readd_by_index(
>> +					be32_to_cpu(pr->dn->phandle));
>> +
>> +	} else {
>> +		rc = dlpar_cpu_readd_by_index(
>> +					be32_to_cpu(pr->dn->phandle));
>> +	}
>> +
>> +	return rc;
>> +}
> 
> Do we need to do the full compare of the new vs. the old affinity property?
> 
> I would think we would only get an updated property if the property changes.
> We don't care what changes in the property at this point, only that it changed.
> You could just call dlpar_cpu_readd_by_index() directly.

Okay.

> 
> -Nathan

Thanks.
Michael

> 
>> +
>>  static int pseries_smp_notifier(struct notifier_block *nb,
>>  				unsigned long action, void *data)
>>  {
>>  	struct of_reconfig_data *rd = data;
>>  	int err = 0;
>>
>> +	if (strcmp(rd->dn->type, "cpu"))
>> +		return notifier_from_errno(err);
>> +
>>  	switch (action) {
>>  	case OF_RECONFIG_ATTACH_NODE:
>>  		err = pseries_add_processor(rd->dn);
>> @@ -889,6 +954,10 @@ static int pseries_smp_notifier(struct notifier_block *nb,
>>  	case OF_RECONFIG_DETACH_NODE:
>>  		pseries_remove_processor(rd->dn);
>>  		break;
>> +	case OF_RECONFIG_UPDATE_PROPERTY:
>> +		if (!strcmp(rd->prop->name, "ibm,associativity"))
>> +			err = pseries_update_cpu(rd);
>> +		break;
>>  	}
>>  	return notifier_from_errno(err);
>>  }
>> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
>> index c1578f5..2341eae 100644
>> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
>> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
>> @@ -1040,6 +1040,12 @@ static int pseries_update_drconf_memory(struct of_reconfig_data *pr)
>>  					  memblock_size);
>>  			rc = (rc < 0) ? -EINVAL : 0;
>>  			break;
>> +		} else if ((be32_to_cpu(old_drmem[i].aa_index) !=
>> +					be32_to_cpu(new_drmem[i].aa_index)) &&
>> +				(be32_to_cpu(new_drmem[i].flags) &
>> +					DRCONF_MEM_ASSIGNED)) {
>> +			rc = dlpar_memory_readd_by_index(
>> +				be32_to_cpu(new_drmem[i].drc_index))>  		}
>>  	}
>>  	return rc;
>>
> 

-- 
Michael W. Bringmann
Linux Technology Center
IBM Corporation
Tie-Line  363-5196
External: (512) 286-5196
Cell:       (512) 466-0650
mwb@linux.vnet.ibm.com
