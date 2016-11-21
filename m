Return-Path: <vdavydov@tarantool.org>
Received: from fallback8.mail.ru (fallback8.mail.ru [94.100.181.110])
 by lists.ozlabs.org (Postfix) with ESMTP id 3tMjHp3kGdzDvj0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 20:00:54 +1100 (AEDT)
Date: Mon, 21 Nov 2016 11:36:16 +0300
From: Vladimir Davydov <vdavydov@tarantool.org>
To: Balbir Singh <bsingharora@gmail.com>
Cc: mpe@ellerman.id.au, hannes@cmpxchg.org, mhocko@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RESEND] [PATCH v1 1/3] Add basic infrastructure for memcg
 hotplug support
Message-ID: <20161121083616.GC18431@esperanza>
References: <1479253501-26261-1-git-send-email-bsingharora@gmail.com>
 <1479253501-26261-2-git-send-email-bsingharora@gmail.com>
 <20161116090129.GA18225@esperanza>
 <3accc533-8dda-a69c-fabc-23eb388cf11b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3accc533-8dda-a69c-fabc-23eb388cf11b@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 17, 2016 at 11:28:12AM +1100, Balbir Singh wrote:
> >> @@ -5773,6 +5771,59 @@ static int __init cgroup_memory(char *s)
> >>  }
> >>  __setup("cgroup.memory=", cgroup_memory);
> >>  
> >> +static void memcg_node_offline(int node)
> >> +{
> >> +	struct mem_cgroup *memcg;
> >> +
> >> +	if (node < 0)
> >> +		return;
> > 
> > Is this possible?
> 
> Yes, please see node_states_check_changes_online/offline

OK, I see.

> 
> > 
> >> +
> >> +	for_each_mem_cgroup(memcg) {
> >> +		free_mem_cgroup_per_node_info(memcg, node);
> >> +		mem_cgroup_may_update_nodemask(memcg);
> > 
> > If memcg->numainfo_events is 0, mem_cgroup_may_update_nodemask() won't
> > update memcg->scan_nodes. Is it OK?
> > 
> >> +	}
> > 
> > What if a memory cgroup is created or destroyed while you're walking the
> > tree? Should we probably use get_online_mems() in mem_cgroup_alloc() to
> > avoid that?
> > 
> 
> The iterator internally takes rcu_read_lock() to avoid any side-effects
> of cgroups added/removed. I suspect you are also suggesting using get_online_mems()
> around each call to for_each_online_node
> 
> My understanding so far is
> 
> 1. invalidate_reclaim_iterators should be safe (no bad side-effects)
> 2. mem_cgroup_free - should be safe as well
> 3. mem_cgroup_alloc - needs protection
> 4. mem_cgroup_init - needs protection
> 5. mem_cgroup_remove_from_tress - should be safe

I'm not into the memory hotplug code, but my understanding is that if
memcg offline happens to race with node unplug, it's possible that

 - mem_cgroup_free() doesn't free the node's data, because it sees the
   node as already offline
 - memcg hotplug code doesn't free the node's data either, because it
   sees the cgroup as offline

May be, we should surround all the loops over online nodes with
get/put_online_mems() to be sure that nothing wrong can happen.
They are slow path, anyway.

Thanks,
Vladimir
