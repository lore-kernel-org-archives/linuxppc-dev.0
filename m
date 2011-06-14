Return-Path: <sfbest@us.ibm.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id C961CB6F81
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 15 Jun 2011 02:58:05 +1000 (EST)
Date: Tue, 14 Jun 2011 12:58:02 -0400
From: Steve Best <sfbest@us.ibm.com>
To: Steve Best <sfbest@us.ibm.com>, linuxppc-dev@lists.ozlabs.org
Message-Id: <20110614165011.23034.66685.sendpatchset@squad5-lp1.lab.bos.redhat.com>
Subject: [PATCH] powerpc/mm: add devmem_is_allowed() for STRICT_DEVMEM checking
Cc: Steve Best <sfbest@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



       Provide devmem_is_allowed() routine to restrict access to kernel
       memory from userspace.
       Set CONFIG_STRICT_DEVMEM config option to switch on checking.
    
Signed-off-by: Steve Best <sfbest@us.ibm.com>

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index e72dcf6..e1aab6b 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -283,4 +283,15 @@ config PPC_EARLY_DEBUG_CPM_ADDR
 	  platform probing is done, all platforms selected must
 	  share the same address.
 
+config STRICT_DEVMEM
+        def_bool y
+        prompt "Filter access to /dev/mem"
+        ---help---
+          This option restricts access to /dev/mem.  If this option is
+          disabled, you allow userspace access to all memory, including
+          kernel and userspace memory. 
+          Memory access is required for experts who want to debug the kernel.
+
+          If you are unsure, say Y.
+
 endmenu
diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index 2cd664e..dc2ec96 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -261,6 +261,7 @@ extern void clear_user_page(void *page, unsigned long vaddr, struct page *pg);
 extern void copy_user_page(void *to, void *from, unsigned long vaddr,
 		struct page *p);
 extern int page_is_ram(unsigned long pfn);
+extern int devmem_is_allowed(unsigned long pfn);
 
 #ifdef CONFIG_PPC_SMLPAR
 void arch_free_page(struct page *page, int order);
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 29d4dde..b1a6233 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -520,3 +520,21 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
 	hash_preload(vma->vm_mm, address, access, trap);
 #endif /* CONFIG_PPC_STD_MMU */
 }
+
+/*
+ * devmem_is_allowed() checks to see if /dev/mem access to a certain address
+ * is valid. The argument is a physical page number.
+ *
+ * On PowerPC, access has to be given to data regions used by X. We have to
+ * disallow access to device-exclusive MMIO regions and system RAM. 
+ */
+int devmem_is_allowed(unsigned long pfn)
+{
+        if ((pfn >= 57360 || pfn <= 57392))
+                return 1;
+        if (iomem_is_exclusive(pfn << PAGE_SHIFT))
+                return 0;
+        if (!page_is_ram(pfn))
+                return 1;
+        return 0;
+}
