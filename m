Date: Fri, 10 Dec 1999 12:22:56 -0600
From: Grant Erickson <grant@lcse.umn.edu>
To: linuxppc-dev@lists.linuxppc.org, linuxppc-embedded@lists.linuxppc.org
cc: Cort Dougan <cort@ppc.kernel.org>
Subject: [PATCH] R7 Save in Exception Handlers
Message-ID: <Pine.SGI.4.10.9912101204350.164510-100000@brule.borg.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In an effort to accomodate saving the critical vs. non-critical exception
state for transfer_to_handler in head_4xx.S I'd previously used r0. This
had the unfortunate side-effect of squishing the syscall number for things
like kthread_init.

Instead, I've found that r7 seems to be a reasonable alternative. However,
in order to do this, r7 needs to be saved before transfer_to_handler
rather than in it.

In an effort to keep the 4xx, 8xx, and other ports in sync, please
consider the following patch against 2.3.31:

--- linux-2.3.31/arch/ppc/kernel/head.S	Thu Dec  2 14:37:34 1999
+++ linux/arch/ppc/kernel/head.S	Fri Dec 10 10:00:13 1999
@@ -287,7 +287,8 @@
 	stw	r2,GPR2(r21);	\
 	stw	r1,0(r21);	\
 	tovirt(r1,r21);			/* set new kernel sp */	\
-	SAVE_4GPRS(3, r21);
+	SAVE_4GPRS(3, r21);	\
+	SAVE_GPR(7, r21);
 /*
  * Note: code which follows this uses cr0.eq (set if from kernel),
  * r21, r22 (SRR0), and r23 (SRR1).
@@ -674,7 +675,6 @@
 transfer_to_handler:
 	stw	r22,_NIP(r21)
 	stw	r23,_MSR(r21)
-	SAVE_GPR(7, r21)
 	SAVE_4GPRS(8, r21)
 	SAVE_8GPRS(12, r21)
 	SAVE_8GPRS(24, r21)
--- linux-2.3.31/arch/ppc/kernel/head_8xx.S	Thu Oct  7 10:17:08 1999
+++ linux/arch/ppc/kernel/head_8xx.S	Fri Dec 10 10:00:49 1999
@@ -197,7 +197,8 @@
 	stw	r2,GPR2(r21);	\
 	stw	r1,0(r21);	\
 	tovirt(r1,r21);			/* set new kernel sp */	\
-	SAVE_4GPRS(3, r21);
+	SAVE_4GPRS(3, r21);	\
+	SAVE_GPR(7, r21);
 /*
  * Note: code which follows this uses cr0.eq (set if from kernel),
  * r21, r22 (SRR0), and r23 (SRR1).
@@ -591,7 +592,6 @@
 	lis	r22,MSR_POW@h
 	andc	r23,r23,r22
 	stw	r23,_MSR(r21)
-	SAVE_GPR(7, r21)
 	SAVE_4GPRS(8, r21)
 	SAVE_8GPRS(12, r21)
 	SAVE_8GPRS(24, r21)
--- linux-2.3.31/arch/ppc/kernel/head_4xx.S	Sat Nov 27 15:41:59 1999
+++ linux/arch/ppc/kernel/head_4xx.S	Fri Dec 10 10:13:13 1999
@@ -129,7 +129,8 @@
 	stw	r2,GPR2(r21);		/* Save r2 on the stack		   */\
 	stw	r1,0(r21);						     \
 	tovirt(r1,r21);			/* Set-up new kernel stack pointer */\
-	SAVE_4GPRS(3, r21);		/* Save r3 through r6 on the stack */
+	SAVE_4GPRS(3, r21);		/* Save r3 through r6 on the stack */\
+	SAVE_GPR(7, r21);		/* Save r7 on the stack		   */
 
 	## Common exception code for standard (non-critical) exceptions.
 
@@ -166,7 +167,7 @@
 	START_EXCEPTION(n, label);					     \
 	STND_EXCEPTION_PROLOG;						     \
 	addi	r3,r1,STACK_FRAME_OVERHEAD;				     \
-	li	r0,STND_EXC;						     \
+	li	r7,STND_EXC;						     \
 	li	r20,MSR_KERNEL;						     \
 	FINISH_EXCEPTION(func)
 
@@ -175,7 +176,7 @@
 	START_EXCEPTION(n, label);					     \
 	CRIT_EXCEPTION_PROLOG;						     \
 	addi	r3,r1,STACK_FRAME_OVERHEAD;				     \
-	li	r0,CRIT_EXC;						     \
+	li	r7,CRIT_EXC;						     \
 	li	r20,MSR_KERNEL;						     \
 	FINISH_EXCEPTION(func)
 
@@ -184,7 +185,7 @@
 	START_EXCEPTION(n, label);					     \
 	STND_EXCEPTION_PROLOG;						     \
 	addi	r3,r1,STACK_FRAME_OVERHEAD;				     \
