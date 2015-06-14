Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 7F6561A06AD
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Jun 2015 23:08:12 +1000 (AEST)
Message-Id: <20150614074609.036850762@telegraphics.com.au>
Date: Sun, 14 Jun 2015 17:46:14 +1000
From: Finn Thain <fthain@telegraphics.com.au>
To: <linux-kernel@vger.kernel.org>, <linux-m68k@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>,
 Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
 Darren Hart <dvhart@infradead.org>, ibm-acpi-devel@lists.sourceforge.net,
 platform-driver-x86@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [RFC v2 07/24] x86/thinkpad_acpi: Use arch_nvram_ops methods instead
 of nvram_read_byte() and nvram_write_byte()
References: <20150614074607.242676098@telegraphics.com.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Make use of arch_nvram_ops in the thinkpad_acpi driver so that the
nvram_* function exports can be removed.

This patch series was tested on a ThinkPad T43.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Acked-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Reviewed-by: Darren Hart <dvhart@linux.intel.com>

---
 drivers/platform/x86/thinkpad_acpi.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

Index: linux/drivers/platform/x86/thinkpad_acpi.c
===================================================================
--- linux.orig/drivers/platform/x86/thinkpad_acpi.c	2015-06-14 17:45:34.000000000 +1000
+++ linux/drivers/platform/x86/thinkpad_acpi.c	2015-06-14 17:45:42.000000000 +1000
@@ -2311,30 +2311,30 @@ static void hotkey_read_nvram(struct tp_
 	u8 d;
 
 	if (m & TP_NVRAM_HKEY_GROUP_HK2) {
-		d = nvram_read_byte(TP_NVRAM_ADDR_HK2);
+		d = arch_nvram_ops.read_byte(TP_NVRAM_ADDR_HK2);
 		n->thinkpad_toggle = !!(d & TP_NVRAM_MASK_HKT_THINKPAD);
 		n->zoom_toggle = !!(d & TP_NVRAM_MASK_HKT_ZOOM);
 		n->display_toggle = !!(d & TP_NVRAM_MASK_HKT_DISPLAY);
 		n->hibernate_toggle = !!(d & TP_NVRAM_MASK_HKT_HIBERNATE);
 	}
 	if (m & TP_ACPI_HKEY_THNKLGHT_MASK) {
-		d = nvram_read_byte(TP_NVRAM_ADDR_THINKLIGHT);
+		d = arch_nvram_ops.read_byte(TP_NVRAM_ADDR_THINKLIGHT);
 		n->thinklight_toggle = !!(d & TP_NVRAM_MASK_THINKLIGHT);
 	}
 	if (m & TP_ACPI_HKEY_DISPXPAND_MASK) {
-		d = nvram_read_byte(TP_NVRAM_ADDR_VIDEO);
+		d = arch_nvram_ops.read_byte(TP_NVRAM_ADDR_VIDEO);
 		n->displayexp_toggle =
 				!!(d & TP_NVRAM_MASK_HKT_DISPEXPND);
 	}
 	if (m & TP_NVRAM_HKEY_GROUP_BRIGHTNESS) {
-		d = nvram_read_byte(TP_NVRAM_ADDR_BRIGHTNESS);
+		d = arch_nvram_ops.read_byte(TP_NVRAM_ADDR_BRIGHTNESS);
 		n->brightness_level = (d & TP_NVRAM_MASK_LEVEL_BRIGHTNESS)
 				>> TP_NVRAM_POS_LEVEL_BRIGHTNESS;
 		n->brightness_toggle =
 				!!(d & TP_NVRAM_MASK_HKT_BRIGHTNESS);
 	}
 	if (m & TP_NVRAM_HKEY_GROUP_VOLUME) {
-		d = nvram_read_byte(TP_NVRAM_ADDR_MIXER);
+		d = arch_nvram_ops.read_byte(TP_NVRAM_ADDR_MIXER);
 		n->volume_level = (d & TP_NVRAM_MASK_LEVEL_VOLUME)
 				>> TP_NVRAM_POS_LEVEL_VOLUME;
 		n->mute = !!(d & TP_NVRAM_MASK_MUTE);
@@ -6155,7 +6155,7 @@ static unsigned int tpacpi_brightness_nv
 {
 	u8 lnvram;
 
-	lnvram = (nvram_read_byte(TP_NVRAM_ADDR_BRIGHTNESS)
+	lnvram = (arch_nvram_ops.read_byte(TP_NVRAM_ADDR_BRIGHTNESS)
 		  & TP_NVRAM_MASK_LEVEL_BRIGHTNESS)
 		  >> TP_NVRAM_POS_LEVEL_BRIGHTNESS;
 	lnvram &= bright_maxlvl;
@@ -6180,7 +6180,7 @@ static void tpacpi_brightness_checkpoint
 	if (unlikely(!acpi_ec_read(TP_EC_BACKLIGHT, &lec)))
 		goto unlock;
 	lec &= TP_EC_BACKLIGHT_LVLMSK;
-	b_nvram = nvram_read_byte(TP_NVRAM_ADDR_BRIGHTNESS);
+	b_nvram = arch_nvram_ops.read_byte(TP_NVRAM_ADDR_BRIGHTNESS);
 
 	if (lec != ((b_nvram & TP_NVRAM_MASK_LEVEL_BRIGHTNESS)
 			     >> TP_NVRAM_POS_LEVEL_BRIGHTNESS)) {
@@ -6188,7 +6188,7 @@ static void tpacpi_brightness_checkpoint
 		b_nvram &= ~(TP_NVRAM_MASK_LEVEL_BRIGHTNESS <<
 				TP_NVRAM_POS_LEVEL_BRIGHTNESS);
 		b_nvram |= lec;
-		nvram_write_byte(b_nvram, TP_NVRAM_ADDR_BRIGHTNESS);
+		arch_nvram_ops.write_byte(b_nvram, TP_NVRAM_ADDR_BRIGHTNESS);
 		dbg_printk(TPACPI_DBG_BRGHT,
 			   "updated NVRAM backlight level to %u (0x%02x)\n",
 			   (unsigned int) lec, (unsigned int) b_nvram);
@@ -6796,13 +6796,13 @@ static void tpacpi_volume_checkpoint_nvr
 	if (unlikely(!acpi_ec_read(TP_EC_AUDIO, &lec)))
 		goto unlock;
 	lec &= ec_mask;
-	b_nvram = nvram_read_byte(TP_NVRAM_ADDR_MIXER);
+	b_nvram = arch_nvram_ops.read_byte(TP_NVRAM_ADDR_MIXER);
 
 	if (lec != (b_nvram & ec_mask)) {
 		/* NVRAM needs update */
 		b_nvram &= ~ec_mask;
 		b_nvram |= lec;
-		nvram_write_byte(b_nvram, TP_NVRAM_ADDR_MIXER);
+		arch_nvram_ops.write_byte(b_nvram, TP_NVRAM_ADDR_MIXER);
 		dbg_printk(TPACPI_DBG_MIXER,
 			   "updated NVRAM mixer status to 0x%02x (0x%02x)\n",
 			   (unsigned int) lec, (unsigned int) b_nvram);
