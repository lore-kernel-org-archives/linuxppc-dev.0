Return-Path: <miltonm@bga.com>
Received: from mail4.comsite.net (mail4.comsite.net [205.238.176.238])
	by ozlabs.org (Postfix) with ESMTP id 8ED06B6F14
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 May 2011 17:42:37 +1000 (EST)
To: <linuxppc-dev@lists.ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <e619719d90d94f19b6e2b47c3f36e7873da5bef9.1305092637.git.miltonm@bga.com>
In-Reply-To: <cover.1305092637.git.miltonm@bga.com>
References: <cover.1305092637.git.miltonm@bga.com>
From: Milton Miller <miltonm@bga.com>
Date: Wed, 11 May 2011 00:30:18 -0500
Subject: [PATCH 30/37] powerpc: mpc62xx_pic: fix get_irq handling of NO_IRQ
Cc: Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If none of irq category bits were set mpc52xx_get_irq() would pass
NO_IRQ_IGNORE (-1) to irq_linear_revmap, which does an unsigned compare
and declares the interrupt above the linear map range.  It then punts
to irq_find_mapping, which performs a linear search of all irqs,
which will likely miss and only then return NO_IRQ.

If no status bit is set, then we should return NO_IRQ directly.
The interrupt should not be suppressed from spurious counting, in fact
that is the definition of supurious.

Signed-off-by: Milton Miller <miltonm@bga.com>
---
---
 arch/powerpc/platforms/52xx/mpc52xx_pic.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pic.c b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
index bb61181..1a9a495 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pic.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
@@ -486,7 +486,7 @@ void __init mpc52xx_init_irq(void)
 unsigned int mpc52xx_get_irq(void)
 {
 	u32 status;
-	int irq = NO_IRQ_IGNORE;
+	int irq;
 
 	status = in_be32(&intr->enc_status);
 	if (status & 0x00000400) {	/* critical */
@@ -509,6 +509,8 @@ unsigned int mpc52xx_get_irq(void)
 		} else {
 			irq |= (MPC52xx_IRQ_L1_PERP << MPC52xx_IRQ_L1_OFFSET);
 		}
+	} else {
+		return NO_IRQ;
 	}
 
 	return irq_linear_revmap(mpc52xx_irqhost, irq);
-- 
1.7.0.4
