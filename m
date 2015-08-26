Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6A2E61A1DA9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2015 18:27:14 +1000 (AEST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 26 Aug 2015 13:57:12 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id DC058394005C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2015 13:57:08 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7Q8QiYw45023384
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2015 13:56:44 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7Q8QfGv025418
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2015 13:56:43 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 ryabinin.a.a@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 10/10] powerpc/mm: kasan: Add kasan support for ppc64
Date: Wed, 26 Aug 2015 13:56:18 +0530
Message-Id: <1440577578-15813-11-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1440577578-15813-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1440577578-15813-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We use the region with region ID 0xe as the kasan shadow region. Since
we use hash page table, we can't have the early zero page based shadow
region support. Hence we disable kasan in the early code and runtime
enable this. We could imporve the condition using static keys. (but
that is for a later patch). We also can't support inline instrumentation
because our kernel mapping doesn't give us a large enough free window
to map the entire range. For VMALLOC and VMEMMAP region we just
return a zero page instead of having a translation bolted into the
htab. This simplifies handling VMALLOC and VMEMAP area. Kasan is not
tracking both the region as of now

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kasan.h         | 74 ++++++++++++++++++++++++++++++++
 arch/powerpc/include/asm/pgtable-ppc64.h |  1 +
 arch/powerpc/include/asm/ppc_asm.h       | 10 +++++
 arch/powerpc/include/asm/string.h        | 13 ++++++
 arch/powerpc/kernel/Makefile             |  5 +++
 arch/powerpc/kernel/prom_init_check.sh   |  2 +-
 arch/powerpc/kernel/setup_64.c           |  3 ++
 arch/powerpc/kvm/Makefile                |  1 +
 arch/powerpc/lib/mem_64.S                |  6 ++-
 arch/powerpc/lib/memcpy_64.S             |  3 +-
 arch/powerpc/lib/ppc_ksyms.c             | 10 +++++
 arch/powerpc/mm/Makefile                 |  7 +++
 arch/powerpc/mm/kasan_init.c             | 44 +++++++++++++++++++
 arch/powerpc/mm/slb_low.S                |  4 ++
 arch/powerpc/platforms/Kconfig.cputype   |  1 +
 15 files changed, 180 insertions(+), 4 deletions(-)
 create mode 100644 arch/powerpc/include/asm/kasan.h
 create mode 100644 arch/powerpc/mm/kasan_init.c

diff --git a/arch/powerpc/include/asm/kasan.h b/arch/powerpc/include/asm/kasan.h
new file mode 100644
index 000000000000..51e76e698bb9
--- /dev/null
+++ b/arch/powerpc/include/asm/kasan.h
@@ -0,0 +1,74 @@
+#ifndef __ASM_KASAN_H
+#define __ASM_KASAN_H
+
+#ifndef __ASSEMBLY__
+
+#ifdef CONFIG_KASAN
+/*
+ * KASAN_SHADOW_START: We use a new region for kasan mapping
+ * KASAN_SHADOW_END: KASAN_SHADOW_START + 1/8 of kernel virtual addresses.
+ */
+#define KASAN_SHADOW_START      (KASAN_REGION_ID << REGION_SHIFT)
+#define KASAN_SHADOW_END        (KASAN_SHADOW_START + (1UL << (PGTABLE_RANGE - 3)))
+/*
+ * This value is used to map an address to the corresponding shadow
+ * address by the following formula:
+ *     shadow_addr = (address >> 3) + KASAN_SHADOW_OFFSET;
+ *
+ * This applies to the linear mapping.
+ * Hence 0xc000000000000000 -> 0xe000000000000000
+ * We use an internal zero page as the shadow address for vmall and vmemmap
+ * region, since we don't track both of them now.
+ *
+ */
+#define KASAN_SHADOW_KERNEL_OFFSET	((KASAN_REGION_ID << REGION_SHIFT) - \
+					 (KERNEL_REGION_ID << (REGION_SHIFT - 3)))
+
+extern unsigned char kasan_zero_page[PAGE_SIZE];
+#define kasan_mem_to_shadow kasan_mem_to_shadow
+static inline void *kasan_mem_to_shadow(const void *addr)
+{
+	unsigned long offset = 0;
+
+	switch (REGION_ID(addr)) {
+	case KERNEL_REGION_ID:
+		offset = KASAN_SHADOW_KERNEL_OFFSET;
+		break;
+	default:
+		return (void *)kasan_zero_page;
+	}
+	return (void *)((unsigned long)addr >> KASAN_SHADOW_SCALE_SHIFT)
+		+ offset;
+}
+
+#define kasan_shadow_to_mem kasan_shadow_to_mem
+static inline void *kasan_shadow_to_mem(const void *shadow_addr)
+{
+	unsigned long offset = 0;
+
+	switch (REGION_ID(shadow_addr)) {
+	case KASAN_REGION_ID:
+		offset = KASAN_SHADOW_KERNEL_OFFSET;
+		break;
+	default:
+		pr_err("Shadow memory whose origin not found %p\n", shadow_addr);
+		BUG();
+	}
+	return (void *)(((unsigned long)shadow_addr - offset)
+			<< KASAN_SHADOW_SCALE_SHIFT);
+}
+
+#define kasan_enabled kasan_enabled
+extern bool __kasan_enabled;
+static inline bool kasan_enabled(void)
+{
+	return __kasan_enabled;
+}
+
+void kasan_init(void);
+#else
+static inline void kasan_init(void) { }
+#endif
+
+#endif
+#endif
diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/include/asm/pgtable-ppc64.h
index 3bb7488bd24b..369ce5442aa6 100644
--- a/arch/powerpc/include/asm/pgtable-ppc64.h
+++ b/arch/powerpc/include/asm/pgtable-ppc64.h
@@ -80,6 +80,7 @@
 #define KERNEL_REGION_ID	(REGION_ID(PAGE_OFFSET))
 #define VMEMMAP_REGION_ID	(0xfUL)	/* Server only */
 #define USER_REGION_ID		(0UL)
