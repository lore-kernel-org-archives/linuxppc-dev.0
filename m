Return-Path: <alistair@popple.id.au>
Received: from ipmail06.adl6.internode.on.net (ipmail06.adl6.internode.on.net
 [IPv6:2001:44b8:8060:ff02:300:1:6:6])
 by ozlabs.org (Postfix) with ESMTP id 0DBEC2C00ED
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 May 2013 10:42:13 +1000 (EST)
References: <1368057988-7353-1-git-send-email-alistair@popple.id.au>
Message-ID: <cone.1368060133.955601.31795.1000@mexican>
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: Update currituck pci/usb fixup for new board
 revision
Date: Thu, 09 May 2013 10:42:13 +1000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The currituck board uses a different IRQ for the pci usb host
controller depending on the board revision. This patch adds support
for newer board revisions by retrieving the board revision from the
FPGA and mapping the appropriate IRQ.

Signed-off-by: Alistair Popple <alistair@popple.id.au>
---

Sorry - I had forgotten to commit a minor fix to the device tree
changes in the last patch. Corrected patch below.

 arch/powerpc/boot/dts/currituck.dts    |    5 ++++
 arch/powerpc/platforms/44x/currituck.c |   39 ++++++++++++++++++++++++++++++--
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/currituck.dts b/arch/powerpc/boot/dts/currituck.dts
index b801dd0..d2c8a87 100644
--- a/arch/powerpc/boot/dts/currituck.dts
+++ b/arch/powerpc/boot/dts/currituck.dts
@@ -103,6 +103,11 @@
 				interrupts = <34 2>;
 			};

+			FPGA0: fpga@50000000 {
+				compatible = "ibm,currituck-fpga";
+				reg = <0x50000000 0x4>;
+			};
+
 			IIC0: i2c@00000000 {
 				compatible = "ibm,iic-currituck", "ibm,iic";
 				reg = <0x0 0x00000014>;
diff --git a/arch/powerpc/platforms/44x/currituck.c b/arch/powerpc/platforms/44x/currituck.c
index ecd3890..c52e1b3 100644
--- a/arch/powerpc/platforms/44x/currituck.c
+++ b/arch/powerpc/platforms/44x/currituck.c
@@ -176,13 +176,48 @@ static int __init ppc47x_probe(void)
 	return 1;
 }

+static int board_rev = -1;
+static int __init ppc47x_get_board_rev(void)
+{
+	u8 fpga_reg0;
+	void *fpga;
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "ibm,currituck-fpga");
+	if (!np)
+		goto fail;
+
+	fpga = of_iomap(np, 0);
+	of_node_put(np);
+	if (!fpga)
+		goto fail;
+
+	fpga_reg0 = ioread8(fpga);
+	board_rev = fpga_reg0 & 0x03;
+	pr_info("%s: Found board revision %d\n", __func__, board_rev);
+	iounmap(fpga);
+	return 0;
+
+fail:
+	pr_info("%s: Unable to find board revision\n", __func__);
+	return 0;
+}
+machine_arch_initcall(ppc47x, ppc47x_get_board_rev);
+
 /* Use USB controller should have been hardware swizzled but it wasn't :( */
 static void ppc47x_pci_irq_fixup(struct pci_dev *dev)
 {
 	if (dev->vendor == 0x1033 && (dev->device == 0x0035 ||
 	                              dev->device == 0x00e0)) {
-		dev->irq = irq_create_mapping(NULL, 47);
-		pr_info("%s: Mapping irq 47 %d\n", __func__, dev->irq);
+		if (board_rev == 0) {
+			dev->irq = irq_create_mapping(NULL, 47);
+			pr_info("%s: Mapping irq %d\n", __func__, dev->irq);
+		} else if (board_rev == 2) {
+			dev->irq = irq_create_mapping(NULL, 49);
+			pr_info("%s: Mapping irq %d\n", __func__, dev->irq);
+		} else {
+			pr_alert("%s: Unknown board revision\n", __func__);
+		}
 	}
 }

-- 
1.7.10.4
