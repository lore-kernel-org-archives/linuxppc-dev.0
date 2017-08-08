Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRXxF70sqzDqp9
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 21:58:57 +1000 (AEST)
Message-Id: <b0ddf7fa5ac8d295a181fce239aea27974225b2c.1502191399.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1502191399.git.christophe.leroy@c-s.fr>
References: <cover.1502191399.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 08/12] powerpc/8xx: Getting rid of remaining use of CONFIG_8xx
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue,  8 Aug 2017 13:58:54 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Two config options exist to define powerpc MPC8xx:
* CONFIG_PPC_8xx
* CONFIG_8xx

arch/powerpc/platforms/Kconfig.cputype has contained the following
comment about CONFIG_8xx item for some years:
"# this is temp to handle compat with arch=ppc"

arch/powerpc is now the only place with remaining use of
CONFIG_8xx: get rid of them.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Kconfig                         |  4 ++--
 arch/powerpc/Makefile                        |  2 +-
 arch/powerpc/boot/Makefile                   |  4 ++--
 arch/powerpc/include/asm/cache.h             |  2 +-
 arch/powerpc/include/asm/cputable.h          |  4 ++--
 arch/powerpc/include/asm/fs_pd.h             |  2 +-
 arch/powerpc/include/asm/nohash/32/pgtable.h |  2 +-
 arch/powerpc/include/asm/ppc_asm.h           |  2 +-
 arch/powerpc/include/asm/reg.h               | 10 +++++-----
 arch/powerpc/include/asm/timex.h             |  2 +-
 arch/powerpc/kernel/Makefile                 |  2 +-
 arch/powerpc/kernel/cputable.c               |  4 ++--
 arch/powerpc/kernel/irq.c                    |  2 +-
 arch/powerpc/kernel/kgdb.c                   |  4 ++--
 arch/powerpc/mm/fault.c                      |  2 +-
 arch/powerpc/mm/mem.c                        |  2 +-
 arch/powerpc/mm/mmu_decl.h                   | 10 +++++-----
 arch/powerpc/mm/tlb_nohash_low.S             |  2 +-
 arch/powerpc/platforms/8xx/Kconfig           |  1 -
 arch/powerpc/platforms/Kconfig.cputype       |  2 +-
 20 files changed, 32 insertions(+), 33 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index f2e2a07dd422..634871cee587 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -394,7 +394,7 @@ config HUGETLB_PAGE_SIZE_VARIABLE
 
 config MATH_EMULATION
 	bool "Math emulation"
-	depends on 4xx || 8xx || PPC_MPC832x || BOOKE
+	depends on 4xx || PPC_8xx || PPC_MPC832x || BOOKE
 	---help---
 	  Some PowerPC chips designed for embedded applications do not have
 	  a floating-point unit and therefore do not implement the
@@ -956,7 +956,7 @@ config PPC_PCI_CHOICE
 
 config PCI
 	bool "PCI support" if PPC_PCI_CHOICE
-	default y if !40x && !CPM2 && !8xx && !PPC_83xx \
+	default y if !40x && !CPM2 && !PPC_8xx && !PPC_83xx \
 		&& !PPC_85xx && !PPC_86xx && !GAMECUBE_COMMON
 	default PCI_QSPAN if PPC_8xx
 	select GENERIC_PCI_IOMAP
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 0c4b282ec936..399765ccff2f 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -250,7 +250,7 @@ KBUILD_AFLAGS += $(aflags-y)
 KBUILD_CFLAGS += $(cflags-y)
 
 head-y				:= arch/powerpc/kernel/head_$(BITS).o
-head-$(CONFIG_8xx)		:= arch/powerpc/kernel/head_8xx.o
+head-$(CONFIG_PPC_8xx)		:= arch/powerpc/kernel/head_8xx.o
 head-$(CONFIG_40x)		:= arch/powerpc/kernel/head_40x.o
 head-$(CONFIG_44x)		:= arch/powerpc/kernel/head_44x.o
 head-$(CONFIG_FSL_BOOKE)	:= arch/powerpc/kernel/head_fsl_booke.o
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 6f952fe1f084..8a437c5f6b01 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -115,7 +115,7 @@ src-wlib-y += crtsavres.S
 endif
 src-wlib-$(CONFIG_40x) += 4xx.c planetcore.c
 src-wlib-$(CONFIG_44x) += 4xx.c ebony.c bamboo.c
-src-wlib-$(CONFIG_8xx) += mpc8xx.c planetcore.c fsl-soc.c
+src-wlib-$(CONFIG_PPC_8xx) += mpc8xx.c planetcore.c fsl-soc.c
 src-wlib-$(CONFIG_PPC_82xx) += pq2.c fsl-soc.c planetcore.c
 src-wlib-$(CONFIG_EMBEDDED6xx) += mv64x60.c mv64x60_i2c.c ugecon.c fsl-soc.c
 
