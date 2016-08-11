Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8yB45wTBzDr0Z
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 16:03:24 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH 4/5] powerpc/Makefile: Drop CONFIG_WORD_SIZE for BITS
Date: Thu, 11 Aug 2016 16:03:14 +1000
Message-Id: <1470895395-10007-4-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1470895395-10007-1-git-send-email-mpe@ellerman.id.au>
References: <1470895395-10007-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 2578bfae84a7 ("[POWERPC] Create and use CONFIG_WORD_SIZE") added
CONFIG_WORD_SIZE, and suggests that other arches were going to do
likewise.

But that never happened, powerpc is the only architecture which uses it.

So switch to using a simple make variable, BITS, like x86, sh, sparc and
tile. It is also easier to spell and simpler, avoiding any confusion
about whether it's defined due to ordering of make vs kconfig.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Kconfig         |  5 -----
 arch/powerpc/Makefile        | 25 +++++++++++++++----------
 arch/powerpc/kernel/Makefile | 15 +++++++--------
 arch/powerpc/lib/Makefile    |  2 +-
 arch/powerpc/mm/Makefile     |  7 +++----
 5 files changed, 26 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index ec4047e170a0..d8eaf7b54ced 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -12,11 +12,6 @@ config 64BIT
 	bool
 	default y if PPC64
 
-config WORD_SIZE
-	int
-	default 64 if PPC64
-	default 32 if !PPC64
-
 config ARCH_PHYS_ADDR_T_64BIT
        def_bool PPC64 || PHYS_64BIT
 
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index ff3369b01666..c941d5360366 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -57,10 +57,15 @@ OLDARCH	:= ppc
 endif
 endif
 
-# It seems there are times we use this Makefile without
-# including the config file, but this replicates the old behaviour
-ifeq ($(CONFIG_WORD_SIZE),)
-CONFIG_WORD_SIZE := 32
+# BITS is used as extension for files which are available in a 32 bit
+# and a 64 bit version to simplify shared Makefiles.
+# e.g.: obj-y += foo_$(BITS).o
+export BITS
+
+ifdef CONFIG_PPC64
+        BITS := 64
+else
+        BITS := 32
 endif
 
 UTS_MACHINE := $(OLDARCH)
@@ -88,10 +93,10 @@ aflags-$(CONFIG_CPU_BIG_ENDIAN)		+= $(call cc-option,-mbig-endian)
 aflags-$(CONFIG_CPU_LITTLE_ENDIAN)	+= -mlittle-endian
 
 ifeq ($(HAS_BIARCH),y)
-override AS	+= -a$(CONFIG_WORD_SIZE)
-override LD	+= -m elf$(CONFIG_WORD_SIZE)$(LDEMULATION)
-override CC	+= -m$(CONFIG_WORD_SIZE)
-override AR	:= GNUTARGET=elf$(CONFIG_WORD_SIZE)-$(GNUTARGET) $(AR)
+override AS	+= -a$(BITS)
+override LD	+= -m elf$(BITS)$(LDEMULATION)
+override CC	+= -m$(BITS)
+override AR	:= GNUTARGET=elf$(BITS)-$(GNUTARGET) $(AR)
 endif
 
 LDFLAGS_vmlinux-y := -Bstatic
@@ -178,7 +183,7 @@ KBUILD_CFLAGS	+= $(call cc-option,-msoft-float)
 KBUILD_CFLAGS	+= -pipe -Iarch/$(ARCH) $(CFLAGS-y)
 CPP		= $(CC) -E $(KBUILD_CFLAGS)
 
-CHECKFLAGS	+= -m$(CONFIG_WORD_SIZE) -D__powerpc__ -D__powerpc$(CONFIG_WORD_SIZE)__
+CHECKFLAGS	+= -m$(BITS) -D__powerpc__ -D__powerpc$(BITS)__
 ifdef CONFIG_CPU_BIG_ENDIAN
 CHECKFLAGS	+= -D__BIG_ENDIAN__
 else
@@ -233,7 +238,7 @@ KBUILD_CFLAGS += $(cpu-as-y)
 KBUILD_AFLAGS += $(aflags-y)
 KBUILD_CFLAGS += $(cflags-y)
 
-head-y				:= arch/powerpc/kernel/head_$(CONFIG_WORD_SIZE).o
+head-y				:= arch/powerpc/kernel/head_$(BITS).o
 head-$(CONFIG_8xx)		:= arch/powerpc/kernel/head_8xx.o
 head-$(CONFIG_40x)		:= arch/powerpc/kernel/head_40x.o
 head-$(CONFIG_44x)		:= arch/powerpc/kernel/head_44x.o
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index b2027a5cf508..9faaf34f0401 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -31,8 +31,7 @@ obj-y				:= cputable.o ptrace.o syscalls.o \
 				   process.o systbl.o idle.o \
 				   signal.o sysfs.o cacheinfo.o time.o \
 				   prom.o traps.o setup-common.o \
-				   udbg.o misc.o io.o dma.o \
-				   misc_$(CONFIG_WORD_SIZE).o \
+				   udbg.o misc.o io.o dma.o misc_$(BITS).o \
 				   of_platform.o prom_parse.o
 obj-$(CONFIG_PPC64)		+= setup_64.o sys_ppc32.o \
 				   signal_64.o ptrace32.o \
