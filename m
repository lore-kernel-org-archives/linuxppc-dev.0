Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id C6D6DDE11A
	for <linuxppc-dev@ozlabs.org>; Sat, 16 May 2009 04:33:23 +1000 (EST)
Date: Fri, 15 May 2009 11:33:20 -0700
From: Ira Snyder <iws@ovro.caltech.edu>
To: Dan Williams <dan.j.williams@intel.com>, Li Yang <leoli@freescale.com>,
	linuxppc-dev@ozlabs.org
Subject: [PATCH] fsldma: snooping is not enabled for last entry in
	descriptor chain
Message-ID: <20090515183320.GB858@ovro.caltech.edu>
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

On the 83xx controller, snooping is necessary for the DMA controller to
ensure cache coherence with the CPU when transferring to/from RAM.

The last descriptor in a chain will always have the End-of-Chain interrupt
bit set, so we can set the snoop bit while adding the End-of-Chain
interrupt bit.

Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
---

While working on adding the DMA_SLAVE feature, I noticed that the last
descriptor in a chain does not have the snoop bits enabled.

This is easily verified by doing the following:
1) set FSL_DMA_BCR_MAX_CNT = (1 << 18)
2) #define DEBUG 1
3) #define FSL_DMA_LD_DEBUG 1
4) setup a 1MB memcpy operation

The memcpy must be set up on an idle channel, and must be submitted
without any other transactions. dma_async_memcpy_issue_pending() must be
called without queueing any more transactions. You will see that the
snoop bit (bit 4) is not set in the last descriptor.

 drivers/dma/fsldma.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 4264c98..dba0b58 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -179,9 +179,14 @@ static void dma_halt(struct fsl_dma_chan *fsl_chan)
 static void set_ld_eol(struct fsl_dma_chan *fsl_chan,
 			struct fsl_desc_sw *desc)
 {
+	u64 snoop_bits;
+
+	snoop_bits = ((fsl_chan->feature & FSL_DMA_IP_MASK) == FSL_DMA_IP_83XX)
+		? FSL_DMA_SNEN : 0;
+
 	desc->hw.next_ln_addr = CPU_TO_DMA(fsl_chan,
-		DMA_TO_CPU(fsl_chan, desc->hw.next_ln_addr, 64)	| FSL_DMA_EOL,
-		64);
+		DMA_TO_CPU(fsl_chan, desc->hw.next_ln_addr, 64) | FSL_DMA_EOL
+			| snoop_bits, 64);
 }
 
 static void append_ld_queue(struct fsl_dma_chan *fsl_chan,
-- 
1.5.4.3