@@ -132,7 +132,7 @@ src-plat-$(CONFIG_44x) += treeboot-ebony.c cuboot-ebony.c treeboot-bamboo.c \
 				treeboot-iss4xx.c treeboot-currituck.c \
 				treeboot-akebono.c \
 				simpleboot.c fixed-head.S virtex.c
-src-plat-$(CONFIG_8xx) += cuboot-8xx.c fixed-head.S ep88xc.c redboot-8xx.c
+src-plat-$(CONFIG_PPC_8xx) += cuboot-8xx.c fixed-head.S ep88xc.c redboot-8xx.c
 src-plat-$(CONFIG_PPC_MPC52xx) += cuboot-52xx.c
 src-plat-$(CONFIG_PPC_82xx) += cuboot-pq2.c fixed-head.S ep8248e.c cuboot-824x.c
 src-plat-$(CONFIG_PPC_83xx) += cuboot-83xx.c fixed-head.S redboot-83xx.c
diff --git a/arch/powerpc/include/asm/cache.h b/arch/powerpc/include/asm/cache.h
index 5a90292afbad..d122f7f957ce 100644
--- a/arch/powerpc/include/asm/cache.h
+++ b/arch/powerpc/include/asm/cache.h
@@ -5,7 +5,7 @@
 
 
 /* bytes per L1 cache line */
-#if defined(CONFIG_8xx) || defined(CONFIG_403GCX)
+#if defined(CONFIG_PPC_8xx) || defined(CONFIG_403GCX)
 #define L1_CACHE_SHIFT		4
 #define MAX_COPY_PREFETCH	1
 #elif defined(CONFIG_PPC_E500MC)
diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index d02ad93bf708..a9bf921f4efc 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -513,7 +513,7 @@ enum {
 #else
 	    CPU_FTRS_GENERIC_32 |
 #endif
-#ifdef CONFIG_8xx
+#ifdef CONFIG_PPC_8xx
 	    CPU_FTRS_8XX |
 #endif
 #ifdef CONFIG_40x
@@ -565,7 +565,7 @@ enum {
 #else
 	    CPU_FTRS_GENERIC_32 &
 #endif
-#ifdef CONFIG_8xx
+#ifdef CONFIG_PPC_8xx
 	    CPU_FTRS_8XX &
 #endif
 #ifdef CONFIG_40x
diff --git a/arch/powerpc/include/asm/fs_pd.h b/arch/powerpc/include/asm/fs_pd.h
index f79d6c74eb2a..8def56ec05c6 100644
--- a/arch/powerpc/include/asm/fs_pd.h
+++ b/arch/powerpc/include/asm/fs_pd.h
@@ -26,7 +26,7 @@
 #define cpm2_unmap(addr) do {} while(0)
 #endif
 
-#ifdef CONFIG_8xx
+#ifdef CONFIG_PPC_8xx
 #include <asm/8xx_immap.h>
 
 extern immap_t __iomem *mpc8xx_immr;
diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index 91314268f04f..9278eaa7ca59 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -121,7 +121,7 @@ extern int icache_44x_need_flush;
 #include <asm/nohash/pte-book3e.h>
 #elif defined(CONFIG_FSL_BOOKE)
 #include <asm/nohash/32/pte-fsl-booke.h>
-#elif defined(CONFIG_8xx)
+#elif defined(CONFIG_PPC_8xx)
 #include <asm/nohash/32/pte-8xx.h>
 #endif
 
diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index d0e4f909ee36..c6e0cc1cb8cf 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -417,7 +417,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_601)
  * and they must be used.
  */
 
-#if !defined(CONFIG_4xx) && !defined(CONFIG_8xx)
+#if !defined(CONFIG_4xx) && !defined(CONFIG_PPC_8xx)
 #define tlbia					\
 	li	r4,1024;			\
 	mtctr	r4;				\
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index c0600e9e0ff5..70722e5b93e7 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -22,9 +22,9 @@
 #include <asm/reg_fsl_emb.h>
 #endif
 
-#ifdef CONFIG_8xx
+#ifdef CONFIG_PPC_8xx
 #include <asm/reg_8xx.h>
-#endif /* CONFIG_8xx */
+#endif /* CONFIG_PPC_8xx */
 
 #define MSR_SF_LG	63              /* Enable 64 bit mode */
 #define MSR_ISF_LG	61              /* Interrupt 64b mode valid on 630 */
@@ -135,7 +135,7 @@
 #define MSR_KERNEL	(MSR_ | MSR_64BIT)
 #define MSR_USER32	(MSR_ | MSR_PR | MSR_EE)
 #define MSR_USER64	(MSR_USER32 | MSR_64BIT)
-#elif defined(CONFIG_PPC_BOOK3S_32) || defined(CONFIG_8xx)
+#elif defined(CONFIG_PPC_BOOK3S_32) || defined(CONFIG_PPC_8xx)
 /* Default MSR for kernel mode. */
 #define MSR_KERNEL	(MSR_ME|MSR_RI|MSR_IR|MSR_DR)
 #define MSR_USER	(MSR_KERNEL|MSR_PR|MSR_EE)
@@ -1164,7 +1164,7 @@
 #endif
 #endif
 
-#ifdef CONFIG_8xx
+#ifdef CONFIG_PPC_8xx
 #define SPRN_SPRG_SCRATCH0	SPRN_SPRG0
 #define SPRN_SPRG_SCRATCH1	SPRN_SPRG1
 #define SPRN_SPRG_SCRATCH2	SPRN_SPRG2
@@ -1363,7 +1363,7 @@ static inline void msr_check_and_clear(unsigned long bits)
 
 #else /* __powerpc64__ */
 
-#if defined(CONFIG_8xx)
+#if defined(CONFIG_PPC_8xx)
 #define mftbl()		({unsigned long rval;	\
 			asm volatile("mftbl %0" : "=r" (rval)); rval;})
 #define mftbu()		({unsigned long rval;	\
