Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spc2K6frYzDrPL
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 11:23:21 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH v3 27/42] powerpc/64s: Consolidate Reserved 0xec0,
 0xee0 interrupts
Date: Wed,  5 Oct 2016 11:22:49 +1100
Message-Id: <1475626984-18770-28-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1475626984-18770-1-git-send-email-mpe@ellerman.id.au>
References: <1475626984-18770-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Nicholas Piggin <npiggin@gmail.com>

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/exceptions-64s.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 54e352d6b50c..ee9d4959948c 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1023,6 +1023,8 @@ EXC_COMMON_ASYNC(h_virt_irq_common, 0xea0, do_IRQ)
 
 
 EXC_REAL_NONE(0xec0, 0xf00)
+EXC_VIRT_NONE(0x4ec0, 0x4f00)
+
 
 __EXC_REAL_OOL(performance_monitor, 0xf00, 0xf20)
 
@@ -1320,8 +1322,6 @@ EXC_COMMON(altivec_assist_common, 0x1700, unknown_exception)
 	 * come here.
 	 */
 
-EXC_VIRT_NONE(0x4ec0, 0x4f00)
-
 __EXC_VIRT_OOL(performance_monitor, 0x4f00, 0x4f20)
 
 __EXC_VIRT_OOL(altivec_unavailable, 0x4f20, 0x4f40)
-- 
2.7.4
