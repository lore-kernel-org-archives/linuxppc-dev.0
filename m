Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40bTcl65NCzF2Rn
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 16:57:59 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com,
	maddy@linux.ibm.com
Subject: [PATCH] powerpc/64: Remove unused paca->soft_enabled
Date: Wed,  2 May 2018 16:57:54 +1000
Message-Id: <20180502065754.13816-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In commit 4e26bc4a4ed6 ("powerpc/64: Rename soft_enabled to
irq_soft_mask") we renamed paca->soft_enabled. But then in commit
8e0b634b1327 ("powerpc/64s: Do not allocate lppaca if we are not
virtualized") we added it back. Oops. This happened because the two
patches were in flight at the same time and rebased vs each other
multiple times, and we missed it in review.

Fixes: 8e0b634b1327 ("powerpc/64s: Do not allocate lppaca if we are not virtualized")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/paca.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 433dcdbf9da5..e7814d948c7a 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -165,7 +165,6 @@ struct paca_struct {
 	u64 saved_msr;			/* MSR saved here by enter_rtas */
 	u16 trap_save;			/* Used when bad stack is encountered */
 	u8 irq_soft_mask;		/* mask for irq soft masking */
-	u8 soft_enabled;		/* irq soft-enable flag */
 	u8 irq_happened;		/* irq happened while soft-disabled */
 	u8 io_sync;			/* writel() needs spin_unlock sync */
 	u8 irq_work_pending;		/* IRQ_WORK interrupt while soft-disable */
-- 
2.14.1