-	li	r0,STND_EXC;						     \
+	li	r7,STND_EXC;						     \
 	li	r20,MSR_KERNEL;						     \
 	li	r4,0;							     \
 	bl	transfer_to_handler;					     \
@@ -214,7 +215,7 @@
 	mfspr	r4,SPRN_DEAR		# Grab the DEAR, save it, pass as arg2
 	stw	r4,_DEAR(r21)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
-	li	r0,STND_EXC		# This is a standard exception
+	li	r7,STND_EXC		# This is a standard exception
 	li	r20,MSR_KERNEL
 	rlwimi	r20,r23,0,16,16		# Copy EE bit from the saved MSR
 	FINISH_EXCEPTION(do_page_fault)	# do_page_fault(regs, ESR, DEAR)
@@ -226,7 +227,7 @@
 	mr	r4,r22			# Pass SRR0 as arg2
 	mr	r5,r23			# Pass SRR1 as arg3
 	addi	r3,r1,STACK_FRAME_OVERHEAD
-	li	r0,STND_EXC		# This is a standard exception
+	li	r7,STND_EXC		# This is a standard exception
 	li	r20,MSR_KERNEL
 	rlwimi	r20,r23,0,16,16		# Copy EE bit from the saved MSR
 	FINISH_EXCEPTION(do_page_fault)	# do_page_fault(regs, SRR0, SRR1)
@@ -242,7 +243,7 @@
 	mfspr	r4,SPRN_DEAR		# Grab the DEAR and save it
 	stw	r4,_DEAR(r21)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
-	li	r0,STND_EXC		# This is a standard exception
+	li	r7,STND_EXC		# This is a standard exception
 	li	r20,MSR_KERNEL
 	rlwimi	r20,r23,0,16,16		# Copy EE bit from the saved MSR
 	FINISH_EXCEPTION(AlignmentException)
@@ -252,7 +253,7 @@
 	START_EXCEPTION(0x0700,	ProgramCheck)
 	STND_EXCEPTION_PROLOG
 	addi	r3,r1,STACK_FRAME_OVERHEAD
-	li	r0,STND_EXC		# This is a standard exception
+	li	r7,STND_EXC		# This is a standard exception
 	li	r20,MSR_KERNEL
 	rlwimi	r20,r23,0,16,16		# Copy EE bit from the saved MSR
 	FINISH_EXCEPTION(ProgramCheckException)
@@ -266,7 +267,7 @@
 	START_EXCEPTION(0x0C00,	SystemCall)
 	STND_EXCEPTION_PROLOG
 	stw	r3,ORIG_GPR3(r21)
-	li	r0,STND_EXC		# This is a standard exception
+	li	r7,STND_EXC		# This is a standard exception
 	li	r20,MSR_KERNEL
 	rlwimi	r20,r23,0,16,16		# Copy EE bit from the saved MSR
 	FINISH_EXCEPTION(DoSyscall)
@@ -294,7 +295,7 @@
 	START_EXCEPTION(0x1100,	DTLBMiss)
 	STND_EXCEPTION_PROLOG
 	addi	r3,r1,STACK_FRAME_OVERHEAD
-	li	r0,STND_EXC
+	li	r7,STND_EXC
 	li	r20,MSR_KERNEL
 	FINISH_EXCEPTION(UnknownException)
 
@@ -303,7 +304,7 @@
 	START_EXCEPTION(0x1200,	ITLBMiss)
 	STND_EXCEPTION_PROLOG
 	addi	r3,r1,STACK_FRAME_OVERHEAD
-	li	r0,STND_EXC
+	li	r7,STND_EXC
 	li	r20,MSR_KERNEL
 	FINISH_EXCEPTION(UnknownException)	
 
@@ -341,7 +342,6 @@
 _GLOBAL(transfer_to_handler)
 	stw	r22,_NIP(r21)		# Save the faulting IP on the stack
 	stw	r23,_MSR(r21)		# Save the exception MSR on the stack
-	SAVE_GPR(7, r21)		# Save r7 on the stack
 	SAVE_4GPRS(8, r21)		# Save r8 through r11 on the stack
 	SAVE_8GPRS(12, r21)		# Save r12 through r19 on the stack
 	SAVE_8GPRS(24, r21)		# Save r24 through r31 on the stack
@@ -367,7 +367,7 @@
 	bgt-	stack_ovf		# If r2 < r1 < r2 + TASK_STRUCT_SIZE
 	lwz	r24,0(r23)		# Virtual address of the handler
 	lwz	r23,4(r23)		# Handler return pointer
-	cmpwi	cr0,r0,STND_EXC		# What type of exception is this?
+	cmpwi	cr0,r7,STND_EXC		# What type of exception is this?
 	bne	3f			# It is a critical exception...
 
 	## Standard exception jump path


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
