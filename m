Return-Path: <linnj@wolfgang-pc.public.xilinx.com>
Received: from outbound2-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id D1FA4DE0F6
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Apr 2008 03:52:21 +1100 (EST)
From: John Linn <john.linn@xilinx.com>
To: linuxppc-dev@ozlabs.org,
	grant.likely@secretlab.ca
Subject: [PATCH 1/3][POWERPC][V2] of_serial: Fix possible null dereference.
Date: Wed,  2 Apr 2008 09:52:13 -0700
Message-Id: <20080402165216.8FD2BC9807F@mail21-dub.bigfish.com>
Cc: John Linn <john.linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>

The of_serial driver queries the current-speed property and attempts
to use it to register the custom_divisor property of the uart_port.
However, if current-speed is not set, then this code will dereference
a bad pointer.  The fix is to only set custom_divisor when a
current-speed property appears in the device tree.

Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Signed-off-by: John Linn <john.linn@xilinx.com>
---
 drivers/serial/of_serial.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/of_serial.c b/drivers/serial/of_serial.c
index a64d858..2efb892 100644
--- a/drivers/serial/of_serial.c
+++ b/drivers/serial/of_serial.c
@@ -56,7 +56,9 @@ static int __devinit of_platform_serial_setup(struct of_device *ofdev,
 	port->flags = UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF | UPF_IOREMAP
 		| UPF_FIXED_PORT;
 	port->dev = &ofdev->dev;
-	port->custom_divisor = *clk / (16 * (*spd));
+	/* If current-speed was set, then try not to change it. */
+	if (spd)
+		port->custom_divisor = *clk / (16 * (*spd));
 
 	return 0;
 }
-- 
1.5.2.1
