Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNqLg6jJpzDvyd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 15:37:15 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id y68so128992pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 20:37:15 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
To: linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org
Cc: Balbir Singh <bsingharora@gmail.com>, Tejun Heo <tj@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: [mm v2 0/3] Support memory cgroup hotplug
Date: Wed, 23 Nov 2016 15:36:51 +1100
Message-Id: <1479875814-11938-1-git-send-email-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In the absence of hotplug we use extra memory proportional to
(possible_nodes - online_nodes) * number_of_cgroups. PPC64 has a patch
to disable large consumption with large number of cgroups. This patch
adds hotplug support to memory cgroups and reverts the commit that
limited possible nodes to online nodes.

Cc: Tejun Heo <tj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org> 
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>

I've tested this patches under a VM with two nodes and movable
nodes enabled. I've offlined nodes and checked that the system
and cgroups with tasks deep in the hierarchy continue to work
fine.

These patches are on top of linux-next (20161117)

Changelog v2:
	Add get/put_online_mems() around node iteration
	Use MEM_OFFLINE/MEM_ONLINE instead of MEM_GOING_OFFLINE/ONLINE

Balbir Singh (3):
  mm: Add basic infrastructure for memcg hotplug support
  mm: Move operations to hotplug callbacks
  powerpc/mm: fix node_possible_map limitations

 arch/powerpc/mm/numa.c |   7 ----
 mm/memcontrol.c        | 107 +++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 94 insertions(+), 20 deletions(-)

-- 
2.5.5
