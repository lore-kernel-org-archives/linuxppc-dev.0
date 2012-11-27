Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 04/16] powerpc: New macros for transactional memory support
Date: Tue, 27 Nov 2012 13:47:56 +1100
Message-Id: <1353984488-1283-5-git-send-email-mikey@neuling.org>
In-Reply-To: <1353984488-1283-1-git-send-email-mikey@neuling.org>
References: <1353984488-1283-1-git-send-email-mikey@neuling.org>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Matt Evans <matt@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds new macros for saving and restoring checkpointed architected state
from and to the thread_struct.

It also adds some debugging macros for when your brain explodes trying to debug
your transactional memory enabled kernel.

Signed-off-by: Matt Evans <matt@ozlabs.org>
Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/include/asm/ppc_asm.h   |   83 ++++++++++++++++++++++++++++++++++
 arch/powerpc/include/asm/processor.h |    1 +
 arch/powerpc/kernel/asm-offsets.c    |   24 ++++++++++
 arch/powerpc/kernel/fpu.S            |   12 +++++
 arch/powerpc/kernel/process.c        |   10 ++++
 arch/powerpc/kernel/traps.c          |   11 +++++
 6 files changed, 141 insertions(+)

diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index ea2a86e..a17a598 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -125,6 +125,89 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
 #define REST_16VRS(n,b,base)	REST_8VRS(n,b,base); REST_8VRS(n+8,b,base)
 #define REST_32VRS(n,b,base)	REST_16VRS(n,b,base); REST_16VRS(n+16,b,base)
 
