Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C25A6B6F7F
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Aug 2011 05:19:14 +1000 (EST)
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e4.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p7UItoZ8016846
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Aug 2011 14:55:50 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p7UJJBm8204726
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Aug 2011 15:19:11 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p7UJJAYJ004369
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Aug 2011 16:19:11 -0300
Date: Tue, 30 Aug 2011 12:19:17 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH] Implement CONFIG_STRICT_DEVMEM support for Powerpc
Message-ID: <20110830191917.GA15338@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org, sbest@us.ibm.com,
	paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>From 9d899c6bcb685afc58245f1fcfe5de1e8b499856 Mon Sep 17 00:00:00 2001
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Date: Mon, 29 Aug 2011 14:12:08 -0700
Subject: [PATCH 1/1] Implement CONFIG_STRICT_DEVMEM support for Powerpc.

As described in the help text in the patch, this token restricts general
access to /dev/mem as a way of increasing the security. Specifically, access
to exclusive IOMEM and kernel RAM is denied unless CONFIG_STRICT_DEVMEM is
set to 'n'.

Implement the 'devmem_is_allowed()' interface for Powerpc. It will be
called from range_is_allowed() when userpsace attempts to access /dev/mem.

This patch is based on an earlier patch from Steve Best and with input from
Paul Mackerras and Scott Wood.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/Kconfig.debug      |   12 ++++++++++++
 arch/powerpc/include/asm/page.h |    1 +
 arch/powerpc/mm/mem.c           |   16 ++++++++++++++++
 drivers/char/mem.c              |    4 ++--
 4 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index 067cb84..1cf1b00 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -298,4 +298,16 @@ config PPC_EARLY_DEBUG_CPM_ADDR
 	  platform probing is done, all platforms selected must
 	  share the same address.
 
+config STRICT_DEVMEM
+	def_bool y
+	prompt "Filter access to /dev/mem"
+	help
+	  This option restricts access to /dev/mem.  If this option is
+	  disabled, you allow userspace access to all memory, including
+	  kernel and userspace memory. Accidental memory access is likely
+	  to be disastrous.
+	  Memory access is required for experts who want to debug the kernel.
+
+	  If you are unsure, say Y.
+
 endmenu
diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index 2cd664e..9eac49e 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -261,6 +261,7 @@ extern void clear_user_page(void *page, unsigned long vaddr, struct page *pg);
 extern void copy_user_page(void *to, void *from, unsigned long vaddr,
 		struct page *p);
 extern int page_is_ram(unsigned long pfn);
+extern int devmem_is_allowd(unsigned long pfn);
 
 #ifdef CONFIG_PPC_SMLPAR
 void arch_free_page(struct page *page, int order);
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index c781bbc..bb7537d 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -549,3 +549,19 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
 	hash_preload(vma->vm_mm, address, access, trap);
 #endif /* CONFIG_PPC_STD_MMU */
 }
+
+/*
+ * devmem_is_allowed(): check to see if /dev/mem access to a certain address
+ * is valid. The argument is a physical page number.
+ *
+ * Access has to be given to non-kernel-ram areas as well, these contain the
+ * PCI mmio resources as well as potential bios/acpi data regions.
+ */
+int devmem_is_allowed(unsigned long pfn)
+{
+	if (iomem_is_exclusive(pfn << PAGE_SHIFT))
+		return 0;
+	if (!page_is_ram(pfn))
+		return 1;
+	return 0;
+}
diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index 8fc04b4..0fb542c 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -66,8 +66,8 @@ static inline int range_is_allowed(unsigned long pfn, unsigned long size)
 	while (cursor < to) {
 		if (!devmem_is_allowed(pfn)) {
 			printk(KERN_INFO
-		"Program %s tried to access /dev/mem between %Lx->%Lx.\n",
-				current->comm, from, to);
+		"Program %s tried to access /dev/mem between %Lx->%Lx and "
+			"pfn %lu.\n", current->comm, from, to, pfn);
 			return 0;
 		}
 		cursor += PAGE_SIZE;
-- 
1.7.0.4
