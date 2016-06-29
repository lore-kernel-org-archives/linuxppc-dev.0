Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rfqFM6YDNzDqww
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 03:20:39 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5THIogv060368
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 13:20:37 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23v097vugx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 13:20:37 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Wed, 29 Jun 2016 13:20:36 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id EF0BD6E803C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 13:20:12 -0400 (EDT)
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5THKXd68716650
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 17:20:33 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 29B9F12403D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 13:20:31 -0400 (EDT)
Received: from [9.41.92.173] (unknown [9.41.92.173])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP id D49E6124037
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 13:20:30 -0400 (EDT)
Subject: [PATCH v2 2/2] powerpc/pseries: Remove call to memblock_add()
To: linuxppc-dev@lists.ozlabs.org
References: <5774027B.6070708@linux.vnet.ibm.com>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Wed, 29 Jun 2016 12:20:30 -0500
MIME-Version: 1.0
In-Reply-To: <5774027B.6070708@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <5774035E.3080403@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The call to memblock_add is not needed, this is already done by
memory_add(). This patch removes this call which shrinks
dlpar_add_lmb_memory() enough that it can be merged into dlpar_add_lmb().

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/hotplug-memory.c |   37 ++++++-----------------
 1 file changed, 10 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 076cd7e..43c8691 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -533,36 +533,11 @@ static int dlpar_memory_remove_by_index(u32 drc_index, struct property *prop)
 
 #endif /* CONFIG_MEMORY_HOTREMOVE */
 
-static int dlpar_add_lmb_memory(struct of_drconf_cell *lmb)
+static int dlpar_add_lmb(struct of_drconf_cell *lmb)
 {
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
 
@@ -578,10 +553,18 @@ static int dlpar_add_lmb(struct of_drconf_cell *lmb)
 		return rc;
 	}
 
-	rc = dlpar_add_lmb_memory(lmb);
+	block_sz = memory_block_size_bytes();
+
+	/* Find the node id for this address */
+	nid = memory_add_physaddr_to_nid(lmb->base_addr);
+
+	/* Add the memory */
+	rc = add_memory(nid, lmb->base_addr, block_sz);
 	if (rc) {
 		dlpar_remove_device_tree_lmb(lmb);
 		dlpar_release_drc(lmb->drc_index);
+	} else {
+		lmb->flags |= DRCONF_MEM_ASSIGNED;
 	}
 
 	return rc;
