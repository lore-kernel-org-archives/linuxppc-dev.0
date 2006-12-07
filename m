Return-Path: <b07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 5D19667E55
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Dec 2006 04:40:01 +1100 (EST)
Date: Thu, 7 Dec 2006 11:35:41 -0600
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 4/4] powerpc: Call of_register_i2c_devices() for fsl-i2c.
Message-ID: <20061207173541.GG22989@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Call of_register_i2c_devices() to register I2C devices on
the device tree under an fsl-i2c node.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
This patch depends on David Brownell's patchset at
http://lists.lm-sensors.org/pipermail/i2c/2006-November/000516.html

 arch/powerpc/sysdev/fsl_soc.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index ad31e56..a4d3c46 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -345,6 +345,8 @@ static int __init fsl_i2c_of_init(void)
 						    fsl_i2c_platform_data));
 		if (ret)
 			goto unreg;
+
+		of_register_i2c_devices(np, i);
 	}
 
 	return 0;
-- 
1.4.2.3
