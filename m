Return-Path: <paulus@ozlabs.org>
Resent-Message-ID: <20110502090524.GA2706@brick.ozlabs.ibm.com>
Date: Mon, 2 May 2011 15:48:20 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] powerpc: Save Come-From Address Register (CFAR) in
	exception frame
Message-ID: <20110502054820.GB3182@brick.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Recent 64-bit server processors (POWER6 and POWER7) have a "Come-From
Address Register" (CFAR), that records the address of the most recent
branch or rfid (return from interrupt) instruction for debugging purposes.

This saves the value of the CFAR in the exception entry code and stores
it in the exception frame.  We also make xmon print the CFAR value in
its register dump code.

Rather than extend the pt_regs struct at this time, we steal the orig_gpr3
field, which is only used for system calls, and use it for the CFAR value
for all exceptions/interrupts other than system calls.  This means we
don't save the CFAR on system calls, which is not a great problem since
system calls tend not to happen unexpectedly, and also avoids adding the
overhead of reading the CFAR to the system call entry path.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/cputable.h      |    6 ++++--
 arch/powerpc/include/asm/exception-64s.h |    9 +++++++++
 arch/powerpc/include/asm/paca.h          |    6 +++---
 arch/powerpc/include/asm/reg.h           |    1 +
 arch/powerpc/kernel/exceptions-64s.S     |    4 ++++
 arch/powerpc/xmon/xmon.c                 |    4 ++++
 6 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 3db2476..b0069ed 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -197,6 +197,7 @@ extern const char *powerpc_base_platform;
 #define CPU_FTR_STCX_CHECKS_ADDRESS	LONG_ASM_CONST(0x0200000000000000)
 #define CPU_FTR_POPCNTB			LONG_ASM_CONST(0x0400000000000000)
 #define CPU_FTR_POPCNTD			LONG_ASM_CONST(0x0800000000000000)
+#define CPU_FTR_CFAR			LONG_ASM_CONST(0x1000000000000000)
 
 #ifndef __ASSEMBLY__
 
@@ -411,14 +412,15 @@ extern const char *powerpc_base_platform;
 	    CPU_FTR_COHERENT_ICACHE | \
 	    CPU_FTR_PURR | CPU_FTR_SPURR | CPU_FTR_REAL_LE | \
 	    CPU_FTR_DSCR | CPU_FTR_UNALIGNED_LD_STD | \
-	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_POPCNTB)
+	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_POPCNTB | CPU_FTR_CFAR)
 #define CPU_FTRS_POWER7 (CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | CPU_FTR_HVMODE_206 |\
 	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
 	    CPU_FTR_COHERENT_ICACHE | \
 	    CPU_FTR_PURR | CPU_FTR_SPURR | CPU_FTR_REAL_LE | \
 	    CPU_FTR_DSCR | CPU_FTR_SAO  | CPU_FTR_ASYM_SMT | \
-	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_POPCNTB | CPU_FTR_POPCNTD)
+	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_POPCNTB | CPU_FTR_POPCNTD |\
+	    CPU_FTR_CFAR)
 #define CPU_FTRS_CELL	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 96ccef1..f5dfe34 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -46,6 +46,7 @@
 #define EX_CCR		60
 #define EX_R3		64
 #define EX_LR		72
+#define EX_CFAR		80
 
 /*
  * We're short on space and time in the exception prolog, so we can't
@@ -66,6 +67,10 @@
 	std	r10,area+EX_R10(r13);					\
 	std	r11,area+EX_R11(r13);					\
 	std	r12,area+EX_R12(r13);					\
+	BEGIN_FTR_SECTION_NESTED(66);					\
+	mfspr	r10,SPRN_CFAR;						\
+	std	r10,area+EX_CFAR(r13);					\
+	END_FTR_SECTION_NESTED(CPU_FTR_CFAR, CPU_FTR_CFAR, 66);		\
 	GET_SCRATCH0(r9);						\
 	std	r9,area+EX_R13(r13);					\
 	mfcr	r9
@@ -130,6 +135,10 @@
 	std	r9,GPR11(r1);						   \
 	std	r10,GPR12(r1);						   \
 	std	r11,GPR13(r1);						   \
+	BEGIN_FTR_SECTION_NESTED(66);					   \
+	ld	r10,area+EX_CFAR(r13);					   \
+	std	r10,ORIG_GPR3(r1);					   \
+	END_FTR_SECTION_NESTED(CPU_FTR_CFAR, CPU_FTR_CFAR, 66);		   \
 	ld	r2,PACATOC(r13);	/* get kernel TOC into r2	*/ \
 	mflr	r9;			/* save LR in stackframe	*/ \
 	std	r9,_LINK(r1);						   \
diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 65c13c4..7412676 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -92,9 +92,9 @@ struct paca_struct {
 	 * Now, starting in cacheline 2, the exception save areas
 	 */
 	/* used for most interrupts/exceptions */
-	u64 exgen[10] __attribute__((aligned(0x80)));
-	u64 exmc[10];		/* used for machine checks */
-	u64 exslb[10];		/* used for SLB/segment table misses
+	u64 exgen[11] __attribute__((aligned(0x80)));
+	u64 exmc[11];		/* used for machine checks */
+	u64 exslb[11];		/* used for SLB/segment table misses
  				 * on the linear mapping */
 	/* SLB related definitions */
 	u16 vmalloc_sllp;
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 1f9ac12..47e3416 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -188,6 +188,7 @@
 
 #define SPRN_CTR	0x009	/* Count Register */
 #define SPRN_DSCR	0x11
+#define SPRN_CFAR	0x1c	/* Come From Address Register */
 #define SPRN_CTRLF	0x088
 #define SPRN_CTRLT	0x098
 #define   CTRL_CT	0xc0000000	/* current thread */
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 27ca8b7..0ec3b42 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -474,6 +474,10 @@ bad_stack:
 	std	r9,GPR11(r1)
 	std	r10,GPR12(r1)
 	std	r11,GPR13(r1)
+BEGIN_FTR_SECTION
+	ld	r10,EX_CFAR(r3)
+	std	r10,ORIG_GPR3(r1)
+END_FTR_SECTION_IFSET(CPU_FTR_CFAR)
 	SAVE_8GPRS(14,r1)
 	SAVE_10GPRS(22,r1)
 	lhz	r12,PACA_TRAP_SAVE(r13)
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 60593ad..909804a 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -1497,6 +1497,10 @@ static void prregs(struct pt_regs *fp)
 #endif
 	printf("pc  = ");
 	xmon_print_symbol(fp->nip, " ", "\n");
+	if (TRAP(fp) != 0xc00 && cpu_has_feature(CPU_FTR_CFAR)) {
+		printf("cfar= ");
+		xmon_print_symbol(fp->orig_gpr3, " ", "\n");
+	}
 	printf("lr  = ");
 	xmon_print_symbol(fp->link, " ", "\n");
 	printf("msr = "REG"   cr  = %.8lx\n", fp->msr, fp->ccr);
-- 
1.7.4.1
