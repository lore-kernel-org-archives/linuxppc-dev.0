Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sWTx072JMzDrq8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Sep 2016 19:56:20 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: dan.j.williams@intel.com, vinod.koul@intel.com, dmaengine@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org,
	arnd@arndb.de
Subject: [PATCH] drivers/dma: NO_IRQ removal from powerpc-only drivers
Date: Sat, 10 Sep 2016 19:56:04 +1000
Message-Id: <1473501364-6575-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We'd like to eventually remove NO_IRQ on powerpc, so remove usages of it
from powerpc-only drivers.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 drivers/dma/bestcomm/bestcomm.c |  4 ++--
 drivers/dma/fsl_raid.c          |  2 +-
 drivers/dma/fsldma.c            | 12 ++++++------
 drivers/dma/mpc512x_dma.c       |  4 ++--
 drivers/dma/ppc4xx/adma.c       |  4 ++--
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/bestcomm/bestcomm.c b/drivers/dma/bestcomm/bestcomm.c
index 7ce843723003..7a67b8345092 100644
--- a/drivers/dma/bestcomm/bestcomm.c
+++ b/drivers/dma/bestcomm/bestcomm.c
@@ -82,7 +82,7 @@ bcom_task_alloc(int bd_count, int bd_size, int priv_size)
 
 	/* Get IRQ of that task */
 	tsk->irq = irq_of_parse_and_map(bcom_eng->ofnode, tsk->tasknum);
-	if (tsk->irq == NO_IRQ)
+	if (!tsk->irq)
 		goto error;
 
 	/* Init the BDs, if needed */
@@ -104,7 +104,7 @@ bcom_task_alloc(int bd_count, int bd_size, int priv_size)
 
 error:
 	if (tsk) {
-		if (tsk->irq != NO_IRQ)
+		if (tsk->irq)
 			irq_dispose_mapping(tsk->irq);
 		bcom_sram_free(tsk->bd);
 		kfree(tsk->cookie);
diff --git a/drivers/dma/fsl_raid.c b/drivers/dma/fsl_raid.c
index de2a2a2b1d75..b449fbae1213 100644
--- a/drivers/dma/fsl_raid.c
+++ b/drivers/dma/fsl_raid.c
@@ -670,7 +670,7 @@ static int fsl_re_chan_probe(struct platform_device *ofdev,
 
 	/* read irq property from dts */
 	chan->irq = irq_of_parse_and_map(np, 0);
-	if (chan->irq == NO_IRQ) {
+	if (!chan->irq) {
 		dev_err(dev, "No IRQ defined for JR %d\n", q);
 		ret = -ENODEV;
 		goto err_free;
diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 911b7177eb50..4b7a66d357d2 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1153,7 +1153,7 @@ static void fsldma_free_irqs(struct fsldma_device *fdev)
 	struct fsldma_chan *chan;
 	int i;
 
-	if (fdev->irq != NO_IRQ) {
+	if (fdev->irq) {
 		dev_dbg(fdev->dev, "free per-controller IRQ\n");
 		free_irq(fdev->irq, fdev);
 		return;
@@ -1161,7 +1161,7 @@ static void fsldma_free_irqs(struct fsldma_device *fdev)
 
 	for (i = 0; i < FSL_DMA_MAX_CHANS_PER_DEVICE; i++) {
 		chan = fdev->chan[i];
-		if (chan && chan->irq != NO_IRQ) {
+		if (chan && chan->irq) {
 			chan_dbg(chan, "free per-channel IRQ\n");
 			free_irq(chan->irq, chan);
 		}
@@ -1175,7 +1175,7 @@ static int fsldma_request_irqs(struct fsldma_device *fdev)
 	int i;
 
 	/* if we have a per-controller IRQ, use that */
-	if (fdev->irq != NO_IRQ) {
+	if (fdev->irq) {
 		dev_dbg(fdev->dev, "request per-controller IRQ\n");
 		ret = request_irq(fdev->irq, fsldma_ctrl_irq, IRQF_SHARED,
 				  "fsldma-controller", fdev);
@@ -1188,7 +1188,7 @@ static int fsldma_request_irqs(struct fsldma_device *fdev)
 		if (!chan)
 			continue;
 
-		if (chan->irq == NO_IRQ) {
+		if (!chan->irq) {
 			chan_err(chan, "interrupts property missing in device tree\n");
 			ret = -ENODEV;
 			goto out_unwind;
@@ -1211,7 +1211,7 @@ out_unwind:
 		if (!chan)
 			continue;
 
-		if (chan->irq == NO_IRQ)
+		if (!chan->irq)
 			continue;
 
 		free_irq(chan->irq, chan);
@@ -1311,7 +1311,7 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
 	list_add_tail(&chan->common.device_node, &fdev->common.channels);
 
 	dev_info(fdev->dev, "#%d (%s), irq %d\n", chan->id, compatible,
-		 chan->irq != NO_IRQ ? chan->irq : fdev->irq);
+		 chan->irq ? chan->irq : fdev->irq);
 
 	return 0;
 
diff --git a/drivers/dma/mpc512x_dma.c b/drivers/dma/mpc512x_dma.c
index fa86592c7ae1..9dd99ba18fce 100644
--- a/drivers/dma/mpc512x_dma.c
+++ b/drivers/dma/mpc512x_dma.c
@@ -926,7 +926,7 @@ static int mpc_dma_probe(struct platform_device *op)
 	}
 
 	mdma->irq = irq_of_parse_and_map(dn, 0);
-	if (mdma->irq == NO_IRQ) {
+	if (!mdma->irq) {
 		dev_err(dev, "Error mapping IRQ!\n");
 		retval = -EINVAL;
 		goto err;
@@ -935,7 +935,7 @@ static int mpc_dma_probe(struct platform_device *op)
 	if (of_device_is_compatible(dn, "fsl,mpc8308-dma")) {
 		mdma->is_mpc8308 = 1;
 		mdma->irq2 = irq_of_parse_and_map(dn, 1);
-		if (mdma->irq2 == NO_IRQ) {
+		if (!mdma->irq2) {
 			dev_err(dev, "Error mapping IRQ!\n");
 			retval = -EINVAL;
 			goto err_dispose1;
diff --git a/drivers/dma/ppc4xx/adma.c b/drivers/dma/ppc4xx/adma.c
index da3688b94bdc..66bd96724b2f 100644
--- a/drivers/dma/ppc4xx/adma.c
+++ b/drivers/dma/ppc4xx/adma.c
@@ -3891,7 +3891,7 @@ static int ppc440spe_adma_setup_irqs(struct ppc440spe_adma_device *adev,
 	np = ofdev->dev.of_node;
 	if (adev->id != PPC440SPE_XOR_ID) {
 		adev->err_irq = irq_of_parse_and_map(np, 1);
-		if (adev->err_irq == NO_IRQ) {
+		if (!adev->err_irq) {
 			dev_warn(adev->dev, "no err irq resource?\n");
 			*initcode = PPC_ADMA_INIT_IRQ2;
 			adev->err_irq = -ENXIO;
@@ -3902,7 +3902,7 @@ static int ppc440spe_adma_setup_irqs(struct ppc440spe_adma_device *adev,
 	}
 
 	adev->irq = irq_of_parse_and_map(np, 0);
-	if (adev->irq == NO_IRQ) {
+	if (!adev->irq) {
 		dev_err(adev->dev, "no irq resource\n");
 		*initcode = PPC_ADMA_INIT_IRQ1;
 		ret = -ENXIO;
-- 
2.7.4
