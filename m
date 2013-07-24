Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp05.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6DBB22C00BA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 04:44:35 +1000 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Thu, 25 Jul 2013 00:08:41 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 178E0E0053
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 00:14:25 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6OIjGdi45088990
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 00:15:16 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r6OIiMKc002873
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 04:44:23 +1000
Message-ID: <51F02083.7040700@linux.vnet.ibm.com>
Date: Wed, 24 Jul 2013 13:44:19 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 6/8] Update the powerpc arch specific memory add/remove
 handlers
References: <51F01E06.6090800@linux.vnet.ibm.com>
In-Reply-To: <51F01E06.6090800@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In order to properly hot add and remove memory for powerpc the arch
specific callouts need to now complete all of the required work to
fully add or remove the memory.

With this update we can also remove the handler for memory node add
because the powerpc arch specific memory add handler will do all the
work needed. We do still need the memory node remove handler because
systems with memory specified in the memory@XXX nodes in the device tree
we have to use the removal of the node to trigger memory hot remove.

For systems on newer firmware with memory specified in the
ibm,dynamic-reconfiguration-memory node of the device tree this is not an
issue.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/mm/mem.c                           |   33 +++++++++++++++++++---
 arch/powerpc/platforms/pseries/hotplug-memory.c |   35 ------------------------
 2 files changed, 29 insertions(+), 39 deletions(-)

Index: linux/arch/powerpc/mm/mem.c
===================================================================
--- linux.orig/arch/powerpc/mm/mem.c
+++ linux/arch/powerpc/mm/mem.c
@@ -35,6 +35,7 @@
 #include <linux/memblock.h>
 #include <linux/hugetlb.h>
 #include <linux/slab.h>
+#include <linux/vmalloc.h>
 
 #include <asm/pgalloc.h>
 #include <asm/prom.h>
@@ -120,17 +121,24 @@ int arch_add_memory(int nid, u64 start,
 	struct zone *zone;
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
+	u64 va_start;
+	int ret;
 
 	pgdata = NODE_DATA(nid);
 
-	start = (unsigned long)__va(start);
-	if (create_section_mapping(start, start + size))
+	va_start = (unsigned long)__va(start);
+	if (create_section_mapping(va_start, va_start + size))
 		return -EINVAL;
 
 	/* this should work for most non-highmem platforms */
 	zone = pgdata->node_zones;
 
-	return __add_pages(nid, zone, start_pfn, nr_pages);
+	ret = __add_pages(nid, zone, start_pfn, nr_pages);
+	if (ret)
+		return ret;
+
+	ret = memblock_add(start, size);
+	return ret;
 }
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
@@ -138,10 +146,27 @@ int arch_remove_memory(u64 start, u64 si
 {
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
+	unsigned long va_addr;
 	struct zone *zone;
+	int ret;
 
 	zone = page_zone(pfn_to_page(start_pfn));
-	return __remove_pages(zone, start_pfn, nr_pages);
+	ret = __remove_pages(zone, start_pfn, nr_pages);
+	if (ret)
+		return ret;
+
+	memblock_remove(start, size);
+
+	/* remove htab bolted mappings */
+	va_addr = (unsigned long)__va(start);
+	ret = remove_section_mapping(va_addr, va_addr + size);
+
+	/* Ensure all vmalloc mappings are flushed in case they also
+	 * hit that section of memory.
+	 */
+	vm_unmap_aliases();
+
+	return ret;
 }
 #endif
 #endif /* CONFIG_MEMORY_HOTPLUG */
Index: linux/arch/powerpc/platforms/pseries/hotplug-memory.c
===================================================================
--- linux.orig/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ linux/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -166,38 +166,6 @@ static inline int pseries_remove_memory(
 }
 #endif /* CONFIG_MEMORY_HOTREMOVE */
 
-static int pseries_add_memory(struct device_node *np)
-{
-	const char *type;
-	const unsigned int *regs;
-	unsigned long base;
-	unsigned int lmb_size;
-	int ret = -EINVAL;
-
-	/*
-	 * Check to see if we are actually adding memory
-	 */
-	type = of_get_property(np, "device_type", NULL);
-	if (type == NULL || strcmp(type, "memory") != 0)
-		return 0;
-
-	/*
-	 * Find the base and size of the memblock
-	 */
-	regs = of_get_property(np, "reg", NULL);
-	if (!regs)
-		return ret;
-
-	base = *(unsigned long *)regs;
-	lmb_size = regs[3];
-
-	/*
-	 * Update memory region to represent the memory add
-	 */
-	ret = memblock_add(base, lmb_size);
-	return (ret < 0) ? -EINVAL : 0;
-}
-
 static int pseries_update_drconf_memory(struct of_prop_reconfig *pr)
 {
 	struct of_drconf_cell *new_drmem, *old_drmem;
@@ -251,9 +219,6 @@ static int pseries_memory_notifier(struc
 	int err = 0;
 
 	switch (action) {
-	case OF_RECONFIG_ATTACH_NODE:
-		err = pseries_add_memory(node);
-		break;
 	case OF_RECONFIG_DETACH_NODE:
 		err = pseries_remove_memory(node);
 		break;
