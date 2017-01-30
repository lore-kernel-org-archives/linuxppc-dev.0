Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vBgZd5388zDqF9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 18:12:41 +1100 (AEDT)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/3] powerpc/powernv: Add support for direct mapped LPC on
 POWER9
Date: Mon, 30 Jan 2017 18:11:57 +1100
Message-Id: <20170130071157.22677-3-benh@kernel.crashing.org>
In-Reply-To: <20170130071157.22677-1-benh@kernel.crashing.org>
References: <20170130071157.22677-1-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use the new non-PCI ISA bridge support to expose the POWER9
LPC bus as direct mapped via the ISA IO port range. This
enables direct access via drivers such as 8250

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/legacy_serial.c       |  3 ++-
 arch/powerpc/platforms/powernv/opal-lpc.c | 18 +++++++++++++-----
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/legacy_serial.c b/arch/powerpc/kernel/legacy_serial.c
index bc525ea..0694d20 100644
--- a/arch/powerpc/kernel/legacy_serial.c
+++ b/arch/powerpc/kernel/legacy_serial.c
@@ -233,7 +233,8 @@ static int __init add_legacy_isa_port(struct device_node *np,
 	 *
 	 * Note: Don't even try on P8 lpc, we know it's not directly mapped
 	 */
-	if (!of_device_is_compatible(isa_brg, "ibm,power8-lpc")) {
+	if (!of_device_is_compatible(isa_brg, "ibm,power8-lpc") ||
+	    of_get_property(isa_brg, "ranges", NULL)) {
 		taddr = of_translate_address(np, reg);
 		if (taddr == OF_BAD_ADDR)
 			taddr = 0;
diff --git a/arch/powerpc/platforms/powernv/opal-lpc.c b/arch/powerpc/platforms/powernv/opal-lpc.c
index 2048ce7..1a8cd54 100644
--- a/arch/powerpc/platforms/powernv/opal-lpc.c
+++ b/arch/powerpc/platforms/powernv/opal-lpc.c
@@ -407,9 +407,17 @@ void opal_lpc_init(void)
 	if (opal_lpc_chip_id < 0)
 		return;
 
-	/* Setup special IO ops */
-	ppc_pci_io = opal_lpc_io;
-	isa_io_special = true;
-
-	pr_info("OPAL: Power8 LPC bus found, chip ID %d\n", opal_lpc_chip_id);
+	/* Does it support direct mapping ? */
+	if (of_get_property(np, "ranges", NULL)) {
+		pr_info("OPAL: Found memory mapped LPC bus on chip %d\n",
+			opal_lpc_chip_id);
+		isa_bridge_init_non_pci(np);
+	} else {
+		pr_info("OPAL: Found non-mapped LPC bus on chip %d\n",
+			opal_lpc_chip_id);
+
+		/* Setup special IO ops */
+		ppc_pci_io = opal_lpc_io;
+		isa_io_special = true;
+	}
 }
-- 
2.9.3
