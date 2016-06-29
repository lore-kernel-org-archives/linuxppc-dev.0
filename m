Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rfqCr2fPBzDqvj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 03:19:19 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5THIpg5067973
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 13:19:17 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23uwt7twtf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 13:19:17 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Wed, 29 Jun 2016 11:19:16 -0600
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id B121BC40003
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 11:18:58 -0600 (MDT)
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5THJE4r54001716
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 17:19:14 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B06F2124035
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 13:19:14 -0400 (EDT)
Received: from [9.41.92.173] (unknown [9.41.92.173])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP id 84376124037
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 13:19:14 -0400 (EDT)
Subject: [PATCH v2 1/2] powerpc/pseries: Auto-online hotplugged memory
To: linuxppc-dev@lists.ozlabs.org
References: <5774027B.6070708@linux.vnet.ibm.com>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Wed, 29 Jun 2016 12:19:14 -0500
MIME-Version: 1.0
In-Reply-To: <5774027B.6070708@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <57740312.9090900@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A recent update (commit id 31bc3858ea3) allows for automatically
onlining memory that is added. This patch sets the config option
CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=y for pseries and updates the
pseries memory hotplug code so that DLPAR added memory can be
automatically onlined instead of explicitly onlining the memory.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/configs/pseries_defconfig          |    1 +
 arch/powerpc/platforms/pseries/hotplug-memory.c |   14 --------------
 2 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
index 36871a4..725f411 100644
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -53,6 +53,7 @@ CONFIG_KEXEC=y
 CONFIG_IRQ_ALL_CPUS=y
 CONFIG_MEMORY_HOTPLUG=y
 CONFIG_MEMORY_HOTREMOVE=y
+CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=y
 CONFIG_KSM=y
 CONFIG_TRANSPARENT_HUGEPAGE=y
 CONFIG_PPC_64K_PAGES=y
diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 2ce1385..076cd7e 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -535,7 +535,6 @@ static int dlpar_memory_remove_by_index(u32 drc_index, struct property *prop)
 
 static int dlpar_add_lmb_memory(struct of_drconf_cell *lmb)
 {
-	struct memory_block *mem_block;
 	unsigned long block_sz;
 	int nid, rc;
 
@@ -556,19 +555,6 @@ static int dlpar_add_lmb_memory(struct of_drconf_cell *lmb)
 		return rc;
 	}
 
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
 	lmb->flags |= DRCONF_MEM_ASSIGNED;
 	return 0;
 }
