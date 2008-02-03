Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id DA0ADDE16E
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Feb 2008 04:10:19 +1100 (EST)
Date: Sun, 3 Feb 2008 20:10:09 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 05/11] [POWERPC] qe_lib: support for gpio_set_dedicated
Message-ID: <20080203171009.GE28024@localhost.localdomain>
References: <20080203170820.GA18520@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080203170820.GA18520@localhost.localdomain>
Cc: David Brownell <david-b@pacbell.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So far we just restore pre-set dedicated function of the pin.
No need for anything else, so far.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/sysdev/qe_lib/qe_io.c |   46 ++++++++++++++++++++++++++++++++++++
 1 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/qe_lib/qe_io.c b/arch/powerpc/sysdev/qe_lib/qe_io.c
index dffb44a..abe02e0 100644
--- a/arch/powerpc/sysdev/qe_lib/qe_io.c
+++ b/arch/powerpc/sysdev/qe_lib/qe_io.c
@@ -225,6 +225,9 @@ struct qe_gpio_chip {
 
 	/* shadowed data register to clear/set bits safely */
 	u32 cpdata;
+
+	/* saved_regs used to restore dedicated functions */
+	struct port_regs saved_regs;
 };
 
 #define to_qe_gpio_chip(x) container_of(x, struct qe_gpio_chip, mm_gc)
@@ -235,6 +238,12 @@ static void qe_gpio_save_regs(struct of_mm_gpio_chip *mm_gc)
 	struct port_regs __iomem *regs = mm_gc->regs;
 
 	qe_gc->cpdata = in_be32(&regs->cpdata);
+	qe_gc->saved_regs.cpdata = qe_gc->cpdata;
+	qe_gc->saved_regs.cpdir1 = in_be32(&regs->cpdir1);
+	qe_gc->saved_regs.cpdir2 = in_be32(&regs->cpdir2);
+	qe_gc->saved_regs.cppar1 = in_be32(&regs->cppar1);
+	qe_gc->saved_regs.cppar2 = in_be32(&regs->cppar2);
+	qe_gc->saved_regs.cpodr = in_be32(&regs->cpodr);
 }
 
 static int qe_gpio_get(struct gpio_chip *gc, unsigned int gpio)
@@ -301,6 +310,43 @@ static int qe_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
 	return 0;
 }
 
+static int qe_gpio_set_dedicated(struct gpio_chip *gc, unsigned int gpio,
+				 int func)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct qe_gpio_chip *qe_gc = to_qe_gpio_chip(mm_gc);
+	struct port_regs __iomem *regs = mm_gc->regs;
+	struct port_regs *sregs = &qe_gc->saved_regs;
+	unsigned long flags;
+	u32 mask1 = 1 << (NUM_OF_PINS - (gpio + 1));
+	u32 mask2 = 0x3 << (NUM_OF_PINS - (gpio % (NUM_OF_PINS / 2) + 1) * 2);
+	bool second_reg = gpio > (NUM_OF_PINS / 2) - 1;
+
+	spin_lock_irqsave(&qe_gc->lock, flags);
+
+	if (second_reg)
+		clrsetbits_be32(&regs->cpdir2, mask2, sregs->cpdir2 & mask2);
+	else
+		clrsetbits_be32(&regs->cpdir1, mask2, sregs->cpdir1 & mask2);
+
+	if (second_reg)
+		clrsetbits_be32(&regs->cppar2, mask2, sregs->cppar2 & mask2);
+	else
+		clrsetbits_be32(&regs->cppar1, mask2, sregs->cppar1 & mask2);
+
+	if (sregs->cpdata & mask1)
+		qe_gc->cpdata |= mask1;
+	else
+		qe_gc->cpdata &= ~mask1;
+
+	out_be32(&regs->cpdata, qe_gc->cpdata);
+	clrsetbits_be32(&regs->cpodr, mask1, sregs->cpodr & mask1);
+
+	spin_unlock_irqrestore(&qe_gc->lock, flags);
+
+	return 0;
+}
+
 static int __init qe_add_gpiochips(void)
 {
 	int ret;
-- 
1.5.2.2
