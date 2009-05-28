Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 3366ADDFC1
	for <linuxppc-dev@ozlabs.org>; Fri, 29 May 2009 05:20:45 +1000 (EST)
Date: Thu, 28 May 2009 12:20:42 -0700
From: Ira Snyder <iws@ovro.caltech.edu>
To: linuxppc-dev@ozlabs.org, Li Yang <leoli@freescale.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH] fsldma: enable external start for the 83xx controller
Message-ID: <20090528192042.GB25993@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The 83xx controller has external start capability, but lacks external pause
capability. Hook up the external start function pointer for the 83xx
controller.

Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
---

Though there is no way to enable external start in the mainline driver,
the DMA_SLAVE patch I posted last week does give the ability to enable
external start.

I have tested this patch along with the DMA_SLAVE patch using a driver
for some custom hardware that uses the external DMA control lines.

 drivers/dma/fsldma.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index db07113..b2fd35e 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1099,9 +1099,9 @@ static int __devinit fsl_dma_chan_probe(struct fsl_dma_device *fdev,
 
 	switch (new_fsl_chan->feature & FSL_DMA_IP_MASK) {
 	case FSL_DMA_IP_85XX:
-		new_fsl_chan->toggle_ext_start = fsl_chan_toggle_ext_start;
 		new_fsl_chan->toggle_ext_pause = fsl_chan_toggle_ext_pause;
 	case FSL_DMA_IP_83XX:
+		new_fsl_chan->toggle_ext_start = fsl_chan_toggle_ext_start;
 		new_fsl_chan->set_src_loop_size = fsl_chan_set_src_loop_size;
 		new_fsl_chan->set_dest_loop_size = fsl_chan_set_dest_loop_size;
 	}
-- 
1.5.4.3