+#define KASAN_REGION_ID		(0xeUL) /* Server only */
 
 /*
  * Defines the address of the vmemap area, in its own region on
diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index dd0fc18d8103..e75ae67e804e 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -226,6 +226,11 @@ name:
 
 #define DOTSYM(a)	a
 
+#define KASAN_OVERRIDE(x, y) \
+	.weak x;	     \
+	.set x, y
+
+
 #else
 
 #define XGLUE(a,b) a##b
@@ -263,6 +268,11 @@ GLUE(.,name):
 
 #define DOTSYM(a)	GLUE(.,a)
 
+#define KASAN_OVERRIDE(x, y)	\
+	.weak x;		\
+	.set x, y;		\
+	.weak DOTSYM(x);	\
+	.set DOTSYM(x), DOTSYM(y)
 #endif
 
 #else /* 32-bit */
diff --git a/arch/powerpc/include/asm/string.h b/arch/powerpc/include/asm/string.h
index e40010abcaf1..b10a4c01cdbf 100644
--- a/arch/powerpc/include/asm/string.h
+++ b/arch/powerpc/include/asm/string.h
@@ -27,6 +27,19 @@ extern void * memmove(void *,const void *,__kernel_size_t);
 extern int memcmp(const void *,const void *,__kernel_size_t);
 extern void * memchr(const void *,int,__kernel_size_t);
 
+extern void * __memset(void *, int, __kernel_size_t);
+extern void * __memcpy(void *, const void *, __kernel_size_t);
+extern void * __memmove(void *, const void *, __kernel_size_t);
+
+#if defined(CONFIG_KASAN) && !defined(__SANITIZE_ADDRESS__)
+/*
+ * For files that are not instrumented (e.g. mm/slub.c) we
+ * should use not instrumented version of mem* functions.
+ */
+#define memcpy(dst, src, len) __memcpy(dst, src, len)
+#define memmove(dst, src, len) __memmove(dst, src, len)
+#define memset(s, c, n) __memset(s, c, n)
+#endif
 #endif /* __KERNEL__ */
 
 #endif	/* _ASM_POWERPC_STRING_H */
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 12868b1c4e05..7b205628fd1b 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -26,6 +26,11 @@ CFLAGS_REMOVE_ftrace.o = -pg -mno-sched-epilog
 CFLAGS_REMOVE_time.o = -pg -mno-sched-epilog
 endif
 
+KASAN_SANITIZE_prom_init.o := n
+KASAN_SANITIZE_align.o := n
+KASAN_SANITIZE_dbell.o := n
+KASAN_SANITIZE_setup_64.o := n
+
 obj-y				:= cputable.o ptrace.o syscalls.o \
 				   irq.o align.o signal_32.o pmc.o vdso.o \
 				   process.o systbl.o idle.o \
