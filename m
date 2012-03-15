Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E00F7B6F13
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2012 09:28:00 +1100 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id q2FMRt76014728
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Mar 2012 17:27:56 -0500
Message-ID: <1331850475.3105.152.camel@pasglop>
Subject: [PATCH] powerpc: Fix power4/970 idle code regression with lockdep
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Fri, 16 Mar 2012 09:27:55 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

in commit 7230c5644188cd9e3fb380cc97dde00c464a3ba7
"powerpc: Rework lazy-interrupt handling"

I introduced a regression, accidentally calling irq tracing twice
and not properly restoring a clobbered register (r7) later used
for writing to the MSR.

This caused lockups when booting on a G5 with lockdep enabled.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/idle_power4.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/idle_power4.S b/arch/powerpc/kernel/idle_power4.S
index d8cdba4c2..2c71b0f 100644
--- a/arch/powerpc/kernel/idle_power4.S
+++ b/arch/powerpc/kernel/idle_power4.S
@@ -50,9 +50,9 @@ END_FTR_SECTION_IFCLR(CPU_FTR_CAN_NAP)
 	addi    r1,r1,128
 	ld	r0,16(r1)
 	mtlr	r0
+	mfmsr	r7
 #endif /* CONFIG_TRACE_IRQFLAGS */
 
-	TRACE_ENABLE_INTS
 	li	r0,1
 	stb	r0,PACASOFTIRQEN(r13)	/* we'll hard-enable shortly */
 BEGIN_FTR_SECTION
-- 
1.7.9
