Return-Path: <Joakim.Tjernlund@infinera.com>
Received: from smtp.transmode.se (smtp.transmode.se [31.15.61.139])
 by lists.ozlabs.org (Postfix) with ESMTP id 419D3P29FVzF0wQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 02:30:41 +1000 (AEST)
From: Joakim Tjernlund <joakim.tjernlund@infinera.com>
To: York Sun <york.sun@nxp.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] QE GPIO: Add qe_gpio_set_multiple
Date: Tue, 19 Jun 2018 18:22:16 +0200
Message-Id: <20180619162216.20030-1-joakim.tjernlund@infinera.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This cousin to gpio-mpc8xxx was lacking a multiple pins method,
add one.

Signed-off-by: Joakim Tjernlund <joakim.tjernlund@infinera.com>
---
 drivers/soc/fsl/qe/gpio.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/soc/fsl/qe/gpio.c b/drivers/soc/fsl/qe/gpio.c
index 3b27075c21a7..819bed0f5667 100644
--- a/drivers/soc/fsl/qe/gpio.c
+++ b/drivers/soc/fsl/qe/gpio.c
@@ -83,6 +83,33 @@ static void qe_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
 	spin_unlock_irqrestore(&qe_gc->lock, flags);
 }
 
+static void qe_gpio_set_multiple(struct gpio_chip *gc,
+				 unsigned long *mask, unsigned long *bits)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct qe_gpio_chip *qe_gc = gpiochip_get_data(gc);
+	struct qe_pio_regs __iomem *regs = mm_gc->regs;
+	unsigned long flags;
+	int i;
+
+	spin_lock_irqsave(&qe_gc->lock, flags);
+
+	for (i = 0; i < gc->ngpio; i++) {
+		if (*mask == 0)
+			break;
+		if (__test_and_clear_bit(i, mask)) {
+			if (test_bit(i, bits))
+				qe_gc->cpdata |= (1U << (QE_PIO_PINS - 1 - i));
+			else
+				qe_gc->cpdata &= ~(1U << (QE_PIO_PINS - 1 - i));
+		}
+	}
+
+	out_be32(&regs->cpdata, qe_gc->cpdata);
+
+	spin_unlock_irqrestore(&qe_gc->lock, flags);
+}
+
 static int qe_gpio_dir_in(struct gpio_chip *gc, unsigned int gpio)
 {
 	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
@@ -298,6 +325,7 @@ static int __init qe_add_gpiochips(void)
 		gc->direction_output = qe_gpio_dir_out;
 		gc->get = qe_gpio_get;
 		gc->set = qe_gpio_set;
+		gc->set_multiple = qe_gpio_set_multiple;
 
 		ret = of_mm_gpiochip_add_data(np, mm_gc, qe_gc);
 		if (ret)
-- 
2.13.6
