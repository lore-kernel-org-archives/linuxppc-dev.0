Return-Path: <nfont@austin.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3D736B70B1
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 13:57:41 +1000 (EST)
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e1.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o6K3q8fP032031
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Jul 2010 23:52:08 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o6K3vcXB1826908
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Jul 2010 23:57:38 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o6K3vboU014161
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Jul 2010 23:57:38 -0400
Message-ID: <4C451EAF.1080505@austin.ibm.com>
Date: Mon, 19 Jul 2010 22:57:35 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 6/8] v3 Update the node sysfs code
References: <4C451BF5.50304@austin.ibm.com>
In-Reply-To: <4C451BF5.50304@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: greg@kroah.com, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Update the node sysfs code to be aware of the new capability for a memory
block to contain multiple memory sections.  This requires an additional
parameter to unregister_mem_sect_under_nodes so that we know which memory
section of the memory block to unregister.

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
---
 drivers/base/memory.c |    2 +-
 drivers/base/node.c   |   12 ++++++++----
 include/linux/node.h  |    3 ++-
 3 files changed, 11 insertions(+), 6 deletions(-)

Index: linux-2.6/drivers/base/node.c
===================================================================
--- linux-2.6.orig/drivers/base/node.c	2010-07-19 21:10:25.000000000 -0500
+++ linux-2.6/drivers/base/node.c	2010-07-19 21:13:11.000000000 -0500
@@ -346,8 +346,10 @@ int register_mem_sect_under_node(struct
 		return -EFAULT;
 	if (!node_online(nid))
 		return 0;
-	sect_start_pfn = section_nr_to_pfn(mem_blk->phys_index);
-	sect_end_pfn = sect_start_pfn + PAGES_PER_SECTION - 1;
+
+	sect_start_pfn = section_nr_to_pfn(mem_blk->start_phys_index);
+	sect_end_pfn = section_nr_to_pfn(mem_blk->end_phys_index);
+	sect_end_pfn += PAGES_PER_SECTION - 1;
 	for (pfn = sect_start_pfn; pfn <= sect_end_pfn; pfn++) {
 		int page_nid;
 
@@ -371,7 +373,8 @@ int register_mem_sect_under_node(struct
 }
 
 /* unregister memory section under all nodes that it spans */
-int unregister_mem_sect_under_nodes(struct memory_block *mem_blk)
+int unregister_mem_sect_under_nodes(struct memory_block *mem_blk,
+				    unsigned long phys_index)
 {
 	NODEMASK_ALLOC(nodemask_t, unlinked_nodes, GFP_KERNEL);
 	unsigned long pfn, sect_start_pfn, sect_end_pfn;
@@ -383,7 +386,8 @@ int unregister_mem_sect_under_nodes(stru
 	if (!unlinked_nodes)
 		return -ENOMEM;
 	nodes_clear(*unlinked_nodes);
-	sect_start_pfn = section_nr_to_pfn(mem_blk->phys_index);
+
+	sect_start_pfn = section_nr_to_pfn(phys_index);
 	sect_end_pfn = sect_start_pfn + PAGES_PER_SECTION - 1;
 	for (pfn = sect_start_pfn; pfn <= sect_end_pfn; pfn++) {
 		int nid;
Index: linux-2.6/drivers/base/memory.c
===================================================================
--- linux-2.6.orig/drivers/base/memory.c	2010-07-19 21:12:22.000000000 -0500
+++ linux-2.6/drivers/base/memory.c	2010-07-19 21:13:11.000000000 -0500
@@ -550,9 +550,9 @@ int remove_memory_block(unsigned long no
 
 	mem = find_memory_block(section);
 	atomic_dec(&mem->section_count);
+	unregister_mem_sect_under_nodes(mem, __section_nr(section));
 
 	if (atomic_read(&mem->section_count) == 0) {
-		unregister_mem_sect_under_nodes(mem);
 		mem_remove_simple_file(mem, start_phys_index);
 		mem_remove_simple_file(mem, end_phys_index);
 		mem_remove_simple_file(mem, state);
Index: linux-2.6/include/linux/node.h
===================================================================
--- linux-2.6.orig/include/linux/node.h	2010-07-19 21:10:25.000000000 -0500
+++ linux-2.6/include/linux/node.h	2010-07-19 21:13:11.000000000 -0500
@@ -44,7 +44,8 @@ extern int register_cpu_under_node(unsig
 extern int unregister_cpu_under_node(unsigned int cpu, unsigned int nid);
 extern int register_mem_sect_under_node(struct memory_block *mem_blk,
 						int nid);
-extern int unregister_mem_sect_under_nodes(struct memory_block *mem_blk);
+extern int unregister_mem_sect_under_nodes(struct memory_block *mem_blk,
+					   unsigned long phys_index);
 
 #ifdef CONFIG_HUGETLBFS
 extern void register_hugetlbfs_with_node(node_registration_func_t doregister,
