Return-Path: <Jan.Schneider@honeywell.com>
Received: from az18nt141.honeywell.com (az18nt141.honeywell.com [199.64.7.141])
	by ozlabs.org (Postfix) with ESMTP id F0A2767A80
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Jan 2005 21:34:25 +1100 (EST)
Message-ID: <938F1554888BD71194E100B0D0FCD97201AAD807@ge51smail2.ge51.honeywell.de>
From: "Schneider, Jan (GE51)" <Jan.Schneider@honeywell.com>
To: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Date: Thu, 27 Jan 2005 02:48:03 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: [PATCH] Debug Register MPC855
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

I have made som changes on kernel 2.4.18 to get access to the Debug
Registers on a MPC855.
Please apply and let me know whether the kernel runs stable or not.
I need this support for the gdb to set Hardware Breakpoints on a MPC855
target.

Thank you


--- /linux/arch/ppc/kernel/entry.S.orig	2005-01-25 14:20:17.269216024 +0100
+++ /linux/arch/ppc/kernel/entry.S	2005-01-25 14:27:22.440580152 +0100
@@ -294,6 +294,27 @@
 	stw	r20,_CCR(r1)
 	stw	r22,_CTR(r1)
 	stw	r23,_XER(r1)
+	
+	mfspr	r23,CMPA
+	stw	r23,_CMPA(r1)
+	mfspr	r23,CMPB
+	stw	r23,_CMPB(r1)
+	mfspr	r23,CMPC
+	stw	r23,_CMPC(r1)
+	mfspr	r23,CMPD
+	stw	r23,_CMPD(r1)
+	mfspr	r23,CMPE
+	stw	r23,_CMPE(r1)
+	mfspr	r23,CMPF
+	stw	r23,_CMPF(r1)
+	mfspr	r23,CMPG
+	stw	r23,_CMPG(r1)
+	mfspr	r23,CMPH
+	stw	r23,_CMPH(r1)
+		
+	mfspr	r23,ICTRL
+	stw	r23,_ICTRL(r1)
+	
 	li	r0,0x0ff0
 	stw	r0,TRAP(r1)
 	stw	r1,KSP(r3)	/* Set old stack pointer */
@@ -419,6 +440,27 @@
 restore:
 	lwz	r3,_XER(r1)
 	mtspr	XER,r3
+	
+	lwz	r3,_CMPA(r1)
+	mtspr	CMPA,r3
+	lwz	r3,_CMPB(r1)
+	mtspr	CMPB,r3
+	lwz	r3,_CMPC(r1)
+	mtspr	CMPC,r3
+	lwz	r3,_CMPD(r1)
+	mtspr	CMPD,r3
+	lwz	r3,_CMPE(r1)
+	mtspr	CMPE,r3
+	lwz	r3,_CMPF(r1)
+	mtspr	CMPF,r3
+	lwz	r3,_CMPG(r1)
+	mtspr	CMPG,r3
+	lwz	r3,_CMPH(r1)
+	mtspr	CMPH,r3
+	
+	lwz	r3,_ICTRL(r1)
+	mtspr	ICTRL,r3
+	
 	REST_10GPRS(9,r1)
 	REST_10GPRS(19,r1)
 	REST_2GPRS(29,r1)


--- /linux/arch/ppc/kernel/head_8xx.S.orig	2005-01-25
14:22:39.591579736 +0100
+++ /linux/arch/ppc/kernel/head_8xx.S	2005-01-25 14:27:43.950310176 +0100
@@ -136,6 +136,24 @@
 	stw	r22,_CTR(r21);	\
 	mfspr	r20,XER;	\
 	stw	r20,_XER(r21);	\
+	mfspr	r20,CMPA;	\
+	stw	r20,_CMPA(r21);	\
+	mfspr	r20,CMPB;	\
+	stw	r20,_CMPB(r21);	\
+	mfspr	r20,CMPC;	\
+	stw	r20,_CMPC(r21);	\
+	mfspr	r20,CMPD;	\
+	stw	r20,_CMPD(r21);	\
+	mfspr	r20,CMPE;	\
+	stw	r20,_CMPE(r21);	\
+	mfspr	r20,CMPF;	\
+	stw	r20,_CMPF(r21);	\
+	mfspr	r20,CMPG;	\
+	stw	r20,_CMPG(r21);	\
+	mfspr	r20,CMPH;	\
+	stw	r20,_CMPH(r21);	\
+	mfspr	r20,ICTRL;	\
+	stw	r20,_ICTRL(r21);\
 	mfspr	r22,SRR0;	\
 	mfspr	r23,SRR1;	\
 	stw	r0,GPR0(r21);	\
