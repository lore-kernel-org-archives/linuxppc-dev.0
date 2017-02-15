Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vNpQ56bDJzDqCg
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 05:55:25 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1FIra8L154023
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 13:55:23 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28mq9tygfn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 13:55:23 -0500
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Wed, 15 Feb 2017 11:55:22 -0700
Subject: [PATCH v7 2/4] powerpc/pseries: Revert 'Auto-online hotplugged memory'
To: linuxppc-dev@lists.ozlabs.org
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Cc: jallen@linux.vnet.ibm.com, sahilmehta17@gmail.com,
 mdroth@linux.vnet.ibm.com, david@gibson.dropbear.id.au
Date: Wed, 15 Feb 2017 13:45:30 -0500
In-Reply-To: <20170215184321.11755.88199.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
References: <20170215184321.11755.88199.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20170215184528.11755.568.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Revert the patch patch to auto-online hotplugged memory, commit
id ec999072442a. Using the auto-online acpability does online added
memory but does not update the associated device struct to
indicate that the memory is online. The result of this is that
memoryXX/online file in sysfs still reports the memory as being offline.

Additionally, not updating the device struct to indicate the memory
is online will cause the pseries memory DLPAR code to fail when trying
to remove a LMB that was previously removed and added back. This happens
when validating that the LMB is removable.

Looking further into the auto-online memory, it seems that this
capability is meant more for something like a balloon driver rather than
general memory hotplug.

This patch reverts to the previous behavior of calling device_online()
to online the LMB when it is DLPAR added and moves the lmb_to_memblock()
routine out of CONFIG_MEMORY_HOTREMOVE now that we call it for add.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/configs/pseries_defconfig          |    1 
 arch/powerpc/platforms/pseries/hotplug-memory.c |   52 ++++++++++++++++-------
 2 files changed, 37 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
index d99734f..28fc0c9 100644
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -56,7 +56,6 @@ CONFIG_KEXEC_FILE=y
 CONFIG_IRQ_ALL_CPUS=y
 CONFIG_MEMORY_HOTPLUG=y
 CONFIG_MEMORY_HOTREMOVE=y
-CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=y
 CONFIG_KSM=y
 CONFIG_TRANSPARENT_HUGEPAGE=y
 CONFIG_PPC_64K_PAGES=y
diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index f971ea0..9609a72 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -320,6 +320,19 @@ static int dlpar_remove_device_tree_lmb(struct of_drconf_cell *lmb)
 	return dlpar_update_device_tree_lmb(lmb);
 }
 
+static struct memory_block *lmb_to_memblock(struct of_drconf_cell *lmb)
+{
+	unsigned long section_nr;
+	struct mem_section *mem_sect;
+	struct memory_block *mem_block;
+
+	section_nr = pfn_to_section_nr(PFN_DOWN(lmb->base_addr));
+	mem_sect = __nr_to_section(section_nr);
+
+	mem_block = find_memory_block(mem_sect);
+	return mem_block;
+}
+
 #ifdef CONFIG_MEMORY_HOTREMOVE
 static int pseries_remove_memblock(unsigned long base, unsigned int memblock_size)
 {
@@ -407,19 +420,6 @@ static bool lmb_is_removable(struct of_drconf_cell *lmb)
 
 static int dlpar_add_lmb(struct of_drconf_cell *);
 
-static struct memory_block *lmb_to_memblock(struct of_drconf_cell *lmb)
-{
-	unsigned long section_nr;
-	struct mem_section *mem_sect;
-	struct memory_block *mem_block;
-
-	section_nr = pfn_to_section_nr(PFN_DOWN(lmb->base_addr));
-	mem_sect = __nr_to_section(section_nr);
-
-	mem_block = find_memory_block(mem_sect);
-	return mem_block;
-}
-
 static int dlpar_remove_lmb(struct of_drconf_cell *lmb)
 {
 	struct memory_block *mem_block;
@@ -636,6 +636,20 @@ static int dlpar_memory_readd_by_index(u32 drc_index, struct property *prop)
 
 #endif /* CONFIG_MEMORY_HOTREMOVE */
 
+static int dlpar_online_lmb(struct of_drconf_cell *lmb)
+{
+	struct memory_block *mem_block;
+	int rc;
+
+	mem_block = lmb_to_memblock(lmb);
+	if (!mem_block)
+		return -EINVAL;
+
+	rc = device_online(&mem_block->dev);
+	put_device(&mem_block->dev);
+	return rc;
+}
+
 static int dlpar_add_lmb(struct of_drconf_cell *lmb)
 {
 	unsigned long block_sz;
@@ -659,10 +673,18 @@ static int dlpar_add_lmb(struct of_drconf_cell *lmb)
 
 	/* Add the memory */
 	rc = add_memory(nid, lmb->base_addr, block_sz);
-	if (rc)
+	if (rc) {
 		dlpar_remove_device_tree_lmb(lmb);
-	else
+		return rc;
+	}
+
+	rc = dlpar_online_lmb(lmb);
+	if (rc) {
+		remove_memory(nid, lmb->base_addr, block_sz);
+		dlpar_remove_device_tree_lmb(lmb);
+	} else {
 		lmb->flags |= DRCONF_MEM_ASSIGNED;
+	}
 
 	return rc;
 }
