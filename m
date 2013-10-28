Return-Path: <rcjenn@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp08.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2C6AF2C0098
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Oct 2013 01:21:01 +1100 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <rcjenn@linux.vnet.ibm.com>;
 Tue, 29 Oct 2013 00:21:00 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 1AC192BB0044
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Oct 2013 01:20:59 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9SE3d8s5833058
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Oct 2013 01:03:39 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9SEKv30027569
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Oct 2013 01:20:58 +1100
From: Robert C Jennings <rcj@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 1/2] powerpc: Fix warnings for arch/powerpc/mm/numa.c
Date: Mon, 28 Oct 2013 09:20:50 -0500
Message-Id: <1382970051-8251-2-git-send-email-rcj@linux.vnet.ibm.com>
In-Reply-To: <1382970051-8251-1-git-send-email-rcj@linux.vnet.ibm.com>
References: <1382970051-8251-1-git-send-email-rcj@linux.vnet.ibm.com>
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
v1 -> v2: No changes in this patch
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