@@ -630,7 +648,7 @@
  * using them.
  */
 	STD_EXCEPTION(0x1c00, Trap_1c, UnknownException)
-	STD_EXCEPTION(0x1d00, Trap_1d, UnknownException)
+	STD_EXCEPTION(0x1d00, Trap_1d, InstructionBreakpoint)
 	STD_EXCEPTION(0x1e00, Trap_1e, UnknownException)
 	STD_EXCEPTION(0x1f00, Trap_1f, UnknownException)


--- /linux/arch/ppc/kernel/mk_defs.c.orig	2005-01-25
14:23:12.434586840 +0100
+++ /linux/arch/ppc/kernel/mk_defs.c	2005-01-25 14:28:11.315150088 +0100
@@ -116,6 +116,20 @@
 	DEFINE(_LINK, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, link));
 	DEFINE(_CCR, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, ccr));
 	DEFINE(_MQ, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, mq));
+	
+	DEFINE(_CMPA, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, cmpa));

+	DEFINE(_CMPB, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, cmpb));

+	DEFINE(_CMPC, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, cmpc));

+	DEFINE(_CMPD, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, cmpd));

+	DEFINE(_DER, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, der));

+	DEFINE(_CMPE, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, cmpe));

+	DEFINE(_CMPF, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, cmpf));

+	DEFINE(_CMPG, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, cmpg));

+	DEFINE(_CMPH, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, cmph));

+	DEFINE(_LCTRL1, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs,
lctrl1));	
+	DEFINE(_LCTRL2, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs,
lctrl2));	
+	DEFINE(_ICTRL, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs,
ictrl));	
+		
 	DEFINE(_XER, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, xer));
 	DEFINE(_DAR, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, dar));
 	DEFINE(_DSISR, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs,
dsisr));

--- /linux/arch/ppc/kernel/process.c.orig	2005-01-25
14:23:45.410573728 +0100
+++ /linux/arch/ppc/kernel/process.c	2005-01-25 14:28:33.340801680 +0100
@@ -191,6 +191,8 @@
 	return 1;
 }
 
+
+
 void
 _switch_to(struct task_struct *prev, struct task_struct *new,
 	  struct task_struct **last)