diff --git a/arch/powerpc/include/asm/timex.h b/arch/powerpc/include/asm/timex.h
index b467dbcb0fb7..cb61eae5b7ed 100644
--- a/arch/powerpc/include/asm/timex.h
+++ b/arch/powerpc/include/asm/timex.h
@@ -29,7 +29,7 @@ static inline cycles_t get_cycles(void)
 	ret = 0;
 
 	__asm__ __volatile__(
-#ifdef CONFIG_8xx
+#ifdef CONFIG_PPC_8xx
 		"97:	mftb %0\n"
 #else
 		"97:	mfspr %0, %2\n"
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 21f88017df91..ea7ac4a50d21 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -84,7 +84,7 @@ extra-y				:= head_$(BITS).o
 extra-$(CONFIG_40x)		:= head_40x.o
 extra-$(CONFIG_44x)		:= head_44x.o
 extra-$(CONFIG_FSL_BOOKE)	:= head_fsl_booke.o
-extra-$(CONFIG_8xx)		:= head_8xx.o
+extra-$(CONFIG_PPC_8xx)		:= head_8xx.o
 extra-y				+= vmlinux.lds
 
 obj-$(CONFIG_RELOCATABLE)	+= reloc_$(BITS).o
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 080bf51e0104..e9ba5b84ac9b 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -1259,7 +1259,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.platform		= "ppc603",
 	},
 #endif /* CONFIG_PPC_BOOK3S_32 */
-#ifdef CONFIG_8xx
+#ifdef CONFIG_PPC_8xx
 	{	/* 8xx */
 		.pvr_mask		= 0xffff0000,
 		.pvr_value		= 0x00500000,
@@ -1274,7 +1274,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.machine_check		= machine_check_8xx,
 		.platform		= "ppc823",
 	},
-#endif /* CONFIG_8xx */
+#endif /* CONFIG_PPC_8xx */
 #ifdef CONFIG_40x
 	{	/* 403GC */
 		.pvr_mask		= 0xffffff00,
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index f291f7826abc..d99c57c2db32 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -24,7 +24,7 @@
  * mask register (of which only 16 are defined), hence the weird shifting
  * and complement of the cached_irq_mask.  I want to be able to stuff
  * this right into the SIU SMASK register.
- * Many of the prep/chrp functions are conditional compiled on CONFIG_8xx
+ * Many of the prep/chrp functions are conditional compiled on CONFIG_PPC_8xx
  * to reduce code space and undefined function references.
  */
 
diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
index dbf098121ce6..35e240a0a408 100644
--- a/arch/powerpc/kernel/kgdb.c
+++ b/arch/powerpc/kernel/kgdb.c
@@ -67,9 +67,9 @@ static struct hard_trap_info
 #endif
 #else /* ! (defined(CONFIG_40x) || defined(CONFIG_BOOKE)) */
 	{ 0x0d00, 0x05 /* SIGTRAP */ },		/* single-step */
-#if defined(CONFIG_8xx)
+#if defined(CONFIG_PPC_8xx)
 	{ 0x1000, 0x04 /* SIGILL */  },		/* software emulation */
-#else /* ! CONFIG_8xx */
+#else /* ! CONFIG_PPC_8xx */
 	{ 0x0f00, 0x04 /* SIGILL */  },		/* performance monitor */
 	{ 0x0f20, 0x08 /* SIGFPE */  },		/* altivec unavailable */
 	{ 0x1300, 0x05 /* SIGTRAP */ }, 	/* instruction address break */
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index c0f2f807c989..7a218f69f956 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -391,7 +391,7 @@ static void sanity_check_fault(bool is_write, unsigned long error_code) { }
 #define page_fault_is_bad(__err)	(0)
 #else
 #define page_fault_is_write(__err)	((__err) & DSISR_ISSTORE)
-#if defined(CONFIG_8xx)
+#if defined(CONFIG_PPC_8xx)
 #define page_fault_is_bad(__err)	((__err) & 0x10000000)
 #elif defined(CONFIG_PPC64)
 #define page_fault_is_bad(__err)	((__err) & DSISR_BAD_FAULT_64S)
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 46b4e67d2372..4362b86ef84c 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -436,7 +436,7 @@ void flush_dcache_icache_page(struct page *page)
 		return;
 	}
 #endif
