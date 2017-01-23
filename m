Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v6ngg2fgQzDqHT
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jan 2017 10:33:35 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0NNT3Ui082755
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jan 2017 18:33:32 -0500
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0b-001b2d01.pphosted.com with ESMTP id 285r3pq533-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jan 2017 18:33:32 -0500
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 24 Jan 2017 09:33:29 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id E6D4E2CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jan 2017 10:33:26 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v0NNXI3G16318480
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jan 2017 10:33:26 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v0NNWs8r003517
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jan 2017 10:32:54 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/mm: Fix RECLAIM_DISTANCE
Date: Tue, 24 Jan 2017 10:32:28 +1100
Message-Id: <1485214348-19487-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When @node_reclaim_mode ("/proc/sys/vm/zone_reclaim_mode") is enabled,
the nodes in the specified distance (< RECLAIM_DISTANCE) to the preferred
one will be checked for page direct reclaim in the fast path, as below
function call chain indicates. Currently, RECLAIM_DISTANCE is set to 10,
equal to LOCAL_DISTANCE. It means no nodes, including the preferred one,
don't match the conditions. So no nodes are checked for direct reclaim
in the fast path.

   __alloc_pages_nodemask
   get_page_from_freelist
   zone_allows_reclaim

This fixes it by setting RECLAIM_DISTANCE to 30. With it, the preferred
node and its directly adjacent nodes will be checked for page direct
reclaim. The comments explaining RECLAIM_DISTANCE is out of date. This
updates and makes it correct.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/topology.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
index 8b3b46b..ce1a156 100644
--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -9,10 +9,11 @@ struct device_node;
 #ifdef CONFIG_NUMA
 
 /*
- * If zone_reclaim_mode is enabled, a RECLAIM_DISTANCE of 10 will mean that
- * all zones on all nodes will be eligible for zone_reclaim().
+ * If node_reclaim_mode is enabled, a RECLAIM_DISTANCE of 30 means that
+ * the preferred node and its directly adjacent nodes are eligible for
+ * node_reclaim().
  */
-#define RECLAIM_DISTANCE 10
+#define RECLAIM_DISTANCE	30
 
 #include <asm/mmzone.h>
 
-- 
2.7.4
