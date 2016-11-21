Return-Path: <Yanjiang.Jin@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tMgy41bNdzDvhx
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 19:00:27 +1100 (AEDT)
From: <yanjiang.jin@windriver.com>
To: <mark.rutland@arm.com>, <benh@kernel.crashing.org>, <leoli@freescale.com>,
 <zw@zh-kernel.org>
CC: <dmaengine@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <devicetree@vger.kernel.org>, <yanjiang.jin@windriver.com>,
 <linux-kernel@vger.kernel.org>, <jinyanjiang@gmail.com>
Subject: [PATCH] fsldma: t4240qds: drop "SG" CAP for DMA3
Date: Mon, 21 Nov 2016 12:52:49 +0800
Message-ID: <1479703969-15413-1-git-send-email-yanjiang.jin@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Yanjiang Jin <yanjiang.jin@windriver.com>

T4240QDS DMA controller uses the external DMA control signals to start or
restart a paused DMA transfer, acknowledge a DMA transfer in progress and
also indicates a transfer completion.
"scatterlist copy" depends on these signals.

But as "T4240 Reference Manual" shown:
"The external DMA control signals are available on DMA1 and DMA2. They are
 not supported by DMA3."

So add an of_node property "fsl,external-dma-control-signals" to only DMA1
and DMA2, it can prevent DMA3 from doing DMA_SG operations. Else we would
get the below errors during doing dmatest:

modprobe dmatest run=1 iterations=42

dmatest: Started 1 threads using dma2chan0
fsl-elo-dma ffe102300.dma: chan0: Transfer Error!
fsl-elo-dma ffe102300.dma: chan0: irq: unhandled sr 0x00000080
dmatest: dma2chan0-sg0: dstbuf[0x3954] not copied! Expected d8, got 2b
........................
dmatest: dma2chan7-sg0: dstbuf[0x1c51] not copied! Expected df, got 2e
dmatest: dma2chan7-sg0: 1301 errors suppressed
dmatest: dma2chan7-sg0: result #42: 'data error' with
src_off=0xf21 dst_off=0x1c32 len=0x535 (1333)
dmatest: dma2chan7-sg0: summary 42 tests, 42 failures 2952 iops 23968 KB/s

Signed-off-by: Yanjiang Jin <yanjiang.jin@windriver.com>
---
 arch/powerpc/boot/dts/fsl/t4240si-post.dtsi |  6 ++++++
 drivers/dma/fsldma.c                        | 11 +++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
index 68c4ead..155997d 100644
--- a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
@@ -1029,7 +1029,13 @@
 	};
 
 /include/ "elo3-dma-0.dtsi"
+	dma@100300 {
+		fsl,external-dma-control-signals;
+	};
 /include/ "elo3-dma-1.dtsi"
+	dma@101300 {
+		fsl,external-dma-control-signals;
+	};
 /include/ "elo3-dma-2.dtsi"
 
 /include/ "qoriq-espi-0.dtsi"
diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 51c75bf..f7054f4 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1354,12 +1354,19 @@ static int fsldma_of_probe(struct platform_device *op)
 	fdev->irq = irq_of_parse_and_map(op->dev.of_node, 0);
 
 	dma_cap_set(DMA_MEMCPY, fdev->common.cap_mask);
-	dma_cap_set(DMA_SG, fdev->common.cap_mask);
+
 	dma_cap_set(DMA_SLAVE, fdev->common.cap_mask);
+
+	if (of_get_property(op->dev.of_node,
+		"fsl,external-dma-control-signals", NULL)) {
+		dma_cap_set(DMA_SG, fdev->common.cap_mask);
+		fdev->common.device_prep_dma_sg = fsl_dma_prep_sg;
+	} else
+		dma_cap_clear(DMA_SG, fdev->common.cap_mask);
+
 	fdev->common.device_alloc_chan_resources = fsl_dma_alloc_chan_resources;
 	fdev->common.device_free_chan_resources = fsl_dma_free_chan_resources;
 	fdev->common.device_prep_dma_memcpy = fsl_dma_prep_memcpy;
-	fdev->common.device_prep_dma_sg = fsl_dma_prep_sg;
 	fdev->common.device_tx_status = fsl_tx_status;
 	fdev->common.device_issue_pending = fsl_dma_memcpy_issue_pending;
 	fdev->common.device_config = fsl_dma_device_config;
-- 
1.9.1
