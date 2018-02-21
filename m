Return-Path: <bharata@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zmYnY0sWXzDrM8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 21:36:48 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1LAYaIF131127
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 05:36:47 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g96mt19v7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 05:36:44 -0500
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bharata@linux.vnet.ibm.com>;
 Wed, 21 Feb 2018 10:36:41 -0000
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: nfont@linux.vnet.ibm.com, mwb@linux.vnet.ibm.com,
 Bharata B Rao <bharata@linux.vnet.ibm.com>
Subject: [RFC PATCH v0 2/2] powerpc,
 drmem: Rename DRMEM_LMB_RESERVED to DRMEM_LMB_ISOLATED
Date: Wed, 21 Feb 2018 16:06:27 +0530
In-Reply-To: <1519209387-29767-1-git-send-email-bharata@linux.vnet.ibm.com>
References: <1519209387-29767-1-git-send-email-bharata@linux.vnet.ibm.com>
Message-Id: <1519209387-29767-3-git-send-email-bharata@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Memory hotplug code uses a temporary LMB flags bit DRMEM_LMB_RESERVED
to mark the LMB which is currently undergoing hotplug or unplug.
It is easy to confuse DRMEM_LMB_RESERVED to mean the LMB is reserved
for which a separate flag bit already exists DRCONF_MEM_RESERVED. Since
both DRMEM_LMB_RESERVED and DRCONF_MEM_RESERVED operate on the same
LMB flags word, rename the former to DRMEM_LMB_ISOLATED.

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/drmem.h                | 14 ++++-----
 arch/powerpc/mm/drmem.c                         |  2 +-
 arch/powerpc/platforms/pseries/hotplug-memory.c | 40 ++++++++++++-------------
 3 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/include/asm/drmem.h b/arch/powerpc/include/asm/drmem.h
index ce242b9..b3fa3f7 100644
--- a/arch/powerpc/include/asm/drmem.h
+++ b/arch/powerpc/include/asm/drmem.h
@@ -72,21 +72,21 @@ static inline u32 drmem_lmb_size(void)
 	return drmem_info->lmb_size;
 }
 
-#define DRMEM_LMB_RESERVED	0x80000000
+#define DRMEM_LMB_ISOLATED	0x80000000
 
-static inline void drmem_mark_lmb_reserved(struct drmem_lmb *lmb)
+static inline void drmem_mark_lmb_isolated(struct drmem_lmb *lmb)
 {
-	lmb->flags |= DRMEM_LMB_RESERVED;
+	lmb->flags |= DRMEM_LMB_ISOLATED;
 }
 
-static inline void drmem_remove_lmb_reservation(struct drmem_lmb *lmb)
+static inline void drmem_remove_lmb_isolation(struct drmem_lmb *lmb)
 {
-	lmb->flags &= ~DRMEM_LMB_RESERVED;
+	lmb->flags &= ~DRMEM_LMB_ISOLATED;
 }
 
-static inline bool drmem_lmb_reserved(struct drmem_lmb *lmb)
+static inline bool drmem_lmb_isolated(struct drmem_lmb *lmb)
 {
-	return lmb->flags & DRMEM_LMB_RESERVED;
+	return lmb->flags & DRMEM_LMB_ISOLATED;
 }
 
 u64 drmem_lmb_memory_max(void);
diff --git a/arch/powerpc/mm/drmem.c b/arch/powerpc/mm/drmem.c
index 3f18036..652bf3a 100644
--- a/arch/powerpc/mm/drmem.c
+++ b/arch/powerpc/mm/drmem.c
@@ -35,7 +35,7 @@ static u32 drmem_lmb_flags(struct drmem_lmb *lmb)
 	 * Return the value of the lmb flags field minus the reserved
 	 * bit used internally for hotplug processing.
 	 */
-	return lmb->flags & ~DRMEM_LMB_RESERVED;
+	return lmb->flags & ~DRMEM_LMB_ISOLATED;
 }
 
 static struct property *clone_property(struct property *prop, u32 prop_sz)
diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index c1578f5..2f5ca29 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -467,7 +467,7 @@ static int dlpar_memory_remove_by_count(u32 lmbs_to_remove)
 		/* Mark this lmb so we can add it later if all of the
 		 * requested LMBs cannot be removed.
 		 */
-		drmem_mark_lmb_reserved(lmb);
+		drmem_mark_lmb_isolated(lmb);
 
 		lmbs_removed++;
 		if (lmbs_removed == lmbs_to_remove)
@@ -478,7 +478,7 @@ static int dlpar_memory_remove_by_count(u32 lmbs_to_remove)
 		pr_err("Memory hot-remove failed, adding LMB's back\n");
 
 		for_each_drmem_lmb(lmb) {
-			if (!drmem_lmb_reserved(lmb))
+			if (!drmem_lmb_isolated(lmb))
 				continue;
 
 			rc = dlpar_add_lmb(lmb);
@@ -486,20 +486,20 @@ static int dlpar_memory_remove_by_count(u32 lmbs_to_remove)
 				pr_err("Failed to add LMB back, drc index %x\n",
 				       lmb->drc_index);
 
-			drmem_remove_lmb_reservation(lmb);
+			drmem_remove_lmb_isolation(lmb);
 		}
 
 		rc = -EINVAL;
 	} else {
 		for_each_drmem_lmb(lmb) {
-			if (!drmem_lmb_reserved(lmb))
+			if (!drmem_lmb_isolated(lmb))
 				continue;
 
 			dlpar_release_drc(lmb->drc_index);
 			pr_info("Memory at %llx was hot-removed\n",
 				lmb->base_addr);
 
-			drmem_remove_lmb_reservation(lmb);
+			drmem_remove_lmb_isolation(lmb);
 		}
 		rc = 0;
 	}
