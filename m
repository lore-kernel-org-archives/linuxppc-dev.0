Return-Path: <mstsxfx@gmail.com>
Received: from mail-wm0-f66.google.com (mail-wm0-f66.google.com [74.125.82.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNv583q3VzDw4h
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 18:25:48 +1100 (AEDT)
Received: by mail-wm0-f66.google.com with SMTP id u144so858120wmu.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 23:25:48 -0800 (PST)
Date: Wed, 23 Nov 2016 08:25:44 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Balbir Singh <bsingharora@gmail.com>
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [mm v2 0/3] Support memory cgroup hotplug
Message-ID: <20161123072543.GD2864@dhcp22.suse.cz>
References: <1479875814-11938-1-git-send-email-bsingharora@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1479875814-11938-1-git-send-email-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed 23-11-16 15:36:51, Balbir Singh wrote:
> In the absence of hotplug we use extra memory proportional to
> (possible_nodes - online_nodes) * number_of_cgroups. PPC64 has a patch
> to disable large consumption with large number of cgroups. This patch
> adds hotplug support to memory cgroups and reverts the commit that
> limited possible nodes to online nodes.

Balbir,
I have asked this in the previous version but there still seems to be a
lack of information of _why_ do we want this, _how_ much do we save on
the memory overhead on most systems and _why_ the additional complexity
is really worth it. Please make sure to add all this in the cover
letter.

I still didn't get to look into those patches because I am swamped with
other things but to be honest I do not really see a strong justification
to make it high priority for me.

> Cc: Tejun Heo <tj@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org> 
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> 
> I've tested this patches under a VM with two nodes and movable
> nodes enabled. I've offlined nodes and checked that the system
> and cgroups with tasks deep in the hierarchy continue to work
> fine.
> 
> These patches are on top of linux-next (20161117)
> 
> Changelog v2:
> 	Add get/put_online_mems() around node iteration
> 	Use MEM_OFFLINE/MEM_ONLINE instead of MEM_GOING_OFFLINE/ONLINE
> 
> Balbir Singh (3):
>   mm: Add basic infrastructure for memcg hotplug support
>   mm: Move operations to hotplug callbacks
>   powerpc/mm: fix node_possible_map limitations
> 
>  arch/powerpc/mm/numa.c |   7 ----
>  mm/memcontrol.c        | 107 +++++++++++++++++++++++++++++++++++++++++++------
>  2 files changed, 94 insertions(+), 20 deletions(-)
> 
> -- 
> 2.5.5

-- 
Michal Hocko
SUSE Labs
