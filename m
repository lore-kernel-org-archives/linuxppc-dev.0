Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 061BEDDE28
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Sep 2007 02:58:08 +1000 (EST)
Date: Mon, 17 Sep 2007 11:57:28 -0500
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH 01/28] CPM: Change from fsl,brg-frequency to
	brg/clock-frequency
Message-ID: <20070917165728.GA6563@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070917165643.GA6545@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

As suggested by David Gibson, now that we have a separate node
for the baud rate generators, it's better to use the standard
clock-frequency property than a cpm-node-level fsl,brg-frequency
property.

This patch updates existing places where fsl,brg-frequency is
used.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/cuboot-8xx.c |    8 +++++---
 arch/powerpc/boot/cuboot-pq2.c |    8 +++++---
 arch/powerpc/sysdev/fsl_soc.c  |   24 ++++++++++++++----------
 3 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/boot/cuboot-8xx.c b/arch/powerpc/boot/cuboot-8xx.c
index 88ed840..0e82015 100644
--- a/arch/powerpc/boot/cuboot-8xx.c
+++ b/arch/powerpc/boot/cuboot-8xx.c
@@ -29,10 +29,12 @@ static void platform_fixups(void)
 	dt_fixup_cpu_clocks(bd.bi_intfreq, bd.bi_busfreq / 16, bd.bi_busfreq);
 
 	node = finddevice("/soc/cpm");
-	if (node) {
+	if (node)
 		setprop(node, "clock-frequency", &bd.bi_busfreq, 4);
-		setprop(node, "fsl,brg-frequency", &bd.bi_busfreq, 4);
-	}
+
+	node = finddevice("/soc/cpm/brg");
+	if (node)
+		setprop(node, "clock-frequency",  &bd.bi_busfreq, 4);
 }
 
 void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
diff --git a/arch/powerpc/boot/cuboot-pq2.c b/arch/powerpc/boot/cuboot-pq2.c
index 8021fd4..b150bd4 100644
--- a/arch/powerpc/boot/cuboot-pq2.c
+++ b/arch/powerpc/boot/cuboot-pq2.c
@@ -264,10 +264,12 @@ static void pq2_platform_fixups(void)
 	dt_fixup_cpu_clocks(bd.bi_intfreq, bd.bi_busfreq / 4, bd.bi_busfreq);
 
 	node = finddevice("/soc/cpm");
-	if (node) {
+	if (node)
 		setprop(node, "clock-frequency", &bd.bi_cpmfreq, 4);
-		setprop(node, "fsl,brg-frequency", &bd.bi_brgfreq, 4);
-	}
+
+	node = finddevice("/soc/cpm/brg");
+	if (node)
+		setprop(node, "clock-frequency",  &bd.bi_brgfreq, 4);
 
 	update_cs_ranges();
 	fixup_pci();
diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index d028e8d..3052366 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -73,22 +73,26 @@ static u32 brgfreq = -1;
 u32 get_brgfreq(void)
 {
 	struct device_node *node;
+	const unsigned int *prop;
+	int size;
 
 	if (brgfreq != -1)
 		return brgfreq;
 
-	node = of_find_compatible_node(NULL, NULL, "fsl,cpm1");
-	if (!node)
-		node = of_find_compatible_node(NULL, NULL, "fsl,cpm2");
-	if (!node)
-		node = of_find_node_by_type(NULL, "cpm");
+	node = of_find_compatible_node(NULL, NULL, "fsl,cpm-brg");
 	if (node) {
-		int size;
-		const unsigned int *prop;
+		prop = of_get_property(node, "clock-frequency", &size);
+		if (prop && size == 4)
+			brgfreq = *prop;
 
-		prop = of_get_property(node, "fsl,brg-frequency", &size);
-		if (!prop)
-			prop = of_get_property(node, "brg-frequency", &size);
+		of_node_put(node);
+		return brgfreq;
+	}
+
+	/* Legacy device binding -- will go away when no users are left. */
+	node = of_find_node_by_type(NULL, "cpm");
+	if (node) {
+		prop = of_get_property(node, "brg-frequency", &size);
 		if (prop && size == 4)
 			brgfreq = *prop;
 
-- 
1.5.3.1
