Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <13ad89a6b3d95020367cbadb2b0e7b0e72457009.1240450296.git.michael@ellerman.id.au>
In-Reply-To: <c3e0e417a708c5d76d9f4130e5f2b0398a1e0c3e.1240450296.git.michael@ellerman.id.au>
References: <c3e0e417a708c5d76d9f4130e5f2b0398a1e0c3e.1240450296.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 5/6] powerpc/powermac: Use generic_handle_irq() in
	gatwick_action()
Date: Thu, 23 Apr 2009 11:31:44 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Don't call __do_IRQ() directly in gatwick_action(), use
generic_handle_irq().

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/powermac/pic.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/pic.c b/arch/powerpc/platforms/powermac/pic.c
index 7039d8f..dce7363 100644
--- a/arch/powerpc/platforms/powermac/pic.c
+++ b/arch/powerpc/platforms/powermac/pic.c
@@ -221,7 +221,7 @@ static irqreturn_t gatwick_action(int cpl, void *dev_id)
 			continue;
 		irq += __ilog2(bits);
 		spin_unlock_irqrestore(&pmac_pic_lock, flags);
-		__do_IRQ(irq);
+		generic_handle_irq(irq);
 		spin_lock_irqsave(&pmac_pic_lock, flags);
 		rc = IRQ_HANDLED;
 	}
-- 
1.6.2.1
