Return-Path: <sfbest@us.ibm.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 5DC41B70E9
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  1 Feb 2011 06:16:04 +1100 (EST)
Date: Mon, 31 Jan 2011 14:16:00 -0500
From: Steve Best <sfbest@us.ibm.com>
To: Steve Best <sfbest@us.ibm.com>, linuxppc-dev@lists.ozlabs.org
Message-Id: <20110131191109.5727.87742.sendpatchset@squad5-lp1.lab.bos.redhat.com>
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
index 2d38a50..6805d5d 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -299,4 +299,16 @@ config PPC_EARLY_DEBUG_CPM_ADDR
 	  platform probing is done, all platforms selected must
 	  share the same address.
 
+config STRICT_DEVMEM
+        def_bool y
+        prompt "Filter access to /dev/mem"
+        ---help---
+          This option restricts access to /dev/mem.  If this option is
+          disabled, you allow userspace access to all memory, including
+          kernel and userspace memory. Accidental memory access is likely
+          to be disastrous.
+          Memory access is required for experts who want to debug the kernel.
+
+          If you are unsure, say Y.
+
 endmenu
diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index 53b64be..f225032 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -262,6 +262,11 @@ extern void copy_user_page(void *to, void *from, unsigned long vaddr,
 		struct page *p);
 extern int page_is_ram(unsigned long pfn);
 
+static inline int devmem_is_allowed(unsigned long pfn)
+{
+        return 0;
+}
+
 #ifdef CONFIG_PPC_SMLPAR
 void arch_free_page(struct page *page, int order);
 #define HAVE_ARCH_FREE_PAGE
