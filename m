Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 530EBB7D66
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Apr 2010 19:26:07 +1000 (EST)
From: Wolfram Sang <w.sang@pengutronix.de>
To: linuxppc-dev@ozlabs.org
Date: Tue, 27 Apr 2010 11:25:27 +0200
Message-Id: <1272360327-31425-1-git-send-email-w.sang@pengutronix.de>
Subject: [PATCH RESEND] serial/mpc52xx_uart: Drop outdated comments
Cc: linux-serial@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Most things mentioned are either obsolete (platform-support) or wrong (device
numbering, DCD spport) these days. The remaining rest is obvious.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
---
 drivers/serial/mpc52xx_uart.c |   33 ---------------------------------
 1 files changed, 0 insertions(+), 33 deletions(-)

diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
index 3119fdd..a176ab4 100644
--- a/drivers/serial/mpc52xx_uart.c
+++ b/drivers/serial/mpc52xx_uart.c
@@ -29,39 +29,6 @@
  * kind, whether express or implied.
  */
 
-/* Platform device Usage :
- *
- * Since PSCs can have multiple function, the correct driver for each one
- * is selected by calling mpc52xx_match_psc_function(...). The function
- * handled by this driver is "uart".
- *
- * The driver init all necessary registers to place the PSC in uart mode without
- * DCD. However, the pin multiplexing aren't changed and should be set either
- * by the bootloader or in the platform init code.
- *
- * The idx field must be equal to the PSC index (e.g. 0 for PSC1, 1 for PSC2,
- * and so on). So the PSC1 is mapped to /dev/ttyPSC0, PSC2 to /dev/ttyPSC1 and
- * so on. But be warned, it's an ABSOLUTE REQUIREMENT ! This is needed mainly
- * fpr the console code : without this 1:1 mapping, at early boot time, when we
- * are parsing the kernel args console=ttyPSC?, we wouldn't know which PSC it
- * will be mapped to.
- */
-
-/* OF Platform device Usage :
- *
- * This driver is only used for PSCs configured in uart mode.  The device
- * tree will have a node for each PSC with "mpc52xx-psc-uart" in the compatible
- * list.
- *
- * By default, PSC devices are enumerated in the order they are found.  However
- * a particular PSC number can be forces by adding 'device_no = <port#>'
- * to the device node.
- *
- * The driver init all necessary registers to place the PSC in uart mode without
- * DCD. However, the pin multiplexing aren't changed and should be set either
- * by the bootloader or in the platform init code.
- */
-
 #undef DEBUG
 
 #include <linux/device.h>
-- 
1.7.0
