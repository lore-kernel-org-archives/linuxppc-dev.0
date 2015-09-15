Return-Path: <raghavendra.kt@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2B8E91A2BD4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2015 12:07:26 +1000 (AEST)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <raghavendra.kt@linux.vnet.ibm.com>;
 Mon, 14 Sep 2015 20:07:24 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id C36BD3E40030
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2015 20:07:21 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t8F24LcI64553080
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2015 19:04:21 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8F27K37019885
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2015 20:07:21 -0600
From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
To: <benh@kernel.crashing.org>, <paulus@samba.org>, <mpe@ellerman.id.au>,
 <anton@samba.org>, <akpm@linux-foundation.org>
Cc: <nacc@linux.vnet.ibm.com>, <gkurz@linux.vnet.ibm.com>,
 <grant.likely@linaro.org>, <nikunj@linux.vnet.ibm.com>,
 <vdavydov@parallels.com>, <raghavendra.kt@linux.vnet.ibm.com>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <linux-mm@kvack.org>
Subject: [PATCH V2 1/2] mm: Replace nr_node_ids for loop with for_each_node in
 list lru
Date: Tue, 15 Sep 2015 07:38:36 +0530
Message-Id: <1442282917-16893-2-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
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

The functions used in the patch are in slowpath, which gets called
whenever alloc_super is called during mounts.

Though this should not make difference for the architectures with
sequential numa node ids, for the powerpc which can potentially have
sparse node ids (for e.g., 4 node system having numa ids, 0,1,16,17
is common), this patch saves some unnecessary allocations for
non existing numa nodes.

Even without that saving, perhaps patch makes code more readable.

[ Take memcg_aware check outside for_each loop: Vldimir]
Signed-off-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
---
 mm/list_lru.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

 Changes in V2:
  - Take memcg_aware check outside for_each loop (Vldimir)
  - Add comment that node 0 should always be present (Vladimir)  
  
diff --git a/mm/list_lru.c b/mm/list_lru.c
index 909eca2..60cd6dd 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -42,6 +42,10 @@ static void list_lru_unregister(struct list_lru *lru)
 #ifdef CONFIG_MEMCG_KMEM
 static inline bool list_lru_memcg_aware(struct list_lru *lru)
 {
+	/*
+	 * This needs node 0 to be always present, even
+	 * in the systems supporting sparse numa ids.
+	 */
 	return !!lru->node[0].memcg_lrus;
 }
 
@@ -377,16 +381,20 @@ static int memcg_init_list_lru(struct list_lru *lru, bool memcg_aware)
 {
 	int i;
 
-	for (i = 0; i < nr_node_ids; i++) {
-		if (!memcg_aware)
-			lru->node[i].memcg_lrus = NULL;
-		else if (memcg_init_list_lru_node(&lru->node[i]))
+	if (!memcg_aware)
+		return 0;
+
+	for_each_node(i) {
+		if (memcg_init_list_lru_node(&lru->node[i]))
 			goto fail;
 	}
 	return 0;
 fail:
-	for (i = i - 1; i >= 0; i--)
+	for (i = i - 1; i >= 0; i--) {
+		if (!lru->node[i].memcg_lrus)
+			continue;
 		memcg_destroy_list_lru_node(&lru->node[i]);
+	}
 	return -ENOMEM;
 }
 
@@ -397,7 +405,7 @@ static void memcg_destroy_list_lru(struct list_lru *lru)
 	if (!list_lru_memcg_aware(lru))
 		return;
 
-	for (i = 0; i < nr_node_ids; i++)
+	for_each_node(i)
 		memcg_destroy_list_lru_node(&lru->node[i]);
 }
 
@@ -409,16 +417,20 @@ static int memcg_update_list_lru(struct list_lru *lru,
 	if (!list_lru_memcg_aware(lru))
 		return 0;
 
-	for (i = 0; i < nr_node_ids; i++) {
+	for_each_node(i) {
 		if (memcg_update_list_lru_node(&lru->node[i],
 					       old_size, new_size))
 			goto fail;
 	}
 	return 0;
 fail:
-	for (i = i - 1; i >= 0; i--)
+	for (i = i - 1; i >= 0; i--) {
+		if (!lru->node[i].memcg_lrus)
+			continue;
+
 		memcg_cancel_update_list_lru_node(&lru->node[i],
 						  old_size, new_size);
+	}
 	return -ENOMEM;
 }
 
@@ -430,7 +442,7 @@ static void memcg_cancel_update_list_lru(struct list_lru *lru,
 	if (!list_lru_memcg_aware(lru))
 		return;
 
-	for (i = 0; i < nr_node_ids; i++)
+	for_each_node(i)
 		memcg_cancel_update_list_lru_node(&lru->node[i],
 						  old_size, new_size);
 }
@@ -485,7 +497,7 @@ static void memcg_drain_list_lru(struct list_lru *lru,
 	if (!list_lru_memcg_aware(lru))
 		return;
 
-	for (i = 0; i < nr_node_ids; i++)
+	for_each_node(i)
 		memcg_drain_list_lru_node(&lru->node[i], src_idx, dst_idx);
 }
 
@@ -522,7 +534,7 @@ int __list_lru_init(struct list_lru *lru, bool memcg_aware,
 	if (!lru->node)
 		goto out;
 
-	for (i = 0; i < nr_node_ids; i++) {
+	for_each_node(i) {
 		spin_lock_init(&lru->node[i].lock);
 		if (key)
 			lockdep_set_class(&lru->node[i].lock, key);
-- 
1.7.11.7
