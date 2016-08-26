Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sLYcV13NFzDrg5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Aug 2016 07:11:05 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7QL9HRj083936
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2016 17:11:04 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2521bv1fxr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2016 17:11:04 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Fri, 26 Aug 2016 17:11:03 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 9AD426E8041
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2016 17:10:40 -0400 (EDT)
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7QLAqYT13238574
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2016 21:11:01 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B33AE2804A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2016 17:11:01 -0400 (EDT)
Received: from ltcalpine2-lp14.aus.stglabs.ibm.com (unknown [9.40.195.197])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP id 920A92803F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2016 17:11:01 -0400 (EDT)
Subject: [PATCH 3/3] powerpc/pseries: Add bitmap to track updated LMBs
To: linuxppc-dev@lists.ozlabs.org
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Fri, 26 Aug 2016 17:04:08 -0400
In-Reply-To: <20160826210312.44862.37838.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
References: <20160826210312.44862.37838.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20160826210408.44862.76026.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Recent updates to the PAPR for memory hotplug has now made the
reserved field of the ibm,dynamic-memory property a capabilities
field. To support this update we can no longer use the reserved field
to track which LMBs have been updated during a DLPAR operation.

This patch adds a bitfield to track any LMBs that are updated during
a DLPAR operation so that we can roll back to the state proior to the
DLPAR operation if an error occurs.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/hotplug-memory.c |   25 ++++++++++-------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index a0371d1..4be1b61 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -27,6 +27,7 @@
 static struct drconf_mem {
 	u32 num_lmbs;
 	struct of_drconf_cell *lmbs;
+	unsigned long *lmb_update_map;
 } drmem;
 
 #define for_each_lmb_range(lmb, start, end)			\
@@ -46,15 +47,15 @@ static void lmb_set_aa_index(u32 lmb, u32 aa_index) {
 }
 
 static bool lmb_updated(u32 lmb) {
-	return drmem.lmbs[lmb].reserved;
+	return test_bit(lmb, drmem.lmb_update_map);
 }
 
 static void mark_lmb_updated(u32 lmb) {
-	drmem.lmbs[lmb].reserved = 1;
+	set_bit(lmb, drmem.lmb_update_map);
 }
 
-static void rm_lmb_update(u32 lmb) {
-	drmem.lmbs[lmb].reserved = 0;
+static void clear_lmb_updates(void) {
+	bitmap_zero(drmem.lmb_update_map, drmem.num_lmbs);
 }
 
 static bool lmb_reserved(u32 lmb) {
@@ -99,6 +100,11 @@ static void __init update_drconf_memory(void)
 	p = prop->value;
 	drmem.num_lmbs = be32_to_cpu(*p++);
 	drmem.lmbs = (struct of_drconf_cell *)p;
+	
+	if (!drmem.lmb_update_map) {
+		drmem.lmb_update_map = kmalloc(BITS_TO_LONGS(drmem.num_lmbs),
+					       GFP_KERNEL);
+	}
 }
 
 unsigned long pseries_memory_block_size(void)
@@ -484,8 +490,6 @@ static int dlpar_memory_remove_by_count(u32 lmbs_to_remove)
 			if (rc)
 				pr_err("Failed to add LMB back, drc index %x\n",
 				       lmb_drc_index(lmb));
-
-			rm_lmb_update(lmb);
 		}
 
 		rc = -EINVAL;
@@ -496,8 +500,6 @@ static int dlpar_memory_remove_by_count(u32 lmbs_to_remove)
 
 			pr_info("Memory at %llx was hot-removed\n",
 				lmb_base_address(lmb));
-
-			rm_lmb_update(lmb);
 		}
 		rc = 0;
 	}
@@ -588,8 +590,6 @@ static int dlpar_memory_remove_by_ic(u32 lmbs_to_remove, u32 drc_index)
 			if (rc)
 				pr_err("Failed to add LMB, drc index %x\n",
 				       lmb_drc_index(lmb));
-
-			rm_lmb_update(lmb);
 		}
 		rc = -EINVAL;
 	} else {
@@ -599,8 +599,6 @@ static int dlpar_memory_remove_by_ic(u32 lmbs_to_remove, u32 drc_index)
 
 			pr_info("Memory at %llx (drc index %x) was hot-removed\n",
 				lmb_base_address(lmb), lmb_drc_index(lmb));
-
-			rm_lmb_update(lmb);
 		}
 	}
 
@@ -732,7 +730,6 @@ static int dlpar_memory_add_by_count(u32 lmbs_to_add)
 
 			pr_info("Memory at %llx (drc index %x) was hot-added\n",
 				lmb_base_address(lmb), lmb_drc_index(lmb));
-			rm_lmb_update(lmb);
 		}
 	}
 
@@ -830,7 +827,6 @@ static int dlpar_memory_add_by_ic(u32 lmbs_to_add, u32 drc_index)
 
 			pr_info("Memory at %llx (drc index %x) was hot-added\n",
 				lmb_base_address(lmb), lmb_drc_index(lmb));
-			rm_lmb_update(lmb);
 		}
 	}
 
@@ -843,6 +839,7 @@ int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
 	int rc;
 
 	lock_device_hotplug();
+	clear_lmb_updates();
 
 	switch (hp_elog->action) {
 	case PSERIES_HP_ELOG_ACTION_ADD:
