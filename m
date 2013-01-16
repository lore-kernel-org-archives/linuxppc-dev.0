Return-Path: <B08248@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe001.messaging.microsoft.com [216.32.180.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CC5032C008F
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Jan 2013 04:21:34 +1100 (EST)
From: Stuart Yoder <stuart.yoder@freescale.com>
To: <agraf@suse.de>
Subject: [PATCH] KVM: PPC: add paravirt idle loop for 64-bit book E
Date: Wed, 16 Jan 2013 11:21:24 -0600
Message-ID: <1358356884-14216-1-git-send-email-stuart.yoder@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org,
 Stuart Yoder <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Stuart Yoder <stuart.yoder@freescale.com>

loop was derived from book3e_idle()

Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>
---
 arch/powerpc/kernel/epapr_hcalls.S |   63 ++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/arch/powerpc/kernel/epapr_hcalls.S b/arch/powerpc/kernel/epapr_hcalls.S
index 62c0dc2..6a46bfb 100644
--- a/arch/powerpc/kernel/epapr_hcalls.S
+++ b/arch/powerpc/kernel/epapr_hcalls.S
@@ -17,6 +17,68 @@
 #include <asm/asm-compat.h>
 #include <asm/asm-offsets.h>
 
+#ifdef CONFIG_PPC64
+/* epapr_ev_idle() was derived from book3e_idle() */
+_GLOBAL(epapr_ev_idle)
+	/* Save LR for later */
+	mflr	r0
+	std	r0,16(r1)
+
+	/* Hard disable interrupts */
+	wrteei	0
+
+	/* Now check if an interrupt came in while we were soft disabled
+	 * since we may otherwise lose it (doorbells etc...).
+	 */
+	lbz	r3,PACAIRQHAPPENED(r13)
+	cmpwi	cr0,r3,0
+	bnelr
+
+	/* Now we are going to mark ourselves as soft and hard enabled in
+	 * order to be able to take interrupts while asleep. We inform lockdep
+	 * of that. We don't actually turn interrupts on just yet tho.
+	 */
+#ifdef CONFIG_TRACE_IRQFLAGS
+	stdu    r1,-128(r1)
+	bl	.trace_hardirqs_on
+	addi    r1,r1,128
+#endif
+	li	r0,1
+	stb	r0,PACASOFTIRQEN(r13)
+	
+	/* Interrupts will make use return to LR, so get something we want
+	 * in there
+	 */
+	bl	1f
+
+	/* And return (interrupts are on) */
+	ld	r0,16(r1)
+	mtlr	r0
+	blr
+
+1:	/* Let's set the _TLF_NAPPING flag so interrupts make us return
+	 * to the right spot
+	*/
+	CURRENT_THREAD_INFO(r11, r1)
+	ld	r10,TI_LOCAL_FLAGS(r11)
+	ori	r10,r10,_TLF_NAPPING
+	std	r10,TI_LOCAL_FLAGS(r11)
+
+	/* We can now re-enable hard interrupts and go to sleep */
+	wrteei	1
+idle_loop:
+	LOAD_REG_IMMEDIATE(r11, EV_HCALL_TOKEN(EV_IDLE))
+
+.global epapr_ev_idle_start
+epapr_ev_idle_start:
+	li	r3, -1
+	nop
+	nop
+	nop
+	b	idle_loop
+
+#else /* CONFIG_PPC64 */
+
 /* epapr_ev_idle() was derived from e500_idle() */
 _GLOBAL(epapr_ev_idle)
 	CURRENT_THREAD_INFO(r3, r1)
@@ -42,6 +104,7 @@ epapr_ev_idle_start:
 	 * _TLF_NAPPING.
 	 */
 	b	idle_loop
+#endif
 
 /* Hypercall entry point. Will be patched with device tree instructions. */
 .global epapr_hypercall_start
-- 
1.7.9.7
