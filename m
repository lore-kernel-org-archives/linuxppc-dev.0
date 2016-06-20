Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYC216Bh2zDq60
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 23:51:21 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5KDn2B8044837
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 09:51:19 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23mywvwq71-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 09:51:19 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 20 Jun 2016 07:51:17 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 196D13E40047
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 07:51:14 -0600 (MDT)
Received: from b03ledav002.gho.boulder.ibm.com
 (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5KDpEPR37486826
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 06:51:14 -0700
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E9D1613603C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 07:51:13 -0600 (MDT)
Received: from [9.41.92.173] (unknown [9.41.92.173])
 by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP id CA02313603A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 07:51:13 -0600 (MDT)
To: linuxppc-dev@lists.ozlabs.org
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/pseries: Auto online hotplugged memory
Date: Mon, 20 Jun 2016 08:51:12 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <5767F4D0.7070504@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Auto online hotplugged memory

A recent update (commit id 31bc3858ea3) to the core mm hotplug code
introduced the memhp_auto_online variable to allow for automatically
onlining memory that is added.

This patch update the pseries memory hotplug code to enable this so that
any memory DLPAR added to the system is automatically onlined. The code
to add the memory block for memory added from add_memory() is removed as
this is not needed, the memory_add code does this.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/hotplug-memory.c |   52 +++++------------------
 1 file changed, 11 insertions(+), 41 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 2ce1385..03f6169 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -533,50 +533,11 @@ static int dlpar_memory_remove_by_index(u32 drc_index, struct property *prop)
 
 #endif /* CONFIG_MEMORY_HOTREMOVE */
 
-static int dlpar_add_lmb_memory(struct of_drconf_cell *lmb)
+static int dlpar_add_lmb(struct of_drconf_cell *lmb)
 {
-	struct memory_block *mem_block;
 	unsigned long block_sz;
 	int nid, rc;
 
-	block_sz = memory_block_size_bytes();
-
-	/* Find the node id for this address */
-	nid = memory_add_physaddr_to_nid(lmb->base_addr);
-
-	/* Add the memory */
-	rc = add_memory(nid, lmb->base_addr, block_sz);
-	if (rc)
-		return rc;
-
-	/* Register this block of memory */
-	rc = memblock_add(lmb->base_addr, block_sz);
-	if (rc) {
-		remove_memory(nid, lmb->base_addr, block_sz);
-		return rc;
-	}
-
-	mem_block = lmb_to_memblock(lmb);
-	if (!mem_block) {
-		remove_memory(nid, lmb->base_addr, block_sz);
-		return -EINVAL;
-	}
-
-	rc = device_online(&mem_block->dev);
-	put_device(&mem_block->dev);
-	if (rc) {
-		remove_memory(nid, lmb->base_addr, block_sz);
-		return rc;
-	}
-
-	lmb->flags |= DRCONF_MEM_ASSIGNED;
-	return 0;
-}
-
-static int dlpar_add_lmb(struct of_drconf_cell *lmb)
-{
-	int rc;
-
 	if (lmb->flags & DRCONF_MEM_ASSIGNED)
 		return -EINVAL;
 
@@ -592,10 +553,19 @@ static int dlpar_add_lmb(struct of_drconf_cell *lmb)
 		return rc;
 	}
 
-	rc = dlpar_add_lmb_memory(lmb);
+	block_sz = memory_block_size_bytes();
+
+	/* Find the node id for this address */
+	nid = memory_add_physaddr_to_nid(lmb->base_addr);
+
+	/* Add and online memory */
+	memhp_auto_online = true;
+	rc = add_memory(nid, lmb->base_addr, block_sz);
 	if (rc) {
 		dlpar_remove_device_tree_lmb(lmb);
 		dlpar_release_drc(lmb->drc_index);
+	} else {
+		lmb->flags |= DRCONF_MEM_ASSIGNED;
 	}
 
 	return rc;
