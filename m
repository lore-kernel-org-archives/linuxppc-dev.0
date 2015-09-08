Return-Path: <raghavendra.kt@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D05581A1F58
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Sep 2015 04:30:25 +1000 (AEST)
Received: from /spool/local
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <raghavendra.kt@linux.vnet.ibm.com>;
 Tue, 8 Sep 2015 14:30:23 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 31FCB38C8046
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Sep 2015 14:30:22 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t88IULE957213000
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Sep 2015 18:30:21 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t88IUKJd011182
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Sep 2015 14:30:21 -0400
From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
To: <benh@kernel.crashing.org>, <paulus@samba.org>, <mpe@ellerman.id.au>,
 <anton@samba.org>, <akpm@linux-foundation.org>
Cc: <nacc@linux.vnet.ibm.com>, <gkurz@linux.vnet.ibm.com>,
 <zhong@linux.vnet.ibm.com>, <grant.likely@linaro.org>,
 <nikunj@linux.vnet.ibm.com>, <vdavydov@parallels.com>,
 <raghavendra.kt@linux.vnet.ibm.com>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH 2/2] powerpc:numa Do not allocate bootmem memory for non
 existing nodes
Date: Wed,  9 Sep 2015 00:01:47 +0530
Message-Id: <1441737107-23103-3-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
In-Reply-To: <1441737107-23103-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
References: <1441737107-23103-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
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
