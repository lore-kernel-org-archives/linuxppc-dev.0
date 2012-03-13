Return-Path: <vinod.koul@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by ozlabs.org (Postfix) with ESMTP id D56BEB6F62
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Mar 2012 19:45:11 +1100 (EST)
Subject: Re: [PATCH v2 0/9] DMA engine cookie handling cleanups
From: Vinod Koul <vinod.koul@intel.com>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
In-Reply-To: <1331569438.1727.3.camel@vkoul-udesk3>
References: <20120306223321.GD15201@n2100.arm.linux.org.uk>
 <1331128466.24656.421.camel@vkoul-udesk3>
 <20120312161143.GA10830@n2100.arm.linux.org.uk>
 <1331569438.1727.3.camel@vkoul-udesk3>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 13 Mar 2012 14:10:36 +0530
Message-ID: <1331628036.1727.22.camel@vkoul-udesk3>
Mime-Version: 1.0
Cc: Stephen Warren <swarren@nvidia.com>,
 Linus Walleij <linus.walleij@stericsson.com>,
 Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>,
 Barry Song <baohua.song@csr.com>, Dan Williams <dan.j.williams@intel.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-03-12 at 21:53 +0530, Vinod Koul wrote:
> > > I applied the v2 on a branch and also rebased on top of
> slave-dma.next.
> > > There were few conflicts in imx-dma.c. Sacha, Javier, pls see that
> merge
> > > is right.
> > > 
> > > This branch (rmk_cookie_fixes2_rebased) is not yet pushed, as I am
> not
> > > able to connect to infradead.org, should be done when server is
> back.
> > 
> > Are you going to pick up Shawn Guo's tested-by for these patches, or
> are
> > we saying its too late for that now?
> Sure, his and others we have received on this series.
> Also, IIRC there was one fixup from Jassi on pl330?
> 
> I should be able to merge this tomorrow, if thats fine with you. 
I have merged this to my next, but haven't pushed out yet. This is
available on branch next_cookie2_merge.
Also I got few (more than expected build failures) and a merge issue on
imx driver. Sascha, Russell can you see if fix on imx is right

Please see if the below patch is the right fix for build failures in
addition to one suggested by Jassi.

-------------------x-------------------------x----------------------

>From 949ff5b8d46b5e3435d21b2651ce3a2599208d44 Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@linux.intel.com>
Date: Tue, 13 Mar 2012 11:58:12 +0530
Subject: [PATCH] dmaengine: fix for cookie changes and merge

Fixed trivial issues in drivers:
	drivers/dma/imx-sdma.c
	drivers/dma/intel_mid_dma.c
	drivers/dma/ioat/dma_v3.c
	drivers/dma/iop-adma.c
	drivers/dma/sirf-dma.c
	drivers/dma/timb_dma.c

Signed-off-by: Vinod Koul <vinod.koul@linux.intel.com>
---
 drivers/dma/imx-sdma.c      |    1 +
 drivers/dma/intel_mid_dma.c |    1 +
 drivers/dma/ioat/dma_v3.c   |    1 +
 drivers/dma/iop-adma.c      |    1 +
 drivers/dma/sirf-dma.c      |    2 ++
 drivers/dma/timb_dma.c      |    6 +-----
 6 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index ccfc7c4..81f9d57 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1127,6 +1127,7 @@ static void sdma_issue_pending(struct dma_chan *chan)
 	struct sdma_engine *sdma = sdmac->sdma;
 
 	if (sdmac->status == DMA_IN_PROGRESS)
+		sdma_enable_channel(sdma, sdmac->channel);
 }
 
 #define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V1	34
diff --git a/drivers/dma/intel_mid_dma.c b/drivers/dma/intel_mid_dma.c
index d599d96..2449812 100644
--- a/drivers/dma/intel_mid_dma.c
+++ b/drivers/dma/intel_mid_dma.c
@@ -477,6 +477,7 @@ static enum dma_status intel_mid_dma_tx_status(struct dma_chan *chan,
 						dma_cookie_t cookie,
 						struct dma_tx_state *txstate)
 {
+	struct intel_mid_dma_chan *midc = to_intel_mid_dma_chan(chan);
 	enum dma_status ret;
 
 	ret = dma_cookie_status(chan, cookie, txstate);
diff --git a/drivers/dma/ioat/dma_v3.c b/drivers/dma/ioat/dma_v3.c
index 145eda2..2c4476c 100644
--- a/drivers/dma/ioat/dma_v3.c
+++ b/drivers/dma/ioat/dma_v3.c
@@ -61,6 +61,7 @@
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
 #include <linux/prefetch.h>
+#include "../dmaengine.h"
 #include "registers.h"
 #include "hw.h"
 #include "dma.h"
diff --git a/drivers/dma/iop-adma.c b/drivers/dma/iop-adma.c
index 1f3a703..4499f88 100644
--- a/drivers/dma/iop-adma.c
+++ b/drivers/dma/iop-adma.c
@@ -894,6 +894,7 @@ static enum dma_status iop_adma_status(struct dma_chan *chan,
 					struct dma_tx_state *txstate)
 {
 	struct iop_adma_chan *iop_chan = to_iop_adma_chan(chan);
+	int ret;
 
 	ret = dma_cookie_status(chan, cookie, txstate);
 	if (ret == DMA_SUCCESS)
diff --git a/drivers/dma/sirf-dma.c b/drivers/dma/sirf-dma.c
index a2cde85..45ba352 100644
--- a/drivers/dma/sirf-dma.c
+++ b/drivers/dma/sirf-dma.c
@@ -18,6 +18,8 @@
 #include <linux/of_platform.h>
 #include <linux/sirfsoc_dma.h>
 
+#include "dmaengine.h"
+
 #define SIRFSOC_DMA_DESCRIPTORS                 16
 #define SIRFSOC_DMA_CHANNELS                    16
 
diff --git a/drivers/dma/timb_dma.c b/drivers/dma/timb_dma.c
index 7805996..d408c22 100644
--- a/drivers/dma/timb_dma.c
+++ b/drivers/dma/timb_dma.c
@@ -510,17 +510,13 @@ static void td_free_chan_resources(struct dma_chan *chan)
 static enum dma_status td_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 				    struct dma_tx_state *txstate)
 {
-	struct timb_dma_chan *td_chan =
-		container_of(chan, struct timb_dma_chan, chan);
 	enum dma_status ret;
 
 	dev_dbg(chan2dev(chan), "%s: Entry\n", __func__);
 
 	ret = dma_cookie_status(chan, cookie, txstate);
 
-	dev_dbg(chan2dev(chan),
-		"%s: exit, ret: %d, last_complete: %d, last_used: %d\n",
-		__func__, ret, last_complete, last_used);
+	dev_dbg(chan2dev(chan), "%s: exit, ret: %d\n", 	__func__, ret);
 
 	return ret;
 }
-- 
1.7.0.4




-- 
~Vinod
