Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vHfxQ45QpzDqBN
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Feb 2017 21:01:14 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: anton@samba.org
Subject: [PATCH] powerpc/powernv: Fix opal_exit tracepoint opcode
Date: Tue,  7 Feb 2017 21:01:01 +1100
Message-Id: <1486461661-12867-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently the opal_exit tracepoint usually shows the opcode as 0:

  <idle>-0     [047] d.h.   635.654292: opal_entry: opcode=63
  <idle>-0     [047] d.h.   635.654296: opal_exit: opcode=0 retval=0
  kopald-1209  [019] d...   636.420943: opal_entry: opcode=10
  kopald-1209  [019] d...   636.420959: opal_exit: opcode=0 retval=0

This is because we incorrectly load the opcode into r0 before calling
__trace_opal_exit(), whereas it expects the opcode in r3 (first function
parameter). In fact we are leaving the retval in r3, so opcode and
retval will always show the same value.

Instead load the opcode into r3, resulting in:

  <idle>-0     [040] d.h.   636.618625: opal_entry: opcode=63
  <idle>-0     [040] d.h.   636.618627: opal_exit: opcode=63 retval=0

Fixes: c49f63530bb6 ("powernv: Add OPAL tracepoints")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/powernv/opal-wrappers.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index f7c19c9c57ed..63fe1b2b1175 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -146,7 +146,7 @@ opal_tracepoint_entry:
 opal_tracepoint_return:
 	std	r3,STK_REG(R31)(r1)
 	mr	r4,r3
-	ld	r0,STK_REG(R23)(r1)
+	ld	r3,STK_REG(R23)(r1)
 	bl	__trace_opal_exit
 	ld	r3,STK_REG(R31)(r1)
 	addi	r1,r1,STACKFRAMESIZE
-- 
2.7.4
