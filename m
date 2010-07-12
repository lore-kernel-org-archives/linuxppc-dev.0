Return-Path: <nfont@austin.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B0BD81007DD
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jul 2010 01:47:15 +1000 (EST)
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e3.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o6CFWufi002658
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jul 2010 11:32:56 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o6CFlCoP115536
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jul 2010 11:47:12 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o6CFlCrC010663
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jul 2010 11:47:12 -0400
Message-ID: <4C3B3900.6050000@austin.ibm.com>
Date: Mon, 12 Jul 2010 10:47:12 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] Update sysfs node routines for new sysfs memory
	directories
References: <4C3B3446.5090302@austin.ibm.com>
In-Reply-To: <4C3B3446.5090302@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch updates the node sysfs directory routines that create
links to the memory sections under each node.  This update makes
the node code aware that a memory sysfs directory can cover
multiple memory sections.

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>

---
 drivers/base/node.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

Index: linux-2.6/drivers/base/node.c
===================================================================
--- linux-2.6.orig/drivers/base/node.c	2010-07-09 14:36:53.000000000 -0500
+++ linux-2.6/drivers/base/node.c	2010-07-09 14:38:22.000000000 -0500
@@ -346,8 +346,10 @@
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
 
@@ -383,8 +385,10 @@
 	if (!unlinked_nodes)
 		return -ENOMEM;
 	nodes_clear(*unlinked_nodes);
-	sect_start_pfn = section_nr_to_pfn(mem_blk->phys_index);
-	sect_end_pfn = sect_start_pfn + PAGES_PER_SECTION - 1;
+
+	sect_start_pfn = section_nr_to_pfn(mem_blk->start_phys_index);
+	sect_end_pfn = section_nr_to_pfn(mem_blk->end_phys_index);
+	sect_end_pfn += PAGES_PER_SECTION - 1;
 	for (pfn = sect_start_pfn; pfn <= sect_end_pfn; pfn++) {
 		int nid;
