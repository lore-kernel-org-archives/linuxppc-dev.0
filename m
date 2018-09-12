Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 429Sqq2r1ZzF37B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2018 03:06:47 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8CH5JuT114128
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 13:06:45 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mf4fgy36v-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 13:06:44 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Wed, 12 Sep 2018 13:06:43 -0400
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w8CH6eHg36044808
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 17:06:41 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9078528058
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 13:04:44 -0400 (EDT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 65DA328059
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 13:04:44 -0400 (EDT)
Received: from ltcalpine2-lp14.aus.stglabs.ibm.com (unknown [9.40.195.197])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 13:04:44 -0400 (EDT)
Subject: [PATCH] powerpc/pseries: Track LMB nid instead of using device tree
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Date: Wed, 12 Sep 2018 11:45:23 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <153677072365.15599.14388703259401466198.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When removing memory we need to remove the memory from the node
it was added to instead of looking up the node it should be in
in the device tree.

During testing we have seen scenarios where the affinity for a
LMB changes due to a partition migration or PRRN event. In these
cases the node the LMB exists in may not match the node the device
tree indicates it belongs in. This can lead to a system crash
when trying to DLAPR remove the LMB after a migration or PRRN
event. The current code looks up the node in the device tree to
remove the LMB from, the crash occurs when we try to offline this
node and it does not have any data, i.e. node_data[nid] == NULL.

36:mon> e
cpu 0x36: Vector: 300 (Data Access) at [c0000001828b7810]
    pc: c00000000036d08c: try_offline_node+0x2c/0x1b0
    lr: c0000000003a14ec: remove_memory+0xbc/0x110
    sp: c0000001828b7a90
   msr: 800000000280b033
   dar: 9a28
 dsisr: 40000000
  current = 0xc0000006329c4c80
  paca    = 0xc000000007a55200   softe: 0        irq_happened: 0x01
    pid   = 76926, comm = kworker/u320:3

36:mon> t
[link register   ] c0000000003a14ec remove_memory+0xbc/0x110
[c0000001828b7a90] c00000000006a1cc arch_remove_memory+0x9c/0xd0 (unreliable)
[c0000001828b7ad0] c0000000003a14e0 remove_memory+0xb0/0x110
[c0000001828b7b20] c0000000000c7db4 dlpar_remove_lmb+0x94/0x160
[c0000001828b7b60] c0000000000c8ef8 dlpar_memory+0x7e8/0xd10
[c0000001828b7bf0] c0000000000bf828 handle_dlpar_errorlog+0xf8/0x160
[c0000001828b7c60] c0000000000bf8cc pseries_hp_work_fn+0x3c/0xa0
[c0000001828b7c90] c000000000128cd8 process_one_work+0x298/0x5a0
[c0000001828b7d20] c000000000129068 worker_thread+0x88/0x620
[c0000001828b7dc0] c00000000013223c kthread+0x1ac/0x1c0
[c0000001828b7e30] c00000000000b45c ret_from_kernel_thread+0x5c/0x80

To resolve this we need to track the node a LMB belongs to when
it is added to the system so we can remove it from that node instead
of the node that the device tree indicates it should belong to.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/drmem.h                |    1 +
 arch/powerpc/mm/drmem.c                         |    7 ++++++-
 arch/powerpc/platforms/pseries/hotplug-memory.c |   18 +++++++++---------
 3 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/drmem.h b/arch/powerpc/include/asm/drmem.h
index ce242b9ea8c6..d099123f4f26 100644
--- a/arch/powerpc/include/asm/drmem.h
+++ b/arch/powerpc/include/asm/drmem.h
@@ -17,6 +17,7 @@ struct drmem_lmb {
 	u32     drc_index;
 	u32     aa_index;
 	u32     flags;
+	int	nid;
 };
 
 struct drmem_lmb_info {
diff --git a/arch/powerpc/mm/drmem.c b/arch/powerpc/mm/drmem.c
index 3f1803672c9b..2baf00945b33 100644
--- a/arch/powerpc/mm/drmem.c
+++ b/arch/powerpc/mm/drmem.c
@@ -366,8 +366,11 @@ static void __init init_drmem_v1_lmbs(const __be32 *prop)
 	if (!drmem_info->lmbs)
 		return;
 
-	for_each_drmem_lmb(lmb)
+	for_each_drmem_lmb(lmb) {
 		read_drconf_v1_cell(lmb, &prop);
+		lmb->nid = memory_add_physaddr_to_nid(lmb->base_addr);
+	}
+
 }
 
 static void __init init_drmem_v2_lmbs(const __be32 *prop)
@@ -412,6 +415,8 @@ static void __init init_drmem_v2_lmbs(const __be32 *prop)
 
 			lmb->aa_index = dr_cell.aa_index;
 			lmb->flags = dr_cell.flags;
+
+			lmb->nid = memory_add_physaddr_to_nid(lmb->base_addr);
 		}
 	}
 }
diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index c1578f54c626..fc3a1e2d98b8 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -221,6 +221,9 @@ static int dlpar_add_device_tree_lmb(struct drmem_lmb *lmb)
 
 	lmb->aa_index = aa_index;
 
+	/* Find the node id for this address */
+	lmb->nid = memory_add_physaddr_to_nid(lmb->base_addr);
+
 	rtas_hp_event = true;
 	rc = drmem_update_dt();
 	rtas_hp_event = false;
@@ -234,6 +237,7 @@ static int dlpar_remove_device_tree_lmb(struct drmem_lmb *lmb)
 
 	lmb->flags &= ~DRCONF_MEM_ASSIGNED;
 	lmb->aa_index = 0xffffffff;
+	lmb->nid = -1;
 
 	rtas_hp_event = true;
 	rc = drmem_update_dt();
@@ -411,7 +415,7 @@ static int dlpar_add_lmb(struct drmem_lmb *);
 static int dlpar_remove_lmb(struct drmem_lmb *lmb)
 {
 	unsigned long block_sz;
-	int nid, rc;
+	int rc;
 
 	if (!lmb_is_removable(lmb))
 		return -EINVAL;
@@ -421,9 +425,8 @@ static int dlpar_remove_lmb(struct drmem_lmb *lmb)
 		return rc;
 
 	block_sz = pseries_memory_block_size();
-	nid = memory_add_physaddr_to_nid(lmb->base_addr);
 
-	remove_memory(nid, lmb->base_addr, block_sz);
+	remove_memory(lmb->nid, lmb->base_addr, block_sz);
 
 	/* Update memory regions for memory remove */
 	memblock_remove(lmb->base_addr, block_sz);
@@ -683,7 +686,7 @@ static int dlpar_memory_remove_by_ic(u32 lmbs_to_remove, u32 drc_index)
 static int dlpar_add_lmb(struct drmem_lmb *lmb)
 {
 	unsigned long block_sz;
-	int nid, rc;
+	int rc;
 
 	if (lmb->flags & DRCONF_MEM_ASSIGNED)
 		return -EINVAL;
@@ -698,11 +701,8 @@ static int dlpar_add_lmb(struct drmem_lmb *lmb)
 
 	block_sz = memory_block_size_bytes();
 
-	/* Find the node id for this address */
-	nid = memory_add_physaddr_to_nid(lmb->base_addr);
-
 	/* Add the memory */
-	rc = add_memory(nid, lmb->base_addr, block_sz);
+	rc = add_memory(lmb->nid, lmb->base_addr, block_sz);
 	if (rc) {
 		dlpar_remove_device_tree_lmb(lmb);
 		return rc;
@@ -710,7 +710,7 @@ static int dlpar_add_lmb(struct drmem_lmb *lmb)
 
 	rc = dlpar_online_lmb(lmb);
 	if (rc) {
-		remove_memory(nid, lmb->base_addr, block_sz);
+		remove_memory(lmb->nid, lmb->base_addr, block_sz);
 		dlpar_remove_device_tree_lmb(lmb);
 	} else {
 		lmb->flags |= DRCONF_MEM_ASSIGNED;
