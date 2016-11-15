Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJPBz51CMzDt1s
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 10:45:15 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id 144so8666257pfv.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 15:45:15 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
To: mpe@ellerman.id.au, hannes@cmpxchg.org, mhocko@kernel.org,
 vdavydov.dev@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 Balbir Singh <bsingharora@gmail.com>, Tejun Heo <tj@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [RESEND][v1 0/3] Support memory cgroup hotplug
Date: Wed, 16 Nov 2016 10:44:58 +1100
Message-Id: <1479253501-26261-1-git-send-email-bsingharora@gmail.com>
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

Balbir Singh (3):
  Add basic infrastructure for memcg hotplug support
  Move from all possible nodes to online nodes
  powerpc: fix node_possible_map limitations

 arch/powerpc/mm/numa.c |  7 ----
 mm/memcontrol.c        | 96 +++++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 83 insertions(+), 20 deletions(-)

-- 
2.5.5
