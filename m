Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7E0EE1A03D6
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Apr 2015 14:11:58 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/2] powerpc/cell: Fix crash in iic_setup_cpu() after per_cpu
 changes
Date: Fri,  3 Apr 2015 14:11:53 +1100
Message-Id: <1428030714-24989-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The conversion from __get_cpu_var() to this_cpu_ptr() in iic_setup_cpu()
is wrong. It causes an oops at boot.

We need the per-cpu address of struct cpu_iic, not cpu_iic.regs->prio.

Sparse noticed this, because we pass a non-iomem pointer to out_be64(),
but we obviously don't check the sparse results often enough.

Fixes: 69111bac42f5 ("powerpc: Replace __get_cpu_var uses")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/cell/interrupt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/cell/interrupt.c b/arch/powerpc/platforms/cell/interrupt.c
index 4c11421847be..3af8324c122e 100644
--- a/arch/powerpc/platforms/cell/interrupt.c
+++ b/arch/powerpc/platforms/cell/interrupt.c
@@ -163,7 +163,7 @@ static unsigned int iic_get_irq(void)
 
 void iic_setup_cpu(void)
 {
-	out_be64(this_cpu_ptr(&cpu_iic.regs->prio), 0xff);
+	out_be64(&this_cpu_ptr(&cpu_iic)->regs->prio, 0xff);
 }
 
 u8 iic_get_target_id(int cpu)
-- 
2.1.0
