Return-Path: <paulus@ozlabs.org>
Date: Mon, 2 May 2011 15:46:44 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] powerpc: Save register r9-r13 values accurately on
	interrupt with bad stack
Message-ID: <20110502054643.GA3182@brick.ozlabs.ibm.com>
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

When we take an interrupt or exception from kernel mode and the stack
pointer is obviously not a kernel address (i.e. the top bit is 0), we
switch to an emergency stack, save register values and panic.  However,
on 64-bit server machines, we don't actually save the values of r9 - r13
at the time of the interrupt, but rather values corrupted by the
exception entry code for r12-r13, and nothing at all for r9-r11.

This fixes it by passing a pointer to the register save area in the paca
through to the bad_stack code in r3.  The register values are saved in
one of the paca register save areas (depending on which exception this
is).  Using the pointer in r3, the bad_stack code now retrieves the
saved values of r9 - r13 and stores them in the exception frame on the
emergency stack.  This also stores the normal exception frame marker
("regshere") in the exception frame.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/exception-64s.h |    7 ++++---
 arch/powerpc/kernel/exceptions-64s.S     |   20 +++++++++++++++++---
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index d6b4849..96ccef1 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -104,10 +104,11 @@
 	beq-	1f;							   \
 	ld	r1,PACAKSAVE(r13);	/* kernel stack to use		*/ \
 1:	cmpdi	cr1,r1,0;		/* check if r1 is in userspace	*/ \
-	bge-	cr1,2f;			/* abort if it is		*/ \
-	b	3f;							   \
-2:	li	r1,(n);			/* will be reloaded later	*/ \
+	blt+	cr1,3f;			/* abort if it is		*/ \
+	li	r1,(n);			/* will be reloaded later	*/ \
 	sth	r1,PACA_TRAP_SAVE(r13);					   \
+	std	r3,area+EX_R3(r13);					   \
+	addi	r3,r13,area;		/* r3 -> where regs are saved*/	   \
 	b	bad_stack;						   \
 3:	std	r9,_CCR(r1);		/* save CR in stackframe	*/ \
 	std	r11,_NIP(r1);		/* save SRR0 in stackframe	*/ \
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 226cc8c..27ca8b7 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -461,9 +461,20 @@ bad_stack:
 	std	r12,_XER(r1)
 	SAVE_GPR(0,r1)
 	SAVE_GPR(2,r1)
-	SAVE_4GPRS(3,r1)
-	SAVE_2GPRS(7,r1)
-	SAVE_10GPRS(12,r1)
+	ld	r10,EX_R3(r3)
+	std	r10,GPR3(r1)
+	SAVE_GPR(4,r1)
+	SAVE_4GPRS(5,r1)
+	ld	r9,EX_R9(r3)
+	ld	r10,EX_R10(r3)
+	SAVE_2GPRS(9,r1)
+	ld	r9,EX_R11(r3)
+	ld	r10,EX_R12(r3)
+	ld	r11,EX_R13(r3)
+	std	r9,GPR11(r1)
+	std	r10,GPR12(r1)
+	std	r11,GPR13(r1)
+	SAVE_8GPRS(14,r1)
 	SAVE_10GPRS(22,r1)
 	lhz	r12,PACA_TRAP_SAVE(r13)
 	std	r12,_TRAP(r1)
@@ -472,6 +483,9 @@ bad_stack:
 	li	r12,0
 	std	r12,0(r11)
 	ld	r2,PACATOC(r13)
+	ld	r11,exception_marker@toc(r2)
+	std	r12,RESULT(r1)
+	std	r11,STACK_FRAME_OVERHEAD-16(r1)
 1:	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	.kernel_bad_stack
 	b	1b
-- 
1.7.4.1
