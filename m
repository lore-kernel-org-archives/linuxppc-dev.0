Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 77B8BDDE29
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Aug 2007 02:38:26 +1000 (EST)
Date: Mon, 20 Aug 2007 11:38:12 -0500
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH 4/4] fsl_soc.c cleanup
Message-ID: <20070820163812.GC29912@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070820163619.GA29889@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

1. Fix get_immrbase() to use ranges, rather than reg.

It is not always the case that the SoC's first reg property points
to the beginning of the entire SoC block.

2. Update the way get_brgfreq() finds things in the device tree.

It now uses names that are less namespace polluting.  The old names
are supported until all boards are converted.

3. "size" is changed from unsigned int to int, to match what
of_get_property() expects.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/sysdev/fsl_soc.c |   38 +++++++++++++++++++++++++++-----------
 1 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index a9953c5..fff9f54 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -51,11 +51,20 @@ phys_addr_t get_immrbase(void)
 
 	soc = of_find_node_by_type(NULL, "soc");
 	if (soc) {
-		unsigned int size;
-		const void *prop = of_get_property(soc, "reg", &size);
+		int size;
+		u32 naddr;
+		const u32 *prop = of_get_property(soc, "#address-cells", &size);
+
+		if (prop && size == 4)
+			naddr = *prop;
+		else
+			naddr = 2;
+
+		prop = of_get_property(soc, "ranges", &size);
+
+		if (prop && size >= 12)
+			immrbase = of_translate_address(soc, prop + naddr);
 
-		if (prop)
-			immrbase = of_translate_address(soc, prop);
 		of_node_put(soc);
 	};
 
@@ -75,16 +84,23 @@ u32 get_brgfreq(void)
 	if (brgfreq != -1)
 		return brgfreq;
 
-	node = of_find_node_by_type(NULL, "cpm");
+	node = of_find_compatible_node(NULL, NULL, "fsl,cpm1");
+	if (!node)
+		node = of_find_compatible_node(NULL, NULL, "fsl,cpm2");
+	if (!node)
+		node = of_find_node_by_type(NULL, "cpm");
 	if (node) {
-		unsigned int size;
-		const unsigned int *prop = of_get_property(node,
-					"brg-frequency", &size);
+		int size;
+		const unsigned int *prop;
 
-		if (prop)
+		prop = of_get_property(node, "fsl,brg-frequency", &size);
+		if (!prop)
+			prop = of_get_property(node, "brg-frequency", &size);
+		if (prop && size == 4)
 			brgfreq = *prop;
+
 		of_node_put(node);
-	};
+	}
 
 	return brgfreq;
 }
@@ -102,7 +118,7 @@ u32 get_baudrate(void)
 
 	node = of_find_node_by_type(NULL, "serial");
 	if (node) {
-		unsigned int size;
+		int size;
 		const unsigned int *prop = of_get_property(node,
 				"current-speed", &size);
 
-- 
1.5.0.3
