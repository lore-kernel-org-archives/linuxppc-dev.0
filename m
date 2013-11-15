Return-Path: <Gang.Liu@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 600D32C0094
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Nov 2013 19:34:20 +1100 (EST)
From: Liu Gang <Gang.Liu@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <linux-gpio@vger.kernel.org>,
 <linus.walleij@linaro.org>
Subject: [PATCH] powerpc/gpio: Fix the wrong GPIO input data on MPC8572/MPC8536
Date: Fri, 15 Nov 2013 15:16:29 +0800
Message-ID: <1384499789-3631-1-git-send-email-Gang.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: b07421@freescale.com, Liu Gang <Gang.Liu@freescale.com>,
 r61911@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For MPC8572/MPC8536, the status of GPIOs defined as output
cannot be determined by reading GPDAT register, so the code
use shadow data register instead. But if the input pins are
asserted high, they will always read high due to the shadow
data, even if the pins are set to low.

So the input pins should be read directly from GPDAT, not
the shadow data.

Signed-off-by: Liu Gang <Gang.Liu@freescale.com>
---
 drivers/gpio/gpio-mpc8xxx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-mpc8xxx.c b/drivers/gpio/gpio-mpc8xxx.c
index 9ae29cc..1d4ac75 100644
--- a/drivers/gpio/gpio-mpc8xxx.c
+++ b/drivers/gpio/gpio-mpc8xxx.c
@@ -71,6 +71,7 @@ static int mpc8572_gpio_get(struct gpio_chip *gc, unsigned int gpio)
 	struct mpc8xxx_gpio_chip *mpc8xxx_gc = to_mpc8xxx_gpio_chip(mm);
 
 	val = in_be32(mm->regs + GPIO_DAT) & ~in_be32(mm->regs + GPIO_DIR);
+	mpc8xxx_gc->data &= in_be32(mm->regs + GPIO_DIR);
 
 	return (val | mpc8xxx_gc->data) & mpc8xxx_gpio2mask(gpio);
 }
-- 
1.8.4.1
