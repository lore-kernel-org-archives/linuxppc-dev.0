Return-Path: <linnj@wolfgang-pc.public.xilinx.com>
Received: from outbound4-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 14974DE08B
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 01:44:07 +1100 (EST)
Received: from outbound4-sin.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound4-sin-R.bigfish.com (Postfix) with ESMTP id 81A47160F06
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 14:44:05 +0000 (UTC)
Received: from mail63-sin-R.bigfish.com (unknown [10.3.40.3])
	by outbound4-sin.bigfish.com (Postfix) with ESMTP id 4CAF346004A
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 14:44:05 +0000 (UTC)
Received: from mail63-sin (localhost.localdomain [127.0.0.1])
	by mail63-sin-R.bigfish.com (Postfix) with ESMTP id 9030712E0173
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 14:44:04 +0000 (UTC)
Received: from xsj-gw1 (unknown [149.199.60.83])
	by mail63-sin.bigfish.com (Postfix) with ESMTP id 6A0E3518070
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 14:44:02 +0000 (UTC)
Received: from unknown-38-66.xilinx.com ([149.199.38.66]
	helo=xsj-smtp1.xilinx.com) by xsj-gw1 with esmtp (Exim 4.63)
	(envelope-from <linnj@wolfgang-pc.public.xilinx.com>)
	id 1JcLzt-0005hL-Ll
	for linuxppc-dev@ozlabs.org; Thu, 20 Mar 2008 07:44:01 -0700
From: John Linn <john.linn@xilinx.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/3] [POWERPC] of_serial: Fix possible null dereference.
Date: Thu, 20 Mar 2008 07:43:50 -0700
Message-Id: <20080320144402.6A0E3518070@mail63-sin.bigfish.com>
Cc: John Linn <john.linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
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
