Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 479C967A3F
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Mar 2006 07:21:17 +1100 (EST)
Date: Tue, 14 Mar 2006 21:21:11 +0100
From: Olaf Hering <olh@suse.de>
To: Paul Mackeras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH] remove duplicate EXPORT_SYMBOLS
Message-ID: <20060314202111.GB19372@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


remove warnings when building a 64bit kernel.
smp_call_function triggers also with 32bit kernel.

WARNING: vmlinux: duplicate symbol 'smp_call_function' previous definition was in vmlinux
arch/powerpc/kernel/ppc_ksyms.c:164:EXPORT_SYMBOL(smp_call_function);
arch/powerpc/kernel/smp.c:300:EXPORT_SYMBOL(smp_call_function);

WARNING: vmlinux: duplicate symbol 'ioremap' previous definition was in vmlinux
arch/powerpc/kernel/ppc_ksyms.c:113:EXPORT_SYMBOL(ioremap);
arch/powerpc/mm/pgtable_64.c:321:EXPORT_SYMBOL(ioremap);

WARNING: vmlinux: duplicate symbol '__ioremap' previous definition was in vmlinux
arch/powerpc/kernel/ppc_ksyms.c:117:EXPORT_SYMBOL(__ioremap);
arch/powerpc/mm/pgtable_64.c:322:EXPORT_SYMBOL(__ioremap);

WARNING: vmlinux: duplicate symbol 'iounmap' previous definition was in vmlinux
arch/powerpc/kernel/ppc_ksyms.c:118:EXPORT_SYMBOL(iounmap);
arch/powerpc/mm/pgtable_64.c:323:EXPORT_SYMBOL(iounmap);


Signed-off-by: Olaf Hering <olh@suse.de>
---
 arch/powerpc/kernel/ppc_ksyms.c |   10 ----------
 arch/powerpc/mm/pgtable_32.c    |    5 +++++
 2 files changed, 5 insertions(+), 10 deletions(-)

Index: linux-2.6.16-rc6-olh/arch/powerpc/kernel/ppc_ksyms.c
===================================================================
--- linux-2.6.16-rc6-olh.orig/arch/powerpc/kernel/ppc_ksyms.c
+++ linux-2.6.16-rc6-olh/arch/powerpc/kernel/ppc_ksyms.c
@@ -109,15 +109,6 @@ EXPORT_SYMBOL(_insw_ns);
 EXPORT_SYMBOL(_outsw_ns);
 EXPORT_SYMBOL(_insl_ns);
 EXPORT_SYMBOL(_outsl_ns);
-EXPORT_SYMBOL(ioremap);
-#ifdef CONFIG_44x
-EXPORT_SYMBOL(ioremap64);
-#endif
-EXPORT_SYMBOL(__ioremap);
-EXPORT_SYMBOL(iounmap);
-#ifdef CONFIG_PPC32
-EXPORT_SYMBOL(ioremap_bot);	/* aka VMALLOC_END */
-#endif
 
 #if defined(CONFIG_PPC32) && (defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE))
 EXPORT_SYMBOL(ppc_ide_md);
@@ -160,7 +151,6 @@ EXPORT_SYMBOL(__flush_icache_range);
 EXPORT_SYMBOL(flush_dcache_range);
 
 #ifdef CONFIG_SMP
-EXPORT_SYMBOL(smp_call_function);
 #ifdef CONFIG_PPC32
 EXPORT_SYMBOL(smp_hw_index);
 #endif
Index: linux-2.6.16-rc6-olh/arch/powerpc/mm/pgtable_32.c
===================================================================
--- linux-2.6.16-rc6-olh.orig/arch/powerpc/mm/pgtable_32.c
+++ linux-2.6.16-rc6-olh/arch/powerpc/mm/pgtable_32.c
@@ -37,6 +37,7 @@
 
 unsigned long ioremap_base;
 unsigned long ioremap_bot;
+EXPORT_SYMBOL(ioremap_bot);	/* aka VMALLOC_END */
 int io_bat_index;
 
 #if defined(CONFIG_6xx) || defined(CONFIG_POWER3)
@@ -153,6 +154,7 @@ ioremap64(unsigned long long addr, unsig
 {
 	return __ioremap(addr, size, _PAGE_NO_CACHE);
 }
+EXPORT_SYMBOL(ioremap64);
 
 void __iomem *
 ioremap(phys_addr_t addr, unsigned long size)
@@ -162,6 +164,7 @@ ioremap(phys_addr_t addr, unsigned long 
 	return ioremap64(addr64, size);
 }
 #endif /* CONFIG_PHYS_64BIT */
+EXPORT_SYMBOL(ioremap);
 
 void __iomem *
 __ioremap(phys_addr_t addr, unsigned long size, unsigned long flags)
@@ -247,6 +250,7 @@ __ioremap(phys_addr_t addr, unsigned lon
 out:
 	return (void __iomem *) (v + ((unsigned long)addr & ~PAGE_MASK));
 }
+EXPORT_SYMBOL(__ioremap);
 
 void iounmap(volatile void __iomem *addr)
 {
@@ -259,6 +263,7 @@ void iounmap(volatile void __iomem *addr
 	if (addr > high_memory && (unsigned long) addr < ioremap_bot)
 		vunmap((void *) (PAGE_MASK & (unsigned long)addr));
 }
+EXPORT_SYMBOL(iounmap);
 
 void __iomem *ioport_map(unsigned long port, unsigned int len)
 {
