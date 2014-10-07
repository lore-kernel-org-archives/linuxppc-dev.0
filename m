Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C64E1A021C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Oct 2014 15:38:08 +1100 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 36F47140080
 for <linuxppc-dev@ozlabs.org>; Tue,  7 Oct 2014 15:38:06 +1100 (EST)
Message-ID: <1412656654.30859.117.camel@pasglop>
Subject: [PATCH v3 1/7] ALSA: hda - Limit 40bit DMA for AMD HDMI controllers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alex Deucher <alexdeucher@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 07 Oct 2014 15:37:34 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Dave Airlie <airlied@linux.ie>,
 linux-pci@vger.kernel.org, Anton Blanchard <anton@au1.ibm.com>,
 Yijing Wang <wangyijing@huawei.com>, Takashi Iwai <tiwai@suse.de>,
 Brian King <brking@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Takashi Iwai <tiwai@suse.de>

AMD/ATI HDMI controller chip models, we already have a filter to lower
to 32bit DMA, but the rest are supposed to be working with 64bit
although the hardware doesn't really work with 63bit but only with 40
or 48bit DMA.  In this patch, we take 40bit DMA for safety for the
AMD/ATI controllers as the graphics drivers does.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: <stable@vger.kernel.org>
---
 sound/pci/hda/hda_intel.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index aa302fb..99b367b 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1482,6 +1482,7 @@ static int azx_first_init(struct azx *chip)
 	struct snd_card *card = chip->card;
 	int err;
 	unsigned short gcap;
+	unsigned int dma_bits = 64;
 
 #if BITS_PER_LONG != 64
 	/* Fix up base address on ULI M5461 */
@@ -1518,9 +1519,14 @@ static int azx_first_init(struct azx *chip)
 	gcap = azx_readw(chip, GCAP);
 	dev_dbg(card->dev, "chipset global capabilities = 0x%x\n", gcap);
 
+	/* AMD devices support 40 or 48bit DMA, take the safe one */
+	if (chip->pci->vendor == PCI_VENDOR_ID_AMD)
+		dma_bits = 40;
+
 	/* disable SB600 64bit support for safety */
 	if (chip->pci->vendor == PCI_VENDOR_ID_ATI) {
 		struct pci_dev *p_smbus;
+		dma_bits = 40;
 		p_smbus = pci_get_device(PCI_VENDOR_ID_ATI,
 					 PCI_DEVICE_ID_ATI_SBX00_SMBUS,
 					 NULL);
@@ -1550,9 +1556,11 @@ static int azx_first_init(struct azx *chip)
 	}
 
 	/* allow 64bit DMA address if supported by H/W */
-	if ((gcap & AZX_GCAP_64OK) && !pci_set_dma_mask(pci, DMA_BIT_MASK(64)))
-		pci_set_consistent_dma_mask(pci, DMA_BIT_MASK(64));
-	else {
+	if (!(gcap & AZX_GCAP_64OK))
+		dma_bits = 32;
+	if (!pci_set_dma_mask(pci, DMA_BIT_MASK(dma_bits))) {
+		pci_set_consistent_dma_mask(pci, DMA_BIT_MASK(dma_bits));
+	} else {
 		pci_set_dma_mask(pci, DMA_BIT_MASK(32));
 		pci_set_consistent_dma_mask(pci, DMA_BIT_MASK(32));
 	}
