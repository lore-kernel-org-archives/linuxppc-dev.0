Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C82961A02A1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Oct 2014 15:43:48 +1100 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D3D7A1400A0
 for <linuxppc-dev@ozlabs.org>; Tue,  7 Oct 2014 15:43:47 +1100 (EST)
Message-ID: <1412656696.30859.122.camel@pasglop>
Subject: [PATCH v3 4/7] sound/radeon: Add quirk for broken 64-bit MSI
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alex Deucher <alexdeucher@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 07 Oct 2014 15:38:16 +1100
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

From: Signed-off-by: Alex Deucher <alexdeucher@gmail.com>

A number of radeon cards have a HW limitation causing them to be
unable to generate the full 64-bit of address bits for MSIs. This
breaks MSIs on some platforms such as POWER machines.

We used to have a powerpc specific quirk to address that on a
single card, but this doesn't scale very well, this is better
put under control of the drivers who know precisely what a given
HW revision can do.

This moves the setting of the quirk flag to the audio driver.

While recent ASICs have that problem fixed, they don't seem to
be listed in the PCI IDs of the current driver, so let's quirk all
the ATI HDMI for now. The consequences are nil on x86 anyway.

Signed-off-by: Alex Deucher <alexdeucher@gmail.com>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: <stable@vger.kernel.org>
---
 sound/pci/hda/hda_intel.c | 96 +++++++++++++++++++++++++++++++++--------------
 sound/pci/hda/hda_priv.h  |  1 +
 2 files changed, 69 insertions(+), 28 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 99b367b..af38ed9 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1506,9 +1506,14 @@ static int azx_first_init(struct azx *chip)
 		return -ENXIO;
 	}
 
-	if (chip->msi)
+	if (chip->msi) {
+		if (chip->driver_caps & AZX_DCAPS_NO_MSI64) {
+			dev_dbg(card->dev, "Disabling 64bit MSI\n");
+			pci->no_64bit_msi = true;
+		}
 		if (pci_enable_msi(pci) < 0)
 			chip->msi = 0;
+	}
 
 	if (azx_acquire_irq(chip, 0) < 0)
 		return -EBUSY;
