Date: Tue, 25 May 2004 02:29:19 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: [PATCH 6/7] remove apus special case in address conversion
Message-ID: <Pine.LNX.4.58.0405250229080.19045@scrub.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Use __pa()/__va() instead of direct calculation.

Index: 2.6/include/asm-ppc/io.h
diff -u 2.6/include/asm-ppc/io.h:1.1.1.3 2.6/include/asm-ppc/io.h:1.5
--- 2.6/include/asm-ppc/io.h:1.1.1.3	Sun May 23 15:31:13 2004
+++ 2.6/include/asm-ppc/io.h	Mon May 24 13:32:36 2004
@@ -213,24 +220,16 @@ extern void io_block_mapping(unsigned lo
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
 		return 0;
-        return (void *)(address - PCI_DRAM_OFFSET + KERNELBASE);
-#else
-	return (void*) mm_ptov (address);
-#endif
+	return __va(address) - PCI_DRAM_OFFSET;
 }

 /*
@@ -239,20 +238,12 @@ extern inline void * bus_to_virt(unsigne
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

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
