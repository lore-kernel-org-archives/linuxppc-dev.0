Return-Path: <rcjenn@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp08.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 80F582C013B
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Oct 2013 06:25:22 +1100 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <rcjenn@linux.vnet.ibm.com>;
 Sat, 26 Oct 2013 00:55:16 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 4013CE0018
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Oct 2013 00:56:47 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9PJP4Mj38142120
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Oct 2013 00:55:05 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9PJPCov010634
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Oct 2013 00:55:12 +0530
From: Robert C Jennings <rcj@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] powerpc: Fix warnings for arch/powerpc/mm/numa.c
Date: Fri, 25 Oct 2013 14:25:06 -0500
Message-Id: <1382729107-13560-2-git-send-email-rcj@linux.vnet.ibm.com>
In-Reply-To: <1382729107-13560-1-git-send-email-rcj@linux.vnet.ibm.com>
References: <1382729107-13560-1-git-send-email-rcj@linux.vnet.ibm.com>
Cc: Robert C Jennings <rcj@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Simple fixes for sparse warnings in this file.

Resolves:
arch/powerpc/mm/numa.c:198:24:
        warning: Using plain integer as NULL pointer

arch/powerpc/mm/numa.c:1157:5: 
       warning: symbol 'hot_add_node_scn_to_nid' was not declared.
                Should it be static?

arch/powerpc/mm/numa.c:1238:28: 
       warning: Using plain integer as NULL pointer

arch/powerpc/mm/numa.c:1538:6: 
       warning: symbol 'topology_schedule_update' was not declared.
                Should it be static?

Signed-off-by: Robert C Jennings <rcj@linux.vnet.ibm.com>
---
 arch/powerpc/mm/numa.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index c916127..33d6784 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -195,7 +195,7 @@ static const __be32 *of_get_usable_memory(struct device_node *memory)
 	u32 len;
 	prop = of_get_property(memory, "linux,drconf-usable-memory", &len);
 	if (!prop || len < sizeof(unsigned int))
-		return 0;
+		return NULL;
 	return prop;
 }
 
@@ -1154,7 +1154,7 @@ static int hot_add_drconf_scn_to_nid(struct device_node *memory,
  * represented in the device tree as a node (i.e. memory@XXXX) for
  * each memblock.
  */
-int hot_add_node_scn_to_nid(unsigned long scn_addr)
+static int hot_add_node_scn_to_nid(unsigned long scn_addr)
 {
 	struct device_node *memory;
 	int nid = -1;
@@ -1235,7 +1235,7 @@ static u64 hot_add_drconf_memory_max(void)
         struct device_node *memory = NULL;
         unsigned int drconf_cell_cnt = 0;
         u64 lmb_size = 0;
-	const __be32 *dm = 0;
+	const __be32 *dm = NULL;
 
         memory = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
         if (memory) {
@@ -1535,7 +1535,7 @@ static void topology_work_fn(struct work_struct *work)
 }
 static DECLARE_WORK(topology_work, topology_work_fn);
 
-void topology_schedule_update(void)
+static void topology_schedule_update(void)
 {
 	schedule_work(&topology_work);
 }
-- 
1.8.1.2
