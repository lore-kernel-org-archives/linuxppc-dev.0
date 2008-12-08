Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 08 Dec 2008 16:40:03 +1100
Subject: [PATCH 3/9] powerpc/4xx: Extended DCR support
In-Reply-To: <1228714789.103940.266501677728.qpush@grosgo>
Message-Id: <20081208054057.34A5FDDD04@ozlabs.org>
Cc: Kumar Gala <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds supports to the "extended" DCR addressing via
the indirect mfdcrx/mtdcrx instructions supported by some
4xx cores (440H6 and later)

I enabled the feature for now only on AMCC 460 chips

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/include/asm/cputable.h   |    7 ++-
 arch/powerpc/include/asm/dcr-native.h |   63 +++++++++++++++++++++++++++-------
 arch/powerpc/kernel/cputable.c        |    4 +-
 arch/powerpc/sysdev/dcr-low.S         |    8 +++-
 4 files changed, 65 insertions(+), 17 deletions(-)

--- linux-work.orig/arch/powerpc/include/asm/cputable.h	2008-12-08 15:43:12.000000000 +1100
+++ linux-work/arch/powerpc/include/asm/cputable.h	2008-12-08 15:43:41.000000000 +1100
@@ -164,6 +164,7 @@ extern const char *powerpc_base_platform
 #define CPU_FTR_NEED_PAIRED_STWCX	ASM_CONST(0x0000000004000000)
 #define CPU_FTR_LWSYNC			ASM_CONST(0x0000000008000000)
 #define CPU_FTR_NOEXECUTE		ASM_CONST(0x0000000010000000)
+#define CPU_FTR_INDEXED_DCR		ASM_CONST(0x0000000020000000)
 
 /*
  * Add the 64-bit processor unique features in the top half of the word;
@@ -369,6 +370,8 @@ extern const char *powerpc_base_platform
 #define CPU_FTRS_8XX	(CPU_FTR_USE_TB)
 #define CPU_FTRS_40X	(CPU_FTR_USE_TB | CPU_FTR_NODSISRALIGN | CPU_FTR_NOEXECUTE)
 #define CPU_FTRS_44X	(CPU_FTR_USE_TB | CPU_FTR_NODSISRALIGN | CPU_FTR_NOEXECUTE)
+#define CPU_FTRS_440H6	(CPU_FTR_USE_TB | CPU_FTR_NODSISRALIGN | CPU_FTR_NOEXECUTE | \
+	    CPU_FTR_INDEXED_DCR)
 #define CPU_FTRS_E200	(CPU_FTR_USE_TB | CPU_FTR_SPE_COMP | \
 	    CPU_FTR_NODSISRALIGN | CPU_FTR_COHERENT_ICACHE | \
 	    CPU_FTR_UNIFIED_ID_CACHE | CPU_FTR_NOEXECUTE)
@@ -455,7 +458,7 @@ enum {
 	    CPU_FTRS_40X |
 #endif
 #ifdef CONFIG_44x
-	    CPU_FTRS_44X |
+	    CPU_FTRS_44X | CPU_FTRS_440H6 |
 #endif
 #ifdef CONFIG_E200
 	    CPU_FTRS_E200 |
@@ -495,7 +498,7 @@ enum {
 	    CPU_FTRS_40X &
 #endif
 #ifdef CONFIG_44x
-	    CPU_FTRS_44X &
+	    CPU_FTRS_44X & CPU_FTRS_440H6 &
 #endif
 #ifdef CONFIG_E200
 	    CPU_FTRS_E200 &
Index: linux-work/arch/powerpc/include/asm/dcr-native.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/dcr-native.h	2008-09-29 14:21:37.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/dcr-native.h	2008-12-08 15:43:41.000000000 +1100
@@ -23,6 +23,7 @@
 #ifndef __ASSEMBLY__
 
 #include <linux/spinlock.h>
+#include <asm/cputable.h>
 
 typedef struct {
 	unsigned int base;
@@ -39,23 +40,45 @@ static inline bool dcr_map_ok_native(dcr
 #define dcr_read_native(host, dcr_n)		mfdcr(dcr_n + host.base)
 #define dcr_write_native(host, dcr_n, value)	mtdcr(dcr_n + host.base, value)
 
-/* Device Control Registers */
-void __mtdcr(int reg, unsigned int val);
-unsigned int __mfdcr(int reg);
+/* Table based DCR accessors */
+extern void __mtdcr(unsigned int reg, unsigned int val);
+extern unsigned int __mfdcr(unsigned int reg);
+
+/* mfdcrx/mtdcrx instruction based accessors. We hand code
+ * the opcodes in order not to depend on newer binutils
+ */
+static inline unsigned int mfdcrx(unsigned int reg)
+{
+	unsigned int ret;
+	asm volatile(".long 0x7c000206 | (%0 << 21) | (%1 << 16)"
+		     : "=r" (ret) : "r" (reg));
+	return ret;
+}
+
+static inline void mtdcrx(unsigned int reg, unsigned int val)
+{
+	asm volatile(".long 0x7c000306 | (%0 << 21) | (%1 << 16)"
+		     : : "r" (val), "r" (reg));
+}
+
 #define mfdcr(rn)						\
 	({unsigned int rval;					\
-	if (__builtin_constant_p(rn))				\
+	if (__builtin_constant_p(rn) && rn < 1024)		\
 		asm volatile("mfdcr %0," __stringify(rn)	\
 		              : "=r" (rval));			\
+	else if (likely(cpu_has_feature(CPU_FTR_INDEXED_DCR)))	\
+		rval = mfdcrx(rn);				\
 	else							\
 		rval = __mfdcr(rn);				\
 	rval;})
 
 #define mtdcr(rn, v)						\
 do {								\
-	if (__builtin_constant_p(rn))				\
+	if (__builtin_constant_p(rn) && rn < 1024)		\
 		asm volatile("mtdcr " __stringify(rn) ",%0"	\
 			      : : "r" (v)); 			\
+	else if (likely(cpu_has_feature(CPU_FTR_INDEXED_DCR)))	\
+		mtdcrx(rn, v);					\
 	else							\
 		__mtdcr(rn, v);					\
 } while (0)
