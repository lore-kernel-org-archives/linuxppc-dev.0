Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id AE157DDEE8
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Apr 2009 04:35:20 +1000 (EST)
Date: Fri, 24 Apr 2009 11:35:18 -0700
From: Ira Snyder <iws@ovro.caltech.edu>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fsldma: use PCI Read Multiple command
Message-ID: <20090424183517.GB23140@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, Dan Williams <dan.j.williams@intel.com>,
	Li Yang <leoli@freescale.com>, Zhang Wei <wei.zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

By default, the Freescale 83xx DMA controller uses the PCI Read Line
command when reading data over the PCI bus. Setting the controller to use
the PCI Read Multiple command instead allows the controller to read much
larger bursts of data, which provides a drastic speed increase.

The slowdown due to using PCI Read Line was only observed when a PCI-to-PCI
bridge was between the devices trying to communicate.

A simple test driver showed an increase from 4MB/sec to 116MB/sec when
performing DMA over the PCI bus. Using DMA to transfer between blocks of
local SDRAM showed no change in performance with this patch. The dmatest
driver was also used to verify the correctness of the transfers, and showed
no errors.

Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
---
 drivers/dma/fsldma.c |    5 +++--
 drivers/dma/fsldma.h |    1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index da8a8ed..638d00e 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -49,9 +49,10 @@ static void dma_init(struct fsl_dma_chan *fsl_chan)
 	case FSL_DMA_IP_83XX:
 		/* Set the channel to below modes:
 		 * EOTIE - End-of-transfer interrupt enable
+		 * PRC_RM - PCI read multiple
 		 */
-		DMA_OUT(fsl_chan, &fsl_chan->reg_base->mr, FSL_DMA_MR_EOTIE,
-				32);
+		DMA_OUT(fsl_chan, &fsl_chan->reg_base->mr, FSL_DMA_MR_EOTIE
+				| FSL_DMA_MR_PRC_RM, 32);
 		break;
 	}
 
diff --git a/drivers/dma/fsldma.h b/drivers/dma/fsldma.h
index 4f21a51..dc7f268 100644
--- a/drivers/dma/fsldma.h
+++ b/drivers/dma/fsldma.h
@@ -38,6 +38,7 @@
 
 /* Special MR definition for MPC8349 */
 #define FSL_DMA_MR_EOTIE	0x00000080
+#define FSL_DMA_MR_PRC_RM	0x00000800
 
 #define FSL_DMA_SR_CH		0x00000020
 #define FSL_DMA_SR_PE		0x00000010
-- 
1.5.4.3
