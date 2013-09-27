Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp01.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 22CB42C008F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Sep 2013 01:18:18 +1000 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Fri, 27 Sep 2013 20:48:15 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 7BD8BE0053
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 20:49:19 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8RFKZvL41156826
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 20:50:35 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r8RFIB8D015703
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 20:48:11 +0530
Received: from [9.41.105.192] ([9.41.105.192])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 r8RFIAUf015558
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 20:48:11 +0530
Message-ID: <5245A1B1.4090308@linux.vnet.ibm.com>
Date: Fri, 27 Sep 2013 10:18:09 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] Correct memory hotplug for ppc with sparse vmemmap
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Previous commit 46723bfa540... introduced a new config option
HAVE_BOOTMEM_INFO_NODE that ended up breaking memory hot-remove for ppc
when sparse vmemmap is not defined.

This patch defines HAVE_BOOTMEM_INFO_NODE for ppc and adds the call to
register_page_bootmem_info_node. Without this we get a BUG_ON for memory
hot remove in put_page_bootmem().

This also adds a stub for register_page_bootmem_memmap to allow ppc to build
with sparse vmemmap defined. Leaving this as a stub is fine since the same
vmemmap addresses are also handled in vmemmap_populate and as such are
properly mapped.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/mm/init_64.c |    4 ++++
 arch/powerpc/mm/mem.c     |    9 +++++++++
 mm/Kconfig                |    2 +-
 3 files changed, 14 insertions(+), 1 deletion(-)

Index: powerpc/arch/powerpc/mm/init_64.c
===================================================================
--- powerpc.orig/arch/powerpc/mm/init_64.c
+++ powerpc/arch/powerpc/mm/init_64.c
@@ -300,5 +300,9 @@ void vmemmap_free(unsigned long start, u
 {
 }

+void register_page_bootmem_memmap(unsigned long section_nr,
+				  struct page *start_page, unsigned long size)
+{
+}
 #endif /* CONFIG_SPARSEMEM_VMEMMAP */

Index: powerpc/arch/powerpc/mm/mem.c
===================================================================
--- powerpc.orig/arch/powerpc/mm/mem.c
+++ powerpc/arch/powerpc/mm/mem.c
@@ -297,12 +297,21 @@ void __init paging_init(void)
 }
 #endif /* ! CONFIG_NEED_MULTIPLE_NODES */

+static void __init register_page_bootmem_info(void)
+{
+	int i;
+
+	for_each_online_node(i)
+		register_page_bootmem_info_node(NODE_DATA(i));
+}
+
 void __init mem_init(void)
 {
 #ifdef CONFIG_SWIOTLB
 	swiotlb_init(0);
 #endif

+	register_page_bootmem_info();
 	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE);
 	set_max_mapnr(max_pfn);
 	free_all_bootmem();
Index: powerpc/mm/Kconfig
===================================================================
--- powerpc.orig/mm/Kconfig
+++ powerpc/mm/Kconfig
@@ -183,7 +183,7 @@ config MEMORY_HOTPLUG_SPARSE
 config MEMORY_HOTREMOVE
 	bool "Allow for memory hot remove"
 	select MEMORY_ISOLATION
-	select HAVE_BOOTMEM_INFO_NODE if X86_64
+	select HAVE_BOOTMEM_INFO_NODE if (X86_64 || PPC64)
 	depends on MEMORY_HOTPLUG && ARCH_ENABLE_MEMORY_HOTREMOVE
 	depends on MIGRATION
