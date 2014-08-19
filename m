Return-Path: <tlfalcon@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 71CDB1A001D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Aug 2014 06:45:06 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tlfalcon@linux.vnet.ibm.com>;
 Tue, 19 Aug 2014 16:45:04 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id CA9306E802A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Aug 2014 16:44:50 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s7JKj1sX7536976
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Aug 2014 20:45:01 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s7JKj0Hk016006
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Aug 2014 16:45:01 -0400
From: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/pseries: Fix endian issues in memory hotplug
Date: Tue, 19 Aug 2014 15:44:57 -0500
Message-Id: <1408481097-26999-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
Cc: nfont@linux.vnet.ibm.com, Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Values acquired from Open Firmware are in 32-bit big endian format
and need to be handled on little endian architectures.  This patch
ensures values are in cpu endian when hotplugging memory.

Signed-off-by: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/hotplug-memory.c | 36 +++++++++++++------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index c904583..17ee193 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -113,7 +113,7 @@ out:
 static int pseries_remove_mem_node(struct device_node *np)
 {
 	const char *type;
-	const unsigned int *regs;
+	const __be32 *regs;
 	unsigned long base;
 	unsigned int lmb_size;
 	int ret = -EINVAL;
@@ -132,8 +132,8 @@ static int pseries_remove_mem_node(struct device_node *np)
 	if (!regs)
 		return ret;
 
-	base = *(unsigned long *)regs;
-	lmb_size = regs[3];
+	base = be64_to_cpu(*(unsigned long *)regs);
+	lmb_size = be32_to_cpu(regs[3]);
 
 	pseries_remove_memblock(base, lmb_size);
 	return 0;
@@ -153,7 +153,7 @@ static inline int pseries_remove_mem_node(struct device_node *np)
 static int pseries_add_mem_node(struct device_node *np)
 {
 	const char *type;
-	const unsigned int *regs;
+	const __be32 *regs;
 	unsigned long base;
 	unsigned int lmb_size;
 	int ret = -EINVAL;
@@ -172,8 +172,8 @@ static int pseries_add_mem_node(struct device_node *np)
 	if (!regs)
 		return ret;
 
-	base = *(unsigned long *)regs;
-	lmb_size = regs[3];
+	base = be64_to_cpu(*(unsigned long *)regs);
+	lmb_size = be32_to_cpu(regs[3]);
 
 	/*
 	 * Update memory region to represent the memory add
@@ -187,14 +187,14 @@ static int pseries_update_drconf_memory(struct of_prop_reconfig *pr)
 	struct of_drconf_cell *new_drmem, *old_drmem;
 	unsigned long memblock_size;
 	u32 entries;
-	u32 *p;
+	__be32 *p;
 	int i, rc = -EINVAL;
 
 	memblock_size = pseries_memory_block_size();
 	if (!memblock_size)
 		return -EINVAL;
 
-	p = (u32 *) pr->old_prop->value;
+	p = (__be32 *) pr->old_prop->value;
 	if (!p)
 		return -EINVAL;
 
@@ -203,28 +203,30 @@ static int pseries_update_drconf_memory(struct of_prop_reconfig *pr)
 	 * entries. Get the niumber of entries and skip to the array of
 	 * of_drconf_cell's.
 	 */
-	entries = *p++;
+	entries = be32_to_cpu(*p++);
 	old_drmem = (struct of_drconf_cell *)p;
 
-	p = (u32 *)pr->prop->value;
+	p = (__be32 *)pr->prop->value;
 	p++;
 	new_drmem = (struct of_drconf_cell *)p;
 
 	for (i = 0; i < entries; i++) {
-		if ((old_drmem[i].flags & DRCONF_MEM_ASSIGNED) &&
-		    (!(new_drmem[i].flags & DRCONF_MEM_ASSIGNED))) {
-			rc = pseries_remove_memblock(old_drmem[i].base_addr,
+		if ((be32_to_cpu(old_drmem[i].flags) & DRCONF_MEM_ASSIGNED) &&
+		    (!(be32_to_cpu(new_drmem[i].flags) & DRCONF_MEM_ASSIGNED))) {
+			rc = pseries_remove_memblock(
+				be64_to_cpu(old_drmem[i].base_addr),
 						     memblock_size);
 			break;
-		} else if ((!(old_drmem[i].flags & DRCONF_MEM_ASSIGNED)) &&
-			   (new_drmem[i].flags & DRCONF_MEM_ASSIGNED)) {
-			rc = memblock_add(old_drmem[i].base_addr,
+		} else if ((!(be32_to_cpu(old_drmem[i].flags) &
+			    DRCONF_MEM_ASSIGNED)) &&
+			    (be32_to_cpu(new_drmem[i].flags) &
+			    DRCONF_MEM_ASSIGNED)) {
+			rc = memblock_add(be64_to_cpu(old_drmem[i].base_addr),
 					  memblock_size);
 			rc = (rc < 0) ? -EINVAL : 0;
 			break;
 		}
 	}
-
 	return rc;
 }
 
-- 
1.8.5.2
