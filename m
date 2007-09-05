Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 70E81DDE3B
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Sep 2007 05:13:23 +1000 (EST)
Date: Wed, 5 Sep 2007 14:13:13 -0500
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH 1/3] CPM: Change from fsl, brg-frequency to brg/clock-frequency
Message-ID: <20070905191313.GA31927@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
This patch applies on top of Kumar's tree.

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
index 63e2350..3ea35fe 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -81,22 +81,26 @@ static u32 brgfreq = -1;
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
+
+		of_node_put(node);
+		return brgfreq;
+	}
 
-		prop = of_get_property(node, "fsl,brg-frequency", &size);
-		if (!prop)
-			prop = of_get_property(node, "brg-frequency", &size);
+	/* Legacy device binding -- will go away when no users are left. */
+	node = of_find_node_by_type(NULL, "cpm");
+	if (node) {
+		prop = of_get_property(node, "brg-frequency", &size);
 		if (prop && size == 4)
 			brgfreq = *prop;
 
-- 
1.5.3
