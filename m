Return-Path: <rmk+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [IPv6:2002:4e20:1eda::1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E1597B70E7
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2012 09:38:08 +1100 (EST)
In-Reply-To: <20120306223321.GD15201@n2100.arm.linux.org.uk>
References: <20120306223321.GD15201@n2100.arm.linux.org.uk>
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Dan Williams <dan.j.williams@intel.com>,Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 3/9] dmaengine: add private header file
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <E1S52xe-0002Mn-Pn@rmk-PC.arm.linux.org.uk>
Sender: Russell King <rmk@arm.linux.org.uk>
Date: Tue, 06 Mar 2012 22:34:26 +0000
Cc: Viresh Kumar <viresh.kumar@st.com>, Stephen Warren <swarren@nvidia.com>,
 Linus Walleij <linus.walleij@stericsson.com>,
 Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add a local private header file to contain definitions and declarations
which should only be used by DMA engine drivers.

We also fix linux/dmaengine.h to use LINUX_DMAENGINE_H to guard against
multiple inclusion.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c    |    2 ++
 drivers/dma/at_hdmac.c      |    1 +
 drivers/dma/coh901318.c     |    1 +
 drivers/dma/dmaengine.h     |   10 ++++++++++
 drivers/dma/dw_dmac.c       |    1 +
 drivers/dma/ep93xx_dma.c    |    2 ++
 drivers/dma/fsldma.c        |    1 +
 drivers/dma/imx-dma.c       |    2 ++
 drivers/dma/imx-sdma.c      |    2 ++
 drivers/dma/intel_mid_dma.c |    2 ++
 drivers/dma/ioat/dma.c      |    2 ++
 drivers/dma/ioat/dma_v2.c   |    2 ++
 drivers/dma/iop-adma.c      |    2 ++
 drivers/dma/ipu/ipu_idmac.c |    1 +
 drivers/dma/mpc512x_dma.c   |    2 ++
 drivers/dma/mv_xor.c        |    2 ++
 drivers/dma/mxs-dma.c       |    2 ++
 drivers/dma/pch_dma.c       |    2 ++
 drivers/dma/pl330.c         |    2 ++
 drivers/dma/ppc4xx/adma.c   |    1 +
 drivers/dma/shdma.c         |    2 ++
 drivers/dma/ste_dma40.c     |    1 +
 drivers/dma/timb_dma.c      |    2 ++
 drivers/dma/txx9dmac.c      |    2 ++
 include/linux/dmaengine.h   |    4 ++--
 25 files changed, 51 insertions(+), 2 deletions(-)
 create mode 100644 drivers/dma/dmaengine.h

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 2b5121f..87475cb 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -85,6 +85,8 @@
 #include <linux/slab.h>
 #include <asm/hardware/pl080.h>
 
+#include "dmaengine.h"
+
 #define DRIVER_NAME	"pl08xdmac"
 
 static struct amba_driver pl08x_amba_driver;
diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 6baf5d7..ce26ba3 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -27,6 +27,7 @@
 #include <linux/of_device.h>
 
 #include "at_hdmac_regs.h"
+#include "dmaengine.h"
 
 /*
  * Glossary
diff --git a/drivers/dma/coh901318.c b/drivers/dma/coh901318.c
index 521434b..fb0d124 100644
--- a/drivers/dma/coh901318.c
+++ b/drivers/dma/coh901318.c
@@ -24,6 +24,7 @@
 #include <mach/coh901318.h>
 
 #include "coh901318_lli.h"
+#include "dmaengine.h"
 
 #define COHC_2_DEV(cohc) (&cohc->chan.dev->device)
 
diff --git a/drivers/dma/dmaengine.h b/drivers/dma/dmaengine.h
new file mode 100644
index 0000000..968570d
--- /dev/null
+++ b/drivers/dma/dmaengine.h
@@ -0,0 +1,10 @@
+/*
+ * The contents of this file are private to DMA engine drivers, and is not
+ * part of the API to be used by DMA engine users.
+ */
+#ifndef DMAENGINE_H
+#define DMAENGINE_H
+
+#include <linux/dmaengine.h>
+
+#endif
diff --git a/drivers/dma/dw_dmac.c b/drivers/dma/dw_dmac.c
index defe574..f10dbe1 100644
--- a/drivers/dma/dw_dmac.c
+++ b/drivers/dma/dw_dmac.c
@@ -22,6 +22,7 @@
 #include <linux/slab.h>
 
 #include "dw_dmac_regs.h"
