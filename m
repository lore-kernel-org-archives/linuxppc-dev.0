Return-Path: <nfont@austin.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2F727B6F70
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 27 Sep 2011 01:23:25 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p8QFNCHG014394
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2011 09:23:12 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p8QFN3DT097468
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2011 09:23:04 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p8QFN2vM018951
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2011 09:23:02 -0600
Message-ID: <4E8098B9.1080702@austin.ibm.com>
Date: Mon, 26 Sep 2011 10:22:33 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Greg KH <gregkh@suse.de>
Subject: [PATCH] memory hotplug: Correct page reservation checking
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The check to ensure that pages of recently added memory sections are correctly
marked as reserved before trying to online the memory is broken.  The request
to online the memory fails with the following:

kernel: section number XXX page number 256 not reserved, was it already online?

This updates the page reservation checking to check the pages of each memory
section of the memory block being onlined individually.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 drivers/base/memory.c |   60 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 37 insertions(+), 23 deletions(-)

Index: linux/drivers/base/memory.c
===================================================================
--- linux.orig/drivers/base/memory.c	2011-09-26 08:33:14.000000000 -0500
+++ linux/drivers/base/memory.c	2011-09-26 08:42:14.000000000 -0500
@@ -227,41 +227,42 @@
  * MEMORY_HOTPLUG depends on SPARSEMEM in mm/Kconfig, so it is
  * OK to have direct references to sparsemem variables in here.
  */
+static int check_page_reservations(unsigned long phys_index)
+{
+	int i;
+	struct page *page;
+
+	page = pfn_to_page(phys_index << PFN_SECTION_SHIFT);
+
+	for (i = 0; i < PAGES_PER_SECTION; i++) {
+		if (PageReserved(page + i))
+			continue;
+
+		printk(KERN_WARNING "section number %ld page number %d "
+			"not reserved, was it already online?\n", phys_index, i);
+			return -EBUSY;
+	}
+
+	return 0;
+}
+
 static int
 memory_block_action(unsigned long phys_index, unsigned long action)
 {
-	int i;
 	unsigned long start_pfn, start_paddr;
 	unsigned long nr_pages = PAGES_PER_SECTION * sections_per_block;
-	struct page *first_page;
+	struct page *page;
 	int ret;
 
-	first_page = pfn_to_page(phys_index << PFN_SECTION_SHIFT);
-
-	/*
-	 * The probe routines leave the pages reserved, just
-	 * as the bootmem code does.  Make sure they're still
-	 * that way.
-	 */
-	if (action == MEM_ONLINE) {
-		for (i = 0; i < nr_pages; i++) {
-			if (PageReserved(first_page+i))
-				continue;
-
-			printk(KERN_WARNING "section number %ld page number %d "
-				"not reserved, was it already online?\n",
-				phys_index, i);
-			return -EBUSY;
-		}
-	}
+	page = pfn_to_page(phys_index << PFN_SECTION_SHIFT);
 
 	switch (action) {
 		case MEM_ONLINE:
-			start_pfn = page_to_pfn(first_page);
+			start_pfn = page_to_pfn(page);
 			ret = online_pages(start_pfn, nr_pages);
 			break;
 		case MEM_OFFLINE:
-			start_paddr = page_to_pfn(first_page) << PAGE_SHIFT;
+			start_paddr = page_to_pfn(page) << PAGE_SHIFT;
 			ret = remove_memory(start_paddr,
 					    nr_pages << PAGE_SHIFT);
 			break;
@@ -277,7 +278,7 @@
 static int memory_block_change_state(struct memory_block *mem,
 		unsigned long to_state, unsigned long from_state_req)
 {
-	int ret = 0;
+	int i, ret = 0;
 
 	mutex_lock(&mem->state_mutex);
 
@@ -289,6 +290,19 @@
 	if (to_state == MEM_OFFLINE)
 		mem->state = MEM_GOING_OFFLINE;
 
+	if (to_state == MEM_ONLINE) {
+		/*
+		 * The probe routines leave the pages reserved, just
+		 * as the bootmem code does.  Make sure they're still
+		 * that way.
+		 */
+		for (i = 0; i < sections_per_block; i++) {
+			ret = check_page_reservations(mem->start_section_nr + i);
+			if (ret)
+				return ret;
+		}
+	}
+
 	ret = memory_block_action(mem->start_section_nr, to_state);
 
 	if (ret)
