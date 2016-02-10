Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9EDBB1A03B0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Feb 2016 04:10:52 +1100 (AEDT)
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Wed, 10 Feb 2016 12:10:50 -0500
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 78EF56E8040
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 11:57:37 -0500 (EST)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1AHAjsJ29360326
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 17:10:45 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1AH7Tdk023759
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 12:07:29 -0500
Received: from [9.41.105.104] ([9.41.105.104])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 u1AH7St1023733
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 12:07:29 -0500
Subject: [PATCH 1/3] powerpc/pseries: Refactor dlpar_add_lmb() code
To: linuxppc-dev@lists.ozlabs.org
References: <56BB6EA5.9090405@linux.vnet.ibm.com>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Message-ID: <56BB6F14.9020708@linux.vnet.ibm.com>
Date: Wed, 10 Feb 2016 11:10:44 -0600
MIME-Version: 1.0
In-Reply-To: <56BB6EA5.9090405@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Re-factor dlpar_lmb_add() routine by moving the validation of the lmb
flags and the acquireing of the DRC to a wrapper around the work to add
the memory to the system. This is done to make handling of errors
during the addition of the memory easier and to facilitate the upcoming
addition of updating the lmb's affinity prior to adding the memory.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/hotplug-memory.c |   34 ++++++++++++++---------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index e9ff44c..294acfd 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -384,43 +384,32 @@ static int dlpar_memory_remove_by_index(u32 drc_index, struct property *prop)
 
 #endif /* CONFIG_MEMORY_HOTREMOVE */
 
-static int dlpar_add_lmb(struct of_drconf_cell *lmb)
+static int dlpar_add_lmb_memory(struct of_drconf_cell *lmb)
 {
 	struct memory_block *mem_block;
 	unsigned long block_sz;
 	int nid, rc;
 
-	if (lmb->flags & DRCONF_MEM_ASSIGNED)
-		return -EINVAL;
-
 	block_sz = memory_block_size_bytes();
 
-	rc = dlpar_acquire_drc(lmb->drc_index);
-	if (rc)
-		return rc;
-
 	/* Find the node id for this address */
 	nid = memory_add_physaddr_to_nid(lmb->base_addr);
 
 	/* Add the memory */
 	rc = add_memory(nid, lmb->base_addr, block_sz);
-	if (rc) {
-		dlpar_release_drc(lmb->drc_index);
+	if (rc)
 		return rc;
-	}
 
 	/* Register this block of memory */
 	rc = memblock_add(lmb->base_addr, block_sz);
 	if (rc) {
 		remove_memory(nid, lmb->base_addr, block_sz);
-		dlpar_release_drc(lmb->drc_index);
 		return rc;
 	}
 
 	mem_block = lmb_to_memblock(lmb);
 	if (!mem_block) {
 		remove_memory(nid, lmb->base_addr, block_sz);
-		dlpar_release_drc(lmb->drc_index);
 		return -EINVAL;
 	}
 
@@ -428,7 +417,6 @@ static int dlpar_add_lmb(struct of_drconf_cell *lmb)
 	put_device(&mem_block->dev);
 	if (rc) {
 		remove_memory(nid, lmb->base_addr, block_sz);
-		dlpar_release_drc(lmb->drc_index);
 		return rc;
 	}
 
@@ -436,6 +424,24 @@ static int dlpar_add_lmb(struct of_drconf_cell *lmb)
 	return 0;
 }
 
+static int dlpar_add_lmb(struct of_drconf_cell *lmb)
+{
+	int rc;
+
+	if (lmb->flags & DRCONF_MEM_ASSIGNED)
+		return -EINVAL;
+
+	rc = dlpar_acquire_drc(lmb->drc_index);
+	if (rc)
+		return rc;
+
+	rc = dlpar_add_lmb_memory(lmb);
+	if (rc)
+		dlpar_release_drc(lmb->drc_index);
+
+	return rc;
+}
+
 static int dlpar_memory_add_by_count(u32 lmbs_to_add, struct property *prop)
 {
 	struct of_drconf_cell *lmbs;
