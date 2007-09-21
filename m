Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 1CAB4DDEE4
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 10:16:29 +1000 (EST)
Date: Fri, 21 Sep 2007 10:16:20 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] Create and use CONFIG_WORD_SIZE
Message-Id: <20070921101620.716be2b3.sfr@canb.auug.org.au>
In-Reply-To: <20070920180825.39aca4d7.sfr@canb.auug.org.au>
References: <20070920180825.39aca4d7.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linus made this suggestion for the x86 merge and this starts the process
for powerpc. We assume that CONFIG_PPC64 implies CONFIG_PPC_MERGE and
CONFIG_PPC_STD_MMU_32 implies CONFIG_PPC_STD_MMU.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/Kconfig         |    5 +++++
 arch/powerpc/Makefile        |   21 ++++++++++++---------
 arch/powerpc/kernel/Makefile |   30 +++++++++++++-----------------
 arch/powerpc/lib/Makefile    |    7 ++++---
 arch/powerpc/mm/Makefile     |   13 ++++++++-----
 arch/ppc/Kconfig             |    4 ++++
 6 files changed, 46 insertions(+), 34 deletions(-)

I got some strange warnings from allmodconfig and this version makes them
go away.  It appears that sometimes we don't include the config when
using the top level arch Makefile.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 66a3295..de886ec 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -14,6 +14,11 @@ config 64BIT
 	bool
 	default y if PPC64
 
+config WORD_SIZE
+	int
+	default 64 if PPC64
+	default 32 if !PPC64
+
 config PPC_MERGE
 	def_bool y
 
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 6015a92..4fda65e 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -39,7 +39,6 @@ KBUILD_DEFCONFIG := $(shell uname -m)_defconfig
 
 ifeq ($(CONFIG_PPC64),y)
 OLDARCH	:= ppc64
-SZ	:= 64
 
 new_nm := $(shell if $(NM) --help 2>&1 | grep -- '--synthetic' > /dev/null; then echo y; else echo n; fi)
 
@@ -49,16 +48,21 @@ endif
 
 else
 OLDARCH	:= ppc
-SZ	:= 32
+endif
+
+# It seems there are times we use this Makefile without
+# including the config file, but this replicates the old behaviour
+ifeq ($(CONFIG_WORD_SIZE),)
+CONFIG_WORD_SIZE := 32
 endif
 
 UTS_MACHINE := $(OLDARCH)
 
 ifeq ($(HAS_BIARCH),y)
-override AS	+= -a$(SZ)
-override LD	+= -m elf$(SZ)ppc
-override CC	+= -m$(SZ)
-override AR	:= GNUTARGET=elf$(SZ)-powerpc $(AR)
+override AS	+= -a$(CONFIG_WORD_SIZE)
+override LD	+= -m elf$(CONFIG_WORD_SIZE)ppc
+override CC	+= -m$(CONFIG_WORD_SIZE)
+override AR	:= GNUTARGET=elf$(CONFIG_WORD_SIZE)-powerpc $(AR)
 endif
 
 LDFLAGS_vmlinux	:= -Bstatic
@@ -72,7 +76,7 @@ AFLAGS		+= $(AFLAGS-y)
 CFLAGS		+= -msoft-float -pipe $(CFLAGS-y)
 CPP		= $(CC) -E $(CFLAGS)
 
-CHECKFLAGS	+= -m$(SZ) -D__powerpc__ -D__powerpc$(SZ)__
+CHECKFLAGS	+= -m$(CONFIG_WORD_SIZE) -D__powerpc__ -D__powerpc$(CONFIG_WORD_SIZE)__
 
 ifeq ($(CONFIG_PPC64),y)
 GCC_BROKEN_VEC	:= $(shell if [ $(call cc-version) -lt 0400 ] ; then echo "y"; fi)