diff --git a/arch/powerpc/kernel/prom_init_check.sh b/arch/powerpc/kernel/prom_init_check.sh
index 12640f7e726b..e25777956123 100644
--- a/arch/powerpc/kernel/prom_init_check.sh
+++ b/arch/powerpc/kernel/prom_init_check.sh
@@ -17,7 +17,7 @@
 # it to the list below:
 
 WHITELIST="add_reloc_offset __bss_start __bss_stop copy_and_flush
-_end enter_prom memcpy memset reloc_offset __secondary_hold
+_end enter_prom __memcpy __memset memcpy memset reloc_offset __secondary_hold
 __secondary_hold_acknowledge __secondary_hold_spinloop __start
 strcmp strcpy strlcpy strlen strncmp strstr logo_linux_clut224
 reloc_got2 kernstart_addr memstart_addr linux_banner _stext
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index bdcbb716f4d6..4b766638ead9 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -69,6 +69,7 @@
 #include <asm/kvm_ppc.h>
 #include <asm/hugetlb.h>
 #include <asm/epapr_hcalls.h>
+#include <asm/kasan.h>
 
 #ifdef DEBUG
 #define DBG(fmt...) udbg_printf(fmt)
@@ -708,6 +709,8 @@ void __init setup_arch(char **cmdline_p)
 	/* Initialize the MMU context management stuff */
 	mmu_context_init();
 