@@ -2070,58 +2075,93 @@ static const struct pci_device_id azx_ids[] = {
 	{ PCI_DEVICE(0x1022, 0x780d),
 	  .driver_data = AZX_DRIVER_GENERIC | AZX_DCAPS_PRESET_ATI_SB },
 	/* ATI HDMI */
-	{ PCI_DEVICE(0x1002, 0x793b),
-	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI },
+	{ PCI_DEVICE(0x1002, 0x1314),
+	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI |
+	  AZX_DCAPS_NO_MSI64 },
 	{ PCI_DEVICE(0x1002, 0x7919),
-	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI },
+	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI |
+	  AZX_DCAPS_NO_MSI64 },
+	{ PCI_DEVICE(0x1002, 0x7969),
+	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI |
+	  AZX_DCAPS_NO_MSI64 },
+	{ PCI_DEVICE(0x1002, 0x793b),
+	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI |
+	  AZX_DCAPS_NO_MSI64 },
 	{ PCI_DEVICE(0x1002, 0x960f),
-	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI },
+	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI |
+	  AZX_DCAPS_NO_MSI64 },
+	{ PCI_DEVICE(0x1002, 0x9646),
+	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI |
+	  AZX_DCAPS_NO_MSI64 },
 	{ PCI_DEVICE(0x1002, 0x970f),
-	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI },
+	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI |
+	  AZX_DCAPS_NO_MSI64 },
 	{ PCI_DEVICE(0x1002, 0xaa00),
-	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI },
+	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI |
+	  AZX_DCAPS_NO_MSI64 },
 	{ PCI_DEVICE(0x1002, 0xaa08),
-	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI },
+	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI |
+	  AZX_DCAPS_NO_MSI64 },
 	{ PCI_DEVICE(0x1002, 0xaa10),
-	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI },
+	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI |
+	  AZX_DCAPS_NO_MSI64 },
 	{ PCI_DEVICE(0x1002, 0xaa18),
-	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI },
+	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI |
+	  AZX_DCAPS_NO_MSI64 },
 	{ PCI_DEVICE(0x1002, 0xaa20),
-	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI },
+	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI |
+	  AZX_DCAPS_NO_MSI64 },
 	{ PCI_DEVICE(0x1002, 0xaa28),
-	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI },
+	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI |
+	  AZX_DCAPS_NO_MSI64 },
 	{ PCI_DEVICE(0x1002, 0xaa30),
-	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI },
+	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI |
+	  AZX_DCAPS_NO_MSI64 },
 	{ PCI_DEVICE(0x1002, 0xaa38),
-	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI },
+	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI |
+	  AZX_DCAPS_NO_MSI64 },
 	{ PCI_DEVICE(0x1002, 0xaa40),
-	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI },
+	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI |
+	  AZX_DCAPS_NO_MSI64 },
 	{ PCI_DEVICE(0x1002, 0xaa48),
-	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI },
+	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI |
+	  AZX_DCAPS_NO_MSI64 },
 	{ PCI_DEVICE(0x1002, 0xaa50),
-	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI },
+	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI |
+	  AZX_DCAPS_NO_MSI64 },
 	{ PCI_DEVICE(0x1002, 0xaa58),
-	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI },
+	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI |
+	  AZX_DCAPS_NO_MSI64 },
 	{ PCI_DEVICE(0x1002, 0xaa60),
-	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI },
+	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI |
+	  AZX_DCAPS_NO_MSI64 },
 	{ PCI_DEVICE(0x1002, 0xaa68),
-	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI },
+	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI |
+	  AZX_DCAPS_NO_MSI64 },
 	{ PCI_DEVICE(0x1002, 0xaa80),
-	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI },
+	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI |
+	  AZX_DCAPS_NO_MSI64 },
 	{ PCI_DEVICE(0x1002, 0xaa88),
-	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI },
+	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI |
+	  AZX_DCAPS_NO_MSI64 },
 	{ PCI_DEVICE(0x1002, 0xaa90),
-	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI },
+	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI |
+	  AZX_DCAPS_NO_MSI64 },
 	{ PCI_DEVICE(0x1002, 0xaa98),
-	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI },
+	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI |
+	  AZX_DCAPS_NO_MSI64 },
 	{ PCI_DEVICE(0x1002, 0x9902),
-	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI },
+	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI |
+	  AZX_DCAPS_NO_MSI64 },
 	{ PCI_DEVICE(0x1002, 0xaaa0),
-	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI },
+	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI |
+	  AZX_DCAPS_NO_MSI64 },
 	{ PCI_DEVICE(0x1002, 0xaaa8),
-	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI },
+	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI |
+	  AZX_DCAPS_NO_MSI64 },
 	{ PCI_DEVICE(0x1002, 0xaab0),
-	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI },
+	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI |
+	  AZX_DCAPS_NO_MSI64 },
 	/* VIA VT8251/VT8237A */
 	{ PCI_DEVICE(0x1106, 0x3288),
 	  .driver_data = AZX_DRIVER_VIA | AZX_DCAPS_POSFIX_VIA },
diff --git a/sound/pci/hda/hda_priv.h b/sound/pci/hda/hda_priv.h
index 949cd43..5016014 100644
--- a/sound/pci/hda/hda_priv.h
+++ b/sound/pci/hda/hda_priv.h
@@ -171,6 +171,7 @@ enum { SDI0, SDI1, SDI2, SDI3, SDO0, SDO1, SDO2, SDO3 };
 #define AZX_DCAPS_PM_RUNTIME	(1 << 26)	/* runtime PM support */
 #define AZX_DCAPS_I915_POWERWELL (1 << 27)	/* HSW i915 powerwell support */
 #define AZX_DCAPS_CORBRP_SELF_CLEAR (1 << 28)	/* CORBRP clears itself after reset */
+#define AZX_DCAPS_NO_MSI64      (1 << 29)	/* Stick to 32-bit MSIs */
 
 /* HD Audio class code */
 #define PCI_CLASS_MULTIMEDIA_HD_AUDIO	0x0403
