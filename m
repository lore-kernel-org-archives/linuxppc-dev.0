Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A278A1A068E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Jul 2014 15:52:57 +1000 (EST)
Date: Thu, 3 Jul 2014 15:52:56 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Subject: [PATCH 2/2] powerpc/pseries: optimise hcall tracepoints
Message-ID: <20140703155256.119067c9@kryten>
In-Reply-To: <20140703155203.33af5387@kryten>
References: <20140703155203.33af5387@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that we execute the hcall tracepoint entry and exit code out of
line, we can use the same stack across both functions.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: b/arch/powerpc/platforms/pseries/hvCall.S
===================================================================
--- a/arch/powerpc/platforms/pseries/hvCall.S
+++ b/arch/powerpc/platforms/pseries/hvCall.S
@@ -46,33 +46,27 @@ hcall_tracepoint_refcount:
 	addi	r4,r1,STK_PARAM(FIRST_REG);			\
 	stdu	r1,-STACK_FRAME_OVERHEAD(r1);			\
 	bl	__trace_hcall_entry;				\
-	addi	r1,r1,STACK_FRAME_OVERHEAD;			\
-	ld	r0,16(r1);					\
-	ld	r3,STK_PARAM(R3)(r1);				\
-	ld	r4,STK_PARAM(R4)(r1);				\
-	ld	r5,STK_PARAM(R5)(r1);				\
-	ld	r6,STK_PARAM(R6)(r1);				\
-	ld	r7,STK_PARAM(R7)(r1);				\
-	ld	r8,STK_PARAM(R8)(r1);				\
-	ld	r9,STK_PARAM(R9)(r1);				\
-	ld	r10,STK_PARAM(R10)(r1);				\
-	mtlr	r0
+	ld	r3,STACK_FRAME_OVERHEAD+STK_PARAM(R3)(r1);	\
+	ld	r4,STACK_FRAME_OVERHEAD+STK_PARAM(R4)(r1);	\
+	ld	r5,STACK_FRAME_OVERHEAD+STK_PARAM(R5)(r1);	\
+	ld	r6,STACK_FRAME_OVERHEAD+STK_PARAM(R6)(r1);	\
+	ld	r7,STACK_FRAME_OVERHEAD+STK_PARAM(R7)(r1);	\
+	ld	r8,STACK_FRAME_OVERHEAD+STK_PARAM(R8)(r1);	\
+	ld	r9,STACK_FRAME_OVERHEAD+STK_PARAM(R9)(r1);	\
+	ld	r10,STACK_FRAME_OVERHEAD+STK_PARAM(R10)(r1)
 
 /*
  * postcall is performed immediately before function return which
  * allows liberal use of volatile registers.
  */
 #define __HCALL_INST_POSTCALL					\
-	mflr	r0;						\
-	ld	r6,STK_PARAM(R3)(r1);				\
-	std	r3,STK_PARAM(R3)(r1);				\
+	ld	r0,STACK_FRAME_OVERHEAD+STK_PARAM(R3)(r1);	\
+	std	r3,STACK_FRAME_OVERHEAD+STK_PARAM(R3)(r1);	\
 	mr	r4,r3;						\
-	mr	r3,r6;						\
-	std	r0,16(r1);					\
-	stdu	r1,-STACK_FRAME_OVERHEAD(r1);			\
+	mr	r3,r0;						\
 	bl	__trace_hcall_exit;				\
+	ld	r0,STACK_FRAME_OVERHEAD+16(r1);			\
 	addi	r1,r1,STACK_FRAME_OVERHEAD;			\
-	ld	r0,16(r1);					\
 	ld	r3,STK_PARAM(R3)(r1);				\
 	mtlr	r0
 
@@ -279,14 +273,14 @@ plpar_hcall9_trace:
 	mr	r7,r8
 	mr	r8,r9
 	mr	r9,r10
-	ld	r10,STK_PARAM(R11)(r1)
-	ld	r11,STK_PARAM(R12)(r1)
-	ld	r12,STK_PARAM(R13)(r1)
+	ld	r10,STACK_FRAME_OVERHEAD+STK_PARAM(R11)(r1)
+	ld	r11,STACK_FRAME_OVERHEAD+STK_PARAM(R12)(r1)
+	ld	r12,STACK_FRAME_OVERHEAD+STK_PARAM(R13)(r1)
 
 	HVSC
 
 	mr	r0,r12
-	ld	r12,STK_PARAM(R4)(r1)
+	ld	r12,STACK_FRAME_OVERHEAD+STK_PARAM(R4)(r1)
 	std	r4,0(r12)
 	std	r5,8(r12)
 	std	r6,16(r12)
