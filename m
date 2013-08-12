Return-Path: <bigeasy@linutronix.de>
Received: from Galois.linutronix.de (www.linutronix.de [62.245.132.108])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 67BB02C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Aug 2013 00:18:07 +1000 (EST)
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Anatolij Gustschin <agust@denx.de>
Subject: [PATCH] powerpc: 52xx: provide a default in mpc52xx_irqhost_map()
Date: Mon, 12 Aug 2013 16:17:53 +0200
Message-Id: <1376317073-14302-1-git-send-email-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org, Wolfram Sang <w.sang@pengutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

My gcc-4.3.5 fails to compile due to:

|cc1: warnings being treated as errors
|arch/powerpc/platforms/52xx/mpc52xx_pic.c: In function ‘mpc52xx_irqhost_map’:
|arch/powerpc/platforms/52xx/mpc52xx_pic.c:343: error: ‘irqchip’ may be used uninitialized in this function

since commit e34298c ("powerpc: 52xx: nop out unsupported critical
IRQs"). This warning is complete crap since only values 0…3 are possible
which are checked but gcc fails to understand that. I wouldn't care much
but since this is compiled with -Werror I made this patch.
While add it, I replaced the warning from l2irq to l1irq since this is
the number that is evaluated.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/powerpc/platforms/52xx/mpc52xx_pic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pic.c b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
index b89ef65..b69221b 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pic.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
@@ -373,8 +373,9 @@ static int mpc52xx_irqhost_map(struct irq_domain *h, unsigned int virq,
 	case MPC52xx_IRQ_L1_PERP: irqchip = &mpc52xx_periph_irqchip; break;
 	case MPC52xx_IRQ_L1_SDMA: irqchip = &mpc52xx_sdma_irqchip; break;
 	case MPC52xx_IRQ_L1_CRIT:
+	default:
 		pr_warn("%s: Critical IRQ #%d is unsupported! Nopping it.\n",
-			__func__, l2irq);
+			__func__, l1irq);
 		irq_set_chip(virq, &no_irq_chip);
 		return 0;
 	}
-- 
1.8.4.rc1
