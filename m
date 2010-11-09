Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <6220310e3ffbd421c2764408f58aa6215c9e3f52.1289273473.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] powerpc: Consolidate obj-y assignments
Date: Tue,  9 Nov 2010 14:31:36 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

No need to have three of them.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/Makefile |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 36c30f3..3bb2a3e 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -29,8 +29,10 @@ endif
 obj-y				:= cputable.o ptrace.o syscalls.o \
 				   irq.o align.o signal_32.o pmc.o vdso.o \
 				   init_task.o process.o systbl.o idle.o \
-				   signal.o sysfs.o cacheinfo.o
-obj-y				+= vdso32/
+				   signal.o sysfs.o cacheinfo.o time.o \
+				   prom.o traps.o setup-common.o \
+				   udbg.o misc.o io.o dma.o \
+				   misc_$(CONFIG_WORD_SIZE).o vdso32/
 obj-$(CONFIG_PPC64)		+= setup_64.o sys_ppc32.o \
 				   signal_64.o ptrace32.o \
 				   paca.o nvram_64.o firmware.o
@@ -80,9 +82,6 @@ extra-$(CONFIG_FSL_BOOKE)	:= head_fsl_booke.o
 extra-$(CONFIG_8xx)		:= head_8xx.o
 extra-y				+= vmlinux.lds
 
-obj-y				+= time.o prom.o traps.o setup-common.o \
-				   udbg.o misc.o io.o dma.o \
-				   misc_$(CONFIG_WORD_SIZE).o
 obj-$(CONFIG_PPC32)		+= entry_32.o setup_32.o
 obj-$(CONFIG_PPC64)		+= dma-iommu.o iommu.o
 obj-$(CONFIG_KGDB)		+= kgdb.o
-- 
1.7.1