+/* Save/restore FPRs, VRs and VSRs from their checkpointed backups in
+ * thread_struct:
+ */
+#define SAVE_FPR_TRANSACT(n, base)	stfd n,THREAD_TRANSACT_FPR0+	\
+					8*TS_FPRWIDTH*(n)(base)
+#define SAVE_2FPRS_TRANSACT(n, base)	SAVE_FPR_TRANSACT(n, base);	\
+					SAVE_FPR_TRANSACT(n+1, base)
+#define SAVE_4FPRS_TRANSACT(n, base)	SAVE_2FPRS_TRANSACT(n, base);	\
+					SAVE_2FPRS_TRANSACT(n+2, base)
+#define SAVE_8FPRS_TRANSACT(n, base)	SAVE_4FPRS_TRANSACT(n, base);	\
+					SAVE_4FPRS_TRANSACT(n+4, base)
+#define SAVE_16FPRS_TRANSACT(n, base)	SAVE_8FPRS_TRANSACT(n, base);	\
+					SAVE_8FPRS_TRANSACT(n+8, base)
+#define SAVE_32FPRS_TRANSACT(n, base)	SAVE_16FPRS_TRANSACT(n, base);	\
+					SAVE_16FPRS_TRANSACT(n+16, base)
+
+#define REST_FPR_TRANSACT(n, base)	lfd	n,THREAD_TRANSACT_FPR0+	\
+					8*TS_FPRWIDTH*(n)(base)
+#define REST_2FPRS_TRANSACT(n, base)	REST_FPR_TRANSACT(n, base);	\
+					REST_FPR_TRANSACT(n+1, base)
+#define REST_4FPRS_TRANSACT(n, base)	REST_2FPRS_TRANSACT(n, base);	\
+					REST_2FPRS_TRANSACT(n+2, base)
+#define REST_8FPRS_TRANSACT(n, base)	REST_4FPRS_TRANSACT(n, base);	\
+					REST_4FPRS_TRANSACT(n+4, base)
+#define REST_16FPRS_TRANSACT(n, base)	REST_8FPRS_TRANSACT(n, base);	\
+					REST_8FPRS_TRANSACT(n+8, base)
+#define REST_32FPRS_TRANSACT(n, base)	REST_16FPRS_TRANSACT(n, base);	\
+					REST_16FPRS_TRANSACT(n+16, base)
+
+
+#define SAVE_VR_TRANSACT(n,b,base)	li b,THREAD_TRANSACT_VR0+(16*(n)); \
+					stvx n,b,base
+#define SAVE_2VRS_TRANSACT(n,b,base)	SAVE_VR_TRANSACT(n,b,base);	\
+					SAVE_VR_TRANSACT(n+1,b,base)
+#define SAVE_4VRS_TRANSACT(n,b,base)	SAVE_2VRS_TRANSACT(n,b,base);	\
+					SAVE_2VRS_TRANSACT(n+2,b,base)
+#define SAVE_8VRS_TRANSACT(n,b,base)	SAVE_4VRS_TRANSACT(n,b,base);	\
+					SAVE_4VRS_TRANSACT(n+4,b,base)
+#define SAVE_16VRS_TRANSACT(n,b,base)	SAVE_8VRS_TRANSACT(n,b,base);	\
+					SAVE_8VRS_TRANSACT(n+8,b,base)
+#define SAVE_32VRS_TRANSACT(n,b,base)	SAVE_16VRS_TRANSACT(n,b,base);	\
+					SAVE_16VRS_TRANSACT(n+16,b,base)
+
+#define REST_VR_TRANSACT(n,b,base)	li b,THREAD_TRANSACT_VR0+(16*(n)); \
+					lvx n,b,base
+#define REST_2VRS_TRANSACT(n,b,base)	REST_VR_TRANSACT(n,b,base);	\
+					REST_VR_TRANSACT(n+1,b,base)
+#define REST_4VRS_TRANSACT(n,b,base)	REST_2VRS_TRANSACT(n,b,base);	\
+					REST_2VRS_TRANSACT(n+2,b,base)
+#define REST_8VRS_TRANSACT(n,b,base)	REST_4VRS_TRANSACT(n,b,base);	\
+					REST_4VRS_TRANSACT(n+4,b,base)
+#define REST_16VRS_TRANSACT(n,b,base)	REST_8VRS_TRANSACT(n,b,base);	\
+					REST_8VRS_TRANSACT(n+8,b,base)
+#define REST_32VRS_TRANSACT(n,b,base)	REST_16VRS_TRANSACT(n,b,base);	\
+					REST_16VRS_TRANSACT(n+16,b,base)
+
+
+#define SAVE_VSR_TRANSACT(n,b,base)	li b,THREAD_TRANSACT_VSR0+(16*(n)); \
+					STXVD2X(n,R##base,R##b)
+#define SAVE_2VSRS_TRANSACT(n,b,base)	SAVE_VSR_TRANSACT(n,b,base);	\
+	                                SAVE_VSR_TRANSACT(n+1,b,base)
+#define SAVE_4VSRS_TRANSACT(n,b,base)	SAVE_2VSRS_TRANSACT(n,b,base);	\
+	                                SAVE_2VSRS_TRANSACT(n+2,b,base)
+#define SAVE_8VSRS_TRANSACT(n,b,base)	SAVE_4VSRS_TRANSACT(n,b,base);	\
+	                                SAVE_4VSRS_TRANSACT(n+4,b,base)
+#define SAVE_16VSRS_TRANSACT(n,b,base)	SAVE_8VSRS_TRANSACT(n,b,base);	\
+	                                SAVE_8VSRS_TRANSACT(n+8,b,base)
+#define SAVE_32VSRS_TRANSACT(n,b,base)	SAVE_16VSRS_TRANSACT(n,b,base);	\
+	                                SAVE_16VSRS_TRANSACT(n+16,b,base)
+
+#define REST_VSR_TRANSACT(n,b,base)	li b,THREAD_TRANSACT_VSR0+(16*(n)); \
+					LXVD2X(n,R##base,R##b)
+#define REST_2VSRS_TRANSACT(n,b,base)	REST_VSR_TRANSACT(n,b,base);    \
+	                                REST_VSR_TRANSACT(n+1,b,base)
+#define REST_4VSRS_TRANSACT(n,b,base)	REST_2VSRS_TRANSACT(n,b,base);	\
+	                                REST_2VSRS_TRANSACT(n+2,b,base)
+#define REST_8VSRS_TRANSACT(n,b,base)	REST_4VSRS_TRANSACT(n,b,base);	\
+	                                REST_4VSRS_TRANSACT(n+4,b,base)
+#define REST_16VSRS_TRANSACT(n,b,base)	REST_8VSRS_TRANSACT(n,b,base);	\
+	                                REST_8VSRS_TRANSACT(n+8,b,base)
+#define REST_32VSRS_TRANSACT(n,b,base)	REST_16VSRS_TRANSACT(n,b,base);	\
+	                                REST_16VSRS_TRANSACT(n+16,b,base)
+
 /* Save the lower 32 VSRs in the thread VSR region */
 #define SAVE_VSR(n,b,base)	li b,THREAD_VSR0+(16*(n));  STXVD2X(n,R##base,R##b)
 #define SAVE_2VSRS(n,b,base)	SAVE_VSR(n,b,base); SAVE_VSR(n+1,b,base)
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 0d1c188..8b2bf7a 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -141,6 +141,7 @@ typedef struct {
 #define TS_FPROFFSET 0
 #define TS_VSRLOWOFFSET 1
 #define TS_FPR(i) fpr[i][TS_FPROFFSET]
+#define TS_TRANS_FPR(i) transact_fpr[i][TS_FPROFFSET]
 
 struct thread_struct {
 	unsigned long	ksp;		/* Kernel stack pointer */
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 7523539..1a70f02 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -121,6 +121,30 @@ int main(void)
 	DEFINE(THREAD_KVM_VCPU, offsetof(struct thread_struct, kvm_vcpu));
 #endif
 
+#ifdef CONFIG_TRANSACTIONAL_MEM
+	DEFINE(THREAD_TM_TFHAR, offsetof(struct thread_struct, tm_tfhar));
+	DEFINE(THREAD_TM_TEXASR, offsetof(struct thread_struct, tm_texasr));
+	DEFINE(THREAD_TM_TFIAR, offsetof(struct thread_struct, tm_tfiar));
+	DEFINE(PT_CKPT_REGS, offsetof(struct thread_struct, ckpt_regs));
+	DEFINE(THREAD_TRANSACT_VR0, offsetof(struct thread_struct,
+					 transact_vr[0]));
+	DEFINE(THREAD_TRANSACT_VSCR, offsetof(struct thread_struct,
+					  transact_vscr));
+	DEFINE(THREAD_TRANSACT_VRSAVE, offsetof(struct thread_struct,
+					    transact_vrsave));
+	DEFINE(THREAD_TRANSACT_FPR0, offsetof(struct thread_struct,
+					  transact_fpr[0]));
+	DEFINE(THREAD_TRANSACT_FPSCR, offsetof(struct thread_struct,
+					   transact_fpscr));
+#ifdef CONFIG_VSX
+	DEFINE(THREAD_TRANSACT_VSR0, offsetof(struct thread_struct,
+					  transact_fpr[0]));
+#endif
+	/* Local pt_regs on stack for Transactional Memory funcs. */
+	DEFINE(TM_FRAME_SIZE, STACK_FRAME_OVERHEAD +
+	       sizeof(struct pt_regs) + 16);
+#endif /* CONFIG_TRANSACTIONAL_MEM */
+
 	DEFINE(TI_FLAGS, offsetof(struct thread_info, flags));
 	DEFINE(TI_LOCAL_FLAGS, offsetof(struct thread_info, local_flags));
 	DEFINE(TI_PREEMPT, offsetof(struct thread_info, preempt_count));
diff --git a/arch/powerpc/kernel/fpu.S b/arch/powerpc/kernel/fpu.S
index e0ada05..adb1551 100644
--- a/arch/powerpc/kernel/fpu.S
+++ b/arch/powerpc/kernel/fpu.S
@@ -35,6 +35,15 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX);					\
 2:	REST_32VSRS(n,c,base);						\
 3:
 
+#define __REST_32FPVSRS_TRANSACT(n,c,base)				\
+BEGIN_FTR_SECTION							\
+	b	2f;							\
+END_FTR_SECTION_IFSET(CPU_FTR_VSX);					\
+	REST_32FPRS_TRANSACT(n,base);					\
+	b	3f;							\
+2:	REST_32VSRS_TRANSACT(n,c,base);					\
+3:
+
 #define __SAVE_32FPVSRS(n,c,base)					\
 BEGIN_FTR_SECTION							\
 	b	2f;							\
@@ -45,9 +54,12 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX);					\
 3:
 #else
 #define __REST_32FPVSRS(n,b,base)	REST_32FPRS(n, base)
+#define __REST_32FPVSRS_TRANSACT(n,b,base)	REST_32FPRS(n, base)
 #define __SAVE_32FPVSRS(n,b,base)	SAVE_32FPRS(n, base)
 #endif
 #define REST_32FPVSRS(n,c,base) __REST_32FPVSRS(n,__REG_##c,__REG_##base)
+#define REST_32FPVSRS_TRANSACT(n,c,base) \
+	__REST_32FPVSRS_TRANSACT(n,__REG_##c,__REG_##base)
 #define SAVE_32FPVSRS(n,c,base) __SAVE_32FPVSRS(n,__REG_##c,__REG_##base)
 
 /*
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index ba48233..6d66a68 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -57,6 +57,16 @@
 #include <linux/kprobes.h>
 #include <linux/kdebug.h>
 
+#ifdef CONFIG_TRANSACTIONAL_MEM
+/* Transactional Memory debug */
+// #define TM_DEBUG_SW
+#ifdef TM_DEBUG_SW
+#define TM_DEBUG(x...) printk(KERN_INFO x)
+#else
+#define TM_DEBUG(x...) do { } while(0)
+#endif
+#endif
+
 extern unsigned long _get_SP(void);
 
 #ifndef CONFIG_SMP
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 3251840..8fed874 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -78,6 +78,16 @@ EXPORT_SYMBOL(__debugger_dabr_match);
 EXPORT_SYMBOL(__debugger_fault_handler);
 #endif
 
+#ifdef CONFIG_TRANSACTIONAL_MEM
+/* Transactional Memory trap debug */
+// #define TM_DEBUG_SW
+#ifdef TM_DEBUG_SW
+#define TM_DEBUG(x...) printk(KERN_INFO x)
+#else
+#define TM_DEBUG(x...) do { } while(0)
+#endif
+#endif
+
 /*
  * Trap & Exception support
  */
@@ -350,6 +360,7 @@ static inline int check_io_access(struct pt_regs *regs)
    exception is in the MSR. */
 #define get_reason(regs)	((regs)->msr)
 #define get_mc_reason(regs)	((regs)->msr)
+#define REASON_TM		0x200000
 #define REASON_FP		0x100000
 #define REASON_ILLEGAL		0x80000
 #define REASON_PRIVILEGED	0x40000
-- 
1.7.9.5
