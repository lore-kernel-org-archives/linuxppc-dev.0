Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0026.hostedemail.com
 [216.40.44.26])
 by lists.ozlabs.org (Postfix) with ESMTP id EC5E91A03BF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jun 2014 06:39:24 +1000 (EST)
From: Joe Perches <joe@perches.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH -next 26/26] sound: Use dma_zalloc_coherent
Date: Sun, 15 Jun 2014 13:37:55 -0700
Message-Id: <1ee1f44142267688ea2db19c11a83596b98c4f17.1402863905.git.joe@perches.com>
In-Reply-To: <cover.1402863904.git.joe@perches.com>
References: <cover.1402863904.git.joe@perches.com>
Cc: Takashi Iwai <tiwai@suse.de>, Johannes Berg <johannes@sipsolutions.net>,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
 Jaroslav Kysela <perex@perex.cz>
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
 sound/aoa/soundbus/i2sbus/core.c | 12 ++++--------
 sound/sparc/dbri.c               |  6 ++----
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/sound/aoa/soundbus/i2sbus/core.c b/sound/aoa/soundbus/i2sbus/core.c
index 4678360..a80d5ea 100644
--- a/sound/aoa/soundbus/i2sbus/core.c
+++ b/sound/aoa/soundbus/i2sbus/core.c
@@ -47,15 +47,11 @@ static int alloc_dbdma_descriptor_ring(struct i2sbus_dev *i2sdev,
 	/* We use the PCI APIs for now until the generic one gets fixed
 	 * enough or until we get some macio-specific versions
 	 */
-	r->space = dma_alloc_coherent(
-			&macio_get_pci_dev(i2sdev->macio)->dev,
-			r->size,
-			&r->bus_addr,
-			GFP_KERNEL);
+	r->space = dma_zalloc_coherent(&macio_get_pci_dev(i2sdev->macio)->dev,
+				       r->size, &r->bus_addr, GFP_KERNEL);
+	if (!r->space)
+		return -ENOMEM;
 
-	if (!r->space) return -ENOMEM;
-
-	memset(r->space, 0, r->size);
 	r->cmds = (void*)DBDMA_ALIGN(r->space);
 	r->bus_cmd_start = r->bus_addr +
 			   (dma_addr_t)((char*)r->cmds - (char*)r->space);
diff --git a/sound/sparc/dbri.c b/sound/sparc/dbri.c
index be1b1aa..b2c3d0d 100644
--- a/sound/sparc/dbri.c
+++ b/sound/sparc/dbri.c
@@ -2534,12 +2534,10 @@ static int snd_dbri_create(struct snd_card *card,
 	dbri->op = op;
 	dbri->irq = irq;
 
-	dbri->dma = dma_alloc_coherent(&op->dev,
-				       sizeof(struct dbri_dma),
-				       &dbri->dma_dvma, GFP_ATOMIC);
+	dbri->dma = dma_zalloc_coherent(&op->dev, sizeof(struct dbri_dma),
+					&dbri->dma_dvma, GFP_ATOMIC);
 	if (!dbri->dma)
 		return -ENOMEM;
-	memset((void *)dbri->dma, 0, sizeof(struct dbri_dma));
 
 	dprintk(D_GEN, "DMA Cmd Block 0x%p (0x%08x)\n",
 		dbri->dma, dbri->dma_dvma);
-- 
1.8.1.2.459.gbcd45b4.dirty
