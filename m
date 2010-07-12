Return-Path: <nfont@austin.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e8.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F1BCA1007D4
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jul 2010 01:46:27 +1000 (EST)
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e8.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o6CFY2qX022009
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jul 2010 11:34:02 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o6CFkF1M2183406
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jul 2010 11:46:16 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o6CFkFDq004922
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jul 2010 11:46:15 -0400
Message-ID: <4C3B38C6.3030806@austin.ibm.com>
Date: Mon, 12 Jul 2010 10:46:14 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] update the mutex name in the memory_block struct
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

This patch updates the name of the memory_block mutex
since it is now used for more than just gating changes
to the status of the memory section coveerd by the memory
sysfs directory.

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
---
 drivers/base/memory.c  |   20 ++++++++++----------
 include/linux/memory.h |    9 +--------
 2 files changed, 11 insertions(+), 18 deletions(-)

Index: linux-2.6/drivers/base/memory.c
===================================================================
--- linux-2.6.orig/drivers/base/memory.c	2010-07-09 14:38:09.000000000 -0500
+++ linux-2.6/drivers/base/memory.c	2010-07-09 14:38:18.000000000 -0500
@@ -242,7 +242,7 @@
 	struct list_head *pos;
 	int ret = 0;
 
-	mutex_lock(&mem->state_mutex);
+	mutex_lock(&mem->mutex);
 
 	list_for_each(pos, &mem->sections) {
 		mbs = list_entry(pos, struct memory_block_section, next);
@@ -272,7 +272,7 @@
 	if (!ret)
 		mem->state = to_state;
 
-	mutex_unlock(&mem->state_mutex);
+	mutex_unlock(&mem->mutex);
 	return ret;
 }
 
@@ -352,7 +352,7 @@
 	if (list_is_singular(&mem->sections))
 		return -EINVAL;
 
-	mutex_lock(&mem->state_mutex);
+	mutex_lock(&mem->mutex);
 
 	list_for_each(pos, &mem->sections) {
 		mbs = list_entry(pos, struct memory_block_section, next);
@@ -370,11 +370,11 @@
 	if (!new_mem_blk)
 		return -ENOMEM;
 
-	mutex_init(&new_mem_blk->state_mutex);
+	mutex_init(&new_mem_blk->mutex);
 	INIT_LIST_HEAD(&new_mem_blk->sections);
 	new_mem_blk->state = mem->state;
 
-	mutex_lock(&new_mem_blk->state_mutex);
+	mutex_lock(&new_mem_blk->mutex);
 
 	new_blk_total = total_scns / 2;
 	new_blk_min = max_scn_nr - new_blk_total + 1;
@@ -395,8 +395,8 @@
 	update_memory_block_phys_indexes(mem);
 	update_memory_block_phys_indexes(new_mem_blk);
 
-	mutex_unlock(&new_mem_blk->state_mutex);
-	mutex_unlock(&mem->state_mutex);
+	mutex_unlock(&new_mem_blk->mutex);
+	mutex_unlock(&mem->mutex);
 	return count;
 }
 
@@ -653,7 +653,7 @@
 			return -ENOMEM;
 
 		mem->state = state;
-		mutex_init(&mem->state_mutex);
+		mutex_init(&mem->mutex);
 		start_pfn = section_nr_to_pfn(__section_nr(section));
 		mem->phys_device = arch_get_memory_phys_device(start_pfn);
 		INIT_LIST_HEAD(&mem->sections);
@@ -680,7 +680,7 @@
 	int section_nr = __section_nr(section);
 
 	mem = find_memory_block(section);
-	mutex_lock(&mem->state_mutex);
+	mutex_lock(&mem->mutex);
 
 	/* remove the specified section */
 	list_for_each_safe(pos, tmp, &mem->sections) {
@@ -692,7 +692,7 @@
 		}
 	}
 
-	mutex_unlock(&mem->state_mutex);
+	mutex_unlock(&mem->mutex);
 
 	if (list_empty(&mem->sections)) {
 		unregister_mem_sect_under_nodes(mem);
Index: linux-2.6/include/linux/memory.h
===================================================================
--- linux-2.6.orig/include/linux/memory.h	2010-07-09 14:36:54.000000000 -0500
+++ linux-2.6/include/linux/memory.h	2010-07-09 14:38:18.000000000 -0500
@@ -31,14 +31,7 @@
 	unsigned long state;
 	unsigned long start_phys_index;
 	unsigned long end_phys_index;
-
-	/*
-	 * This serializes all state change requests.  It isn't
-	 * held during creation because the control files are
-	 * created long after the critical areas during
-	 * initialization.
-	 */
-	struct mutex state_mutex;
+	struct mutex mutex;
 	int phys_device;		/* to which fru does this belong? */
 	void *hw;			/* optional pointer to fw/hw data */
 	int (*phys_callback)(struct memory_block *);