-#if defined(CONFIG_8xx) || defined(CONFIG_PPC64)
+#if defined(CONFIG_PPC_8xx) || defined(CONFIG_PPC64)
 	/* On 8xx there is no need to kmap since highmem is not supported */
 	__flush_dcache_icache(page_address(page));
 #else
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index d46128b22150..57fbc554c785 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -27,7 +27,7 @@
 /*
  * On 40x and 8xx, we directly inline tlbia and tlbivax
  */
-#if defined(CONFIG_40x) || defined(CONFIG_8xx)
+#if defined(CONFIG_40x) || defined(CONFIG_PPC_8xx)
 static inline void _tlbil_all(void)
 {
 	asm volatile ("sync; tlbia; isync" : : : "memory");
@@ -38,7 +38,7 @@ static inline void _tlbil_pid(unsigned int pid)
 }
 #define _tlbil_pid_noind(pid)	_tlbil_pid(pid)
 
-#else /* CONFIG_40x || CONFIG_8xx */
+#else /* CONFIG_40x || CONFIG_PPC_8xx */
 extern void _tlbil_all(void);
 extern void _tlbil_pid(unsigned int pid);
 #ifdef CONFIG_PPC_BOOK3E
@@ -46,12 +46,12 @@ extern void _tlbil_pid_noind(unsigned int pid);
 #else
 #define _tlbil_pid_noind(pid)	_tlbil_pid(pid)
 #endif
-#endif /* !(CONFIG_40x || CONFIG_8xx) */
+#endif /* !(CONFIG_40x || CONFIG_PPC_8xx) */
 
 /*
  * On 8xx, we directly inline tlbie, on others, it's extern
  */
-#ifdef CONFIG_8xx
+#ifdef CONFIG_PPC_8xx
 static inline void _tlbil_va(unsigned long address, unsigned int pid,
 			     unsigned int tsize, unsigned int ind)
 {
@@ -67,7 +67,7 @@ static inline void _tlbil_va(unsigned long address, unsigned int pid,
 {
 	__tlbil_va(address, pid);
 }
-#endif /* CONFIG_8xx */
+#endif /* CONFIG_PPC_8xx */
 
 #if defined(CONFIG_PPC_BOOK3E) || defined(CONFIG_PPC_47x)
 extern void _tlbivax_bcast(unsigned long address, unsigned int pid,
diff --git a/arch/powerpc/mm/tlb_nohash_low.S b/arch/powerpc/mm/tlb_nohash_low.S
index eabecfcaef7c..048b8e9f4492 100644
--- a/arch/powerpc/mm/tlb_nohash_low.S
+++ b/arch/powerpc/mm/tlb_nohash_low.S
@@ -60,7 +60,7 @@ _GLOBAL(__tlbil_va)
 	isync
 1:	blr
 
-#elif defined(CONFIG_8xx)
+#elif defined(CONFIG_PPC_8xx)
 
 /*
  * Nothing to do for 8xx, everything is inline
diff --git a/arch/powerpc/platforms/8xx/Kconfig b/arch/powerpc/platforms/8xx/Kconfig
index 6dd5053faaec..3e51153b9ae1 100644
--- a/arch/powerpc/platforms/8xx/Kconfig
+++ b/arch/powerpc/platforms/8xx/Kconfig
@@ -5,7 +5,6 @@ config CPM1
 choice
 	prompt "8xx Machine Type"
 	depends on PPC_8xx
-	depends on 8xx
 	default MPC885ADS
 
 config MPC8XXFADS
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 9539620a48d4..395593ef580c 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -375,7 +375,7 @@ config NR_CPUS
 
 config NOT_COHERENT_CACHE
 	bool
-	depends on 4xx || 8xx || E200 || PPC_MPC512x || GAMECUBE_COMMON
+	depends on 4xx || PPC_8xx || E200 || PPC_MPC512x || GAMECUBE_COMMON
 	default n if PPC_47x
 	default y
 
-- 
2.13.3
