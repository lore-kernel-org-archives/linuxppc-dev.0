Return-Path: <linuxppc-dev+bounces-26937-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28435C79FAD
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 13:24:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hg1jz1vZfz3bsS;
	Wed, 09 Sep 2026 23:24:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788960263;
	cv=none; b=F+HySMyzlExGSfSvhlNqytOeIy5pPbjIL7yW0hGMC83LAKwcpj/FCzd8IrzlWfqFEhc2Y3jNvO8Tp1E6wGByfURHUxDBGOGEoqu8tB+B9fc7y9+dtd4ir9atvyyZfeknP0Yv0SQQUCEDQqbJEahSXATGBPZSikrpxefK/txUjv3VbOcSOKCew4IMJ7eUosiQbasdvdDORvECIU2ZOIyhojkMiOycBLuuLp0ZZxlK5vV7ytu0YLD04EyhvfX8iPQRZPgWjfE3WEa8jeYoM9ujbHCo1PDzsxUrgzz4VOludmfN6LzedjiC3d3X3/NEPjY7cbxHaQ1s6ZyEPSNTCdF0Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788960263; c=relaxed/relaxed;
	bh=Rq1ndvZs9h6QkOGO/BQPuhbEhLEVdWCFdVZqcHD+QS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b9lDKAODyjFlzk0Oy38QZ5LpTYM/1m/rIBcXljSTerQin4+uVF0EAa4GHOUqllIooeuFWNOeSX/vjveIwduDPGoZi1z0nn18UBoBpzki6UxuVH3uliD07AarMJWoXSCyeK9kn4U/GO1NBOdDS0fBYrWLokH8RgqtRKI51NMNyvroqD3fqyEUauBfr/2OT5//tJhstE0rkxR6fS1bAZBznIGDXAwIBS1vD8xpUEpeUehrHOEzqzIqk/sKSWyEvieRqacl4Hhzsk7+wu8BHtSQlIACaTPCcZsy9PLNMTA9ahDGP24wURnZujYKA4E/dOLVs+jyn5aiWeTMSLwBWrhR2g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UdWn5oLL; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=arnd@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UdWn5oLL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=arnd@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hg1jy1pn5z2yvh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 23:24:22 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B6AE040E3C;
	Wed,  9 Sep 2026 13:24:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA3371F00A3D;
	Wed,  9 Sep 2026 13:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788960260;
	bh=Rq1ndvZs9h6QkOGO/BQPuhbEhLEVdWCFdVZqcHD+QS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UdWn5oLL2kCnrr4fzV1hp4NITLxLhJxn5uDwDZnk4jEFCdVtubg5Rwi9qu1BFw8bH
	 KDV9p0tXYDPBxshmkYq09l+W8H3lgjaUuKxXExU2VGiQeB1OW0UnpYZQA9caWSjRAL
	 eSpjRUNVwC/qDnFq2cUeAZSkedj/lTs8nEzkSbZCsWZysH0KsZiysgHSDUZcJ9ftWY
	 inI9nhnViHwCvdiwR9v1JDn75F6kI36urdm5VBrh8WPm20B3+ebJFx0J+bVK/XAf8/
	 hFIq48gbZFv6OhuumRc8B/WJAGdeFk+JGGaEMdvFWWD5brKIhUcBLowzIgY1PsNg8X
	 L1WRt6tKRTLmw==
From: Arnd Bergmann <arnd@kernel.org>
To: Lee Jones <lee@kernel.org>,
	mfd@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Arnd Bergmann <arnd@arndb.de>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Pavel Machek <pavel@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Support Opensource <support.opensource@diasemi.com>,
	Sebastian Reichel <sre@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Helge Deller <deller@gmx.de>,
	dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org,
	linux-media@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	patches@opensource.cirrus.com,
	linux-watchdog@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	llvm@lists.linux.dev
Subject: [PATCH 14/14] mfd: remove unused iPaq micro driver
Date: Wed,  9 Sep 2026 15:21:51 +0200
Message-ID: <20260909132153.1596191-15-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909132153.1596191-1-arnd@kernel.org>
References: <20260909132153.1596191-1-arnd@kernel.org>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The iPaq support has been removed from the kernel, this driver is
no longer used anywhere.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mfd/Kconfig      |  10 -
 drivers/mfd/Makefile     |   1 -
 drivers/mfd/ipaq-micro.c | 442 ---------------------------------------
 3 files changed, 453 deletions(-)
 delete mode 100644 drivers/mfd/ipaq-micro.c

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 02e52398fcd2..6189bd7cc109 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -780,16 +780,6 @@ config MFD_INTEL_PMC_BXT
 	  Register and P-unit access. In addition this creates devices
 	  for iTCO watchdog and telemetry that are part of the PMC.
 
