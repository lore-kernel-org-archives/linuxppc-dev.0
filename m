Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41H96r5WjGzF1SJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2018 18:39:16 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5T8d3LK101416
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2018 04:39:14 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jwh5x8qne-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2018 04:39:14 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Fri, 29 Jun 2018 02:39:13 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: npiggin@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH] powerpc/mm/hash: Improve error reporting on HCALL failures
Date: Fri, 29 Jun 2018 14:09:04 +0530
Message-Id: <20180629083904.29250-1-aneesh.kumar@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds error reporting to H_ENTER and H_READ hcalls. A failure for
both these hcalls are mostly fatal and it would be good to log the failure
reason.

We also switch printk to pr_*

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/lpar.c | 56 ++++++++++++++-------------
 1 file changed, 29 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 5a392e40f3d2..a3b2a1eb8bfd 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -21,6 +21,7 @@
 
 /* Enables debugging of low-level hash table routines - careful! */
 #undef DEBUG
+#define pr_fmt(fmt) "lpar: " fmt
 
 #include <linux/kernel.h>
 #include <linux/dma-mapping.h>
@@ -165,8 +166,7 @@ static long pSeries_lpar_hpte_insert(unsigned long hpte_group,
 
 	lpar_rc = plpar_pte_enter(flags, hpte_group, hpte_v, hpte_r, &slot);
 	if (unlikely(lpar_rc == H_PTEG_FULL)) {
-		if (!(vflags & HPTE_V_BOLTED))
-			pr_devel(" full\n");
+		pr_devel("Hash table group is full\n");
 		return -1;
 	}
 
@@ -176,14 +176,17 @@ static long pSeries_lpar_hpte_insert(unsigned long hpte_group,
 	 * or we will loop forever, so return -2 in this case.
 	 */
 	if (unlikely(lpar_rc != H_SUCCESS)) {
-		if (!(vflags & HPTE_V_BOLTED))
-			pr_devel(" lpar err %ld\n", lpar_rc);
+		pr_err("Failed hash pte insert with error %ld\n", lpar_rc);
 		return -2;
 	}
+	/*
+	 * Avoid all the boot debug prints.
+	 */
 	if (!(vflags & HPTE_V_BOLTED))
 		pr_devel(" -> slot: %lu\n", slot & 7);
 
-	/* Because of iSeries, we have to pass down the secondary
+	/*
+	 * Because of iSeries, we have to pass down the secondary
 	 * bucket bit here as well
 	 */
 	return (slot & 7) | (!!(vflags & HPTE_V_SECONDARY) << 3);
@@ -240,8 +243,11 @@ static void manual_hpte_clear_all(void)
          */
 	for (i = 0; i < hpte_count; i += 4) {
 		lpar_rc = plpar_pte_read_4_raw(0, i, (void *)ptes);
-		if (lpar_rc != H_SUCCESS)
+		if (lpar_rc != H_SUCCESS) {
+			pr_info("Failed to read hash page table at %ld err %ld\n",
+				i, lpar_rc);
 			continue;
+		}
 		for (j = 0; j < 4; j++){
 			if ((ptes[j].pteh & HPTE_V_VRMA_MASK) ==
 				HPTE_V_VRMA_MASK)
@@ -340,8 +346,11 @@ static long __pSeries_lpar_hpte_find(unsigned long want_v, unsigned long hpte_gr
 	for (i = 0; i < HPTES_PER_GROUP; i += 4, hpte_group += 4) {
 
 		lpar_rc = plpar_pte_read_4(0, hpte_group, (void *)ptes);
-		if (lpar_rc != H_SUCCESS)
+		if (lpar_rc != H_SUCCESS) {
+			pr_info("Failed to read hash page table at %ld err %ld\n",
+				hpte_group, lpar_rc);
 			continue;
+		}
 
 		for (j = 0; j < 4; j++) {
 			if (HPTE_V_COMPARE(ptes[j].pteh, want_v) &&
@@ -612,8 +621,8 @@ static int __init disable_bulk_remove(char *str)
 {
 	if (strcmp(str, "off") == 0 &&
 	    firmware_has_feature(FW_FEATURE_BULK_REMOVE)) {
-			printk(KERN_INFO "Disabling BULK_REMOVE firmware feature");
-			powerpc_firmware_features &= ~FW_FEATURE_BULK_REMOVE;
+		pr_info("Disabling BULK_REMOVE firmware feature");
+		powerpc_firmware_features &= ~FW_FEATURE_BULK_REMOVE;
 	}
 	return 1;
 }
@@ -659,8 +668,7 @@ static int pseries_lpar_resize_hpt(unsigned long shift)
 	if (!firmware_has_feature(FW_FEATURE_HPT_RESIZE))
 		return -ENODEV;
 
-	printk(KERN_INFO "lpar: Attempting to resize HPT to shift %lu\n",
-	       shift);
+	pr_info("Attempting to resize HPT to shift %lu\n", shift);
 
 	t0 = ktime_get();
 
@@ -672,8 +680,7 @@ static int pseries_lpar_resize_hpt(unsigned long shift)
 			/* prepare with shift==0 cancels an in-progress resize */
 			rc = plpar_resize_hpt_prepare(0, 0);
 			if (rc != H_SUCCESS)
-				printk(KERN_WARNING
-				       "lpar: Unexpected error %d cancelling timed out HPT resize\n",
+				pr_warn("Unexpected error %d cancelling timed out HPT resize\n",
 				       rc);
 			return -ETIMEDOUT;
 		}
@@ -691,9 +698,7 @@ static int pseries_lpar_resize_hpt(unsigned long shift)
 	case H_RESOURCE:
 		return -EPERM;
 	default:
-		printk(KERN_WARNING
-		       "lpar: Unexpected error %d from H_RESIZE_HPT_PREPARE\n",
-		       rc);
+		pr_warn("Unexpected error %d from H_RESIZE_HPT_PREPARE\n", rc);
 		return -EIO;
 	}
 
@@ -706,22 +711,19 @@ static int pseries_lpar_resize_hpt(unsigned long shift)
 	if (rc != 0) {
 		switch (state.commit_rc) {
 		case H_PTEG_FULL:
-			printk(KERN_WARNING
-			       "lpar: Hash collision while resizing HPT\n");
+			pr_warn("Hash collision while resizing HPT\n");
 			return -ENOSPC;
 
 		default:
-			printk(KERN_WARNING
-			       "lpar: Unexpected error %d from H_RESIZE_HPT_COMMIT\n",
-			       state.commit_rc);
+			pr_warn("Unexpected error %d from H_RESIZE_HPT_COMMIT\n",
+				state.commit_rc);
 			return -EIO;
 		};
 	}
 
-	printk(KERN_INFO
-	       "lpar: HPT resize to shift %lu complete (%lld ms / %lld ms)\n",
-	       shift, (long long) ktime_ms_delta(t1, t0),
-	       (long long) ktime_ms_delta(t2, t1));
+	pr_info("HPT resize to shift %lu complete (%lld ms / %lld ms)\n",
+		shift, (long long) ktime_ms_delta(t1, t0),
+		(long long) ktime_ms_delta(t2, t1));
 
 	return 0;
 }
@@ -785,13 +787,13 @@ static int __init cmo_free_hint(char *str)
 	parm = strstrip(str);
 
 	if (strcasecmp(parm, "no") == 0 || strcasecmp(parm, "off") == 0) {
-		printk(KERN_INFO "cmo_free_hint: CMO free page hinting is not active.\n");
+		pr_info("%s: CMO free page hinting is not active.\n", __func__);
 		cmo_free_hint_flag = 0;
 		return 1;
 	}
 
 	cmo_free_hint_flag = 1;
-	printk(KERN_INFO "cmo_free_hint: CMO free page hinting is active.\n");
+	pr_info("%s: CMO free page hinting is active.\n", __func__);
 
 	if (strcasecmp(parm, "yes") == 0 || strcasecmp(parm, "on") == 0)
 		return 1;
-- 
2.17.1