@@ -116,8 +120,7 @@ cpu-as-$(CONFIG_E200)		+= -Wa,-me200
 AFLAGS += $(cpu-as-y)
 CFLAGS += $(cpu-as-y)
 
-head-y				:= arch/powerpc/kernel/head_32.o
-head-$(CONFIG_PPC64)		:= arch/powerpc/kernel/head_64.o
+head-y				:= arch/powerpc/kernel/head_$(CONFIG_WORD_SIZE).o
 head-$(CONFIG_8xx)		:= arch/powerpc/kernel/head_8xx.o
 head-$(CONFIG_40x)		:= arch/powerpc/kernel/head_40x.o
 head-$(CONFIG_44x)		:= arch/powerpc/kernel/head_44x.o
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 967afc5..ef3633f 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -37,10 +37,10 @@ obj-$(CONFIG_GENERIC_TBSYNC)	+= smp-tbsync.o
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 obj-$(CONFIG_6xx)		+= idle_6xx.o l2cr_6xx.o cpu_setup_6xx.o
 obj-$(CONFIG_TAU)		+= tau_6xx.o
-obj-$(CONFIG_HIBERNATION)	+= swsusp.o suspend.o
-obj32-$(CONFIG_HIBERNATION) += swsusp_32.o
-obj64-$(CONFIG_HIBERNATION) += swsusp_64.o swsusp_asm64.o
-obj32-$(CONFIG_MODULES)		+= module_32.o
+obj-$(CONFIG_HIBERNATION)	+= swsusp.o suspend.o \
+				   swsusp_$(CONFIG_WORD_SIZE).o
+obj64-$(CONFIG_HIBERNATION)	+= swsusp_asm64.o
+obj-$(CONFIG_MODULES)		+= module_$(CONFIG_WORD_SIZE).o
 
 ifeq ($(CONFIG_PPC_MERGE),y)
 
@@ -53,9 +53,10 @@ extra-$(CONFIG_8xx)		:= head_8xx.o
 extra-y				+= vmlinux.lds
 
 obj-y				+= time.o prom.o traps.o setup-common.o \
-				   udbg.o misc.o io.o
-obj-$(CONFIG_PPC32)		+= entry_32.o setup_32.o misc_32.o
-obj-$(CONFIG_PPC64)		+= misc_64.o dma_64.o iommu.o
+				   udbg.o misc.o io.o \
+				   misc_$(CONFIG_WORD_SIZE).o
+obj-$(CONFIG_PPC32)		+= entry_32.o setup_32.o
+obj-$(CONFIG_PPC64)		+= dma_64.o iommu.o
 obj-$(CONFIG_PPC_MULTIPLATFORM)	+= prom_init.o
 obj-$(CONFIG_MODULES)		+= ppc_ksyms.o
 obj-$(CONFIG_BOOTX_TEXT)	+= btext.o
@@ -63,16 +64,12 @@ obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_KPROBES)		+= kprobes.o
 obj-$(CONFIG_PPC_UDBG_16550)	+= legacy_serial.o udbg_16550.o
 
-module-$(CONFIG_PPC64)		+= module_64.o
-obj-$(CONFIG_MODULES)		+= $(module-y)
-
-pci64-$(CONFIG_PPC64)		+= pci_64.o pci_dn.o isa-bridge.o
-pci32-$(CONFIG_PPC32)		:= pci_32.o
-obj-$(CONFIG_PCI)		+= $(pci64-y) $(pci32-y) pci-common.o
+pci64-$(CONFIG_PPC64)		+= pci_dn.o isa-bridge.o
+obj-$(CONFIG_PCI)		+= pci_$(CONFIG_WORD_SIZE).o $(pci64-y) \
+				   pci-common.o
 obj-$(CONFIG_PCI_MSI)		+= msi.o
