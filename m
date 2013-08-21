Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by ozlabs.org (Postfix) with ESMTP id C123D2C00CD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 01:59:29 +1000 (EST)
Date: Wed, 21 Aug 2013 17:59:24 +0200
Message-Id: <201308211559.r7LFxOBV025845@localhost.localdomain>
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH] Adding proper request of GPIO used by cpm_uart driver
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

cpm_uart serial driver uses GPIO for control signals. In order to be used
properly, GPIOs have to be reserved. Comment in gpiolib.c considers illegal
the use of GPIOs without requesting them. In addition, the direction of the
GPIO has to be set properly.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

diff -ur linux-3.8.13/drivers/tty/serial/cpm_uart/cpm_uart_core.c linux/drivers/tty/serial/cpm_uart/cpm_uart_core.c
--- linux-3.8.13/drivers/tty/serial/cpm_uart/cpm_uart_core.c	2013-08-21 05:34:03.000000000 +0200
+++ linux/drivers/tty/serial/cpm_uart/cpm_uart_core.c	2013-08-21 05:30:04.000000000 +0200
@@ -1213,8 +1213,32 @@
 		goto out_pram;
 	}
 
-	for (i = 0; i < NUM_GPIOS; i++)
-		pinfo->gpios[i] = of_get_gpio(np, i);
+	for (i = 0; i < NUM_GPIOS; i++) {
+		int gpio;
+
+		pinfo->gpios[i] = -1;
+
+		gpio = of_get_gpio(np, i);
+
+		if (gpio_is_valid(gpio)) {
+			ret = gpio_request(gpio, "cpm_uart");
+			if (ret) {
+				pr_err("can't request gpio #%d: %d\n", i, ret);
+				continue;
+			}
+			if (i == GPIO_RTS || i == GPIO_DTR)
+				ret = gpio_direction_output(gpio, 0);
+			else
+				ret = gpio_direction_input(gpio);
+			if (ret) {
+				pr_err("can't set direction for gpio #%d: %d\n",
+					i, ret);
+				gpio_free(gpio);
+				continue;
+			}
+			pinfo->gpios[i] = gpio;
+		}
+	}
 
 #ifdef CONFIG_PPC_EARLY_DEBUG_CPM
 	udbg_putc = NULL;
