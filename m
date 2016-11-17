Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tK26D27NvzDvmP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 11:28:20 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id i88so10574506pfk.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 16:28:20 -0800 (PST)
Subject: Re: [RESEND] [PATCH v1 1/3] Add basic infrastructure for memcg
 hotplug support
To: Vladimir Davydov <vdavydov@tarantool.org>
References: <1479253501-26261-1-git-send-email-bsingharora@gmail.com>
 <1479253501-26261-2-git-send-email-bsingharora@gmail.com>
 <20161116090129.GA18225@esperanza>
Cc: mpe@ellerman.id.au, hannes@cmpxchg.org, mhocko@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, Tejun Heo
 <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <3accc533-8dda-a69c-fabc-23eb388cf11b@gmail.com>
Date: Thu, 17 Nov 2016 11:28:12 +1100
MIME-Version: 1.0
In-Reply-To: <20161116090129.GA18225@esperanza>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 16/11/16 20:01, Vladimir Davydov wrote:
> Hello,
> 
> On Wed, Nov 16, 2016 at 10:44:59AM +1100, Balbir Singh wrote:
>> The lack of hotplug support makes us allocate all memory
>> upfront for per node data structures. With large number
>> of cgroups this can be an overhead. PPC64 actually limits
>> n_possible nodes to n_online to avoid some of this overhead.
>>
>> This patch adds the basic notifiers to listen to hotplug
>> events and does the allocation and free of those structures
>> per cgroup. We walk every cgroup per event, its a trade-off
>> of allocating upfront vs allocating on demand and freeing
>> on offline.
>>
>> Cc: Tejun Heo <tj@kernel.org>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>> Cc: Michal Hocko <mhocko@kernel.org> 
>> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
>>
>> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
>> ---
>>  mm/memcontrol.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++-------
>>  1 file changed, 60 insertions(+), 8 deletions(-)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 91dfc7c..5585fce 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -63,6 +63,7 @@
>>  #include <linux/lockdep.h>
>>  #include <linux/file.h>
>>  #include <linux/tracehook.h>
>> +#include <linux/memory.h>
>>  #include "internal.h"
>>  #include <net/sock.h>
>>  #include <net/ip.h>
>> @@ -1342,6 +1343,10 @@ int mem_cgroup_select_victim_node(struct mem_cgroup *memcg)
>>  {
>>  	return 0;
>>  }
>> +
>> +static void mem_cgroup_may_update_nodemask(struct mem_cgroup *memcg)
>> +{
>> +}
>>  #endif
>>  
>>  static int mem_cgroup_soft_reclaim(struct mem_cgroup *root_memcg,
>> @@ -4115,14 +4120,7 @@ static int alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
>>  {
>>  	struct mem_cgroup_per_node *pn;
>>  	int tmp = node;
>> -	/*
>> -	 * This routine is called against possible nodes.
>> -	 * But it's BUG to call kmalloc() against offline node.
>> -	 *
>> -	 * TODO: this routine can waste much memory for nodes which will
>> -	 *       never be onlined. It's better to use memory hotplug callback
>> -	 *       function.
>> -	 */
>> +
>>  	if (!node_state(node, N_NORMAL_MEMORY))
>>  		tmp = -1;
>>  	pn = kzalloc_node(sizeof(*pn), GFP_KERNEL, tmp);
>> @@ -5773,6 +5771,59 @@ static int __init cgroup_memory(char *s)
>>  }
>>  __setup("cgroup.memory=", cgroup_memory);
>>  
>> +static void memcg_node_offline(int node)
>> +{
>> +	struct mem_cgroup *memcg;
>> +
>> +	if (node < 0)
>> +		return;
> 
> Is this possible?

Yes, please see node_states_check_changes_online/offline

> 
>> +
>> +	for_each_mem_cgroup(memcg) {
>> +		free_mem_cgroup_per_node_info(memcg, node);
>> +		mem_cgroup_may_update_nodemask(memcg);
> 
> If memcg->numainfo_events is 0, mem_cgroup_may_update_nodemask() won't
> update memcg->scan_nodes. Is it OK?
> 
>> +	}
> 
> What if a memory cgroup is created or destroyed while you're walking the
> tree? Should we probably use get_online_mems() in mem_cgroup_alloc() to
> avoid that?
> 

The iterator internally takes rcu_read_lock() to avoid any side-effects
of cgroups added/removed. I suspect you are also suggesting using get_online_mems()
around each call to for_each_online_node

My understanding so far is

1. invalidate_reclaim_iterators should be safe (no bad side-effects)
2. mem_cgroup_free - should be safe as well
3. mem_cgroup_alloc - needs protection
4. mem_cgroup_init - needs protection
5. mem_cgroup_remove_from_tress - should be safe

>> +}
>> +
>> +static void memcg_node_online(int node)
>> +{
>> +	struct mem_cgroup *memcg;
>> +
>> +	if (node < 0)
>> +		return;
>> +
>> +	for_each_mem_cgroup(memcg) {
>> +		alloc_mem_cgroup_per_node_info(memcg, node);
>> +		mem_cgroup_may_update_nodemask(memcg);
>> +	}
>> +}
>> +
>> +static int memcg_memory_hotplug_callback(struct notifier_block *self,
>> +					unsigned long action, void *arg)
>> +{
>> +	struct memory_notify *marg = arg;
>> +	int node = marg->status_change_nid;
>> +
>> +	switch (action) {
>> +	case MEM_GOING_OFFLINE:
>> +	case MEM_CANCEL_ONLINE:
>> +		memcg_node_offline(node);
> 
> Judging by __offline_pages(), the MEM_GOING_OFFLINE event is emitted
> before migrating pages off the node. So, I guess freeing per-node info
> here isn't quite correct, as pages still need it to be moved from the
> node's LRU lists. Better move it to MEM_OFFLINE?
> 

Good point, will redo

>> +		break;
>> +	case MEM_GOING_ONLINE:
>> +	case MEM_CANCEL_OFFLINE:
>> +		memcg_node_online(node);
>> +		break;
>> +	case MEM_ONLINE:
>> +	case MEM_OFFLINE:
>> +		break;
>> +	}
>> +	return NOTIFY_OK;
>> +}
>> +
>> +static struct notifier_block memcg_memory_hotplug_nb __meminitdata = {
>> +	.notifier_call = memcg_memory_hotplug_callback,
>> +	.priority = IPC_CALLBACK_PRI,
> 
> I wonder why you chose this priority?
> 

I just chose the lowest priority

>> +};
>> +
>>  /*
>>   * subsys_initcall() for memory controller.
>>   *
>> @@ -5797,6 +5848,7 @@ static int __init mem_cgroup_init(void)
>>  #endif
>>  
>>  	hotcpu_notifier(memcg_cpu_hotplug_callback, 0);
>> +	register_hotmemory_notifier(&memcg_memory_hotplug_nb);
>>  
>>  	for_each_possible_cpu(cpu)
>>  		INIT_WORK(&per_cpu_ptr(&memcg_stock, cpu)->work,
> 
> I guess, we should modify mem_cgroup_alloc/free() in the scope of this
> patch, otherwise it doesn't make much sense IMHO. May be, it's even
> worth merging patches 1 and 2 altogether.
> 


Thanks for the review, I'll revisit the organization of the patches.


Balbir Singh