@@ -253,13 +255,13 @@
 
 	printk("NIP: %08lX XER: %08lX LR: %08lX SP: %08lX REGS: %p TRAP:
%04lx    %s\n",
 	       regs->nip, regs->xer, regs->link, regs->gpr[1],
regs,regs->trap, print_tainted());
-	printk("MSR: %08lx EE: %01x PR: %01x FP: %01x ME: %01x IR/DR:
%01x%01x\n",
-	       regs->msr, regs->msr&MSR_EE ? 1 : 0, regs->msr&MSR_PR ? 1 :
0,
+	printk("CMPA: %08lX ICTRL: %08lX MSR: %08lx EE: %01x PR: %01x FP:
%01x ME: %01x IR/DR: %01x%01x\n",
+	       regs->cmpa, regs->ictrl, regs->msr, regs->msr&MSR_EE ? 1 : 0,
regs->msr&MSR_PR ? 1 : 0,
 	       regs->msr & MSR_FP ? 1 : 0,regs->msr&MSR_ME ? 1 : 0,
 	       regs->msr&MSR_IR ? 1 : 0,
 	       regs->msr&MSR_DR ? 1 : 0);
 	if (regs->trap == 0x300 || regs->trap == 0x600)
-		printk("DAR: %08lX, DSISR: %08lX\n", regs->dar,
regs->dsisr);
+		printk("DAR: %08lX, DSISR: %08lX DER: %08lX\n", regs->dar,
regs->dsisr, regs->der);
 	printk("TASK = %p[%d] '%s' ",
 	       current, current->pid, current->comm);
 	printk("Last syscall: %ld ", current->thread.last_syscall);


--- /linux/arch/ppc/kernel/ptrace.c.orig	2005-01-25
14:24:08.171113600 +0100
+++ /linux/arch/ppc/kernel/ptrace.c	2005-01-25 14:28:47.701618504 +0100
@@ -33,6 +33,7 @@
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/system.h>
+#include <asm/processor.h>
 
 /*
  * Set of msr bits that gdb can change on behalf of a process.
@@ -65,7 +66,7 @@
 static inline int put_reg(struct task_struct *task, int regno,
 			  unsigned long data)
 {
-	if (regno <= PT_MQ && task->thread.regs != NULL) {
+	if (regno <= PT_ICTRL && task->thread.regs != NULL) {
 		if (regno == PT_MSR)
 			data = (data & MSR_DEBUGCHANGE)
 				| (task->thread.regs->msr &
~MSR_DEBUGCHANGE);
@@ -233,7 +234,7 @@
 		index = (unsigned long) addr >> 2;
 		if ((addr & 3) || index > PT_FPSCR)
 			break;
-
+			
 		if (index < PT_FPR0) {
 			tmp = get_reg(child, (int) index);
 		} else {
@@ -383,4 +384,4 @@
 		send_sig(current->exit_code, current, 1);
 		current->exit_code = 0;
 	}
-}
+}


--- /linux/include/asm-ppc/processor.h.orig	2005-01-25
14:56:33.629358992 +0100
+++ /linux/include/asm-ppc/processor.h	2005-01-25 14:59:33.511012824 +0100
@@ -89,6 +89,18 @@
 
 #define	SPRN_CCR0	0x3B3	/* Core Configuration Register (4xx)
*/
 #define	SPRN_CDBCR	0x3D7	/* Cache Debug Control Register */
+
+#define SPRN_CMPA	0x90	/* Development Support Register Comparator A
*/
+#define SPRN_CMPB	0x91	/* Development Support Register Comparator B
*/
+#define SPRN_CMPC	0x92	/* Development Support Register Comparator C
*/
+#define SPRN_CMPD	0x93	/* Development Support Register Comparator D
*/
+#define SPRN_CMPE	0x98	/* Development Support Register Comparator E
*/
+#define SPRN_CMPF	0x99	/* Development Support Register Comparator F
*/
+#define SPRN_CMPG	0x9A	/* Development Support Register Comparator G
*/
+#define SPRN_CMPH	0x9B	/* Development Support Register Comparator H
*/
+#define SPRN_COUNTA	0x96	/* Development Support Register CounterA */
+#define SPRN_COUNTB	0x97	/* Development Support Register CounterB */
+
 #define	SPRN_CTR	0x009	/* Count Register */
 #define	SPRN_DABR	0x3F5	/* Data Address Breakpoint Register
*/
 #define	SPRN_DAC1	0x3F6	/* Data Address Compare 1 */
@@ -272,6 +284,7 @@
 #define   ICTRL_EICE		0x08000000	/* enable icache parity errs
*/
 #define   ICTRL_EDCE		0x04000000	/* enable dcache parity errs
*/
 #define   ICTRL_EICP		0x00000100	/* enable icache par. check
*/
+#define SPRN_ICTRL2	0x9E	/* Development Support Instruction Support
Control Register */
 #define	SPRN_IMISS	0x3D4	/* Instruction TLB Miss Register */
 #define	SPRN_IMMR	0x27E  	/* Internal Memory Map Register */
 #define	SPRN_L2CR	0x3F9	/* Level 2 Cache Control Regsiter */
@@ -307,6 +320,8 @@
 #define SPRN_L2CR2      0x3f8
 #define	SPRN_L3CR	0x3FA	/* Level 3 Cache Control Regsiter
(7450) */
 #define L3CR_L3E		0x80000000	/* L3 enable */
+#define SPRN_LCTRL1	0x9C	/* Development Support Load/Store Support
Comparators Control Register */
+#define SPRN_LCTRL2	0x9D	/* Development Support Load/Store Support
AND-OR Control Register */
 #define SPRN_MSSCR0	0x3f6	/* Memory Subsystem Control Register 0 */
 #define SPRN_MSSSR0	0x3f7	/* Memory Subsystem Status Register 1 */
 #define SPRN_LDSTCR	0x3f8	/* Load/Store control register */
@@ -415,6 +430,16 @@
 /* Short-hand versions for a number of the above SPRNs */
 
 #define	CTR	SPRN_CTR	/* Counter Register */
+#define CMPA	SPRN_CMPA
+#define CMPB	SPRN_CMPB	/* Development Support Register Comparator B
*/
+#define CMPC	SPRN_CMPC	/* Development Support Register Comparator C
*/
+#define CMPD	SPRN_CMPD	/* Development Support Register Comparator D
*/
+#define CMPE	SPRN_CMPE	/* Development Support Register Comparator E
*/
+#define CMPF	SPRN_CMPF	/* Development Support Register Comparator F
*/
+#define CMPG	SPRN_CMPG	/* Development Support Register Comparator G
*/
+#define CMPH	SPRN_CMPH	/* Development Support Register Comparator H
*/
+#define COUNTA	SPRN_COUNTA	/* Development Support Register CounterA */
+#define COUNTB	SPRN_COUNTB	/* Development Support Register CounterB */
 #define	DAR	SPRN_DAR	/* Data Address Register */
 #define	DABR	SPRN_DABR	/* Data Address Breakpoint Register
*/
 #define	DBAT0L	SPRN_DBAT0L	/* Data BAT 0 Lower Register */
@@ -444,10 +469,13 @@
 #define	IBAT3L	SPRN_IBAT3L	/* Instruction BAT 3 Lower Register
*/
 #define	IBAT3U	SPRN_IBAT3U	/* Instruction BAT 3 Upper Register
*/
 #define	ICMP	SPRN_ICMP	/* Instruction TLB Compare Register
*/
+#define ICTRL	SPRN_ICTRL2	/* Development Support Instruction Support
Control Register */
 #define	IMISS	SPRN_IMISS	/* Instruction TLB Miss Register */
 #define	IMMR	SPRN_IMMR      	/* PPC 860/821 Internal Memory Map
Register */
 #define	L2CR	SPRN_L2CR    	/* PPC 750 L2 control register */
 #define	L3CR	SPRN_L3CR    	/* PPC 7450 L3 Cache control
register */
+#define LCTRL1	SPRN_LCTRL1	/* Development Support Load/Store Support
Comparators Control Register */
+#define LCTRL2	SPRN_LCTRL2	/* Development Support Load/Store Support
AND-OR Control Register */
 #define	LR	SPRN_LR
 #define	PVR	SPRN_PVR	/* Processor Version */
 #define	RPA	SPRN_RPA	/* Required Physical Address
Register */


--- /linux/include/asm-ppc/ptrace.h.orig	2005-01-25
14:57:10.183801872 +0100
+++ /linux/include/asm-ppc/ptrace.h	2005-01-25 14:59:49.425593440 +0100
@@ -32,6 +32,18 @@
 	unsigned long ccr;
 	unsigned long mq;		/* 601 only (not used at present) */
 					/* Used on APUS to hold IPL value.
*/
+	unsigned long cmpa;
+	unsigned long cmpb;
+	unsigned long cmpc;
+	unsigned long cmpd;
+	unsigned long der;
+	unsigned long cmpe;
+	unsigned long cmpf;
+	unsigned long cmpg;
+	unsigned long cmph;
+	unsigned long lctrl1;
+	unsigned long lctrl2;
+	unsigned long ictrl;
 	unsigned long trap;		/* Reason for being here */
 	unsigned long dar;		/* Fault registers */
 	unsigned long dsisr;
@@ -109,10 +121,24 @@
 #define PT_CCR	38
 #define PT_MQ	39
 
-#define PT_FPR0	48	/* each FP reg occupies 2 slots in this
space */
+#define PT_CMPA 40
+#define PT_CMPB 41
+#define PT_CMPC 42
+#define PT_CMPD 43
+#define PT_DER	44
+#define PT_CMPE 45
+#define PT_CMPF 46
+#define PT_CMPG 47
+#define PT_CMPH 48
+#define PT_LCTRL1 49
+#define PT_LCTRL2 50
+#define PT_ICTRL 51
+
+#define PT_FPR0	60	/* each FP reg occupies 2 slots in this
space */
 #define PT_FPR31 (PT_FPR0 + 2*31)
 #define PT_FPSCR (PT_FPR0 + 2*32 + 1)
 
+
 /* Get/set all the altivec registers vr0..vr31, vscr, vrsave, in one go */
 #define PTRACE_GETVRREGS	18
 #define PTRACE_SETVRREGS	19
