Return-Path: <jslaby@suse.cz>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r3DQ649s6zDq5m
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 May 2016 17:23:42 +1000 (AEST)
From: Jiri Slaby <jslaby@suse.cz>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jiri Slaby <jslaby@suse.cz>, Russell King <linux@arm.linux.org.uk>,
 =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <kernel@pengutronix.de>,
 Russell King <linux@armlinux.org.uk>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Laxman Dewangan <ldewangan@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Alexandre Courbot <gnurou@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-tegra@vger.kernel.org
Subject: [PATCH v2] TTY: serial, handle platform_get_irq retval properly
Date: Mon,  9 May 2016 09:23:35 +0200
Message-Id: <1462778615-14718-1-git-send-email-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

platform_get_irq can fail, so we should handle negative value when
returned.

[v2]

platform_get_irq can actually return zero on some platforms. So do not
remove checks for irq == 0 there.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: "Uwe Kleine-König" <kernel@pengutronix.de>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Alexandre Courbot <gnurou@gmail.com>
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-tegra@vger.kernel.org
---
 drivers/tty/serial/amba-pl011.c   | 8 +++++++-
 drivers/tty/serial/fsl_lpuart.c   | 8 +++++++-
 drivers/tty/serial/pmac_zilog.c   | 2 +-
 drivers/tty/serial/serial-tegra.c | 7 ++++++-
 4 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index a2aa655f56c4..c70bb41800f1 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2553,11 +2553,17 @@ static int sbsa_uart_probe(struct platform_device *pdev)
 	if (!uap)
 		return -ENOMEM;
 
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "cannot obtain irq\n");
+		return ret;
+	}
+	uap->port.irq	= ret;
+
 	uap->reg_offset	= vendor_sbsa.reg_offset;
 	uap->vendor	= &vendor_sbsa;
 	uap->fifosize	= 32;
 	uap->port.iotype = vendor_sbsa.access_32b ? UPIO_MEM32 : UPIO_MEM;
-	uap->port.irq	= platform_get_irq(pdev, 0);
 	uap->port.ops	= &sbsa_uart_pops;
 	uap->fixed_baud = baudrate;
 
diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 3d790033744e..7f95f782a485 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1830,7 +1830,13 @@ static int lpuart_probe(struct platform_device *pdev)
 	sport->port.dev = &pdev->dev;
 	sport->port.type = PORT_LPUART;
 	sport->port.iotype = UPIO_MEM;
-	sport->port.irq = platform_get_irq(pdev, 0);
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "cannot obtain irq\n");
+		return ret;
+	}
+	sport->port.irq = ret;
+
 	if (sport->lpuart32)
 		sport->port.ops = &lpuart32_pops;
 	else
diff --git a/drivers/tty/serial/pmac_zilog.c b/drivers/tty/serial/pmac_zilog.c
index e156e39d620c..b24b0556f5a8 100644
--- a/drivers/tty/serial/pmac_zilog.c
+++ b/drivers/tty/serial/pmac_zilog.c
@@ -1720,7 +1720,7 @@ static int __init pmz_init_port(struct uart_pmac_port *uap)
 
 	r_ports = platform_get_resource(uap->pdev, IORESOURCE_MEM, 0);
 	irq = platform_get_irq(uap->pdev, 0);
-	if (!r_ports || !irq)
+	if (!r_ports || irq <= 0)
 		return -ENODEV;
 
 	uap->port.mapbase  = r_ports->start;
diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index bee1e5867426..4c4674b51db9 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -1310,7 +1310,12 @@ static int tegra_uart_probe(struct platform_device *pdev)
 	}
 
 	u->iotype = UPIO_MEM32;
-	u->irq = platform_get_irq(pdev, 0);
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Couldn't get IRQ\n");
+		return ret;
+	}
+	u->irq = ret;
 	u->regshift = 2;
 	ret = uart_add_one_port(&tegra_uart_driver, u);
 	if (ret < 0) {
-- 
2.8.2
