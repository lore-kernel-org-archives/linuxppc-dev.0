Return-Path: <SRS0=ZqAX=PD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5003C43387
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Dec 2018 05:23:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53FFE214D8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Dec 2018 05:23:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53FFE214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43PhFb2N2BzDqPj
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Dec 2018 16:23:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=telegraphics.com.au
 (client-ip=98.124.60.144; helo=kvm5.telegraphics.com.au;
 envelope-from=fthain@telegraphics.com.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=telegraphics.com.au
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 43Pgn05RdqzDqHg
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Dec 2018 16:01:56 +1100 (AEDT)
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
 id E0E962951A; Tue, 25 Dec 2018 19:43:55 -0500 (EST)
To: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
 Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>
Message-Id: <416df0c555a86aee4d0e7e08675abf71f2f5b775.1545784679.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1545784679.git.fthain@telegraphics.com.au>
References: <cover.1545784679.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v8 06/25] x86/thinkpad_acpi: Use arch_nvram_ops methods
 instead of nvram_read_byte() and nvram_write_byte()
Date: Wed, 26 Dec 2018 11:37:59 +1100
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-m68k@lists.linux-m68k.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Make use of arch_nvram_ops in the thinkpad_acpi driver so that the
nvram_* function exports can be removed.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Acked-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Reviewed-by: Darren Hart <dvhart@linux.intel.com>
---
I've tested this on a ThinkPad T43.
---
 drivers/platform/x86/thinkpad_acpi.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index fde08a997557..fbbf7b452e51 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -2435,30 +2435,30 @@ static void hotkey_read_nvram(struct tp_nvram_state *n, const u32 m)
 	u8 d;
 
 	if (m & TP_NVRAM_HKEY_GROUP_HK2) {
-		d = nvram_read_byte(TP_NVRAM_ADDR_HK2);
+		d = arch_nvram_ops.read_byte(TP_NVRAM_ADDR_HK2);
 		n->thinkpad_toggle = !!(d & TP_NVRAM_MASK_HKT_THINKPAD);
 		n->zoom_toggle = !!(d & TP_NVRAM_MASK_HKT_ZOOM);
 		n->display_toggle = !!(d & TP_NVRAM_MASK_HKT_DISPLAY);
 		n->hibernate_toggle = !!(d & TP_NVRAM_MASK_HKT_HIBERNATE);
 	}
 	if (m & TP_ACPI_HKEY_KBD_LIGHT_MASK) {
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
@@ -6605,7 +6605,7 @@ static unsigned int tpacpi_brightness_nvram_get(void)
 {
 	u8 lnvram;
 
-	lnvram = (nvram_read_byte(TP_NVRAM_ADDR_BRIGHTNESS)
+	lnvram = (arch_nvram_ops.read_byte(TP_NVRAM_ADDR_BRIGHTNESS)
 		  & TP_NVRAM_MASK_LEVEL_BRIGHTNESS)
 		  >> TP_NVRAM_POS_LEVEL_BRIGHTNESS;
 	lnvram &= bright_maxlvl;
@@ -6630,7 +6630,7 @@ static void tpacpi_brightness_checkpoint_nvram(void)
 	if (unlikely(!acpi_ec_read(TP_EC_BACKLIGHT, &lec)))
 		goto unlock;
 	lec &= TP_EC_BACKLIGHT_LVLMSK;
-	b_nvram = nvram_read_byte(TP_NVRAM_ADDR_BRIGHTNESS);
+	b_nvram = arch_nvram_ops.read_byte(TP_NVRAM_ADDR_BRIGHTNESS);
 
 	if (lec != ((b_nvram & TP_NVRAM_MASK_LEVEL_BRIGHTNESS)
 			     >> TP_NVRAM_POS_LEVEL_BRIGHTNESS)) {
@@ -6638,7 +6638,7 @@ static void tpacpi_brightness_checkpoint_nvram(void)
 		b_nvram &= ~(TP_NVRAM_MASK_LEVEL_BRIGHTNESS <<
 				TP_NVRAM_POS_LEVEL_BRIGHTNESS);
 		b_nvram |= lec;
-		nvram_write_byte(b_nvram, TP_NVRAM_ADDR_BRIGHTNESS);
+		arch_nvram_ops.write_byte(b_nvram, TP_NVRAM_ADDR_BRIGHTNESS);
 		dbg_printk(TPACPI_DBG_BRGHT,
 			   "updated NVRAM backlight level to %u (0x%02x)\n",
 			   (unsigned int) lec, (unsigned int) b_nvram);
@@ -7236,13 +7236,13 @@ static void tpacpi_volume_checkpoint_nvram(void)
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
-- 
2.19.2

