Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DDE8DB6FD9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Feb 2012 04:14:09 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 19/30] KVM: PPC: e500mc: add load inst fixup
Date: Fri, 17 Feb 2012 18:13:46 +0100
Message-Id: <1329498837-11717-20-git-send-email-agraf@suse.de>
In-Reply-To: <1329498837-11717-1-git-send-email-agraf@suse.de>
References: <1329498837-11717-1-git-send-email-agraf@suse.de>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There's always a chance we're unable to read a guest instruction. The guest
could have its TLB mapped execute-, but not readable, something odd happens
and our TLB gets flushed. So it's a good idea to be prepared for that case
and have a fallback that allows us to fix things up in that case.

Add fixup code that keeps guest code from potentially crashing our host kernel.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kvm/bookehv_interrupts.S |   30 +++++++++++++++++++++++++++++-
 1 files changed, 29 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kvm/bookehv_interrupts.S b/arch/powerpc/kvm/bookehv_interrupts.S
index 63023ae..e0f484c 100644
--- a/arch/powerpc/kvm/bookehv_interrupts.S
+++ b/arch/powerpc/kvm/bookehv_interrupts.S
@@ -28,6 +28,7 @@
 #include <asm/asm-compat.h>
 #include <asm/asm-offsets.h>
 #include <asm/bitsperlong.h>
+#include <asm/thread_info.h>
 
 #include "../kernel/head_booke.h" /* for THREAD_NORMSAVE() */
 
@@ -171,9 +172,36 @@
 	PPC_STL	r30, VCPU_GPR(r30)(r4)
 	PPC_STL	r31, VCPU_GPR(r31)(r4)
 	mtspr	SPRN_EPLC, r8
+
+	/* disable preemption, so we are sure we hit the fixup handler */
+#ifdef CONFIG_PPC64
+	clrrdi	r8,r1,THREAD_SHIFT
+#else
+	rlwinm	r8,r1,0,0,31-THREAD_SHIFT       /* current thread_info */
+#endif
+        lwz     r6,TI_PREEMPT(r8)
+	addi	r7,r6,1
+        stw     r7,TI_PREEMPT(r8)
+
 	isync
-	lwepx	r9, 0, r5
+
+	/*
+	 * In case the read goes wrong, we catch it and write an invalid value
+	 * in LAST_INST instead.
+	 */
+1:	lwepx	r9, 0, r5
+2:
+.section .fixup, "ax"
+3:	li r9, KVM_INST_FETCH_FAILED
+	b 2b
+.previous
+.section __ex_table,"a"
+	PPC_LONG_ALIGN
+	PPC_LONG 1b,3b
+.previous
+
 	mtspr	SPRN_EPLC, r3
+        stw     r6,TI_PREEMPT(r8)
 	stw	r9, VCPU_LAST_INST(r4)
 	.endif
 
-- 
1.6.0.2
