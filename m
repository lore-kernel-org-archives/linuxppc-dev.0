Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.28])
	by ozlabs.org (Postfix) with ESMTP id 3FB88DDF7D
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jan 2009 07:55:39 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so1578186yxg.39
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jan 2009 12:55:38 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 6/8] powerpc/5200: Remove pr_debug() from hot paths in irq
	driver
To: linuxppc-dev@ozlabs.org
Date: Wed, 21 Jan 2009 13:55:35 -0700
Message-ID: <20090121205534.31232.68165.stgit@localhost.localdomain>
In-Reply-To: <20090121205506.31232.27908.stgit@localhost.localdomain>
References: <20090121205506.31232.27908.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

pr_debug() calls in the 'hot' *_mask(), *_unmask(), *_ack() and
get_irq() makes adding #define DEBUG pretty much useless.  Remove
these calls because they completely swamp the output.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/platforms/52xx/mpc52xx_pic.c |   23 -----------------------
 1 files changed, 0 insertions(+), 23 deletions(-)


diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pic.c b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
index 0a093f0..c0a9559 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pic.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
@@ -163,8 +163,6 @@ static void mpc52xx_extirq_mask(unsigned int virq)
 	irq = irq_map[virq].hwirq;
 	l2irq = irq & MPC52xx_IRQ_L2_MASK;
 
-	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
-
 	io_be_clrbit(&intr->ctrl, 11 - l2irq);
 }
 
@@ -176,8 +174,6 @@ static void mpc52xx_extirq_unmask(unsigned int virq)
 	irq = irq_map[virq].hwirq;
 	l2irq = irq & MPC52xx_IRQ_L2_MASK;
 
-	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
-
 	io_be_setbit(&intr->ctrl, 11 - l2irq);
 }
 
@@ -189,8 +185,6 @@ static void mpc52xx_extirq_ack(unsigned int virq)
 	irq = irq_map[virq].hwirq;
 	l2irq = irq & MPC52xx_IRQ_L2_MASK;
 
-	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
-
 	io_be_setbit(&intr->ctrl, 27-l2irq);
 }
 
@@ -255,8 +249,6 @@ static void mpc52xx_main_mask(unsigned int virq)
 	irq = irq_map[virq].hwirq;
 	l2irq = irq & MPC52xx_IRQ_L2_MASK;
 
-	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
-
 	io_be_setbit(&intr->main_mask, 16 - l2irq);
 }
 
@@ -268,8 +260,6 @@ static void mpc52xx_main_unmask(unsigned int virq)
 	irq = irq_map[virq].hwirq;
 	l2irq = irq & MPC52xx_IRQ_L2_MASK;
 
-	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
-
 	io_be_clrbit(&intr->main_mask, 16 - l2irq);
 }
 
@@ -291,8 +281,6 @@ static void mpc52xx_periph_mask(unsigned int virq)
 	irq = irq_map[virq].hwirq;
 	l2irq = irq & MPC52xx_IRQ_L2_MASK;
 
-	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
-
 	io_be_setbit(&intr->per_mask, 31 - l2irq);
 }
 
@@ -304,8 +292,6 @@ static void mpc52xx_periph_unmask(unsigned int virq)
 	irq = irq_map[virq].hwirq;
 	l2irq = irq & MPC52xx_IRQ_L2_MASK;
 
-	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
-
 	io_be_clrbit(&intr->per_mask, 31 - l2irq);
 }
 
@@ -327,8 +313,6 @@ static void mpc52xx_sdma_mask(unsigned int virq)
 	irq = irq_map[virq].hwirq;
 	l2irq = irq & MPC52xx_IRQ_L2_MASK;
 
-	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
-
 	io_be_setbit(&sdma->IntMask, l2irq);
 }
 
@@ -340,8 +324,6 @@ static void mpc52xx_sdma_unmask(unsigned int virq)
 	irq = irq_map[virq].hwirq;
 	l2irq = irq & MPC52xx_IRQ_L2_MASK;
 
-	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
-
 	io_be_clrbit(&sdma->IntMask, l2irq);
 }
 
@@ -353,8 +335,6 @@ static void mpc52xx_sdma_ack(unsigned int virq)
 	irq = irq_map[virq].hwirq;
 	l2irq = irq & MPC52xx_IRQ_L2_MASK;
 
-	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
-
 	out_be32(&sdma->IntPend, 1 << l2irq);
 }
 
@@ -613,8 +593,5 @@ unsigned int mpc52xx_get_irq(void)
 		}
 	}
 
-	pr_debug("%s: irq=%x. virq=%d\n", __func__, irq,
-		 irq_linear_revmap(mpc52xx_irqhost, irq));
-
 	return irq_linear_revmap(mpc52xx_irqhost, irq);
 }
