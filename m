Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHnDM0RxkzDvj3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 10:44:19 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id p66so10117416pga.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 15:44:18 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
To: linux-mm@kvack.org
Cc: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 akpm@linux-foundation.org, tj@kernel.org,
 Balbir Singh <bsingharora@gmail.com>
Subject: [v1 0/3] Support memory cgroup hotplug
Date: Tue, 15 Nov 2016 10:44:02 +1100
Message-Id: <1479167045-28136-1-git-send-email-bsingharora@gmail.com>
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
