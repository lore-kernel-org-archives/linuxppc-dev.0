Return-Path: <jallen@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3twDzq6Zg3zDqW0
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Jan 2017 06:25:59 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v06JOFK0119199
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Jan 2017 14:25:57 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27tdwh01wm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Jan 2017 14:25:57 -0500
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <jallen@linux.vnet.ibm.com>;
 Fri, 6 Jan 2017 12:25:56 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id B7CCB19D804E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jan 2017 12:25:11 -0700 (MST)
Subject: [PATCH v3 1/3] powerpc/pseries: Make the acquire/release of the drc
 for memory a seperate step
To: linuxppc-dev@lists.ozlabs.org, Nathan Fontenot <nfont@linux.vnet.ibm.com>
References: <a4c3e5c2-18d8-0f01-272b-a3ae23318469@linux.vnet.ibm.com>
From: John Allen <jallen@linux.vnet.ibm.com>
Date: Fri, 6 Jan 2017 13:25:53 -0600
MIME-Version: 1.0
In-Reply-To: <a4c3e5c2-18d8-0f01-272b-a3ae23318469@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <02d198a9-5e64-74df-ac30-dec0a8a05ecc@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When adding and removing LMBs we should make the acquire/release of
the DRC a separate step to allow for a few improvements. First
this will ensure that LMBs removed during a remove by count operation
are all available if a error occurs and we need to add them back. By
first removeing all the LMBs from the kernel before releasing their
DRCs the LMBs are available to add back should an error occur.

Also, this will allow for faster re-add operations of memory for
PRRN event handling since we can skip the unneeded step of having
to release the DRC and the acquire it back.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Signed-off-by: John Allen <jallen@linux.vnet.ibm.com>
---
diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 76ec104..0eb4b1d 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -446,9 +446,7 @@ static int dlpar_remove_lmb(struct of_drconf_cell *lmb)
 	/* Update memory regions for memory remove */
 	memblock_remove(lmb->base_addr, block_sz);

-	dlpar_release_drc(lmb->drc_index);
 	dlpar_remove_device_tree_lmb(lmb);
-
 	return 0;
 }

@@ -513,6 +511,7 @@ static int dlpar_memory_remove_by_count(u32 lmbs_to_remove,
 			if (!lmbs[i].reserved)
 				continue;

+			dlpar_release_drc(lmbs[i].drc_index);
 			pr_info("Memory at %llx was hot-removed\n",
 				lmbs[i].base_addr);

@@ -542,6 +541,9 @@ static int dlpar_memory_remove_by_index(u32 drc_index, struct property *prop)
 		if (lmbs[i].drc_index == drc_index) {
 			lmb_found = 1;
 			rc = dlpar_remove_lmb(&lmbs[i]);
+			if (!rc)
+				dlpar_release_drc(lmbs[i].drc_index);
+
 			break;
 		}
 	}
@@ -596,10 +598,6 @@ static int dlpar_add_lmb(struct of_drconf_cell *lmb)
 	if (lmb->flags & DRCONF_MEM_ASSIGNED)
 		return -EINVAL;

-	rc = dlpar_acquire_drc(lmb->drc_index);
-	if (rc)
-		return rc;
-
 	rc = dlpar_add_device_tree_lmb(lmb);
 	if (rc) {
 		pr_err("Couldn't update device tree for drc index %x\n",
@@ -615,12 +613,10 @@ static int dlpar_add_lmb(struct of_drconf_cell *lmb)

 	/* Add the memory */
 	rc = add_memory(nid, lmb->base_addr, block_sz);
-	if (rc) {
+	if (rc)
 		dlpar_remove_device_tree_lmb(lmb);
-		dlpar_release_drc(lmb->drc_index);
-	} else {
+	else
 		lmb->flags |= DRCONF_MEM_ASSIGNED;
-	}

 	return rc;
 }
@@ -652,10 +648,16 @@ static int dlpar_memory_add_by_count(u32 lmbs_to_add, struct property *prop)
 		return -EINVAL;

 	for (i = 0; i < num_lmbs && lmbs_to_add != lmbs_added; i++) {
-		rc = dlpar_add_lmb(&lmbs[i]);
+		rc = dlpar_acquire_drc(lmbs[i].drc_index);
 		if (rc)
 			continue;

+		rc = dlpar_add_lmb(&lmbs[i]);
+		if (rc) {
+			dlpar_release_drc(lmbs[i].drc_index);
+			continue;
+		}
+
 		lmbs_added++;

 		/* Mark this lmb so we can remove it later if all of the
@@ -675,6 +677,8 @@ static int dlpar_memory_add_by_count(u32 lmbs_to_add, struct property *prop)
 			if (rc)
 				pr_err("Failed to remove LMB, drc index %x\n",
 				       be32_to_cpu(lmbs[i].drc_index));
+			else
+				dlpar_release_drc(lmbs[i].drc_index);
 		}
 		rc = -EINVAL;
 	} else {
@@ -708,7 +712,13 @@ static int dlpar_memory_add_by_index(u32 drc_index, struct property *prop)
 	for (i = 0; i < num_lmbs; i++) {
 		if (lmbs[i].drc_index == drc_index) {
 			lmb_found = 1;
-			rc = dlpar_add_lmb(&lmbs[i]);
+			rc = dlpar_acquire_drc(lmbs[i].drc_index);
+			if (!rc) {
+				rc = dlpar_add_lmb(&lmbs[i]);
+				if (rc)
+					dlpar_release_drc(lmbs[i].drc_index);
+			}
+
 			break;
 		}
 	}