-config MFD_IPAQ_MICRO
-	bool "Atmel Micro ASIC (iPAQ h3100/h3600/h3700) Support"
-	depends on SA1100_H3600
-	select MFD_CORE
-	help
-	  Select this to get support for the Microcontroller found in
-	  the Compaq iPAQ handheld computers. This is an Atmel
-	  AT90LS8535 microcontroller flashed with a special iPAQ
-	  firmware using the custom protocol implemented in this driver.
-
 config MFD_IQS62X
 	tristate "Azoteq IQS620A/621/622/624/625 core support"
 	depends on I2C
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index a88a13c8bab8..b56ff2e68d4a 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -218,7 +218,6 @@ obj-$(CONFIG_MFD_RETU)		+= retu-mfd.o
 obj-$(CONFIG_MFD_AS3711)	+= as3711.o
 obj-$(CONFIG_MFD_AS3722)	+= as3722.o
 obj-$(CONFIG_MFD_STW481X)	+= stw481x.o
-obj-$(CONFIG_MFD_IPAQ_MICRO)	+= ipaq-micro.o
 obj-$(CONFIG_MFD_IQS62X)	+= iqs62x.o
 obj-$(CONFIG_MFD_MENF21BMC)	+= menf21bmc.o
 obj-$(CONFIG_MFD_HI6421_PMIC)	+= hi6421-pmic-core.o