+#include "dmaengine.h"
 
 /*
  * This supports the Synopsys "DesignWare AHB Central DMA Controller",
diff --git a/drivers/dma/ep93xx_dma.c b/drivers/dma/ep93xx_dma.c
index bc45787..3260198 100644
--- a/drivers/dma/ep93xx_dma.c
+++ b/drivers/dma/ep93xx_dma.c
@@ -28,6 +28,8 @@
 
 #include <mach/dma.h>
 
+#include "dmaengine.h"
+
 /* M2P registers */
 #define M2P_CONTROL			0x0000
 #define M2P_CONTROL_STALLINT		BIT(0)
diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 9b5cb8a..2ebbe57 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -35,6 +35,7 @@
 #include <linux/dmapool.h>
 #include <linux/of_platform.h>
 
+#include "dmaengine.h"
 #include "fsldma.h"
 
 #define chan_dbg(chan, fmt, arg...)					\
diff --git a/drivers/dma/imx-dma.c b/drivers/dma/imx-dma.c
index 321fc1f..51251a6 100644
--- a/drivers/dma/imx-dma.c
+++ b/drivers/dma/imx-dma.c
@@ -30,6 +30,8 @@
 #include <mach/dma-v1.h>
 #include <mach/hardware.h>
 
+#include "dmaengine.h"
+
 struct imxdma_channel {
 	struct imxdma_engine		*imxdma;
 	unsigned int			channel;
diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index e857904..9950ec3 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -42,6 +42,8 @@
 #include <mach/dma.h>
 #include <mach/hardware.h>
 
+#include "dmaengine.h"
+
 /* SDMA registers */
 #define SDMA_H_C0PTR		0x000
 #define SDMA_H_INTR		0x004
diff --git a/drivers/dma/intel_mid_dma.c b/drivers/dma/intel_mid_dma.c
index a27ae45..a907dd6 100644
--- a/drivers/dma/intel_mid_dma.c
+++ b/drivers/dma/intel_mid_dma.c
@@ -29,6 +29,8 @@
 #include <linux/intel_mid_dma.h>
 #include <linux/module.h>
 
+#include "dmaengine.h"
+
 #define MAX_CHAN	4 /*max ch across controllers*/
 #include "intel_mid_dma_regs.h"
 
diff --git a/drivers/dma/ioat/dma.c b/drivers/dma/ioat/dma.c
index fab440a..dfe411b 100644
--- a/drivers/dma/ioat/dma.c
+++ b/drivers/dma/ioat/dma.c
@@ -40,6 +40,8 @@
 #include "registers.h"
 #include "hw.h"
 
+#include "../dmaengine.h"
+
 int ioat_pending_level = 4;
 module_param(ioat_pending_level, int, 0644);
 MODULE_PARM_DESC(ioat_pending_level,
diff --git a/drivers/dma/ioat/dma_v2.c b/drivers/dma/ioat/dma_v2.c
index d3f0aff..6c1e675 100644
--- a/drivers/dma/ioat/dma_v2.c
+++ b/drivers/dma/ioat/dma_v2.c
@@ -41,6 +41,8 @@
 #include "registers.h"
 #include "hw.h"
 
+#include "../dmaengine.h"
+
 int ioat_ring_alloc_order = 8;
 module_param(ioat_ring_alloc_order, int, 0644);
 MODULE_PARM_DESC(ioat_ring_alloc_order,
diff --git a/drivers/dma/iop-adma.c b/drivers/dma/iop-adma.c
index d8027c2..650bf1e 100644
--- a/drivers/dma/iop-adma.c
+++ b/drivers/dma/iop-adma.c
@@ -36,6 +36,8 @@
 
 #include <mach/adma.h>
 
+#include "dmaengine.h"
+
 #define to_iop_adma_chan(chan) container_of(chan, struct iop_adma_chan, common)
 #define to_iop_adma_device(dev) \
 	container_of(dev, struct iop_adma_device, common)
diff --git a/drivers/dma/ipu/ipu_idmac.c b/drivers/dma/ipu/ipu_idmac.c
index 9149ade..0fcff65 100644
--- a/drivers/dma/ipu/ipu_idmac.c
+++ b/drivers/dma/ipu/ipu_idmac.c
@@ -25,6 +25,7 @@
 
 #include <mach/ipu.h>
 
+#include "../dmaengine.h"
 #include "ipu_intern.h"
 
 #define FS_VF_IN_VALID	0x00000002
diff --git a/drivers/dma/mpc512x_dma.c b/drivers/dma/mpc512x_dma.c
index 39a5cde..c56b3fe 100644
--- a/drivers/dma/mpc512x_dma.c
+++ b/drivers/dma/mpc512x_dma.c
@@ -44,6 +44,8 @@
 
 #include <linux/random.h>
 
+#include "dmaengine.h"
+
 /* Number of DMA Transfer descriptors allocated per channel */
 #define MPC_DMA_DESCRIPTORS	64
 
diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index c6a84da..ee61778 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -26,6 +26,8 @@
 #include <linux/platform_device.h>
 #include <linux/memory.h>
 #include <plat/mv_xor.h>
+
+#include "dmaengine.h"
 #include "mv_xor.h"
 
 static void mv_xor_issue_pending(struct dma_chan *chan);
diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index 3696e6e..daa84ee 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -28,6 +28,8 @@
 #include <mach/dma.h>
 #include <mach/common.h>
 
+#include "dmaengine.h"
+
 /*
  * NOTE: The term "PIO" throughout the mxs-dma implementation means
  * PIO mode of mxs apbh-dma and apbx-dma.  With this working mode,
diff --git a/drivers/dma/pch_dma.c b/drivers/dma/pch_dma.c
index 79a7185..2b3479d 100644
--- a/drivers/dma/pch_dma.c
+++ b/drivers/dma/pch_dma.c
@@ -25,6 +25,8 @@
 #include <linux/module.h>
 #include <linux/pch_dma.h>
 
+#include "dmaengine.h"
+
 #define DRV_NAME "pch-dma"
 
 #define DMA_CTL0_DISABLE		0x0
diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index bdf04f1..d7b0af2 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -21,6 +21,8 @@
 #include <linux/scatterlist.h>
 #include <linux/of.h>
 
+#include "dmaengine.h"
+
 #define NR_DEFAULT_DESC	16
 
 enum desc_status {
diff --git a/drivers/dma/ppc4xx/adma.c b/drivers/dma/ppc4xx/adma.c
index f878322..40082ec 100644
--- a/drivers/dma/ppc4xx/adma.c
+++ b/drivers/dma/ppc4xx/adma.c
@@ -46,6 +46,7 @@
 #include <asm/dcr.h>
 #include <asm/dcr-regs.h>
 #include "adma.h"
+#include "../dmaengine.h"
 
 enum ppc_adma_init_code {
 	PPC_ADMA_INIT_OK = 0,
diff --git a/drivers/dma/shdma.c b/drivers/dma/shdma.c
index ae84c12..c291433 100644
--- a/drivers/dma/shdma.c
+++ b/drivers/dma/shdma.c
@@ -30,6 +30,8 @@
 #include <linux/kdebug.h>
 #include <linux/spinlock.h>
 #include <linux/rculist.h>
+
+#include "dmaengine.h"
 #include "shdma.h"
 
 /* DMA descriptor control */
diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index cfca2a0..156b98f 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -21,6 +21,7 @@
 
 #include <plat/ste_dma40.h>
 
+#include "dmaengine.h"
 #include "ste_dma40_ll.h"
 
 #define D40_NAME "dma40"
diff --git a/drivers/dma/timb_dma.c b/drivers/dma/timb_dma.c
index a1d1559..4b61879 100644
--- a/drivers/dma/timb_dma.c
+++ b/drivers/dma/timb_dma.c
@@ -31,6 +31,8 @@
 
 #include <linux/timb_dma.h>
 
+#include "dmaengine.h"
+
 #define DRIVER_NAME "timb-dma"
 
 /* Global DMA registers */
diff --git a/drivers/dma/txx9dmac.c b/drivers/dma/txx9dmac.c
index a917b67..db6d809 100644
--- a/drivers/dma/txx9dmac.c
+++ b/drivers/dma/txx9dmac.c
@@ -15,6 +15,8 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/scatterlist.h>
+
+#include "dmaengine.h"
 #include "txx9dmac.h"
 
 static struct txx9dmac_chan *to_txx9dmac_chan(struct dma_chan *chan)
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 41d0f92..4b17ca8 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -18,8 +18,8 @@
  * The full GNU General Public License is included in this distribution in the
  * file called COPYING.
  */
-#ifndef DMAENGINE_H
-#define DMAENGINE_H
+#ifndef LINUX_DMAENGINE_H
+#define LINUX_DMAENGINE_H
 
 #include <linux/device.h>
 #include <linux/uio.h>
-- 
1.7.4.4
