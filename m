Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <3ed7c174af4ccbab67467aa80fe84bd6c6e218ee.1302501428.git.michael@ellerman.id.au>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 1/4] powerpc/pci: Split IO vs MMIO indirect access hooks
Date: Mon, 11 Apr 2011 15:54:27 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The goal is to avoid adding overhead to MMIO when only PIO is needed

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/include/asm/io.h          |   16 +++++++++++-----
 arch/powerpc/platforms/Kconfig         |   13 +++++++++----
 arch/powerpc/platforms/cell/Kconfig    |    3 ++-
 arch/powerpc/platforms/iseries/Kconfig |    3 ++-
 4 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index 001f2f1..2f365f5 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -481,10 +481,16 @@ __do_out_asm(_rec_outl, "stwbrx")
 				_memcpy_fromio(dst,PCI_FIX_ADDR(src),n)
 #endif /* !CONFIG_EEH */
 
-#ifdef CONFIG_PPC_INDIRECT_IO
-#define DEF_PCI_HOOK(x)		x
+#ifdef CONFIG_PPC_INDIRECT_PIO
+#define DEF_PCI_HOOK_pio(x)	x
+#else
+#define DEF_PCI_HOOK_pio(x)	NULL
+#endif
+
+#ifdef CONFIG_PPC_INDIRECT_MMIO
+#define DEF_PCI_HOOK_mem(x)	x
 #else
-#define DEF_PCI_HOOK(x)		NULL
+#define DEF_PCI_HOOK_mem(x)	NULL
 #endif
 
 /* Structure containing all the hooks */
@@ -504,7 +510,7 @@ extern struct ppc_pci_io {
 #define DEF_PCI_AC_RET(name, ret, at, al, space, aa)		\
 static inline ret name at					\
 {								\
-	if (DEF_PCI_HOOK(ppc_pci_io.name) != NULL)		\
+	if (DEF_PCI_HOOK_##space(ppc_pci_io.name) != NULL)	\
 		return ppc_pci_io.name al;			\
 	return __do_##name al;					\
 }
@@ -512,7 +518,7 @@ static inline ret name at					\
 #define DEF_PCI_AC_NORET(name, at, al, space, aa)		\
 static inline void name at					\
 {								\
-	if (DEF_PCI_HOOK(ppc_pci_io.name) != NULL)		\
+	if (DEF_PCI_HOOK_##space(ppc_pci_io.name) != NULL)		\
 		ppc_pci_io.name al;				\
 	else							\
 		__do_##name al;					\
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index 59eeb77..220b137 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -152,13 +152,18 @@ config PPC_P7_NAP
 	default n
 
 config PPC_INDIRECT_IO
-	bool
+	def_bool y
 	select GENERIC_IOMAP
-	default n
+	depends on PPC_INDIRECT_PIO || PPC_INDIRECT_MMIO
+
+config PPC_INDIRECT_PIO
+	def_bool n
+
+config PPC_INDIRECT_MEM
+	def_bool n
 
 config GENERIC_IOMAP
-	bool
-	default n
+	def_bool n
 
 source "drivers/cpufreq/Kconfig"
 
diff --git a/arch/powerpc/platforms/cell/Kconfig b/arch/powerpc/platforms/cell/Kconfig
index 81239eb..3c7f1de 100644
--- a/arch/powerpc/platforms/cell/Kconfig
+++ b/arch/powerpc/platforms/cell/Kconfig
@@ -6,7 +6,8 @@ config PPC_CELL_COMMON
 	bool
 	select PPC_CELL
 	select PPC_DCR_MMIO
-	select PPC_INDIRECT_IO
+	select PPC_INDIRECT_PIO
+	select PPC_INDIRECT_MMIO
 	select PPC_NATIVE
 	select PPC_RTAS
 	select IRQ_EDGE_EOI_HANDLER
diff --git a/arch/powerpc/platforms/iseries/Kconfig b/arch/powerpc/platforms/iseries/Kconfig
index e5bc9f7..ea1d362 100644
--- a/arch/powerpc/platforms/iseries/Kconfig
+++ b/arch/powerpc/platforms/iseries/Kconfig
@@ -1,7 +1,8 @@
 config PPC_ISERIES
 	bool "IBM Legacy iSeries"
 	depends on PPC64 && PPC_BOOK3S
-	select PPC_INDIRECT_IO
+	select PPC_INDIRECT_PIO
+	select PPC_INDIRECT_MMIO
 	select PPC_PCI_CHOICE if EXPERT
 
 menu "iSeries device drivers"
-- 
1.7.1
