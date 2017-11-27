Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ylyBj3NH8zDr8d
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Nov 2017 06:52:44 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vARJnsH3141104
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Nov 2017 14:52:42 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2egnadbucy-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Nov 2017 14:52:41 -0500
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Mon, 27 Nov 2017 12:52:41 -0700
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 vARJqdUV5964220
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Nov 2017 12:52:39 -0700
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0DEFB6E038
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Nov 2017 12:52:39 -0700 (MST)
Received: from oc2832402873.ibm.com (unknown [9.53.92.243])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP id CA7396E035
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Nov 2017 12:52:38 -0700 (MST)
Subject: Re: [PATCH V2 1/3] hotplug/mobility: Apply assoc updates for Post
 Migration Topo
To: linuxppc-dev@lists.ozlabs.org
References: <75fbca5e-f06a-f143-b420-8eb52859b230@linux.vnet.ibm.com>
 <55cefe5f-962a-5a0b-70ac-f62451e1ade1@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Date: Mon, 27 Nov 2017 13:52:38 -0600
MIME-Version: 1.0
In-Reply-To: <55cefe5f-962a-5a0b-70ac-f62451e1ade1@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <1a856810-fbfc-7a77-b2d9-dc5e5a959df7@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

See below.

On 11/20/2017 10:04 AM, Nathan Fontenot wrote:
> On 11/16/2017 11:50 AM, Michael Bringmann wrote:
>> hotplug/mobility: Recognize more changes to the associativity of
>> memory blocks described by the 'ibm,dynamic-memory' and 'cpu'
>> properties when processing the topology of LPARS in Post Migration
>> events.  Previous efforts only recognized whether a memory block's
>> assignment had changed in the property.  Changes here include:
>>
>> * Checking the aa_index values of the old/new properties and 'readd'
>>   any block for which the setting has changed.
>> * Checking for changes in cpus and submitting 'readd' ops for them.
>> * Creating some common support routines for the submission of memory
>>   or cpu 'readd' operations.
>>
>> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
>> ---
>> Changes in V2:
>>   -- Try to improve patch header documentation.
>> ---
>>  arch/powerpc/platforms/pseries/hotplug-cpu.c    |   64 +++++++++++++++++++++++
>>  arch/powerpc/platforms/pseries/hotplug-memory.c |    6 ++
>>  arch/powerpc/platforms/pseries/mobility.c       |   47 +++++++++++++----
>>  arch/powerpc/platforms/pseries/pseries.h        |    2 +
>>  4 files changed, 109 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
>> index fadb95e..d127c3a 100644
>> --- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
>> +++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
>> @@ -634,6 +634,27 @@ static int dlpar_cpu_remove_by_index(u32 drc_index)
>>  	return rc;
>>  }
>>
>> +static int dlpar_cpu_readd_by_index(u32 drc_index)
>> +{
>> +	int rc = 0;
>> +
>> +	pr_info("Attempting to update CPU, drc index %x\n", drc_index);
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
>> @@ -824,6 +845,9 @@ int dlpar_cpu(struct pseries_hp_errorlog *hp_elog)
>>  		else
>>  			rc = -EINVAL;
>>  		break;
>> +	case PSERIES_HP_ELOG_ACTION_READD:
>> +		rc = dlpar_cpu_readd_by_index(drc_index);
>> +		break;
>>  	default:
>>  		pr_err("Invalid action (%d) specified\n", hp_elog->action);
>>  		rc = -EINVAL;
>> @@ -874,6 +898,42 @@ static ssize_t dlpar_cpu_release(const char *buf, size_t count)
>>
>>  #endif /* CONFIG_ARCH_CPU_PROBE_RELEASE */
>>
>> +static int pseries_update_drconf_cpu(struct of_reconfig_data *pr)
> 
> I think we can drop the 'drconf' piece from this function name.
> 
> I'm think you got that from the memory routines that use drconf, which
> is really short for dynamic reconfiguration. This was used to state the
> routine worked on memory represented in the dynamic-reconfiguration 
> properties.

Okay.

> 
>> +{
>> +	u32 old_entries, new_entries;
>> +	__be32 *p, *old_assoc, *new_assoc;
>> +
>> +	if (strcmp(pr->dn->type, "cpu"))
>> +		return 0;
>> +
>> +	/* The first int of the property is the number of domains's
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
>> +			pseries_cpu_readd_by_index(pr->dn->phandle);
>> +
>> +	} else {
>> +		pseries_cpu_readd_by_index(pr->dn->phandle);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>  static int pseries_smp_notifier(struct notifier_block *nb,
>>  				unsigned long action, void *data)
>>  {
>> @@ -887,6 +947,10 @@ static int pseries_smp_notifier(struct notifier_block *nb,
>>  	case OF_RECONFIG_DETACH_NODE:
>>  		pseries_remove_processor(rd->dn);
>>  		break;
>> +	case OF_RECONFIG_UPDATE_PROPERTY:
>> +		if (!strcmp(rd->prop->name, "ibm,associativity"))
>> +			err = pseries_update_drconf_cpu(rd);
>> +		break;
>>  	}
>>  	return notifier_from_errno(err);
>>  }
>> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
>> index 1d48ab4..c61cfc6 100644
>> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
>> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
>> @@ -1160,6 +1160,12 @@ static int pseries_update_drconf_memory(struct of_reconfig_data *pr)
>>  					  memblock_size);
>>  			rc = (rc < 0) ? -EINVAL : 0;
>>  			break;
>> +		} else if ((be32_to_cpu(old_drmem[i].aa_index) !=
>> +					be32_to_cpu(new_drmem[i].aa_index)) &&
>> +				(be32_to_cpu(new_drmem[i].flags) &
>> +					DRCONF_MEM_ASSIGNED)) {
>> +			pseries_memory_readd_by_index(
>> +				be32_to_cpu(new_drmem[i].drc_index));
>>  		}
>>  	}
>>  	return rc;
>> diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
>> index f7042ad..7c19b23 100644
>> --- a/arch/powerpc/platforms/pseries/mobility.c
>> +++ b/arch/powerpc/platforms/pseries/mobility.c
>> @@ -239,9 +239,30 @@ static int add_dt_node(__be32 parent_phandle, __be32 drc_index)
>>  	return rc;
>>  }
>>
>> +static void pseries_readd_by_index(int resource, __be32 phandle)
>> +{
>> +	struct pseries_hp_errorlog hp_elog;
>> +
>> +	hp_elog.resource = resource;
>> +	hp_elog.action = PSERIES_HP_ELOG_ACTION_READD;
>> +	hp_elog.id_type = PSERIES_HP_ELOG_ID_DRC_INDEX;
>> +	hp_elog._drc_u.drc_index = phandle;
>> +
>> +	queue_hotplug_event(&hp_elog, NULL, NULL);
>> +}
>> +
>> +void pseries_memory_readd_by_index(__be32 phandle)
>> +{
>> +	pseries_readd_by_index(PSERIES_HP_ELOG_RESOURCE_MEM, phandle);
>> +}
>> +
>> +void pseries_cpu_readd_by_index(__be32 phandle)
>> +{
>> +	pseries_readd_by_index(PSERIES_HP_ELOG_RESOURCE_CPU, phandle);
>> +}
>> +
>>  static void prrn_update_node(__be32 phandle)
>>  {
>> -	struct pseries_hp_errorlog *hp_elog;
>>  	struct device_node *dn;
>>
>>  	/*
>> @@ -254,18 +275,21 @@ static void prrn_update_node(__be32 phandle)
>>  		return;
>>  	}
>>
>> -	hp_elog = kzalloc(sizeof(*hp_elog), GFP_KERNEL);
>> -	if(!hp_elog)
>> -		return;
>> +	pseries_memory_readd_by_index(phandle);
>> +}
>>
>> -	hp_elog->resource = PSERIES_HP_ELOG_RESOURCE_MEM;
>> -	hp_elog->action = PSERIES_HP_ELOG_ACTION_READD;
>> -	hp_elog->id_type = PSERIES_HP_ELOG_ID_DRC_INDEX;
>> -	hp_elog->_drc_u.drc_index = phandle;
>> +static void prrn_update_node_other(s32 scope, __be32 phandle)
>> +{
>> +	struct device_node *dn;
>> +	__be32 drc_index = be32_to_cpu(phandle);
>>
>> -	queue_hotplug_event(hp_elog, NULL, NULL);
>> +	dn = of_find_node_by_phandle(drc_index);
>> +	if (dn) {
>> +		of_node_put(dn);
>>
>> -	kfree(hp_elog);
>> +		if (!strcmp(dn->type, "cpu"))
>> +			pseries_cpu_readd_by_index(phandle);
>> +	}
>>  }
>>
>>  int pseries_devicetree_update(s32 scope)
>> @@ -309,6 +333,9 @@ int pseries_devicetree_update(s32 scope)
>>
>>  					if (scope == PRRN_SCOPE)
>>  						prrn_update_node(phandle);
>> +					else
>> +						prrn_update_node_other(
>> +							scope, phandle);
> 
> I'm not sure I follow what you're doing here.
> 
> This call appears to do a re-add of a CPU for any CPU that has the node updated.
> We don't need to do a re-add of the CPU if the affinity of the CPU has not changed.
> 
> You already have a check for that in the update to pseries_smp_notifier()
> above when you add the check for updates to the affinity property. So I don't
> see why this is needed here.
> 
> -Nathan

I will need to retest this patch with the suggested change.

- Michael

> 
>>
>>  					break;
>>  				case ADD_DT_NODE:
>> diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
>> index 4470a31..b9a69a6 100644
>> --- a/arch/powerpc/platforms/pseries/pseries.h
>> +++ b/arch/powerpc/platforms/pseries/pseries.h
>> @@ -55,6 +55,7 @@ void queue_hotplug_event(struct pseries_hp_errorlog *hp_errlog,
>>  			 struct completion *hotplug_done, int *rc);
>>  #ifdef CONFIG_MEMORY_HOTPLUG
>>  int dlpar_memory(struct pseries_hp_errorlog *hp_elog);
>> +extern void pseries_memory_readd_by_index(__be32 drc_index);
>>  #else
>>  static inline int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
>>  {
>> @@ -64,6 +65,7 @@ static inline int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
>>
>>  #ifdef CONFIG_HOTPLUG_CPU
>>  int dlpar_cpu(struct pseries_hp_errorlog *hp_elog);
>> +extern void pseries_cpu_readd_by_index(__be32 drc_index);
>>  #else
>>  static inline int dlpar_cpu(struct pseries_hp_errorlog *hp_elog)
>>  {
>>
> 
> 

-- 
Michael W. Bringmann
Linux Technology Center
IBM Corporation
Tie-Line  363-5196
External: (512) 286-5196
Cell:       (512) 466-0650
mwb@linux.vnet.ibm.com
