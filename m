Return-Path: <jallen@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tfnq94cmSzDw9p
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Dec 2016 09:16:53 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBFMDmYJ080861
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2016 17:16:51 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0b-001b2d01.pphosted.com with ESMTP id 27c3n6gj1w-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2016 17:16:51 -0500
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <jallen@linux.vnet.ibm.com>;
 Thu, 15 Dec 2016 15:16:50 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 139651FF0029
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2016 15:16:26 -0700 (MST)
Subject: [PATCH v2 1/3] powerpc/pseries: Make the acquire/release of the drc
 for memory a seperate step
To: linuxppc-dev@lists.ozlabs.org, Nathan Fontenot <nfont@linux.vnet.ibm.com>
References: <ef5af85a-5692-6a2b-8fae-5500d3880336@linux.vnet.ibm.com>
From: John Allen <jallen@linux.vnet.ibm.com>
Date: Thu, 15 Dec 2016 16:16:46 -0600
MIME-Version: 1.0
In-Reply-To: <ef5af85a-5692-6a2b-8fae-5500d3880336@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <486213c3-fd3e-67fe-1031-8e107fbf582a@linux.vnet.ibm.com>
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
 arch/powerpc/platforms/pseries/hotplug-memory.c |   34 +++++++++++++++--------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 2617f9f..be11fc3 100644
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

@@ -516,6 +514,7 @@ static int dlpar_memory_remove_by_count(u32 lmbs_to_remove,
 			if (!lmbs[i].reserved)
 				continue;

+			dlpar_release_drc(lmbs[i].drc_index);
 			pr_info("Memory at %llx was hot-removed\n",
 				lmbs[i].base_addr);

@@ -545,6 +544,9 @@ static int dlpar_memory_remove_by_index(u32 drc_index, struct property *prop)
 		if (lmbs[i].drc_index == drc_index) {
 			lmb_found = 1;
 			rc = dlpar_remove_lmb(&lmbs[i]);
+			if (!rc)
+				dlpar_release_drc(lmbs[i].drc_index);
+
 			break;
 		}
 	}
@@ -599,10 +601,6 @@ static int dlpar_add_lmb(struct of_drconf_cell *lmb)
 	if (lmb->flags & DRCONF_MEM_ASSIGNED)
 		return -EINVAL;

-	rc = dlpar_acquire_drc(lmb->drc_index);
-	if (rc)
-		return rc;
-
 	rc = dlpar_add_device_tree_lmb(lmb);
 	if (rc) {
 		pr_err("Couldn't update device tree for drc index %x\n",
@@ -618,12 +616,10 @@ static int dlpar_add_lmb(struct of_drconf_cell *lmb)

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
@@ -655,10 +651,16 @@ static int dlpar_memory_add_by_count(u32 lmbs_to_add, struct property *prop)
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
@@ -678,6 +680,8 @@ static int dlpar_memory_add_by_count(u32 lmbs_to_add, struct property *prop)
 			if (rc)
 				pr_err("Failed to remove LMB, drc index %x\n",
 				       be32_to_cpu(lmbs[i].drc_index));
+			else
+				dlpar_release_drc(lmbs[i].drc_index);
 		}
 		rc = -EINVAL;
 	} else {
@@ -711,7 +715,13 @@ static int dlpar_memory_add_by_index(u32 drc_index, struct property *prop)
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