diff --git a/drivers/mfd/ipaq-micro.c b/drivers/mfd/ipaq-micro.c
deleted file mode 100644
index 5146a6eb0e5a..000000000000
--- a/drivers/mfd/ipaq-micro.c
+++ /dev/null
@@ -1,442 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Compaq iPAQ h3xxx Atmel microcontroller companion support
- *
- * This is an Atmel AT90LS8535 with a special flashed-in firmware that
- * implements the special protocol used by this driver.
- *
- * based on previous kernel 2.4 version by Andrew Christian
- * Author : Alessandro Gardich <gremlin@gremlin.it>
- * Author : Dmitry Artamonow <mad_soft@inbox.ru>
- * Author : Linus Walleij <linus.walleij@linaro.org>
- */
-
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/pm.h>
-#include <linux/delay.h>
-#include <linux/device.h>
-#include <linux/platform_device.h>
-#include <linux/io.h>
-#include <linux/mfd/core.h>
-#include <linux/mfd/ipaq-micro.h>
-#include <linux/string.h>
-#include <linux/string_choices.h>
-#include <linux/random.h>
-#include <linux/slab.h>
-#include <linux/list.h>
-
-#include <mach/hardware.h>
-
-static void ipaq_micro_trigger_tx(struct ipaq_micro *micro)
-{
-	struct ipaq_micro_txdev *tx = &micro->tx;
-	struct ipaq_micro_msg *msg = micro->msg;
-	int i, bp;
-	u8 checksum;
-	u32 val;
-
-	bp = 0;
-	tx->buf[bp++] = CHAR_SOF;
-
-	checksum = ((msg->id & 0x0f) << 4) | (msg->tx_len & 0x0f);
-	tx->buf[bp++] = checksum;
-
-	for (i = 0; i < msg->tx_len; i++) {
-		tx->buf[bp++] = msg->tx_data[i];
-		checksum += msg->tx_data[i];
-	}
-
-	tx->buf[bp++] = checksum;
-	tx->len = bp;
-	tx->index = 0;
-
-	/* Enable interrupt */
-	val = readl(micro->base + UTCR3);
-	val |= UTCR3_TIE;
-	writel(val, micro->base + UTCR3);
-}
-
-int ipaq_micro_tx_msg(struct ipaq_micro *micro, struct ipaq_micro_msg *msg)
-{
-	unsigned long flags;
-
-	dev_dbg(micro->dev, "TX msg: %02x, %d bytes\n", msg->id, msg->tx_len);
-
-	spin_lock_irqsave(&micro->lock, flags);
-	if (micro->msg) {
-		list_add_tail(&msg->node, &micro->queue);
-		spin_unlock_irqrestore(&micro->lock, flags);
-		return 0;
-	}
-	micro->msg = msg;
-	ipaq_micro_trigger_tx(micro);
-	spin_unlock_irqrestore(&micro->lock, flags);
-	return 0;
-}
-EXPORT_SYMBOL(ipaq_micro_tx_msg);
-
-static void micro_rx_msg(struct ipaq_micro *micro, u8 id, int len, u8 *data)
-{
-	dev_dbg(micro->dev, "RX msg: %02x, %d bytes\n", id, len);
-
-	spin_lock(&micro->lock);
-	switch (id) {
-	case MSG_VERSION:
-	case MSG_EEPROM_READ:
-	case MSG_EEPROM_WRITE:
-	case MSG_BACKLIGHT:
-	case MSG_NOTIFY_LED:
-	case MSG_THERMAL_SENSOR:
-	case MSG_BATTERY:
-		/* Handle synchronous messages */
-		if (micro->msg && micro->msg->id == id) {
-			struct ipaq_micro_msg *msg = micro->msg;
-
-			memcpy(msg->rx_data, data, len);
-			msg->rx_len = len;
-			complete(&micro->msg->ack);
-			if (!list_empty(&micro->queue)) {
-				micro->msg = list_entry(micro->queue.next,
-							struct ipaq_micro_msg,
-							node);
-				list_del_init(&micro->msg->node);
-				ipaq_micro_trigger_tx(micro);
-			} else
-				micro->msg = NULL;
-			dev_dbg(micro->dev, "OK RX message 0x%02x\n", id);
-		} else {
-			dev_err(micro->dev,
-				"out of band RX message 0x%02x\n", id);
-			if (!micro->msg)
-				dev_info(micro->dev, "no message queued\n");
-			else
-				dev_info(micro->dev, "expected message %02x\n",
-					 micro->msg->id);
-		}
-		break;
-	case MSG_KEYBOARD:
-		if (micro->key)
-			micro->key(micro->key_data, len, data);
-		else
-			dev_dbg(micro->dev, "key message ignored, no handle\n");
-		break;
-	case MSG_TOUCHSCREEN:
-		if (micro->ts)
-			micro->ts(micro->ts_data, len, data);
-		else
-			dev_dbg(micro->dev, "touchscreen message ignored, no handle\n");
-		break;
-	default:
-		dev_err(micro->dev,
-			"unknown msg %d [%d] %*ph\n", id, len, len, data);
-		break;
-	}
-	spin_unlock(&micro->lock);
-}
-
-static void micro_process_char(struct ipaq_micro *micro, u8 ch)
-{
-	struct ipaq_micro_rxdev *rx = &micro->rx;
-
-	switch (rx->state) {
-	case STATE_SOF:	/* Looking for SOF */
-		if (ch == CHAR_SOF)
-			rx->state = STATE_ID; /* Next byte is the id and len */
-		break;
-	case STATE_ID: /* Looking for id and len byte */
-		rx->id = (ch & 0xf0) >> 4;
-		rx->len = (ch & 0x0f);
-		rx->index = 0;
-		rx->chksum = ch;
-		rx->state = (rx->len > 0) ? STATE_DATA : STATE_CHKSUM;
-		break;
-	case STATE_DATA: /* Looking for 'len' data bytes */
-		rx->chksum += ch;
-		rx->buf[rx->index] = ch;
-		if (++rx->index == rx->len)
-			rx->state = STATE_CHKSUM;
-		break;
-	case STATE_CHKSUM: /* Looking for the checksum */
-		if (ch == rx->chksum)
-			micro_rx_msg(micro, rx->id, rx->len, rx->buf);
-		rx->state = STATE_SOF;
-		break;
-	}
-}
-
-static void micro_rx_chars(struct ipaq_micro *micro)
-{
-	u32 status, ch;
-
-	while ((status = readl(micro->base + UTSR1)) & UTSR1_RNE) {
-		ch = readl(micro->base + UTDR);
-		if (status & UTSR1_PRE)
-			dev_err(micro->dev, "rx: parity error\n");
-		else if (status & UTSR1_FRE)
-			dev_err(micro->dev, "rx: framing error\n");
-		else if (status & UTSR1_ROR)
-			dev_err(micro->dev, "rx: overrun error\n");
-		micro_process_char(micro, ch);
-	}
-}
-
-static void ipaq_micro_get_version(struct ipaq_micro *micro)
-{
-	struct ipaq_micro_msg msg = {
-		.id = MSG_VERSION,
-	};
-
-	ipaq_micro_tx_msg_sync(micro, &msg);
-	if (msg.rx_len == 4) {
-		memcpy(micro->version, msg.rx_data, 4);
-		micro->version[4] = '\0';
-	} else if (msg.rx_len == 9) {
-		memcpy(micro->version, msg.rx_data, 4);
-		micro->version[4] = '\0';
-		/* Bytes 4-7 are "pack", byte 8 is "boot type" */
-	} else {
-		dev_err(micro->dev,
-			"illegal version message %d bytes\n", msg.rx_len);
-	}
-}
-
-static void ipaq_micro_eeprom_read(struct ipaq_micro *micro,
-				   u8 address, u8 len, u8 *data)
-{
-	struct ipaq_micro_msg msg = {
-		.id = MSG_EEPROM_READ,
-	};
-	u8 i;
-
-	for (i = 0; i < len; i++) {
-		msg.tx_data[0] = address + i;
-		msg.tx_data[1] = 1;
-		msg.tx_len = 2;
-		ipaq_micro_tx_msg_sync(micro, &msg);
-		memcpy(data + (i * 2), msg.rx_data, 2);
-	}
-}
-
-static char *ipaq_micro_str(u8 *wchar, u8 len)
-{
-	char retstr[256] = { 0 };
-	u8 i;
-
-	for (i = 0; i < len / 2; i++)
-		retstr[i] = wchar[i * 2];
-	return kstrdup(retstr, GFP_KERNEL);
-}
-
-static u16 ipaq_micro_to_u16(u8 *data)
-{
-	return data[1] << 8 | data[0];
-}
-
-static void __init ipaq_micro_eeprom_dump(struct ipaq_micro *micro)
-{
-	u8 dump[256];
-	char *str;
-
-	ipaq_micro_eeprom_read(micro, 0, 128, dump);
-	str = ipaq_micro_str(dump, 10);
-	if (str) {
-		dev_info(micro->dev, "HW version %s\n", str);
-		kfree(str);
-	}
-	str = ipaq_micro_str(dump+10, 40);
-	if (str) {
-		dev_info(micro->dev, "serial number: %s\n", str);
-		/* Feed the random pool with this */
-		add_device_randomness(str, strlen(str));
-		kfree(str);
-	}
-	str = ipaq_micro_str(dump+50, 20);
-	if (str) {
-		dev_info(micro->dev, "module ID: %s\n", str);
-		kfree(str);
-	}
-	str = ipaq_micro_str(dump+70, 10);
-	if (str) {
-		dev_info(micro->dev, "product revision: %s\n", str);
-		kfree(str);
-	}
-	dev_info(micro->dev, "product ID: %u\n", ipaq_micro_to_u16(dump+80));
-	dev_info(micro->dev, "frame rate: %u fps\n",
-		 ipaq_micro_to_u16(dump+82));
-	dev_info(micro->dev, "page mode: %u\n", ipaq_micro_to_u16(dump+84));
-	dev_info(micro->dev, "country ID: %u\n", ipaq_micro_to_u16(dump+86));
-	dev_info(micro->dev, "color display: %s\n",
-		 str_yes_no(ipaq_micro_to_u16(dump + 88)));
-	dev_info(micro->dev, "ROM size: %u MiB\n", ipaq_micro_to_u16(dump+90));
-	dev_info(micro->dev, "RAM size: %u KiB\n", ipaq_micro_to_u16(dump+92));
-	dev_info(micro->dev, "screen: %u x %u\n",
-		 ipaq_micro_to_u16(dump+94), ipaq_micro_to_u16(dump+96));
-}
-
-static void micro_tx_chars(struct ipaq_micro *micro)
-{
-	struct ipaq_micro_txdev *tx = &micro->tx;
-	u32 val;
-
-	while ((tx->index < tx->len) &&
-	       (readl(micro->base + UTSR1) & UTSR1_TNF)) {
-		writel(tx->buf[tx->index], micro->base + UTDR);
-		tx->index++;
-	}
-
-	/* Stop interrupts */
-	val = readl(micro->base + UTCR3);
-	val &= ~UTCR3_TIE;
-	writel(val, micro->base + UTCR3);
-}
-
-static void micro_reset_comm(struct ipaq_micro *micro)
-{
-	struct ipaq_micro_rxdev *rx = &micro->rx;
-	u32 val;
-
-	if (micro->msg)
-		complete(&micro->msg->ack);
-
-	/* Initialize Serial channel protocol frame */
-	rx->state = STATE_SOF;  /* Reset the state machine */
-
-	/* Set up interrupts */
-	writel(0x01, micro->sdlc + 0x0); /* Select UART mode */
-
-	/* Clean up CR3 */
-	writel(0x0, micro->base + UTCR3);
-
-	/* Format: 8N1 */
-	writel(UTCR0_8BitData | UTCR0_1StpBit, micro->base + UTCR0);
-
-	/* Baud rate: 115200 */
-	writel(0x0, micro->base + UTCR1);
-	writel(0x1, micro->base + UTCR2);
-
-	/* Clear SR0 */
-	writel(0xff, micro->base + UTSR0);
-
-	/* Enable RX int, disable TX int */
-	writel(UTCR3_TXE | UTCR3_RXE | UTCR3_RIE, micro->base + UTCR3);
-	val = readl(micro->base + UTCR3);
-	val &= ~UTCR3_TIE;
-	writel(val, micro->base + UTCR3);
-}
-
-static irqreturn_t micro_serial_isr(int irq, void *dev_id)
-{
-	struct ipaq_micro *micro = dev_id;
-	struct ipaq_micro_txdev *tx = &micro->tx;
-	u32 status;
-
-	status = readl(micro->base + UTSR0);
-	do {
-		if (status & (UTSR0_RID | UTSR0_RFS)) {
-			if (status & UTSR0_RID)
-				/* Clear the Receiver IDLE bit */
-				writel(UTSR0_RID, micro->base + UTSR0);
-			micro_rx_chars(micro);
-		}
-
-		/* Clear break bits */
-		if (status & (UTSR0_RBB | UTSR0_REB))
-			writel(status & (UTSR0_RBB | UTSR0_REB),
-			       micro->base + UTSR0);
-
-		if (status & UTSR0_TFS)
-			micro_tx_chars(micro);
-
-		status = readl(micro->base + UTSR0);
-
-	} while (((tx->index < tx->len) && (status & UTSR0_TFS)) ||
-		 (status & (UTSR0_RFS | UTSR0_RID)));
-
-	return IRQ_HANDLED;
-}
-
-static const struct mfd_cell micro_cells[] = {
-	{ .name = "ipaq-micro-backlight", },
-	{ .name = "ipaq-micro-battery", },
-	{ .name = "ipaq-micro-keys", },
-	{ .name = "ipaq-micro-ts", },
-	{ .name = "ipaq-micro-leds", },
-};
-
-static int __maybe_unused micro_resume(struct device *dev)
-{
-	struct ipaq_micro *micro = dev_get_drvdata(dev);
-
-	micro_reset_comm(micro);
-	mdelay(10);
-
-	return 0;
-}
-
-static int __init micro_probe(struct platform_device *pdev)
-{
-	struct ipaq_micro *micro;
-	int ret;
-	int irq;
-
-	micro = devm_kzalloc(&pdev->dev, sizeof(*micro), GFP_KERNEL);
-	if (!micro)
-		return -ENOMEM;
-
-	micro->dev = &pdev->dev;
-
-	micro->base = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
-	if (IS_ERR(micro->base))
-		return PTR_ERR(micro->base);
-
-	micro->sdlc = devm_platform_ioremap_resource(pdev, 1);
-	if (IS_ERR(micro->sdlc))
-		return PTR_ERR(micro->sdlc);
-
-	micro_reset_comm(micro);
-
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return -EINVAL;
-	ret = devm_request_irq(&pdev->dev, irq, micro_serial_isr,
-			       IRQF_SHARED, "ipaq-micro",
-			       micro);
-	if (ret) {
-		dev_err(&pdev->dev, "unable to grab serial port IRQ\n");
-		return ret;
-	} else
-		dev_info(&pdev->dev, "grabbed serial port IRQ\n");
-
-	spin_lock_init(&micro->lock);
-	INIT_LIST_HEAD(&micro->queue);
-	platform_set_drvdata(pdev, micro);
-
-	ret = mfd_add_devices(&pdev->dev, pdev->id, micro_cells,
-			      ARRAY_SIZE(micro_cells), NULL, 0, NULL);
-	if (ret) {
-		dev_err(&pdev->dev, "error adding MFD cells");
-		return ret;
-	}
-
-	/* Check version */
-	ipaq_micro_get_version(micro);
-	dev_info(&pdev->dev, "Atmel micro ASIC version %s\n", micro->version);
-	ipaq_micro_eeprom_dump(micro);
-
-	return 0;
-}
-
-static const struct dev_pm_ops micro_dev_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(NULL, micro_resume)
-};
-
-static struct platform_driver micro_device_driver = {
-	.driver   = {
-		.name	= "ipaq-h3xxx-micro",
-		.pm	= &micro_dev_pm_ops,
-		.suppress_bind_attrs = true,
-	},
-};
-builtin_platform_driver_probe(micro_device_driver, micro_probe);
-- 
2.53.0


