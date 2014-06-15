Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0185.hostedemail.com
 [216.40.44.185])
 by lists.ozlabs.org (Postfix) with ESMTP id CE19F1A0367
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jun 2014 06:38:15 +1000 (EST)
From: Joe Perches <joe@perches.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH -next 01/26] powerpc: Use dma_zalloc_coherent
Date: Sun, 15 Jun 2014 13:37:30 -0700
Message-Id: <ceb2b3214fbb7c5ea5e356d35df4d0b38b90a41a.1402863905.git.joe@perches.com>
In-Reply-To: <cover.1402863904.git.joe@perches.com>
References: <cover.1402863904.git.joe@perches.com>
Cc: Olof Johansson <olof@lixom.net>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use the zeroing function instead of dma_alloc_coherent & memset(,0,)

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/powerpc/platforms/pasemi/dma_lib.c | 8 +++-----
 arch/powerpc/sysdev/fsl_rmu.c           | 9 ++++-----
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/platforms/pasemi/dma_lib.c b/arch/powerpc/platforms/pasemi/dma_lib.c
index aafa01ba..52b391f 100644
--- a/arch/powerpc/platforms/pasemi/dma_lib.c
+++ b/arch/powerpc/platforms/pasemi/dma_lib.c
@@ -255,15 +255,13 @@ int pasemi_dma_alloc_ring(struct pasemi_dmachan *chan, int ring_size)
 
 	chan->ring_size = ring_size;
 
-	chan->ring_virt = dma_alloc_coherent(&dma_pdev->dev,
-					     ring_size * sizeof(u64),
-					     &chan->ring_dma, GFP_KERNEL);
+	chan->ring_virt = dma_zalloc_coherent(&dma_pdev->dev,
+					      ring_size * sizeof(u64),
+					      &chan->ring_dma, GFP_KERNEL);
 
 	if (!chan->ring_virt)
 		return -ENOMEM;
 
-	memset(chan->ring_virt, 0, ring_size * sizeof(u64));
-
 	return 0;
 }
 EXPORT_SYMBOL(pasemi_dma_alloc_ring);
diff --git a/arch/powerpc/sysdev/fsl_rmu.c b/arch/powerpc/sysdev/fsl_rmu.c
index b48197a..34b49fc 100644
--- a/arch/powerpc/sysdev/fsl_rmu.c
+++ b/arch/powerpc/sysdev/fsl_rmu.c
@@ -744,15 +744,14 @@ fsl_open_outb_mbox(struct rio_mport *mport, void *dev_id, int mbox, int entries)
 	}
 
 	/* Initialize outbound message descriptor ring */
-	rmu->msg_tx_ring.virt = dma_alloc_coherent(priv->dev,
-				rmu->msg_tx_ring.size * RIO_MSG_DESC_SIZE,
-				&rmu->msg_tx_ring.phys, GFP_KERNEL);
+	rmu->msg_tx_ring.virt = dma_zalloc_coherent(priv->dev,
+						    rmu->msg_tx_ring.size * RIO_MSG_DESC_SIZE,
+						    &rmu->msg_tx_ring.phys,
+						    GFP_KERNEL);
 	if (!rmu->msg_tx_ring.virt) {
 		rc = -ENOMEM;
 		goto out_dma;
 	}
-	memset(rmu->msg_tx_ring.virt, 0,
-			rmu->msg_tx_ring.size * RIO_MSG_DESC_SIZE);
 	rmu->msg_tx_ring.tx_slot = 0;
 
 	/* Point dequeue/enqueue pointers at first entry in ring */
-- 
1.8.1.2.459.gbcd45b4.dirty
