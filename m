Return-Path: <raghavendra.kt@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7490A1A2C29
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2015 12:07:39 +1000 (AEST)
Received: from /spool/local
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <raghavendra.kt@linux.vnet.ibm.com>;
 Mon, 14 Sep 2015 22:07:36 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 905BA38C803B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2015 22:07:34 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8F27YlT61603900
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2015 02:07:34 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8F27WSF005717
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2015 22:07:33 -0400
From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
To: <benh@kernel.crashing.org>, <paulus@samba.org>, <mpe@ellerman.id.au>,
 <anton@samba.org>, <akpm@linux-foundation.org>
Cc: <nacc@linux.vnet.ibm.com>, <gkurz@linux.vnet.ibm.com>,
 <grant.likely@linaro.org>, <nikunj@linux.vnet.ibm.com>,
 <vdavydov@parallels.com>, <raghavendra.kt@linux.vnet.ibm.com>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <linux-mm@kvack.org>
Subject: [PATCH V2 2/2] powerpc:numa Do not allocate bootmem memory for non
 existing nodes
Date: Tue, 15 Sep 2015 07:38:37 +0530
Message-Id: <1442282917-16893-3-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
In-Reply-To: <1442282917-16893-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
References: <1442282917-16893-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
---
 arch/powerpc/mm/numa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 8b9502a..8d8a541 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -80,7 +80,7 @@ static void __init setup_node_to_cpumask_map(void)
 		setup_nr_node_ids();
 
 	/* allocate the map */
-	for (node = 0; node < nr_node_ids; node++)
+	for_each_node(node)
 		alloc_bootmem_cpumask_var(&node_to_cpumask_map[node]);
 
 	/* cpumask_of_node() will now work */
-- 
1.7.11.7
