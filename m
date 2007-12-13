Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound1-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id C240BDE049
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 10:43:42 +1100 (EST)
From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To: grant.likely@secretlab.ca, simekm2@fel.cvut.cz,
	jwilliams@itee.uq.edu.au, linuxppc-dev@ozlabs.org
Subject: [PATCH 6/7] [POWERPC] Xilinx: Add correct compatible list for device
	tree bus bindings.
Date: Thu, 13 Dec 2007 15:43:32 -0800
In-Reply-To: <1197589413-5965-5-git-send-email-stephen.neuendorffer@xilinx.com>
References: <1197589413-5965-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<1197589413-5965-2-git-send-email-stephen.neuendorffer@xilinx.com>
	<1197589413-5965-3-git-send-email-stephen.neuendorffer@xilinx.com>
	<1197589413-5965-4-git-send-email-stephen.neuendorffer@xilinx.com>
	<1197589413-5965-5-git-send-email-stephen.neuendorffer@xilinx.com>
Message-Id: <20071213234159.60D7A83804E@mail51-sin.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Includes both flavors of plb, opb, dcr, and a pseudo 'compound' bus
for representing compound peripherals containing more than one logical
device.

Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
---
 arch/powerpc/platforms/40x/virtex.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/40x/virtex.c b/arch/powerpc/platforms/40x/virtex.c
index 859ba1d..7590fa5 100644
--- a/arch/powerpc/platforms/40x/virtex.c
+++ b/arch/powerpc/platforms/40x/virtex.c
@@ -15,12 +15,22 @@
 #include <asm/time.h>
 #include <asm/xilinx_intc.h>
 
+static struct of_device_id xilinx_of_bus_ids[] = {
+	{ .compatible = "xlnx,plb-v46-1.00.a", },
+	{ .compatible = "xlnx,plb-v34-1.01.a", },
+	{ .compatible = "xlnx,plb-v34-1.02.a", },
+	{ .compatible = "xlnx,opb-v20-1.10.c", },
+	{ .compatible = "xlnx,dcr-v29-1.00.a", },
+	{ .compatible = "xlnx,compound", },
+	{},
+};
+
 static int __init virtex_device_probe(void)
 {
 	if (!machine_is(virtex))
 		return 0;
 
-	of_platform_bus_probe(NULL, NULL, NULL);
+	of_platform_bus_probe(NULL, xilinx_of_bus_ids, NULL);
 
 	return 0;
 }
-- 
1.5.3.4
