Return-Path: <mfuchs@ma-fu.de>
Received: from mail-in-15.arcor-online.net (mail-in-15.arcor-online.net
	[151.189.21.55])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1CE35DE098
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jan 2009 06:43:46 +1100 (EST)
From: Matthias Fuchs <mfuchs@ma-fu.de>
To: linux-serial@vger.kernel.org
Subject: [PATCH] serial: Add 16850 uart type support to OF uart driver
Date: Thu, 15 Jan 2009 20:43:35 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200901152043.35949.mfuchs@ma-fu.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

(Resend because former version does not apply cleanly anymore)

This patch adds support for "ns16850" as supported value
of the compatible node in flat device tree uart descriptions.

This is needed for example when you have a XR16C2850 uart
connected to a PPC405's external bus controller.

Signed-off-by: Matthias Fuchs <mfuchs@ma-fu.de>
---
 drivers/serial/of_serial.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/of_serial.c b/drivers/serial/of_serial.c
index a821e3a..14f8fa9 100644
--- a/drivers/serial/of_serial.c
+++ b/drivers/serial/of_serial.c
@@ -163,6 +163,7 @@ static struct of_device_id __devinitdata of_platform_serial_table[] = {
 	{ .type = "serial", .compatible = "ns16450",  .data = (void *)PORT_16450, },
 	{ .type = "serial", .compatible = "ns16550",  .data = (void *)PORT_16550, },
 	{ .type = "serial", .compatible = "ns16750",  .data = (void *)PORT_16750, },
+	{ .type = "serial", .compatible = "ns16850",  .data = (void *)PORT_16850, },
 #ifdef CONFIG_SERIAL_OF_PLATFORM_NWPSERIAL
 	{ .type = "serial", .compatible = "ibm,qpace-nwp-serial",
 					.data = (void *)PORT_NWPSERIAL, },
-- 
1.5.6.3
