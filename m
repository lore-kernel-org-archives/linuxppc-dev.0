Return-Path: <SRS0=1oDC=MP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D68C4338F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Jul 2021 20:32:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4B2360F25
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Jul 2021 20:32:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B4B2360F25
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GWgxD2smjz3bcc
	for <linuxppc-dev@archiver.kernel.org>; Sat, 24 Jul 2021 06:32:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=merlin.20170209 header.b=ltPXWf17;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1234::107; helo=merlin.infradead.org;
 envelope-from=geoff@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=merlin.20170209 header.b=ltPXWf17; 
 dkim-atps=neutral
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1234::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GWgwK57Ldz30Ch
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Jul 2021 06:31:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Date:Cc:To:Subject:From:References:
 In-Reply-To:Message-Id:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=yOa9fiMlPceWzIqfUAWBPARR3JjCZxDXOfOmeeQNka8=; b=ltPXWf17NOJhhtU1flc6NqXhE1
 n6A85s5mc4wiMte2M/Nbyw+83RyVRI2yUmRxkXrhoFy5RYQiQOm6UiNBZLo8/X0v1Fsgk/DCwqEoZ
 Ce3OLHeXezOtG6OojilMaUoNTtpMA1ZSfOrtv1abtemsHhK5jal1JPVpTrWRADbmIJzoJqIMcL6Mk
 aCFYiuLm3Gog9kTrEspxEIgthFX0w+lD9ygM7qVOrh2Q1NSLVdX71Fs/ZSoiIhGKE0UQQn/xlJjry
 sKUJKD4ezzo3gzxlPfs/P79leoIgMCTDlf1IQ+GyrrE2RP939WztzTSqrM712REOWBlC1wl1ObcFR
 lQjARfqQ==;
Received: from geoff by merlin.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1m71pj-009Bir-LM; Fri, 23 Jul 2021 20:31:47 +0000
Message-Id: <8421aa2c148d840b11b7115208e5276017999c2a.1627068552.git.geoff@infradead.org>
In-Reply-To: <cover.1627068552.git.geoff@infradead.org>
References: <cover.1627068552.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Patch-Date: Sat, 24 Jul 2021 13:02:14 -0700
Subject: [PATCH v4 06/10] net/ps3_gelic: Cleanup debug code
To: David S. Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Date: Fri, 23 Jul 2021 20:31:47 +0000
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
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

In an effort to make the PS3 gelic driver easier to maintain, change the
gelic_card_enable_rxdmac routine to use the optimizer to remove
debug code.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 drivers/net/ethernet/toshiba/ps3_gelic_net.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/toshiba/ps3_gelic_net.c b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
index 54e50ad9e629..85fc1915c8be 100644
--- a/drivers/net/ethernet/toshiba/ps3_gelic_net.c
+++ b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
@@ -162,17 +162,16 @@ static void gelic_card_enable_rxdmac(struct gelic_card *card)
 	struct device *dev = ctodev(card);
 	int status;
 
-#ifdef DEBUG
-	if (gelic_descr_get_status(card->rx_chain.head) !=
-	    GELIC_DESCR_DMA_CARDOWNED) {
-		printk(KERN_ERR "%s: status=%x\n", __func__,
-		       be32_to_cpu(card->rx_chain.head->dmac_cmd_status));
-		printk(KERN_ERR "%s: nextphy=%x\n", __func__,
-		       be32_to_cpu(card->rx_chain.head->hw_regs.next_descr_addr));
-		printk(KERN_ERR "%s: head=%p\n", __func__,
-		       card->rx_chain.head);
+	if (__is_defined(DEBUG) && (gelic_descr_get_status(card->rx_chain.head)
+			!= GELIC_DESCR_DMA_CARDOWNED)) {
+		dev_err(dev, "%s:%d: status=%x\n", __func__, __LINE__,
+			be32_to_cpu(card->rx_chain.head->hw_regs.dmac_cmd_status));
+		dev_err(dev, "%s:%d: nextphy=%x\n", __func__, __LINE__,
+			be32_to_cpu(card->rx_chain.head->hw_regs.next_descr_addr));
+		dev_err(dev, "%s:%d: head=%px\n", __func__, __LINE__,
+			card->rx_chain.head);
 	}
-#endif
+
 	status = lv1_net_start_rx_dma(bus_id(card), dev_id(card),
 		card->rx_chain.head->link.cpu_addr, 0);
 
-- 
2.25.1


