Return-Path: <abounine@ott.idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rwMpL1BxFzDqQ1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2016 04:32:41 +1000 (AEST)
From: Alexandre Bounine <alexandre.bounine@idt.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexandre Bounine <alexandre.bounine@idt.com>,
 Matt Porter <mporter@kernel.crashing.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Andre van Herk <andre.van.herk@prodrive-technologies.com>,
 Barry Wood <barry.wood@idt.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 12/13] powerpc/fsl_rio: apply changes for RIO spec rev 3
Date: Thu, 21 Jul 2016 14:18:53 -0400
Message-Id: <1469125134-16523-13-git-send-email-alexandre.bounine@idt.com>
In-Reply-To: <1469125134-16523-1-git-send-email-alexandre.bounine@idt.com>
References: <1469125134-16523-1-git-send-email-alexandre.bounine@idt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

- Remove check for parallel PHY
- Set LP-Serial Register Map type

Signed-off-by: Alexandre Bounine <alexandre.bounine@idt.com>
Cc: Matt Porter <mporter@kernel.crashing.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Andre van Herk <andre.van.herk@prodrive-technologies.com>
Cc: Barry Wood <barry.wood@idt.com>
Cc: linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/sysdev/fsl_rio.c |   12 ++----------
 1 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_rio.c b/arch/powerpc/sysdev/fsl_rio.c
index 1958838..ee5b9f1 100644
--- a/arch/powerpc/sysdev/fsl_rio.c
+++ b/arch/powerpc/sysdev/fsl_rio.c
@@ -643,19 +643,11 @@ int fsl_rio_setup(struct platform_device *dev)
 		port->ops = ops;
 		port->priv = priv;
 		port->phys_efptr = 0x100;
+		port->phys_rmap = 1;
 		priv->regs_win = rio_regs_win;
 
-		/* Probe the master port phy type */
 		ccsr = in_be32(priv->regs_win + RIO_CCSR + i*0x20);
-		port->phy_type = (ccsr & 1) ? RIO_PHY_SERIAL : RIO_PHY_PARALLEL;
-		if (port->phy_type == RIO_PHY_PARALLEL) {
-			dev_err(&dev->dev, "RIO: Parallel PHY type, unsupported port type!\n");
-			release_resource(&port->iores);
-			kfree(priv);
-			kfree(port);
-			continue;
-		}
-		dev_info(&dev->dev, "RapidIO PHY type: Serial\n");
+
 		/* Checking the port training status */
 		if (in_be32((priv->regs_win + RIO_ESCSR + i*0x20)) & 1) {
 			dev_err(&dev->dev, "Port %d is not ready. "
-- 
1.7.8.4
