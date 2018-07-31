Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ffSW6BNLzF0pD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2018 11:47:07 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6V1i4YS138350
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2018 21:47:05 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kj8ckux4q-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2018 21:47:04 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Mon, 30 Jul 2018 19:47:04 -0600
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/mobility: Fix node detach/rename problem
To: Michael Bringmann <mwb@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>
References: <c2fba52a-baac-25fb-c26b-c84b25c3178c@linux.vnet.ibm.com>
 <9cd25a93-6c71-728c-e9bf-a16f80ef5655@linux.vnet.ibm.com>
Date: Mon, 30 Jul 2018 18:46:57 -0700
MIME-Version: 1.0
In-Reply-To: <9cd25a93-6c71-728c-e9bf-a16f80ef5655@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <0dd90afb-4b92-84de-2f7a-b5bf1d197c81@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/30/2018 05:59 PM, Tyrel Datwyler wrote:
> On 07/29/2018 06:11 AM, Michael Bringmann wrote:
>> During LPAR migration, the content of the device tree/sysfs may
>> be updated including deletion and replacement of nodes in the
>> tree.  When nodes are added to the internal node structures, they
>> are appended in FIFO order to a list of nodes maintained by the
>> OF code APIs.  When nodes are removed from the device tree, they
>> are marked OF_DETACHED, but not actually deleted from the system
>> to allow for pointers cached elsewhere in the kernel.  The order
>> and content of the entries in the list of nodes is not altered,
>> though.
>>
>> During LPAR migration some common nodes are deleted and re-added
>> e.g. "ibm,platform-facilities".  If a node is re-added to the OF
>> node lists, the of_attach_node function checks to make sure that
>> the name + ibm,phandle of the to-be-added data is unique.  As the
>> previous copy of a re-added node is not modified beyond the addition
>> of a bit flag, the code (1) finds the old copy, (2) prints a WARNING
>> notice to the console, (3) renames the to-be-added node to avoid
>> filename collisions within a directory, and (3) adds entries to
>> the sysfs/kernfs.
> 
> So, this patch actually just band aids over the real problem. This is a long standing problem with several PFO drivers leaking references. The issue here is that, during the device tree update that follows a migration. the update of the ibm,platform-facilities node and friends below are always deleted and re-added on the destination lpar and subsequently the leaked references prevent the devices nodes from every actually being properly cleaned up after detach. Thus, leading to the issue you are observing.
> 
> As and example a quick look at nx-842-pseries.c reveals several issues.
> 
> static int __init nx842_pseries_init(void)
> {
>         struct nx842_devdata *new_devdata;
>         int ret;
> 
>         if (!of_find_compatible_node(NULL, NULL, "ibm,compression"))
>                 return -ENODEV;
> 
> This call to of_find_compatible_node() results in a node returned with refcount incremented and therefore immediately leaked.
> 
> Further, the reconfig notifier logic makes the assumption that it only needs to deal with node updates, but as I outlined above the post migration device tree update always results in PFO nodes and properties being deleted and re-added.
> 
> /**
>  * nx842_OF_notifier - Process updates to OF properties for the device
>  *
>  * @np: notifier block
>  * @action: notifier action
>  * @update: struct pSeries_reconfig_prop_update pointer if action is
>  *      PSERIES_UPDATE_PROPERTY
>  *
>  * Returns:
>  *      NOTIFY_OK on success
>  *      NOTIFY_BAD encoded with error number on failure, use
>  *              notifier_to_errno() to decode this value
>  */
> static int nx842_OF_notifier(struct notifier_block *np, unsigned long action,
>                              void *data)
> {
>         struct of_reconfig_data *upd = data;
>         struct nx842_devdata *local_devdata;
>         struct device_node *node = NULL;
> 
>         rcu_read_lock();
>         local_devdata = rcu_dereference(devdata);
>         if (local_devdata)
>                 node = local_devdata->dev->of_node;
> 
>         if (local_devdata &&
>                         action == OF_RECONFIG_UPDATE_PROPERTY &&
>                         !strcmp(upd->dn->name, node->name)) {
>                 rcu_read_unlock();
>                 nx842_OF_upd(upd->prop);
>         } else
>                 rcu_read_unlock();
> 
>         return NOTIFY_OK;
> }
> 
> I expect to find the same problems in pseries-rng.c and nx.c.

So, in actuality the main root of the problem is really in the vio core. A node reference for each PFO device under "ibm,platform-facilities" is taken during vio_register_device_node(). We need a reconfig notifier to call vio_unregister_device() for each PFO device on detach, and vio_bus_scan_register_devices("ibm,platform-facilities") on attach. This will make sure the PFO vio devices are released such that vio_dev_release() gets called to put the node reference that was taken at original registration time.

/* vio_dev refcount hit 0 */
static void vio_dev_release(struct device *dev)
{
        struct iommu_table *tbl = get_iommu_table_base(dev);

        if (tbl)
                iommu_tce_table_put(tbl);
        of_node_put(dev->of_node);
        kfree(to_vio_dev(dev));
}

-Tyrel

> 
> -Tyrel
> 
>>
>> This patch fixes the 'migration add' problem by changing the
>> stored 'phandle' of the OF_DETACHed node to 0 (reserved value for
>> of_find_node_by_phandle), so that subsequent re-add operations,
>> such as those during migration, do not find the detached node,
>> do not observe duplicate names, do not rename them,  and the
>> extra WARNING notices are removed from the console output.
>>
>> In addition, it erases the 'name' field of the OF_DETACHED node,
>> to prevent any future calls to of_find_node_by_name() or
>> of_find_node_by_path() from matching this node.
>>
>> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/platforms/pseries/dlpar.c |    3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
>> index 2de0f0d..9d82c28 100644
>> --- a/arch/powerpc/platforms/pseries/dlpar.c
>> +++ b/arch/powerpc/platforms/pseries/dlpar.c
>> @@ -274,6 +274,9 @@ int dlpar_detach_node(struct device_node *dn)
>>  	if (rc)
>>  		return rc;
>>
>> +	dn->phandle = 0;
>> +	memset(dn->name, 0, strlen(dn->name));
>> +
>>  	return 0;
>>  }
>>
>>
> 
