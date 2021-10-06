Return-Path: <SRS0=wNeI=O2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADD7C433F5
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Oct 2021 02:13:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4995F611C6
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Oct 2021 02:13:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4995F611C6
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HPJ065qgdz304m
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Oct 2021 13:13:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256 header.s=201707 header.b=G/yurCq3;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org
 [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HPHym1XbTz2xr4
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Oct 2021 13:12:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256
 header.s=201707 header.b=G/yurCq3; dkim-atps=neutral
Received: by gandalf.ozlabs.org (Postfix, from userid 1010)
 id 4HPHym15XQz4xbV; Wed,  6 Oct 2021 13:12:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
 s=201707; t=1633486336;
 bh=eVFqeu6gtrpCX/MVgIBNrUK2StKPGHzmh/wNXLS7aEI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=G/yurCq3QDxMXPIVgIo7NvHfR8yJHsfkMw9vNMgchjnA2lYJkQBMDg9OTmQqGcGDc
 yCgkZBl25i3y2KpQT7RFpl+wQsPV9Lr50EO8JiUUG8UDmJiwNBgzWYIlNUGUF/LJ2h
 4FhwkKaE4PpKqSlAmFTKz+iT44zWL1Z3iloBM8kL8dnOikXx/xmTIBVdJKfXL1KK7S
 nvv+3Cu9IdbPJZmBil4IT7CRsIwVbnzPO4dhuCp7FyxWHqcU0BuwoJ1OtGhN0y7JG3
 wevolnfQKjiBOW9ofgVxBSvmTmzRzgK4lRzV0eJjDKOQBeUMmzK5jZs7HbfVOOZnxF
 5DaboHs3dpbDQ==
From: Anton Blanchard <anton@ozlabs.org>
To: alistair@popple.id.au, joel@jms.id.au, andrew@aj.id.au, clg@kaod.org,
 mikey@neuling.org, jk@codeconstruct.com.au
Subject: [RFC 2/5] ipmi:bt-bmc: Prefix ASPEED specific registers with ASPEED_
Date: Wed,  6 Oct 2021 13:12:02 +1100
Message-Id: <20211006021205.2579057-2-anton@ozlabs.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211006021205.2579057-1-anton@ozlabs.org>
References: <20211006021205.2579057-1-anton@ozlabs.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Signed-off-by: Anton Blanchard <anton@ozlabs.org>
---
 drivers/char/ipmi/bt-bmc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/char/ipmi/bt-bmc.c b/drivers/char/ipmi/bt-bmc.c
index f85fafc96ef6..2b0fe1255026 100644
--- a/drivers/char/ipmi/bt-bmc.c
+++ b/drivers/char/ipmi/bt-bmc.c
@@ -26,19 +26,19 @@
 #define BT_IO_BASE	0xe4
 #define BT_IRQ		10
 
-#define BT_CR0		0x0
+#define ASPEED_BT_CR0	0x0
 #define   BT_CR0_IO_BASE		16
 #define   BT_CR0_IRQ			12
 #define   BT_CR0_EN_CLR_SLV_RDP		0x8
 #define   BT_CR0_EN_CLR_SLV_WRP		0x4
 #define   BT_CR0_ENABLE_IBT		0x1
-#define BT_CR1		0x4
+#define ASPEED_BT_CR1	0x4
 #define   BT_CR1_IRQ_H2B	0x01
 #define   BT_CR1_IRQ_HBUSY	0x40
-#define BT_CR2		0x8
+#define ASPEED_BT_CR2	0x8
 #define   BT_CR2_IRQ_H2B	0x01
 #define   BT_CR2_IRQ_HBUSY	0x40
-#define BT_CR3		0xc
+#define ASPEED_BT_CR3	0xc
 
 #define BT_CTRL		0x10
 #define   BT_CTRL_B_BUSY		0x80
@@ -379,7 +379,7 @@ static irqreturn_t aspeed_bt_bmc_irq(int irq, void *arg)
 	u32 reg;
 	int rc;
 
-	rc = regmap_read(bt_bmc->map, bt_bmc->offset + BT_CR2, &reg);
+	rc = regmap_read(bt_bmc->map, bt_bmc->offset + ASPEED_BT_CR2, &reg);
 	if (rc)
 		return IRQ_NONE;
 
@@ -388,7 +388,7 @@ static irqreturn_t aspeed_bt_bmc_irq(int irq, void *arg)
 		return IRQ_NONE;
 
 	/* ack pending IRQs */
-	regmap_write(bt_bmc->map, bt_bmc->offset + BT_CR2, reg);
+	regmap_write(bt_bmc->map, bt_bmc->offset + ASPEED_BT_CR2, reg);
 
 	wake_up(&bt_bmc->queue);
 	return IRQ_HANDLED;
@@ -418,7 +418,7 @@ static int aspeed_bt_bmc_config_irq(struct bt_bmc *bt_bmc,
 	 * will be cleared (along with B2H) when we can write the next
 	 * message to the BT buffer
 	 */
-	rc = regmap_update_bits(bt_bmc->map, bt_bmc->offset + BT_CR1,
+	rc = regmap_update_bits(bt_bmc->map, bt_bmc->offset + ASPEED_BT_CR1,
 				(BT_CR1_IRQ_H2B | BT_CR1_IRQ_HBUSY),
 				(BT_CR1_IRQ_H2B | BT_CR1_IRQ_HBUSY));
 
@@ -427,7 +427,7 @@ static int aspeed_bt_bmc_config_irq(struct bt_bmc *bt_bmc,
 
 static void aspeed_enable_bt(struct bt_bmc *bt_bmc)
 {
-	regmap_write(bt_bmc->map, bt_bmc->offset + BT_CR0,
+	regmap_write(bt_bmc->map, bt_bmc->offset + ASPEED_BT_CR0,
 		     (BT_IO_BASE << BT_CR0_IO_BASE) |
 		     (BT_IRQ << BT_CR0_IRQ) |
 		     BT_CR0_EN_CLR_SLV_RDP |
-- 
2.31.1

