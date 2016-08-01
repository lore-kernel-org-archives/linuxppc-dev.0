Return-Path: <alastair@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s2qL02HG2zDqPn
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Aug 2016 16:34:00 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u716SmYN131253
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Aug 2016 02:33:58 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24grr95wte-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Aug 2016 02:33:57 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <alastair@au1.ibm.com>;
 Mon, 1 Aug 2016 16:33:55 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id B06692CE805C
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Aug 2016 16:33:52 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u716XqQL22085782
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Aug 2016 16:33:52 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u716Xq4i010815
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Aug 2016 16:33:52 +1000
From: alastair@au1.ibm.com
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Cc: "Alastair D'Silva" <alastair@d-silva.org>
Subject: [PATCH] powerpc: Fix unused function warning 'lmb_to_memblock'
Date: Mon,  1 Aug 2016 16:32:51 +1000
Message-Id: <1470033171-20843-1-git-send-email-alastair@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Alastair D'Silva <alastair@d-silva.org>

This patch fixes the following warning:
arch/powerpc/platforms/pseries/hotplug-memory.c:323:29: error: 'lmb_to_memblock' defined but not used [-Werror=unused-function]
static struct memory_block *lmb_to_memblock(struct of_drconf_cell *lmb)
                           ^~~~~~~~~~~~~~~

The only consumer of this function is 'dlpar_remove_lmb', which is
enabled with CONFIG_MEMORY_HOTREMOVE, so move it into the same
ifdef block.
---
 arch/powerpc/platforms/pseries/hotplug-memory.c | 26 ++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 43f7beb..76ec104 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -320,19 +320,6 @@ static int dlpar_remove_device_tree_lmb(struct of_drconf_cell *lmb)
 	return dlpar_update_device_tree_lmb(lmb);
 }
 
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
 #ifdef CONFIG_MEMORY_HOTREMOVE
 static int pseries_remove_memblock(unsigned long base, unsigned int memblock_size)
 {
@@ -420,6 +407,19 @@ static bool lmb_is_removable(struct of_drconf_cell *lmb)
 
 static int dlpar_add_lmb(struct of_drconf_cell *);
 
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
 static int dlpar_remove_lmb(struct of_drconf_cell *lmb)
 {
 	struct memory_block *mem_block;
-- 
2.7.4
