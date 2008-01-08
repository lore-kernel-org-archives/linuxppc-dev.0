Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound7-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 57FADDE0D5
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 06:35:22 +1100 (EST)
From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To: grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org,
	simekm2@fel.cvut.cz, jwilliams@itee.uq.edu.au
Subject: [PATCH 6/7] [POWERPC] Xilinx: updated device tree compatibility to
	match uboot bsp generator.
Date: Tue,  8 Jan 2008 11:35:08 -0800
In-Reply-To: <1199820909-32341-6-git-send-email-stephen.neuendorffer@xilinx.com>
References: <1199820909-32341-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<1199820909-32341-2-git-send-email-stephen.neuendorffer@xilinx.com>
	<1199820909-32341-3-git-send-email-stephen.neuendorffer@xilinx.com>
	<1199820909-32341-4-git-send-email-stephen.neuendorffer@xilinx.com>
	<1199820909-32341-5-git-send-email-stephen.neuendorffer@xilinx.com>
	<1199820909-32341-6-git-send-email-stephen.neuendorffer@xilinx.com>
Message-Id: <20080108193519.DCA8BBE0061@mail38-sin.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Missed this one in the boot loader before.

Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
---
 arch/powerpc/boot/serial.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/serial.c b/arch/powerpc/boot/serial.c
index cafeece..b6c68ef 100644
--- a/arch/powerpc/boot/serial.c
+++ b/arch/powerpc/boot/serial.c
@@ -128,7 +128,8 @@ int serial_console_init(void)
 		rc = cpm_console_init(devp, &serial_cd);
 	else if (dt_is_compatible(devp, "mpc5200-psc-uart"))
 		rc = mpc5200_psc_console_init(devp, &serial_cd);
-	else if (dt_is_compatible(devp, "xilinx,uartlite"))
+	else if (dt_is_compatible(devp, "xlnx,opb-uartlite-1.00.b") ||
+		 dt_is_compatible(devp, "xlnx,xps-uartlite-1.00.a"))
 		rc = uartlite_console_init(devp, &serial_cd);
 
 	/* Add other serial console driver calls here */
-- 
1.5.3.4-dirty
