Return-Path: <B35336@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe001.messaging.microsoft.com [65.55.88.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DA113B7018
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2012 20:05:00 +1100 (EST)
Received: from mail171-tx2 (localhost [127.0.0.1])	by
 mail171-tx2-R.bigfish.com (Postfix) with ESMTP id 304161404DC	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2012 09:04:58 +0000 (UTC)
Received: from TX2EHSMHS015.bigfish.com (unknown [10.9.14.244])	by
 mail171-tx2.bigfish.com (Postfix) with ESMTP id 4157812022A	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2012 09:04:56 +0000 (UTC)
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 6/9] powerpc/mpc8548cds: Add FPGA node to dts
Date: Tue, 6 Mar 2012 17:06:42 +0800
Message-ID: <1331024805-15926-5-git-send-email-chenhui.zhao@freescale.com>
In-Reply-To: <1331024805-15926-1-git-send-email-chenhui.zhao@freescale.com>
References: <1331024805-15926-1-git-send-email-chenhui.zhao@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: chenhui zhao <chenhui.zhao@freescale.com>

Remove FPGA(CADMUS) macros in code. Move it to dts.

Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/boot/dts/mpc8548cds.dts      |    8 ++++-
 arch/powerpc/platforms/85xx/mpc85xx_cds.c |   50 +++++++++++++++++++---------
 2 files changed, 41 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8548cds.dts b/arch/powerpc/boot/dts/mpc8548cds.dts
index 8d4df8e..0683983 100644
--- a/arch/powerpc/boot/dts/mpc8548cds.dts
+++ b/arch/powerpc/boot/dts/mpc8548cds.dts
@@ -35,7 +35,8 @@
 	lbc: localbus@e0005000 {
 		reg = <0 0xe0005000 0 0x1000>;
 
-		ranges = <0x0 0x0 0x0 0xff000000 0x01000000>;
+		ranges = <0x0 0x0 0x0 0xff000000 0x01000000
+			  0x1 0x0 0x0 0xf8004000 0x00001000>;
 
 		nor@0,0 {
 			#address-cells = <1>;
@@ -72,6 +73,11 @@
 				read-only;
 			};
 		};
+
+		board-control@1,0 {
+			compatible = "fsl,mpc8548cds-fpga";
+			reg = <0x1 0x0 0x1000>;
+		};
 	};
 
 	soc: soc8548@e0000000 {
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
index c009c5b..a600dd0 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -48,17 +48,24 @@
 
 #include "mpc85xx.h"
 
-/* CADMUS info */
-/* xxx - galak, move into device tree */
-#define CADMUS_BASE (0xf8004000)
-#define CADMUS_SIZE (256)
-#define CM_VER	(0)
-#define CM_CSR	(1)
-#define CM_RST	(2)
-
+/*
+ * The CDS board contains an FPGA/CPLD called "Cadmus", which collects
+ * various logic and performs system control functions.
+ * Here is the FPGA/CPLD register map.
+ */
+struct cadmus_reg {
+	u8 cm_ver;		/* Board version */
+	u8 cm_csr;		/* General control/status */
+	u8 cm_rst;		/* Reset control */
+	u8 cm_hsclk;	/* High speed clock */
+	u8 cm_hsxclk;	/* High speed clock extended */
+	u8 cm_led;		/* LED data */
+	u8 cm_pci;		/* PCI control/status */
+	u8 cm_dma;		/* DMA control */
+	u8 res[248];	/* Total 256 bytes */
+};
 
-static int cds_pci_slot = 2;
-static volatile u8 *cadmus;
+static struct cadmus_reg *cadmus;
 
 #ifdef CONFIG_PCI
 
@@ -274,20 +281,30 @@ machine_device_initcall(mpc85xx_cds, mpc85xx_cds_8259_attach);
  */
 static void __init mpc85xx_cds_setup_arch(void)
 {
-#ifdef CONFIG_PCI
 	struct device_node *np;
-#endif
+	int cds_pci_slot;
 
 	if (ppc_md.progress)
 		ppc_md.progress("mpc85xx_cds_setup_arch()", 0);
 
-	cadmus = ioremap(CADMUS_BASE, CADMUS_SIZE);
-	cds_pci_slot = ((cadmus[CM_CSR] >> 6) & 0x3) + 1;
+	np = of_find_compatible_node(NULL, NULL, "fsl,mpc8548cds-fpga");
+	if (!np) {
+		pr_err("Could not find FPGA node.\n");
+		return;
+	}
+
+	cadmus = of_iomap(np, 0);
+	of_node_put(np);
+	if (!cadmus) {
+		pr_err("Fail to map FPGA area.\n");
+		return;
+	}
 
 	if (ppc_md.progress) {
 		char buf[40];
+		cds_pci_slot = ((in_8(&cadmus->cm_csr) >> 6) & 0x3) + 1;
 		snprintf(buf, 40, "CDS Version = 0x%x in slot %d\n",
-				cadmus[CM_VER], cds_pci_slot);
+				in_8(&cadmus->cm_ver), cds_pci_slot);
 		ppc_md.progress(buf, 0);
 	}
 
@@ -317,7 +334,8 @@ static void mpc85xx_cds_show_cpuinfo(struct seq_file *m)
 	svid = mfspr(SPRN_SVR);
 
 	seq_printf(m, "Vendor\t\t: Freescale Semiconductor\n");
-	seq_printf(m, "Machine\t\t: MPC85xx CDS (0x%x)\n", cadmus[CM_VER]);
+	seq_printf(m, "Machine\t\t: MPC85xx CDS (0x%x)\n",
+			in_8(&cadmus->cm_ver));
 	seq_printf(m, "PVR\t\t: 0x%x\n", pvid);
 	seq_printf(m, "SVR\t\t: 0x%x\n", svid);
 
-- 
1.6.4.1
