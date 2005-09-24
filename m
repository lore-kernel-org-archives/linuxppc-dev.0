Return-Path: <zippel@linux-m68k.org>
Received: from scrub.xs4all.nl (scrub.xs4all.nl [194.109.195.176])
	by ozlabs.org (Postfix) with ESMTP id 8CEDC683DB
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Sep 2005 08:44:19 +1000 (EST)
Received: from roman (helo=localhost)
	by scrub.xs4all.nl with local-esmtp (Exim 3.36 #1 (Debian))
	id 1EJIkk-0004zO-00
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Sep 2005 00:44:18 +0200
Date: Sun, 25 Sep 2005 00:44:18 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
To: linuxppc-dev@ozlabs.org
Message-ID: <Pine.LNX.4.61.0509250044040.19181@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [PATCH 6/8] apus: remove apus special case in address conversion
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Use __pa()/__va() instead of direct calculation for the various address
conversions. This also removes the now unused mm_ptov().

---

 arch/ppc/kernel/ppc_ksyms.c |    3 ---
 arch/ppc/mm/pgtable.c       |   39 ---------------------------------------
 include/asm-ppc/io.h        |   24 ++++--------------------
 3 files changed, 4 insertions(+), 62 deletions(-)

Index: linux/include/asm-ppc/io.h
===================================================================
--- linux.orig/include/asm-ppc/io.h	2005-09-23 16:44:25.000000000 +0200
+++ linux/include/asm-ppc/io.h	2005-09-23 16:44:25.000000000 +0200
@@ -392,24 +392,16 @@ extern void io_block_mapping(unsigned lo
  */
 extern inline unsigned long virt_to_bus(volatile void * address)
 {
-#ifndef CONFIG_APUS
         if (address == (void *)0)
 		return 0;
-        return (unsigned long)address - KERNELBASE + PCI_DRAM_OFFSET;
-#else
-	return iopa ((unsigned long) address);
-#endif
+	return __pa(address) + PCI_DRAM_OFFSET;
 }
 
 extern inline void * bus_to_virt(unsigned long address)
 {
-#ifndef CONFIG_APUS
         if (address == 0)
 		return NULL;
-        return (void *)(address - PCI_DRAM_OFFSET + KERNELBASE);
-#else
-	return (void*) mm_ptov (address);
-#endif
+	return __va(address) - PCI_DRAM_OFFSET;
 }
 
 /*
@@ -418,20 +410,12 @@ extern inline void * bus_to_virt(unsigne
  */
 extern inline unsigned long virt_to_phys(volatile void * address)
 {
-#ifndef CONFIG_APUS
-	return (unsigned long) address - KERNELBASE;
-#else
-	return iopa ((unsigned long) address);
-#endif
+	return __pa(address);
 }
 
 extern inline void * phys_to_virt(unsigned long address)
 {
-#ifndef CONFIG_APUS
-	return (void *) (address + KERNELBASE);
-#else
-	return (void*) mm_ptov (address);
-#endif
+	return __va(address);
 }
 
 /*
Index: linux/arch/ppc/kernel/ppc_ksyms.c
===================================================================
--- linux.orig/arch/ppc/kernel/ppc_ksyms.c	2005-09-23 15:52:38.000000000 +0200
+++ linux/arch/ppc/kernel/ppc_ksyms.c	2005-09-23 16:48:47.000000000 +0200
@@ -68,8 +68,6 @@ long long __ashrdi3(long long, int);
 long long __ashldi3(long long, int);
 long long __lshrdi3(long long, int);
 
-extern unsigned long mm_ptov (unsigned long paddr);
-
 EXPORT_SYMBOL(clear_pages);
 EXPORT_SYMBOL(clear_user_page);
 EXPORT_SYMBOL(do_signal);
@@ -145,7 +143,6 @@ EXPORT_SYMBOL(_outsw_ns);
 EXPORT_SYMBOL(_insl_ns);
 EXPORT_SYMBOL(_outsl_ns);
 EXPORT_SYMBOL(iopa);
-EXPORT_SYMBOL(mm_ptov);
 EXPORT_SYMBOL(ioremap);
 #ifdef CONFIG_44x
 EXPORT_SYMBOL(ioremap64);
Index: linux/arch/ppc/mm/pgtable.c
===================================================================
--- linux.orig/arch/ppc/mm/pgtable.c	2005-09-23 15:52:38.000000000 +0200
+++ linux/arch/ppc/mm/pgtable.c	2005-09-23 16:49:45.000000000 +0200
@@ -429,42 +429,3 @@ unsigned long iopa(unsigned long addr)
 
 	return(pa);
 }
-
-/* This is will find the virtual address for a physical one....
- * Swiped from APUS, could be dangerous :-).
- * This is only a placeholder until I really find a way to make this
- * work.  -- Dan
- */
-unsigned long
-mm_ptov (unsigned long paddr)
-{
-	unsigned long ret;
-#if 0
-	if (paddr < 16*1024*1024)
-		ret = ZTWO_VADDR(paddr);
-	else {
-		int i;
-
-		for (i = 0; i < kmap_chunk_count;){
-			unsigned long phys = kmap_chunks[i++];
-			unsigned long size = kmap_chunks[i++];
-			unsigned long virt = kmap_chunks[i++];
-			if (paddr >= phys
-			    && paddr < (phys + size)){
-				ret = virt + paddr - phys;
-				goto exit;
-			}
-		}
-	
-		ret = (unsigned long) __va(paddr);
-	}
-exit:
-#ifdef DEBUGPV
-	printk ("PTOV(%lx)=%lx\n", paddr, ret);
-#endif
-#else
-	ret = (unsigned long)paddr + KERNELBASE;
-#endif
-	return ret;
-}
-
