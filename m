Return-Path: <gsi@denx.de>
From: Gerhard Sittig <gsi@denx.de>
To: linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org,
 Alexander Popov <a13xp0p0v88@gmail.com>
Subject: [PATCH RFC 5/8] dma: mpc512x: use symbolic specifiers for DMA channels
Date: Fri, 12 Jul 2013 17:26:18 +0200
Message-Id: <1373642781-32631-6-git-send-email-gsi@denx.de>
In-Reply-To: <1373642781-32631-1-git-send-email-gsi@denx.de>
References: <1373642781-32631-1-git-send-email-gsi@denx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Arnd Bergmann <arnd@arndb.de>,
 Vinod Koul <vinod.koul@intel.com>, Gerhard Sittig <gsi@denx.de>,
 Dan Williams <djbw@fb.com>, Anatolij Gustschin <agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

for the DMA controller of the MPC512x SoC, DMA channels directly
correspond to specific peripherals, since requester lines directly map
to channels while no additional flexibility or mapping is involved

introduce a dt-bindings header file for MPC512x DMA channels, and make
the shared DT specs in the mpc5121.dtsi as well as the DMA engine driver
use those names instead of numbers

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 arch/powerpc/boot/dts/mpc5121.dtsi    |    6 +++++-
 drivers/dma/mpc512x_dma.c             |    6 ++++--
 include/dt-bindings/dma/mpc512x-dma.h |   21 +++++++++++++++++++++
 3 files changed, 30 insertions(+), 3 deletions(-)
 create mode 100644 include/dt-bindings/dma/mpc512x-dma.h

diff --git a/arch/powerpc/boot/dts/mpc5121.dtsi b/arch/powerpc/boot/dts/mpc5121.dtsi
index bd14c00..384e692 100644
--- a/arch/powerpc/boot/dts/mpc5121.dtsi
+++ b/arch/powerpc/boot/dts/mpc5121.dtsi
@@ -9,6 +9,8 @@
  * option) any later version.
  */
 
+#include <dt-bindings/dma/mpc512x-dma.h>
+
 /dts-v1/;
 
 / {
@@ -152,7 +154,7 @@
 			compatible = "fsl,mpc5121-sdhc";
 			reg = <0x1500 0x100>;
 			interrupts = <8 0x8>;
-			dmas = <&dma0 30>;
+			dmas = <&dma0 MPC512x_DMACHAN_SDHC>;
 			dma-names = "rx-tx";
 		};
 
@@ -262,6 +264,8 @@
 		lpc@10000 {
 			compatible = "fsl,mpc5121-lpc";
 			reg = <0x10000 0x200>;
+			dmas = <&dma0 MPC512x_DMACHAN_SCLPC>;
+			dma-names = "rx-tx";
 		};
 
 		pata@10200 {
diff --git a/drivers/dma/mpc512x_dma.c b/drivers/dma/mpc512x_dma.c
index 0053ff8..8f6d545 100644
--- a/drivers/dma/mpc512x_dma.c
+++ b/drivers/dma/mpc512x_dma.c
@@ -29,6 +29,8 @@
  * file called COPYING.
  */
 
+#include <dt-bindings/dma/mpc512x-dma.h>
+
 #include <linux/module.h>
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
@@ -257,7 +259,7 @@ static void mpc_dma_execute(struct mpc_dma_chan *mchan)
 		prev->tcd->dlast_sga = mdesc->tcd_paddr;
 		prev->tcd->e_sg = 1;
 		/* only start explicitly on MDDRC channel */
-		if (cid == 32)
+		if (cid == MPC512x_DMACHAN_MDDRC)
 			mdesc->tcd->start = 1;
 
 		prev = mdesc;
@@ -276,7 +278,7 @@ static void mpc_dma_execute(struct mpc_dma_chan *mchan)
 		/* peripherals involved, use external request */
 		out_8(&mdma->regs->dmaserq, cid);
 		break;
-	case 32:
+	case MPC512x_DMACHAN_MDDRC:
 		/* memory transfer, software provided start signal */
 		out_8(&mdma->regs->dmassrt, cid);
 		break;
diff --git a/include/dt-bindings/dma/mpc512x-dma.h b/include/dt-bindings/dma/mpc512x-dma.h
new file mode 100644
index 0000000..56b06d1
--- /dev/null
+++ b/include/dt-bindings/dma/mpc512x-dma.h
@@ -0,0 +1,21 @@
+/*
+ * This header file provides symbolic specifiers for DMA channels
+ * within the MPC512x SoC's DMA controller.  Since requester lines
+ * directly map to channel numbers and no additional flexibility
+ * is involved, DMA channels can be considered directly associated
+ * with individual peripherals.
+ *
+ * This header file gets shared among DT bindings which provide
+ * hardware specs, and driver code which implements supporting logic.
+ */
+
+#ifndef _DT_BINDINGS_DMA_MPC512x_DMA_H
+#define _DT_BINDINGS_DMA_MPC512x_DMA_H
+
+#define MPC512x_DMACHAN_SCLPC		26
+#define MPC512x_DMACHAN_SDHC		30
+#define MPC512x_DMACHAN_MDDRC		32
+
+#define MPC512x_DMACHAN_MAX		64
+
+#endif
-- 
1.7.10.4
