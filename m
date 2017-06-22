Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtpQx0cxPzDr0r
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jun 2017 03:26:33 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>,
 benh@kernel.crashing.org, Michael Neuling <mikey@neuling.org>
Subject: [PATCH] powerpc: Invalidate ERAT on powersave wakeup for POWER9
Date: Thu, 22 Jun 2017 12:26:16 -0500
Message-Id: <20170622172616.7598-1-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On POWER9 the ERAT may be incorrect on wakeup from some stop states
that lose state. This causes random segvs and illegal instructions
when these stop states are enabled.

This patch invalidates the ERAT on wakeup on POWER9 to prevent this
from causing a problem.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kernel/idle_book3s.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index 1ea14b96f1..ace2ad50c8 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -793,6 +793,9 @@ fastsleep_workaround_at_exit:
  */
 .global pnv_wakeup_loss
 pnv_wakeup_loss:
+BEGIN_FTR_SECTION
+	PPC_INVALIDATE_ERAT
+END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
 	ld	r1,PACAR1(r13)
 BEGIN_FTR_SECTION
 	CHECK_HMI_INTERRUPT
-- 
2.11.0