+	kasan_init();
+
 	/* Interrupt code needs to be 64K-aligned */
 	if ((unsigned long)_stext & 0xffff)
 		panic("Kernelbase not 64K-aligned (0x%lx)!\n",
diff --git a/arch/powerpc/kvm/Makefile b/arch/powerpc/kvm/Makefile
index 0570eef83fba..26288d16899e 100644
--- a/arch/powerpc/kvm/Makefile
+++ b/arch/powerpc/kvm/Makefile
@@ -3,6 +3,7 @@
 #
 
 subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
+KASAN_SANITIZE :=n
 
 ccflags-y := -Ivirt/kvm -Iarch/powerpc/kvm
 KVM := ../../../virt/kvm
diff --git a/arch/powerpc/lib/mem_64.S b/arch/powerpc/lib/mem_64.S
index 43435c6892fb..0e1f811babdd 100644
--- a/arch/powerpc/lib/mem_64.S
+++ b/arch/powerpc/lib/mem_64.S
@@ -12,7 +12,8 @@
 #include <asm/errno.h>
 #include <asm/ppc_asm.h>
 
-_GLOBAL(memset)
+KASAN_OVERRIDE(memset,__memset)
+_GLOBAL(__memset)
 	neg	r0,r3
 	rlwimi	r4,r4,8,16,23
 	andi.	r0,r0,7			/* # bytes to be 8-byte aligned */
@@ -77,7 +78,8 @@ _GLOBAL(memset)
 	stb	r4,0(r6)
 	blr
 
-_GLOBAL_TOC(memmove)
+KASAN_OVERRIDE(memmove,__memmove)
+_GLOBAL_TOC(__memmove)
 	cmplw	0,r3,r4
 	bgt	backwards_memcpy
 	b	memcpy
diff --git a/arch/powerpc/lib/memcpy_64.S b/arch/powerpc/lib/memcpy_64.S
index 32a06ec395d2..396b44181ec1 100644
--- a/arch/powerpc/lib/memcpy_64.S
+++ b/arch/powerpc/lib/memcpy_64.S
@@ -10,7 +10,8 @@
 #include <asm/ppc_asm.h>
 
 	.align	7
-_GLOBAL_TOC(memcpy)
+KASAN_OVERRIDE(memcpy,__memcpy)
+_GLOBAL_TOC(__memcpy)
 BEGIN_FTR_SECTION
 #ifdef __LITTLE_ENDIAN__
 	cmpdi	cr7,r5,0
diff --git a/arch/powerpc/lib/ppc_ksyms.c b/arch/powerpc/lib/ppc_ksyms.c
index c7f8e9586316..3a27b08bee26 100644
--- a/arch/powerpc/lib/ppc_ksyms.c
+++ b/arch/powerpc/lib/ppc_ksyms.c
@@ -9,6 +9,16 @@ EXPORT_SYMBOL(memmove);
 EXPORT_SYMBOL(memcmp);
 EXPORT_SYMBOL(memchr);
 
+#ifdef CONFIG_PPC64
+/*
+ * There symbols are needed with kasan. We only
+ * have that enabled for ppc64 now.
+ */
+EXPORT_SYMBOL(__memcpy);
+EXPORT_SYMBOL(__memset);
+EXPORT_SYMBOL(__memmove);
+#endif
+
 EXPORT_SYMBOL(strcpy);
 EXPORT_SYMBOL(strncpy);
 EXPORT_SYMBOL(strcat);
diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index 3eb73a38220d..ad7d589c7e44 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -6,6 +6,11 @@ subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
 
 ccflags-$(CONFIG_PPC64)	:= $(NO_MINIMAL_TOC)
 
+KASAN_SANITIZE_kasan_init.o	:= n
+KASAN_SANITIZE_hash_utils_64.o	:= n
+KASAN_SANITIZE_hugetlbpage.o	:= n
+KASAN_SANITIZE_slb.o	:= n
+
 obj-y				:= fault.o mem.o pgtable.o mmap.o \
 				   init_$(CONFIG_WORD_SIZE).o \
 				   pgtable_$(CONFIG_WORD_SIZE).o
@@ -37,3 +42,5 @@ obj-$(CONFIG_NOT_COHERENT_CACHE) += dma-noncoherent.o
 obj-$(CONFIG_HIGHMEM)		+= highmem.o
 obj-$(CONFIG_PPC_COPRO_BASE)	+= copro_fault.o
 obj-$(CONFIG_SPAPR_TCE_IOMMU)	+= mmu_context_iommu.o
+
+obj-$(CONFIG_KASAN)		+= kasan_init.o
diff --git a/arch/powerpc/mm/kasan_init.c b/arch/powerpc/mm/kasan_init.c
new file mode 100644
index 000000000000..9deba6019fbf
--- /dev/null
+++ b/arch/powerpc/mm/kasan_init.c
@@ -0,0 +1,44 @@
+#define pr_fmt(fmt) "kasan: " fmt
+#include <linux/kernel.h>
+#include <linux/memblock.h>
+#include <linux/kasan.h>
+
+bool __kasan_enabled = false;
+unsigned char kasan_zero_page[PAGE_SIZE] __page_aligned_bss;
+void __init kasan_init(void)
+{
+	unsigned long k_start, k_end;
+	struct memblock_region *reg;
+	unsigned long page_size = 1 << mmu_psize_defs[mmu_vmemmap_psize].shift;
+
+
+	for_each_memblock(memory, reg) {
+		void *p;
+		void *start = __va(reg->base);
+		void *end = __va(reg->base + reg->size);
+		int node = pfn_to_nid(virt_to_pfn(start));
+
+		if (start >= end)
+			break;
+
+		k_start = (unsigned long)kasan_mem_to_shadow(start);
+		k_end = (unsigned long)kasan_mem_to_shadow(end);
+		for (; k_start < k_end; k_start += page_size) {
+			p = vmemmap_alloc_block(page_size, node);
+			if (!p) {
+				pr_info("Disabled Kasan, for lack of free mem\n");
+				/* Free the stuff or panic ? */
+				return;
+			}
+			htab_bolt_mapping(k_start, k_start + page_size,
+					  __pa(p), pgprot_val(PAGE_KERNEL),
+					  mmu_vmemmap_psize, mmu_kernel_ssize);
+		}
+	}
+	/*
+	 * At this point kasan is fully initialized. Enable error messages
+	 */
+	init_task.kasan_depth = 0;
+	__kasan_enabled = true;
+	pr_info("Kernel address sanitizer initialized\n");
+}
diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
index 736d18b3cefd..154bd8a0b437 100644
--- a/arch/powerpc/mm/slb_low.S
+++ b/arch/powerpc/mm/slb_low.S
@@ -80,11 +80,15 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_1T_SEGMENT)
 	/* Check virtual memmap region. To be patches at kernel boot */
 	cmpldi	cr0,r9,0xf
 	bne	1f
+2:
 .globl slb_miss_kernel_load_vmemmap
 slb_miss_kernel_load_vmemmap:
 	li	r11,0
 	b	6f
 1:
+	/* Kasan region same as vmemmap mapping */
+	cmpldi	cr0,r9,0xe
+	beq	2b
 #endif /* CONFIG_SPARSEMEM_VMEMMAP */
 
 	/* vmalloc mapping gets the encoding from the PACA as the mapping
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index c140e94c7c72..7a7c9d54f80e 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -75,6 +75,7 @@ config PPC_BOOK3S_64
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if PPC_64K_PAGES
 	select ARCH_SUPPORTS_NUMA_BALANCING
 	select IRQ_WORK
+	select HAVE_ARCH_KASAN if SPARSEMEM_VMEMMAP
 
 config PPC_BOOK3E_64
 	bool "Embedded processors"
-- 
2.5.0
