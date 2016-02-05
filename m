Return-Path: <abounine@ott.idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6E5D81A01A3
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Feb 2016 10:28:46 +1100 (AEDT)
From: Alexandre Bounine <alexandre.bounine@idt.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexandre Bounine <alexandre.bounine@idt.com>,
 Matt Porter <mporter@kernel.crashing.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Aurelien Jacquiot <a-jacquiot@ti.com>,
 Andre van Herk <andre.van.herk@prodrive-technologies.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 16/30] powerpc/fsl_rio: changes to mport registration
Date: Fri,  5 Feb 2016 18:19:32 -0500
Message-Id: <1454714386-15259-17-git-send-email-alexandre.bounine@idt.com>
In-Reply-To: <1454714386-15259-1-git-send-email-alexandre.bounine@idt.com>
References: <1454714386-15259-1-git-send-email-alexandre.bounine@idt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Change mport object initialization/registration sequence to match reworked
version of rio_register_mport() in the core code.

Signed-off-by: Alexandre Bounine <alexandre.bounine@idt.com>
Cc: Matt Porter <mporter@kernel.crashing.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Aurelien Jacquiot <a-jacquiot@ti.com>
Cc: Andre van Herk <andre.van.herk@prodrive-technologies.com>
Cc: linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/sysdev/fsl_rio.c |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_rio.c b/arch/powerpc/sysdev/fsl_rio.c
index c1cd369..385371a 100644
--- a/arch/powerpc/sysdev/fsl_rio.c
+++ b/arch/powerpc/sysdev/fsl_rio.c
@@ -606,6 +606,12 @@ int fsl_rio_setup(struct platform_device *dev)
 		if (!port)
 			continue;
 
+		rc = rio_mport_initialize(port);
+		if (rc) {
+			kfree(port);
+			continue;
+		}
+
 		i = *port_index - 1;
 		port->index = (unsigned char)i;
 
@@ -682,12 +688,6 @@ int fsl_rio_setup(struct platform_device *dev)
 		dev_info(&dev->dev, "RapidIO Common Transport System size: %d\n",
 				port->sys_size ? 65536 : 256);
 
-		if (rio_register_mport(port)) {
-			release_resource(&port->iores);
-			kfree(priv);
-			kfree(port);
-			continue;
-		}
 		if (port->host_deviceid >= 0)
 			out_be32(priv->regs_win + RIO_GCCSR, RIO_PORT_GEN_HOST |
 				RIO_PORT_GEN_MASTER | RIO_PORT_GEN_DISCOVERED);
@@ -727,6 +727,12 @@ int fsl_rio_setup(struct platform_device *dev)
 
 		dbell->mport[i] = port;
 
+		if (rio_register_mport(port)) {
+			release_resource(&port->iores);
+			kfree(priv);
+			kfree(port);
+			continue;
+		}
 		active_ports++;
 	}
 
-- 
1.7.8.4
