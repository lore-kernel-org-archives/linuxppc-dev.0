Return-Path: <raghavendra.kt@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C48451A2C87
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2015 12:08:10 +1000 (AEST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <raghavendra.kt@linux.vnet.ibm.com>;
 Mon, 14 Sep 2015 20:08:08 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id D6D4B19D803F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2015 19:58:58 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8F27ugF65208510
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2015 19:08:05 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8F27U9v011648
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2015 20:07:31 -0600
From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
To: <benh@kernel.crashing.org>, <paulus@samba.org>, <mpe@ellerman.id.au>,
 <anton@samba.org>, <akpm@linux-foundation.org>
Cc: <nacc@linux.vnet.ibm.com>, <gkurz@linux.vnet.ibm.com>,
 <grant.likely@linaro.org>, <nikunj@linux.vnet.ibm.com>,
 <vdavydov@parallels.com>, <raghavendra.kt@linux.vnet.ibm.com>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <linux-mm@kvack.org>
Subject: [PATCH V2  0/2] Replace nr_node_ids for loop with for_each_node 
Date: Tue, 15 Sep 2015 07:38:35 +0530
Message-Id: <1442282917-16893-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Many places in the kernel use 'for' loop with nr_node_ids. For the architectures
which supports sparse numa ids, this will result in some unnecessary allocations
for non existing nodes.
(for e.g., numa node numbers such as 0,1,16,17 is common in powerpc.)

So replace the for loop with for_each_node so that allocations happen only for
existing numa nodes.

Please note that, though there are many places where nr_node_ids is used,
current patchset uses for_each_node only for slowpath to avoid find_next_bit
traversal.

Changes in V2:
  - Take memcg_aware check outside for_each loop (Vldimir)
  - Add comment that node 0 should always be present (Vladimir)

Raghavendra K T (2):
  mm: Replace nr_node_ids for loop with for_each_node in list lru
  powerpc:numa Do not allocate bootmem memory for non existing nodes

 arch/powerpc/mm/numa.c |  2 +-
 mm/list_lru.c          | 34 +++++++++++++++++++++++-----------
 2 files changed, 24 insertions(+), 12 deletions(-)

-- 
1.7.11.7
