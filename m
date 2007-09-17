Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 30972DDE29
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Sep 2007 02:58:13 +1000 (EST)
Date: Mon, 17 Sep 2007 11:57:34 -0500
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH 05/28] bootwrapper: Support all-in-one PCI nodes in cuboot-pq2.
Message-ID: <20070917165734.GE6563@loki.buserror.net>
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

Consensus was reached to put PCI nodes at the root of the tree (and not
under /soc), but the phandle to a control node was rejected in favor of
simply not worrying about /pci/reg overlapping /soc/ranges.

This updates cuboot-82xx to not look for the phandle.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/cuboot-pq2.c |   25 ++++++++-----------------
 1 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/boot/cuboot-pq2.c b/arch/powerpc/boot/cuboot-pq2.c
index e5d94ff..d78e943 100644
--- a/arch/powerpc/boot/cuboot-pq2.c
+++ b/arch/powerpc/boot/cuboot-pq2.c
@@ -126,11 +126,11 @@ static void fixup_pci(void)
 	u32 *pci_regs[3];
 	u8 *soc_regs;
 	int i, len;
-	void *ctrl_node, *bus_node, *parent_node, *soc_node;
-	u32 naddr, nsize, bus_ph, mem_log2;
+	void *node, *parent_node, *soc_node;
+	u32 naddr, nsize, mem_log2;
 
-	ctrl_node = finddevice("/soc/pci");
-	if (!ctrl_node || !dt_is_compatible(ctrl_node, "fsl,pq2-pci"))
+	node = finddevice("/pci");
+	if (!node || !dt_is_compatible(node, "fsl,pq2-pci"))
 		return;
 
 	soc_node = finddevice("/soc");
@@ -138,27 +138,18 @@ static void fixup_pci(void)
 		goto err;
 
 	for (i = 0; i < 3; i++)
-		if (!dt_xlate_reg(ctrl_node, i,
+		if (!dt_xlate_reg(node, i,
 		                  (unsigned long *)&pci_regs[i], NULL))
 			goto err;
 
 	if (!dt_xlate_reg(soc_node, 0, (unsigned long *)&soc_regs, NULL))
 		goto err;
 
-	len = getprop(ctrl_node, "fsl,bus", &bus_ph, 4);
-	if (len != 4)
-		goto err;
-
-	bus_node = find_node_by_prop_value(NULL, "linux,phandle",
-	                                   (char *)&bus_ph, 4);
-	if (!bus_node)
-		goto err;
-
-	dt_get_reg_format(bus_node, &naddr, &nsize);
+	dt_get_reg_format(node, &naddr, &nsize);
 	if (naddr != 3 || nsize != 2)
 		goto err;
 
-	parent_node = get_parent(bus_node);
+	parent_node = get_parent(node);
 	if (!parent_node)
 		goto err;
 
@@ -166,7 +157,7 @@ static void fixup_pci(void)
 	if (naddr != 1 || nsize != 1)
 		goto err;
 
-	len = getprop(bus_node, "ranges", pci_ranges_buf,
+	len = getprop(node, "ranges", pci_ranges_buf,
 	              sizeof(pci_ranges_buf));
 
 	for (i = 0; i < len / sizeof(struct pci_range); i++) {
-- 
1.5.3.1
