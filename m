Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tN5f04KZqzDvt3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 11:18:00 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id p66so200633pga.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 16:18:00 -0800 (PST)
Subject: Re: [RESEND] [PATCH v1 1/3] Add basic infrastructure for memcg
 hotplug support
To: Vladimir Davydov <vdavydov@tarantool.org>
References: <1479253501-26261-1-git-send-email-bsingharora@gmail.com>
 <1479253501-26261-2-git-send-email-bsingharora@gmail.com>
 <20161116090129.GA18225@esperanza>
 <3accc533-8dda-a69c-fabc-23eb388cf11b@gmail.com>
 <20161121083616.GC18431@esperanza>
Cc: mpe@ellerman.id.au, hannes@cmpxchg.org, mhocko@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, Tejun Heo
 <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <2395f702-8246-4ce6-ca23-7d71ce872507@gmail.com>
Date: Tue, 22 Nov 2016 11:17:53 +1100
MIME-Version: 1.0
In-Reply-To: <20161121083616.GC18431@esperanza>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


>>
>> The iterator internally takes rcu_read_lock() to avoid any side-effects
>> of cgroups added/removed. I suspect you are also suggesting using get_online_mems()
>> around each call to for_each_online_node
>>
>> My understanding so far is
>>
>> 1. invalidate_reclaim_iterators should be safe (no bad side-effects)
>> 2. mem_cgroup_free - should be safe as well
>> 3. mem_cgroup_alloc - needs protection
>> 4. mem_cgroup_init - needs protection
>> 5. mem_cgroup_remove_from_tress - should be safe
> 
> I'm not into the memory hotplug code, but my understanding is that if
> memcg offline happens to race with node unplug, it's possible that
> 
>  - mem_cgroup_free() doesn't free the node's data, because it sees the
>    node as already offline
>  - memcg hotplug code doesn't free the node's data either, because it
>    sees the cgroup as offline
> 
> May be, we should surround all the loops over online nodes with
> get/put_online_mems() to be sure that nothing wrong can happen.
> They are slow path, anyway.
> 

Makes sense, agreed

Balbir