-kexec-$(CONFIG_PPC64)		:= machine_kexec_64.o
-kexec-$(CONFIG_PPC32)		:= machine_kexec_32.o
-obj-$(CONFIG_KEXEC)		+= machine_kexec.o crash.o $(kexec-y)
+obj-$(CONFIG_KEXEC)		+= machine_kexec.o crash.o \
+				   machine_kexec_$(CONFIG_WORD_SIZE).o
 obj-$(CONFIG_AUDIT)		+= audit.o
 obj64-$(CONFIG_AUDIT)		+= compat_audit.o
 
@@ -86,7 +83,6 @@ smpobj-$(CONFIG_SMP)		+= smp.o
 
 endif
 
-obj-$(CONFIG_PPC32)		+= $(obj32-y)
 obj-$(CONFIG_PPC64)		+= $(obj64-y)
 
 extra-$(CONFIG_PPC_FPU)		+= fpu.o
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index 23bbb1e..65d492e 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -7,11 +7,12 @@ EXTRA_CFLAGS		+= -mno-minimal-toc
 endif
 
 ifeq ($(CONFIG_PPC_MERGE),y)
-obj-y			:= string.o alloc.o
-obj-$(CONFIG_PPC32)	+= div64.o copy_32.o checksum_32.o
+obj-y			:= string.o alloc.o \
+			   checksum_$(CONFIG_WORD_SIZE).o
+obj-$(CONFIG_PPC32)	+= div64.o copy_32.o
 endif
 
-obj-$(CONFIG_PPC64)	+= checksum_64.o copypage_64.o copyuser_64.o \
+obj-$(CONFIG_PPC64)	+= copypage_64.o copyuser_64.o \
 			   memcpy_64.o usercopy_64.o mem_64.o string.o
 obj-$(CONFIG_QUICC_ENGINE) += rheap.o
 obj-$(CONFIG_XMON)	+= sstep.o
diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index bf20fa6..20629ae 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -6,13 +6,16 @@ ifeq ($(CONFIG_PPC64),y)
 EXTRA_CFLAGS	+= -mno-minimal-toc
 endif
 
-obj-y				:= fault.o mem.o lmb.o
-obj-$(CONFIG_PPC32)		+= init_32.o pgtable_32.o mmu_context_32.o
+obj-y				:= fault.o mem.o lmb.o \
+				   init_$(CONFIG_WORD_SIZE).o \
+				   pgtable_$(CONFIG_WORD_SIZE).o \
+				   mmu_context_$(CONFIG_WORD_SIZE).o
 hash-$(CONFIG_PPC_NATIVE)	:= hash_native_64.o
-obj-$(CONFIG_PPC64)		+= init_64.o pgtable_64.o mmu_context_64.o \
-				   hash_utils_64.o hash_low_64.o tlb_64.o \
+obj-$(CONFIG_PPC64)		+= hash_utils_64.o \
 				   slb_low.o slb.o stab.o mmap.o $(hash-y)
-obj-$(CONFIG_PPC_STD_MMU_32)	+= ppc_mmu_32.o hash_low_32.o tlb_32.o
+obj-$(CONFIG_PPC_STD_MMU_32)	+= ppc_mmu_32.o
+obj-$(CONFIG_PPC_STD_MMU)	+= hash_low_$(CONFIG_WORD_SIZE).o \
+				   tlb_$(CONFIG_WORD_SIZE).o
 obj-$(CONFIG_40x)		+= 40x_mmu.o
 obj-$(CONFIG_44x)		+= 44x_mmu.o
 obj-$(CONFIG_FSL_BOOKE)		+= fsl_booke_mmu.o
diff --git a/arch/ppc/Kconfig b/arch/ppc/Kconfig
index c1b34eb..c2087f6 100644
--- a/arch/ppc/Kconfig
+++ b/arch/ppc/Kconfig
@@ -4,6 +4,10 @@
 
 mainmenu "Linux/PowerPC Kernel Configuration"
 
+config WORD_SIZE
+	int
+	default 32
+
 config MMU
 	bool
 	default y
-- 
1.5.3.1
