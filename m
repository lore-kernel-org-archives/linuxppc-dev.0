Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound4-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 1F456DDEED
	for <linuxppc-dev@ozlabs.org>; Thu,  8 May 2008 06:47:37 +1000 (EST)
From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To: grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] Xilinx: add compatibility for IBM coreconnect
	busses.
Date: Wed,  7 May 2008 13:47:31 -0700
Message-Id: <20080507204734.574B6185804E@mail138-sin.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The IBM coreconnect names are pretty well defined, it appears.  In
addition, the Xilinx versions of these IPs seem to be proliferating.
Hence, in the future let's prefer to use the standard names.  I've
left the old names in for some backward compatibility for existing
device trees.

Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
---
 arch/powerpc/platforms/40x/virtex.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/40x/virtex.c b/arch/powerpc/platforms/40x/virtex.c
index 6c72994..7e1c0e3 100644
--- a/arch/powerpc/platforms/40x/virtex.c
+++ b/arch/powerpc/platforms/40x/virtex.c
@@ -16,11 +16,15 @@
 #include <asm/xilinx_intc.h>
 
 static struct of_device_id xilinx_of_bus_ids[] __initdata = {
+	{ .compatible = "ibm,plb3", },
+	{ .compatible = "ibm,plb4", },
 	{ .compatible = "xlnx,plb-v46-1.00.a", },
 	{ .compatible = "xlnx,plb-v46-1.02.a", },
 	{ .compatible = "xlnx,plb-v34-1.01.a", },
 	{ .compatible = "xlnx,plb-v34-1.02.a", },
+	{ .compatible = "ibm,opb", },
 	{ .compatible = "xlnx,opb-v20-1.10.c", },
+	{ .compatible = "ibm,dcr", },
 	{ .compatible = "xlnx,dcr-v29-1.00.a", },
 	{ .compatible = "xlnx,compound", },
 	{}
-- 
1.5.3.4
