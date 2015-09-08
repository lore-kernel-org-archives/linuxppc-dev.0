Return-Path: <raghavendra.kt@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C34641A1F44
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Sep 2015 04:30:14 +1000 (AEST)
Received: from /spool/local
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <raghavendra.kt@linux.vnet.ibm.com>;
 Tue, 8 Sep 2015 14:30:11 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id DB0B1C90046
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Sep 2015 14:21:13 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t88IU9Yn32899150
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Sep 2015 18:30:09 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t88IU8S7009420
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Sep 2015 14:30:09 -0400
From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
To: <benh@kernel.crashing.org>, <paulus@samba.org>, <mpe@ellerman.id.au>,
 <anton@samba.org>, <akpm@linux-foundation.org>
Cc: <nacc@linux.vnet.ibm.com>, <gkurz@linux.vnet.ibm.com>,
 <zhong@linux.vnet.ibm.com>, <grant.likely@linaro.org>,
 <nikunj@linux.vnet.ibm.com>, <vdavydov@parallels.com>,
 <raghavendra.kt@linux.vnet.ibm.com>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH  0/2] Replace nr_node_ids for loop with for_each_node 
Date: Wed,  9 Sep 2015 00:01:45 +0530
Message-Id: <1441737107-23103-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
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

Raghavendra K T (2):
  mm: Replace nr_node_ids for loop with for_each_node in list lru
  powerpc:numa Do not allocate bootmem memory for non existing nodes

 arch/powerpc/mm/numa.c |  2 +-
 mm/list_lru.c          | 23 +++++++++++++++--------
 2 files changed, 16 insertions(+), 9 deletions(-)

-- 
1.7.11.7
