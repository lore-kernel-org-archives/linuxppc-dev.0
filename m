Return-Path: <segher@gcc12.fsffrance.org>
Received: from snail.fsffrance.org (eucd.info [88.191.250.43])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DBBB8DE193
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Apr 2008 01:46:05 +1000 (EST)
From: Segher Boessenkool <segher@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Don't play type punning games with lock_token
Date: Wed, 23 Apr 2008 17:13:26 +0200
Message-Id: <2fcdb6beb2e205a397a1928c2c2c4b1e3360b09e.1208962154.git.segher@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The two u16 fields lock_token and paca_index in struct paca_struct are
accessed as one u32 field via type punning.  Change this into one u32
field paca_id, and add a paca_get_index() function to access only the
low 16 bits of this.

Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>
---
 arch/powerpc/kernel/asm-offsets.c          |    2 +-
 arch/powerpc/kernel/paca.c                 |    3 +--
 arch/powerpc/platforms/iseries/exception.S |    2 +-
 include/asm-powerpc/iseries/hv_call.h      |    2 +-
 include/asm-powerpc/paca.h                 |   18 ++++++++++++------
 include/asm-powerpc/smp.h                  |    2 +-
 include/asm-powerpc/spinlock.h             |    2 +-
 7 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 4b749c4..d00171f 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -108,7 +108,7 @@ int main(void)
 	DEFINE(ICACHEL1LINESPERPAGE, offsetof(struct ppc64_caches, ilines_per_page));
 	/* paca */
 	DEFINE(PACA_SIZE, sizeof(struct paca_struct));
-	DEFINE(PACAPACAINDEX, offsetof(struct paca_struct, paca_index));
+	DEFINE(PACAPACAID, offsetof(struct paca_struct, paca_id));
 	DEFINE(PACAPROCSTART, offsetof(struct paca_struct, cpu_start));
 	DEFINE(PACAKSAVE, offsetof(struct paca_struct, kstack));
 	DEFINE(PACACURRENT, offsetof(struct paca_struct, __current));
diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index 55f1a25..d68d86c 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -68,8 +68,7 @@ struct slb_shadow slb_shadow[] __cacheline_aligned = {
  */
 #define PACA_INIT_COMMON(number)					    \
 	.lppaca_ptr = &lppaca[number],					    \
-	.lock_token = 0x8000,						    \
-	.paca_index = (number),		/* Paca Index */		    \
+	.paca_id = 0x80000000 | (number),	/* Paca Index */	    \
 	.kernel_toc = (unsigned long)(&__toc_start) + 0x8000UL,		    \
 	.hw_cpu_id = 0xffff,						    \
 	.slb_shadow_ptr = &slb_shadow[number],
diff --git a/arch/powerpc/platforms/iseries/exception.S b/arch/powerpc/platforms/iseries/exception.S
index 5381038..17dea0d 100644
--- a/arch/powerpc/platforms/iseries/exception.S
+++ b/arch/powerpc/platforms/iseries/exception.S
@@ -42,7 +42,7 @@ system_reset_iSeries:
 	mfmsr	r24
 	ori	r24,r24,MSR_RI
 	mtmsrd	r24			/* RI on */
-	lhz	r24,PACAPACAINDEX(r13)	/* Get processor # */
+	lhz	r24,(PACAPACAID+2)(r13)	/* Get processor # */
 	cmpwi	0,r24,0			/* Are we processor 0? */
 	bne	1f
 	b	.__start_initialization_iSeries	/* Start up the first processor */
diff --git a/include/asm-powerpc/iseries/hv_call.h b/include/asm-powerpc/iseries/hv_call.h
index 162d653..998db2c 100644
--- a/include/asm-powerpc/iseries/hv_call.h
+++ b/include/asm-powerpc/iseries/hv_call.h
@@ -105,7 +105,7 @@ extern void HvCall_writeLogBuffer(const void *buffer, u64 bufLen);
 
 static inline void HvCall_sendIPI(struct paca_struct *targetPaca)
 {
-	HvCall1(HvCallBaseSendIPI, targetPaca->paca_index);
+	HvCall1(HvCallBaseSendIPI, paca_get_index(targetPaca));
 }
 
 #endif /* _ASM_POWERPC_ISERIES_HV_CALL_H */
diff --git a/include/asm-powerpc/paca.h b/include/asm-powerpc/paca.h
index 748b35a..7665d0a 100644
--- a/include/asm-powerpc/paca.h
+++ b/include/asm-powerpc/paca.h
@@ -65,13 +65,12 @@ struct paca_struct {
 #endif /* CONFIG_PPC_ISERIES */
 
 	/*
-	 * MAGIC: the spinlock functions in arch/powerpc/lib/locks.c 
-	 * load lock_token and paca_index with a single lwz
-	 * instruction.  They must travel together and be properly
-	 * aligned.
+	 * MAGIC: the spinlock functions in arch/powerpc/lib/locks.c
+	 * load paca_id with a single lwz instruction.  The high half
+	 * of this is constant 0x8000; the low half is the paca index,
+	 * accessed with paca_get_index().
 	 */
-	u16 lock_token;			/* Constant 0x8000, used in locks */
-	u16 paca_index;			/* Logical processor number */
+	u32 paca_id;
 
 	u64 kernel_toc;			/* Kernel TOC address */
 	u64 stab_real;			/* Absolute address of segment table */
@@ -117,6 +116,13 @@ struct paca_struct {
 	u64 startspurr;			/* SPURR value snapshot */
 };
 
+static inline u16 paca_get_index(struct paca_struct *paca)
+{
+	/* GCC will transform this into a single lhz instruction.  */
+
+	return paca->paca_id & 0xffff;
+}
+
 extern struct paca_struct paca[];
 
 #endif /* __KERNEL__ */
diff --git a/include/asm-powerpc/smp.h b/include/asm-powerpc/smp.h
index 505f35b..5fb4f13 100644
--- a/include/asm-powerpc/smp.h
+++ b/include/asm-powerpc/smp.h
@@ -46,7 +46,7 @@ void generic_mach_cpu_die(void);
 #endif
 
 #ifdef CONFIG_PPC64
-#define raw_smp_processor_id()	(local_paca->paca_index)
+#define raw_smp_processor_id()	paca_get_index(local_paca)
 #define hard_smp_processor_id() (get_paca()->hw_cpu_id)
 #else
 /* 32-bit */
diff --git a/include/asm-powerpc/spinlock.h b/include/asm-powerpc/spinlock.h
index cc4cfce..5922a2f 100644
--- a/include/asm-powerpc/spinlock.h
+++ b/include/asm-powerpc/spinlock.h
@@ -31,7 +31,7 @@
 
 #ifdef CONFIG_PPC64
 /* use 0x800000yy when locked, where yy == CPU number */
-#define LOCK_TOKEN	(*(u32 *)(&get_paca()->lock_token))
+#define LOCK_TOKEN	(get_paca()->paca_id)
 #else
 #define LOCK_TOKEN	1
 #endif
-- 
1.5.5.23.g2a5f.dirty
