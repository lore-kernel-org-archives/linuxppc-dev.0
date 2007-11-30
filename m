Return-Path: <benh@ozlabs.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 30 Nov 2007 17:10:39 +1100
Subject: [PATCH 1/24] powerpc: Make isa_mem_base common to 32 and 64 bits
In-Reply-To: <1196403038.569525.367459803520.qpush@grosgo>
Message-Id: <20071130061142.7CF31DDE20@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This defines isa_mem_base on both 32 and 64 bits (it used to be 32 bits
only). This avoids a few ifdef's in later patches and potentially can
allow support for VGA text mode on 64 bits powerpc.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Small cleanup pre-requisite for my next patch

 arch/powerpc/kernel/pci-common.c |    4 ++++
 arch/powerpc/kernel/pci_32.c     |    1 -
 include/asm-powerpc/io.h         |    5 +++--
 3 files changed, 7 insertions(+), 3 deletions(-)

Index: linux-work/arch/powerpc/kernel/pci-common.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/pci-common.c	2007-11-20 14:42:49.000000000 +1100
+++ linux-work/arch/powerpc/kernel/pci-common.c	2007-11-20 15:03:02.000000000 +1100
@@ -52,6 +52,10 @@ int global_phb_number;		/* Global phb co
 
 extern struct list_head hose_list;
 
+/* ISA Memory physical address */
+resource_size_t isa_mem_base;
+
+
 /*
  * pci_controller(phb) initialized common variables.
  */
Index: linux-work/include/asm-powerpc/io.h
===================================================================
--- linux-work.orig/include/asm-powerpc/io.h	2007-11-20 14:42:49.000000000 +1100
+++ linux-work/include/asm-powerpc/io.h	2007-11-20 14:47:11.000000000 +1100
@@ -50,15 +50,16 @@ extern int check_legacy_ioport(unsigned 
 #define PCI_DRAM_OFFSET	pci_dram_offset
 #else
 #define _IO_BASE	pci_io_base
-#define _ISA_MEM_BASE	0
+#define _ISA_MEM_BASE	isa_mem_base
 #define PCI_DRAM_OFFSET	0
 #endif
 
 extern unsigned long isa_io_base;
-extern unsigned long isa_mem_base;
 extern unsigned long pci_io_base;
 extern unsigned long pci_dram_offset;
 
+extern resource_size_t isa_mem_base;
+
 #if defined(CONFIG_PPC32) && defined(CONFIG_PPC_INDIRECT_IO)
 #error CONFIG_PPC_INDIRECT_IO is not yet supported on 32 bits
 #endif
Index: linux-work/arch/powerpc/kernel/pci_32.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/pci_32.c	2007-11-20 14:42:49.000000000 +1100
+++ linux-work/arch/powerpc/kernel/pci_32.c	2007-11-20 15:02:43.000000000 +1100
@@ -32,7 +32,6 @@
 #endif
 
 unsigned long isa_io_base     = 0;
-unsigned long isa_mem_base    = 0;
 unsigned long pci_dram_offset = 0;
 int pcibios_assign_bus_offset = 1;
 
