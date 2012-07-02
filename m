Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5B1FE2C01CA
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Jul 2012 14:47:23 +1000 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id q624lIvf030865
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 1 Jul 2012 23:47:19 -0500
Message-ID: <1341204437.2588.21.camel@pasglop>
Subject: [PATCH] powerpc: Fixup oddity in entry_32.S
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Date: Mon, 02 Jul 2012 14:47:17 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When I "fixed" the CONFIG_TRACE_IRQFLAGS case on interrupt entry,
I screwed up a little bit with the test for user space vs. kernel.

The code is fine, there's just some dead code around it. I basically
removed the test and always create the added stack frame whether
coming from user or kernel since in any case we do need to save
a bunch of volatile registers or bad things would happen (we can
take page faults in the kernel for example).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index ba3aeb4..477ec2c 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -226,13 +226,7 @@ reenable_mmu:				/* re-enable mmu so we can */
 	stw	r3,16(r1)
 	stw	r4,20(r1)
 	stw	r5,24(r1)
-	andi.	r12,r12,MSR_PR
-	b	11f
 	bl	trace_hardirqs_off
-	b	12f
-11:
-	bl	trace_hardirqs_off
-12:
 	lwz	r5,24(r1)
 	lwz	r4,20(r1)
 	lwz	r3,16(r1)