@@ -69,8 +92,13 @@ static inline unsigned __mfdcri(int base
 	unsigned int val;
 
 	spin_lock_irqsave(&dcr_ind_lock, flags);
-	__mtdcr(base_addr, reg);
-	val = __mfdcr(base_data);
+	if (cpu_has_feature(CPU_FTR_INDEXED_DCR)) {
+		mtdcrx(base_addr, reg);
+		val = mfdcrx(base_data);
+	} else {
+		__mtdcr(base_addr, reg);
+		val = __mfdcr(base_data);
+	}
 	spin_unlock_irqrestore(&dcr_ind_lock, flags);
 	return val;
 }
@@ -81,8 +109,13 @@ static inline void __mtdcri(int base_add
 	unsigned long flags;
 
 	spin_lock_irqsave(&dcr_ind_lock, flags);
-	__mtdcr(base_addr, reg);
-	__mtdcr(base_data, val);
+	if (cpu_has_feature(CPU_FTR_INDEXED_DCR)) {
+		mtdcrx(base_addr, reg);
+		mtdcrx(base_data, val);
+	} else {
+		__mtdcr(base_addr, reg);
+		__mtdcr(base_data, val);
+	}
 	spin_unlock_irqrestore(&dcr_ind_lock, flags);
 }
 
@@ -93,9 +126,15 @@ static inline void __dcri_clrset(int bas
 	unsigned int val;
 
 	spin_lock_irqsave(&dcr_ind_lock, flags);
-	__mtdcr(base_addr, reg);
-	val = (__mfdcr(base_data) & ~clr) | set;
-	__mtdcr(base_data, val);
+	if (cpu_has_feature(CPU_FTR_INDEXED_DCR)) {
+		mtdcrx(base_addr, reg);
+		val = (mfdcrx(base_data) & ~clr) | set;
+		mtdcrx(base_data, val);
+	} else {
+		__mtdcr(base_addr, reg);
+		val = (__mfdcr(base_data) & ~clr) | set;
+		__mtdcr(base_data, val);
+	}
 	spin_unlock_irqrestore(&dcr_ind_lock, flags);
 }
 
Index: linux-work/arch/powerpc/sysdev/dcr-low.S
===================================================================
--- linux-work.orig/arch/powerpc/sysdev/dcr-low.S	2008-07-07 13:45:04.000000000 +1000
+++ linux-work/arch/powerpc/sysdev/dcr-low.S	2008-12-08 15:43:41.000000000 +1100
@@ -11,14 +11,20 @@
 
 #include <asm/ppc_asm.h>
 #include <asm/processor.h>
+#include <asm/bug.h>
 
 #define DCR_ACCESS_PROLOG(table) \
+	cmpli	cr0,r3,1024;	 \
 	rlwinm  r3,r3,4,18,27;   \
 	lis     r5,table@h;      \
 	ori     r5,r5,table@l;   \
 	add     r3,r3,r5;        \
+	bge-	1f;		 \
 	mtctr   r3;              \
-	bctr
+	bctr;			 \
+1:	trap;			 \
+	EMIT_BUG_ENTRY 1b,__FILE__,__LINE__,0;	\
+	blr
 
 _GLOBAL(__mfdcr)
 	DCR_ACCESS_PROLOG(__mfdcr_table)
Index: linux-work/arch/powerpc/kernel/cputable.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/cputable.c	2008-11-24 14:48:55.000000000 +1100
+++ linux-work/arch/powerpc/kernel/cputable.c	2008-12-08 15:43:41.000000000 +1100
@@ -1506,7 +1506,7 @@ static struct cpu_spec __initdata cpu_sp
 		.pvr_mask		= 0xffff0002,
 		.pvr_value		= 0x13020002,
 		.cpu_name		= "460EX",
-		.cpu_features		= CPU_FTRS_44X,
+		.cpu_features		= CPU_FTRS_440H6,
 		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
@@ -1518,7 +1518,7 @@ static struct cpu_spec __initdata cpu_sp
 		.pvr_mask		= 0xffff0002,
 		.pvr_value		= 0x13020000,
 		.cpu_name		= "460GT",
-		.cpu_features		= CPU_FTRS_44X,
+		.cpu_features		= CPU_FTRS_440H6,
 		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
