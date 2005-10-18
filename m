Return-Path: <galak@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id D27F8685D9
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Oct 2005 08:42:16 +1000 (EST)
Date: Tue, 18 Oct 2005 17:42:09 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <Pine.LNX.4.61.0510181741250.3329@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Some more fixes to allow building for a Book-E
 processor
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Some minor fixes that are needed if we are building for a book-e
processor.

Signed-off-by: Kumar K. Gala <kumar.gala@freescale.com>

---
commit a2084dccc9e9b0ccc5c40ed2f1273c82b23369d2
tree f1799fd89588a066ca5210d5dd65ff795ba0af0d
parent 77f543cb467c44960bafa6c91f5af75919d693e4
author Kumar K. Gala <kumar.gala@freescale.com> Tue, 18 Oct 2005 17:38:53 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Tue, 18 Oct 2005 17:38:53 -0500

 arch/powerpc/kernel/Makefile |    3 ++-
 arch/powerpc/mm/Makefile     |    5 ++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -25,13 +25,14 @@ extra-$(CONFIG_40x)		:= head_4xx.o
 extra-$(CONFIG_44x)		:= head_44x.o
 extra-$(CONFIG_FSL_BOOKE)	:= head_fsl_booke.o
 extra-$(CONFIG_8xx)		:= head_8xx.o
+extra-$(CONFIG_6xx)		+= idle_6xx.o
 extra-$(CONFIG_PPC64)		+= entry_64.o
 extra-$(CONFIG_PPC_FPU)		+= fpu.o
 extra-y				+= vmlinux.lds
 
 obj-y				+= process.o init_task.o \
 				   prom.o systbl.o traps.o
-obj-$(CONFIG_PPC32)		+= entry_32.o idle_6xx.o setup_32.o misc_32.o
+obj-$(CONFIG_PPC32)		+= entry_32.o setup_32.o misc_32.o
 obj-$(CONFIG_PPC64)		+= setup_64.o misc_64.o
 obj-$(CONFIG_PPC_OF)		+= prom_init.o
 obj-$(CONFIG_MODULES)		+= ppc_ksyms.o
diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -7,14 +7,13 @@ EXTRA_CFLAGS	+= -mno-minimal-toc
 endif
 
 obj-y				:= fault.o mem.o lmb.o
-obj-$(CONFIG_PPC32)		+= init_32.o pgtable_32.o mmu_context_32.o \
-				   tlb_32.o
+obj-$(CONFIG_PPC32)		+= init_32.o pgtable_32.o mmu_context_32.o
 hash-$(CONFIG_PPC_MULTIPLATFORM) := hash_native_64.o
 obj-$(CONFIG_PPC64)		+= init_64.o pgtable_64.o mmu_context_64.o \
 				   hash_utils_64.o hash_low_64.o tlb_64.o \
 				   slb_low.o slb.o stab.o mmap.o imalloc.o \
 				   $(hash-y)
-obj-$(CONFIG_PPC_STD_MMU_32)	+= ppc_mmu_32.o hash_low_32.o
+obj-$(CONFIG_PPC_STD_MMU_32)	+= ppc_mmu_32.o hash_low_32.o tlb_32.o
 obj-$(CONFIG_40x)		+= 4xx_mmu.o
 obj-$(CONFIG_44x)		+= 44x_mmu.o
 obj-$(CONFIG_FSL_BOOKE)		+= fsl_booke_mmu.o
