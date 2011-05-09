Return-Path: <anton@samba.org>
Date: Mon, 9 May 2011 17:41:59 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH 1/2] powerpc: Add ioremap_wc
Message-ID: <20110509174159.6f9759d9@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Add ioremap_wc so drivers can request write combining on kernel
mappings.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-powerpc/arch/powerpc/include/asm/io.h
===================================================================
--- linux-powerpc.orig/arch/powerpc/include/asm/io.h	2011-05-09 11:25:11.987156163 +1000
+++ linux-powerpc/arch/powerpc/include/asm/io.h	2011-05-09 13:29:33.405575494 +1000
@@ -2,6 +2,8 @@
 #define _ASM_POWERPC_IO_H
 #ifdef __KERNEL__
 
+#define ARCH_HAS_IOREMAP_WC
+
 /*
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
@@ -628,6 +630,8 @@ static inline void iosync(void)
  *
  * * ioremap_nocache is identical to ioremap
  *
+ * * ioremap_wc enables write combining
+ *
  * * iounmap undoes such a mapping and can be hooked
  *
  * * __ioremap_at (and the pending __iounmap_at) are low level functions to
@@ -648,6 +652,7 @@ static inline void iosync(void)
 extern void __iomem *ioremap(phys_addr_t address, unsigned long size);
 extern void __iomem *ioremap_flags(phys_addr_t address, unsigned long size,
 				   unsigned long flags);
+extern void __iomem *ioremap_wc(phys_addr_t address, unsigned long size);
 #define ioremap_nocache(addr, size)	ioremap((addr), (size))
 #define ioremap_prot(addr, size, prot)	ioremap_flags((addr), (size), (prot))
 
Index: linux-powerpc/arch/powerpc/mm/pgtable_32.c
===================================================================
--- linux-powerpc.orig/arch/powerpc/mm/pgtable_32.c	2011-05-09 13:29:48.565843294 +1000
+++ linux-powerpc/arch/powerpc/mm/pgtable_32.c	2011-05-09 13:30:21.376422809 +1000
@@ -133,6 +133,14 @@ ioremap(phys_addr_t addr, unsigned long
 EXPORT_SYMBOL(ioremap);
 
 void __iomem *
+ioremap_wc(phys_addr_t addr, unsigned long size)
+{
+	return __ioremap_caller(addr, size, _PAGE_NO_CACHE,
+				__builtin_return_address(0));
+}
+EXPORT_SYMBOL(ioremap_wc);
+
+void __iomem *
 ioremap_flags(phys_addr_t addr, unsigned long size, unsigned long flags)
 {
 	/* writeable implies dirty for kernel addresses */
Index: linux-powerpc/arch/powerpc/mm/pgtable_64.c
===================================================================
--- linux-powerpc.orig/arch/powerpc/mm/pgtable_64.c	2011-05-09 13:29:48.605844002 +1000
+++ linux-powerpc/arch/powerpc/mm/pgtable_64.c	2011-05-09 13:32:20.378523852 +1000
@@ -255,6 +255,16 @@ void __iomem * ioremap(phys_addr_t addr,
 	return __ioremap_caller(addr, size, flags, caller);
 }
 
+void __iomem * ioremap_wc(phys_addr_t addr, unsigned long size)
+{
+	unsigned long flags = _PAGE_NO_CACHE;
+	void *caller = __builtin_return_address(0);
+
+	if (ppc_md.ioremap)
+		return ppc_md.ioremap(addr, size, flags, caller);
+	return __ioremap_caller(addr, size, flags, caller);
+}
+
 void __iomem * ioremap_flags(phys_addr_t addr, unsigned long size,
 			     unsigned long flags)
 {
@@ -311,6 +321,7 @@ void iounmap(volatile void __iomem *toke
 }
 
 EXPORT_SYMBOL(ioremap);
+EXPORT_SYMBOL(ioremap_wc);
 EXPORT_SYMBOL(ioremap_flags);
 EXPORT_SYMBOL(__ioremap);
 EXPORT_SYMBOL(__ioremap_at);