@@ -70,23 +69,23 @@ obj-$(CONFIG_HIBERNATION)	+= swsusp.o suspend.o
 ifeq ($(CONFIG_FSL_BOOKE),y)
 obj-$(CONFIG_HIBERNATION)	+= swsusp_booke.o
 else
-obj-$(CONFIG_HIBERNATION)	+= swsusp_$(CONFIG_WORD_SIZE).o
+obj-$(CONFIG_HIBERNATION)	+= swsusp_$(BITS).o
 endif
 obj64-$(CONFIG_HIBERNATION)	+= swsusp_asm64.o
-obj-$(CONFIG_MODULES)		+= module.o module_$(CONFIG_WORD_SIZE).o
+obj-$(CONFIG_MODULES)		+= module.o module_$(BITS).o
 obj-$(CONFIG_44x)		+= cpu_setup_44x.o
 obj-$(CONFIG_PPC_FSL_BOOK3E)	+= cpu_setup_fsl_booke.o
 obj-$(CONFIG_PPC_DOORBELL)	+= dbell.o
 obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
 
-extra-y				:= head_$(CONFIG_WORD_SIZE).o
+extra-y				:= head_$(BITS).o
 extra-$(CONFIG_40x)		:= head_40x.o
 extra-$(CONFIG_44x)		:= head_44x.o
 extra-$(CONFIG_FSL_BOOKE)	:= head_fsl_booke.o
 extra-$(CONFIG_8xx)		:= head_8xx.o
 extra-y				+= vmlinux.lds
 
-obj-$(CONFIG_RELOCATABLE)	+= reloc_$(CONFIG_WORD_SIZE).o
+obj-$(CONFIG_RELOCATABLE)	+= reloc_$(BITS).o
 
 obj-$(CONFIG_PPC32)		+= entry_32.o setup_32.o
 obj-$(CONFIG_PPC64)		+= dma-iommu.o iommu.o
@@ -104,11 +103,11 @@ obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 obj-$(CONFIG_SWIOTLB)		+= dma-swiotlb.o
 
 pci64-$(CONFIG_PPC64)		+= pci_dn.o pci-hotplug.o isa-bridge.o
-obj-$(CONFIG_PCI)		+= pci_$(CONFIG_WORD_SIZE).o $(pci64-y) \
+obj-$(CONFIG_PCI)		+= pci_$(BITS).o $(pci64-y) \
 				   pci-common.o pci_of_scan.o
 obj-$(CONFIG_PCI_MSI)		+= msi.o
 obj-$(CONFIG_KEXEC)		+= machine_kexec.o crash.o \
-				   machine_kexec_$(CONFIG_WORD_SIZE).o
+				   machine_kexec_$(BITS).o
 obj-$(CONFIG_AUDIT)		+= audit.o
 obj64-$(CONFIG_AUDIT)		+= compat_audit.o
 
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index ba21be15310f..ad5290005ca4 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -22,7 +22,7 @@ obj64-$(CONFIG_SMP)	+= locks.o
 obj64-$(CONFIG_ALTIVEC)	+= vmx-helper.o
 
 ifeq ($(CONFIG_GENERIC_CSUM),)
-obj-y			+= checksum_$(CONFIG_WORD_SIZE).o checksum_wrappers.o
+obj-y			+= checksum_$(BITS).o checksum_wrappers.o
 endif
 
 obj-$(CONFIG_PPC_EMULATE_SSTEP)	+= sstep.o ldstfp.o
diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index f2cea6d5e764..1a4e570f7894 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -7,17 +7,16 @@ subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
 ccflags-$(CONFIG_PPC64)	:= $(NO_MINIMAL_TOC)
 
 obj-y				:= fault.o mem.o pgtable.o mmap.o \
-				   init_$(CONFIG_WORD_SIZE).o \
-				   pgtable_$(CONFIG_WORD_SIZE).o
+				   init_$(BITS).o pgtable_$(BITS).o
 obj-$(CONFIG_PPC_MMU_NOHASH)	+= mmu_context_nohash.o tlb_nohash.o \
 				   tlb_nohash_low.o
-obj-$(CONFIG_PPC_BOOK3E)	+= tlb_low_$(CONFIG_WORD_SIZE)e.o
+obj-$(CONFIG_PPC_BOOK3E)	+= tlb_low_$(BITS)e.o
 hash64-$(CONFIG_PPC_NATIVE)	:= hash_native_64.o
 obj-$(CONFIG_PPC_BOOK3E_64)   += pgtable-book3e.o
 obj-$(CONFIG_PPC_STD_MMU_64)	+= pgtable-hash64.o hash_utils_64.o slb_low.o slb.o $(hash64-y) mmu_context_book3s64.o pgtable-book3s64.o
 obj-$(CONFIG_PPC_RADIX_MMU)	+= pgtable-radix.o tlb-radix.o
 obj-$(CONFIG_PPC_STD_MMU_32)	+= ppc_mmu_32.o hash_low_32.o mmu_context_hash32.o
-obj-$(CONFIG_PPC_STD_MMU)	+= tlb_hash$(CONFIG_WORD_SIZE).o
+obj-$(CONFIG_PPC_STD_MMU)	+= tlb_hash$(BITS).o
 ifeq ($(CONFIG_PPC_STD_MMU_64),y)
 obj-$(CONFIG_PPC_4K_PAGES)	+= hash64_4k.o
 obj-$(CONFIG_PPC_64K_PAGES)	+= hash64_64k.o
-- 
2.7.4
