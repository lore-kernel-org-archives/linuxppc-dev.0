Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp05.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E068E2C00AA
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Aug 2013 01:32:23 +1000 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Fri, 9 Aug 2013 20:56:12 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 6EEE4394004E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Aug 2013 21:02:11 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r79FXXft33423516
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Aug 2013 21:03:33 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r79FWIWY012434
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Aug 2013 21:02:18 +0530
Message-ID: <52050B80.8010602@linux.vnet.ibm.com>
Date: Fri, 09 Aug 2013 10:32:16 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org, linux-mm <linux-mm@kvack.org>
Subject: [PATCH 2/2] Register bootmem pages at boot on powerpc
References: <52050ACE.4090001@linux.vnet.ibm.com>
In-Reply-To: <52050ACE.4090001@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Register bootmem pages at boot time on powerpc.

Previous commit 46723bfa540... introduced a new config option,
HAVE_BOOTMEM_INFO_NODE, to enable registering of bootmem pages. As a result
the bootmem pages for powerpc are not registered since we do not define this.
This causes a BUG_ON in put_page_bootmem() when trying to hotplug remove
memory on powerpc.

This patch resolves this by doing three things;
- define HAVE_BOOTMEM_INFO_NODE for powerpc
- Add a routine to register bootmem via register_page_bootmem_info_node()
  in mem_init().
- Stub out the register_page_bootmem_memmap() routine needed for building
  with SPARSE_VMEMMAP enabled.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/mm/init_64.c |    6 ++++++
 arch/powerpc/mm/mem.c     |    9 +++++++++
 mm/Kconfig                |    2 +-
 3 files changed, 16 insertions(+), 1 deletion(-)

Index: powerpc/arch/powerpc/mm/init_64.c
===================================================================
--- powerpc.orig/arch/powerpc/mm/init_64.c
+++ powerpc/arch/powerpc/mm/init_64.c
@@ -300,5 +300,11 @@ void vmemmap_free(unsigned long start, u
 {
 }

+void register_page_bootmem_memmap(unsigned long section_nr,
+				  struct page *start_page, unsigned long size)
+{
+	WARN_ONCE(1, KERN_INFO
+		  "Sparse Vmemmap not fully supported for bootmem info nodes\n");
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
