Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 92F0CB7C12
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Oct 2009 04:05:26 +1100 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Fix compile errors found by new ppc64e_defconfig
Date: Fri, 16 Oct 2009 12:05:17 -0500
Message-Id: <1255712717-21221-2-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1255712717-21221-1-git-send-email-galak@kernel.crashing.org>
References: <1255712717-21221-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix the following 3 issues:

arch/powerpc/kernel/process.c: In function 'arch_randomize_brk':
arch/powerpc/kernel/process.c:1183: error: 'mmu_highuser_ssize' undeclared (first use in this function)
arch/powerpc/kernel/process.c:1183: error: (Each undeclared identifier is reported only once
arch/powerpc/kernel/process.c:1183: error: for each function it appears in.)
arch/powerpc/kernel/process.c:1183: error: 'MMU_SEGSIZE_1T' undeclared (first use in this function)

In file included from arch/powerpc/kernel/setup_64.c:60:
arch/powerpc/include/asm/mmu-hash64.h:132: error: redefinition of 'struct mmu_psize_def'
arch/powerpc/include/asm/mmu-hash64.h:159: error: expected identifier or '(' before numeric constant
arch/powerpc/include/asm/mmu-hash64.h:396: error: conflicting types for 'mm_context_t'
arch/powerpc/include/asm/mmu-book3e.h:184: error: previous declaration of 'mm_context_t' was here

cc1: warnings being treated as errors
arch/powerpc/kernel/pci_64.c: In function 'pcibios_unmap_io_space':
arch/powerpc/kernel/pci_64.c:100: error: unused variable 'res'

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/kernel/pci_64.c   |    2 ++
 arch/powerpc/kernel/process.c  |    2 +-
 arch/powerpc/kernel/setup_64.c |    1 -
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index ba949a2..ccf56ac 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -97,7 +97,9 @@ int pcibios_unmap_io_space(struct pci_bus *bus)
 	 * to do an appropriate TLB flush here too
 	 */
 	if (bus->self) {
+#ifdef CONFIG_PPC_STD_MMU_64
 		struct resource *res = bus->resource[0];
+#endif
 
 		pr_debug("IO unmapping for PCI-PCI bridge %s\n",
 			 pci_name(bus->self));
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 2ec1eae..c930ac3 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1172,7 +1172,7 @@ unsigned long arch_randomize_brk(struct mm_struct *mm)
 	unsigned long base = mm->brk;
 	unsigned long ret;
 
-#ifdef CONFIG_PPC64
+#ifdef CONFIG_PPC_STD_MMU_64
 	/*
 	 * If we are using 1TB segments and we are allowed to randomise
 	 * the heap, we can put it above 1TB so it is backed by a 1TB
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 797ea95..04f638d 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -57,7 +57,6 @@
 #include <asm/cache.h>
 #include <asm/page.h>
 #include <asm/mmu.h>
-#include <asm/mmu-hash64.h>
 #include <asm/firmware.h>
 #include <asm/xmon.h>
 #include <asm/udbg.h>
-- 
1.6.0.6
