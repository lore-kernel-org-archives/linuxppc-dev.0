Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 690FD1A0B92
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 21:15:44 +1000 (EST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/3] powerpc: Update comments in irqflags.h
Date: Tue, 15 Jul 2014 21:15:36 +1000
Message-Id: <1405422938-27608-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The comment on TRACE_ENABLE_INTS is incorrect, and appears to have
always been incorrect since the code was merged. It probably came from
an original out-of-tree patch.

Replace it with something that's correct. Also propagate the message to
RECONCILE_IRQ_STATE(), because it's potentially subtle.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/irqflags.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/irqflags.h b/arch/powerpc/include/asm/irqflags.h
index e20eb95429a8..f2149066fe5d 100644
--- a/arch/powerpc/include/asm/irqflags.h
+++ b/arch/powerpc/include/asm/irqflags.h
@@ -32,9 +32,8 @@
 #endif
 
 /*
- * Most of the CPU's IRQ-state tracing is done from assembly code; we
- * have to call a C function so call a wrapper that saves all the
- * C-clobbered registers.
+ * These are calls to C code, so the caller must be prepared for volatiles to
+ * be clobbered.
  */
 #define TRACE_ENABLE_INTS	TRACE_WITH_FRAME_BUFFER(trace_hardirqs_on)
 #define TRACE_DISABLE_INTS	TRACE_WITH_FRAME_BUFFER(trace_hardirqs_off)
@@ -42,6 +41,9 @@
 /*
  * This is used by assembly code to soft-disable interrupts first and
  * reconcile irq state.
+ *
+ * NB: This may call C code, so the caller must be prepared for volatiles to
+ * be clobbered.
  */
 #define RECONCILE_IRQ_STATE(__rA, __rB)		\
 	lbz	__rA,PACASOFTIRQEN(r13);	\
-- 
1.9.1