@@ -608,7 +608,7 @@ static int dlpar_memory_remove_by_ic(u32 lmbs_to_remove, u32 drc_index)
 		if (rc)
 			break;
 
-		drmem_mark_lmb_reserved(lmb);
+		drmem_mark_lmb_isolated(lmb);
 	}
 
 	if (rc) {
@@ -616,7 +616,7 @@ static int dlpar_memory_remove_by_ic(u32 lmbs_to_remove, u32 drc_index)
 
 
 		for_each_drmem_lmb_in_range(lmb, start_lmb, end_lmb) {
-			if (!drmem_lmb_reserved(lmb))
+			if (!drmem_lmb_isolated(lmb))
 				continue;
 
 			rc = dlpar_add_lmb(lmb);
@@ -624,19 +624,19 @@ static int dlpar_memory_remove_by_ic(u32 lmbs_to_remove, u32 drc_index)
 				pr_err("Failed to add LMB, drc index %x\n",
 				       lmb->drc_index);
 
-			drmem_remove_lmb_reservation(lmb);
+			drmem_remove_lmb_isolation(lmb);
 		}
 		rc = -EINVAL;
 	} else {
 		for_each_drmem_lmb_in_range(lmb, start_lmb, end_lmb) {
-			if (!drmem_lmb_reserved(lmb))
+			if (!drmem_lmb_isolated(lmb))
 				continue;
 
 			dlpar_release_drc(lmb->drc_index);
 			pr_info("Memory at %llx (drc index %x) was hot-removed\n",
 				lmb->base_addr, lmb->drc_index);
 
-			drmem_remove_lmb_reservation(lmb);
+			drmem_remove_lmb_isolation(lmb);
 		}
 	}
 
@@ -760,7 +760,7 @@ static int dlpar_memory_add_by_count(u32 lmbs_to_add)
 		/* Mark this lmb so we can remove it later if all of the
 		 * requested LMBs cannot be added.
 		 */
-		drmem_mark_lmb_reserved(lmb);
+		drmem_mark_lmb_isolated(lmb);
 
 		lmbs_added++;
 		if (lmbs_added == lmbs_to_add)
@@ -771,7 +771,7 @@ static int dlpar_memory_add_by_count(u32 lmbs_to_add)
 		pr_err("Memory hot-add failed, removing any added LMBs\n");
 
 		for_each_drmem_lmb(lmb) {
-			if (!drmem_lmb_reserved(lmb))
+			if (!drmem_lmb_isolated(lmb))
 				continue;
 
 			rc = dlpar_remove_lmb(lmb);
@@ -781,17 +781,17 @@ static int dlpar_memory_add_by_count(u32 lmbs_to_add)
 			else
 				dlpar_release_drc(lmb->drc_index);
 
-			drmem_remove_lmb_reservation(lmb);
+			drmem_remove_lmb_isolation(lmb);
 		}
 		rc = -EINVAL;
 	} else {
 		for_each_drmem_lmb(lmb) {
-			if (!drmem_lmb_reserved(lmb))
+			if (!drmem_lmb_isolated(lmb))
 				continue;
 
 			pr_info("Memory at %llx (drc index %x) was hot-added\n",
 				lmb->base_addr, lmb->drc_index);
-			drmem_remove_lmb_reservation(lmb);
+			drmem_remove_lmb_isolation(lmb);
 		}
 		rc = 0;
 	}
@@ -874,14 +874,14 @@ static int dlpar_memory_add_by_ic(u32 lmbs_to_add, u32 drc_index)
 			break;
 		}
 
-		drmem_mark_lmb_reserved(lmb);
+		drmem_mark_lmb_isolated(lmb);
 	}
 
 	if (rc) {
 		pr_err("Memory indexed-count-add failed, removing any added LMBs\n");
 
 		for_each_drmem_lmb_in_range(lmb, start_lmb, end_lmb) {
-			if (!drmem_lmb_reserved(lmb))
+			if (!drmem_lmb_isolated(lmb))
 				continue;
 
 			rc = dlpar_remove_lmb(lmb);
@@ -891,17 +891,17 @@ static int dlpar_memory_add_by_ic(u32 lmbs_to_add, u32 drc_index)
 			else
 				dlpar_release_drc(lmb->drc_index);
 
-			drmem_remove_lmb_reservation(lmb);
+			drmem_remove_lmb_isolation(lmb);
 		}
 		rc = -EINVAL;
 	} else {
 		for_each_drmem_lmb_in_range(lmb, start_lmb, end_lmb) {
-			if (!drmem_lmb_reserved(lmb))
+			if (!drmem_lmb_isolated(lmb))
 				continue;
 
 			pr_info("Memory at %llx (drc index %x) was hot-added\n",
 				lmb->base_addr, lmb->drc_index);
-			drmem_remove_lmb_reservation(lmb);
+			drmem_remove_lmb_isolation(lmb);
 		}
 	}
 
-- 
2.7.4
