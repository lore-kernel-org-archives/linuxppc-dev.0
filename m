Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp02.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7897A2C008C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 04:35:23 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Thu, 25 Jul 2013 04:24:52 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 67CAC2CE804C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 04:35:15 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6OIJoG85570912
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 04:19:51 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r6OIZETV028852
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 04:35:14 +1000
Message-ID: <51F01E5F.80307@linux.vnet.ibm.com>
Date: Wed, 24 Jul 2013 13:35:11 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/8] register bootmem pages for powerpc when sparse vmemmap
 is not defined
References: <51F01E06.6090800@linux.vnet.ibm.com>
In-Reply-To: <51F01E06.6090800@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 isimatu.yasuaki@jp.fujitsu.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Previous commit 46723bfa540... introduced a new config option
HAVE_BOOTMEM_INFO_NODE that ended up breaking memory hot-remove for powerpc
when sparse vmemmap is not defined.

This patch defines HAVE_BOOTMEM_INFO_NODE for powerpc and adds the call to
register_page_bootmem_info_node. Without this patch we get a BUG_ON for memory
hot remove in put_page_bootmem().

This also adds a stub for register_page_bootmem_memmap to allow powerpc to
build with sparse vmemmap defined.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---

---
 arch/powerpc/mm/init_64.c |    6 ++++++
 arch/powerpc/mm/mem.c     |    9 +++++++++
 mm/Kconfig                |    2 +-
 3 files changed, 16 insertions(+), 1 deletion(-)

Index: linux/arch/powerpc/mm/init_64.c
===================================================================
--- linux.orig/arch/powerpc/mm/init_64.c
+++ linux/arch/powerpc/mm/init_64.c
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
 
Index: linux/arch/powerpc/mm/mem.c
===================================================================
--- linux.orig/arch/powerpc/mm/mem.c
+++ linux/arch/powerpc/mm/mem.c
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
Index: linux/mm/Kconfig
===================================================================
--- linux.orig/mm/Kconfig
+++ linux/mm/Kconfig
@@ -183,7 +183,7 @@ config MEMORY_HOTPLUG_SPARSE
 config MEMORY_HOTREMOVE
 	bool "Allow for memory hot remove"
 	select MEMORY_ISOLATION
-	select HAVE_BOOTMEM_INFO_NODE if X86_64
+	select HAVE_BOOTMEM_INFO_NODE if (X86_64 || PPC64)
 	depends on MEMORY_HOTPLUG && ARCH_ENABLE_MEMORY_HOTREMOVE
 	depends on MIGRATION
 
