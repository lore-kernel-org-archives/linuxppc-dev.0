Return-Path: <SRS0=1oDC=MP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2376EC4338F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Jul 2021 20:35:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD60260F23
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Jul 2021 20:35:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BD60260F23
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GWh0C3Rrmz3dvF
	for <linuxppc-dev@archiver.kernel.org>; Sat, 24 Jul 2021 06:35:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=merlin.20170209 header.b=oVGNRVKA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1234::107; helo=merlin.infradead.org;
 envelope-from=geoff@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=merlin.20170209 header.b=oVGNRVKA; 
 dkim-atps=neutral
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1234::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GWgwM4Z4Tz30FZ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Jul 2021 06:31:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Date:Cc:To:Subject:From:References:
 In-Reply-To:Message-Id:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=ZiN7ZFoMH3iWr1xieZ4XL1SnGd5oQPz910OldPrHnOs=; b=oVGNRVKA2WarkS0fVHtEi4/CYu
 9Gs+EUW9g0EI/tvF2uRHNngxIjdQMT+DtifWNlnNjMicUsUUIlKHLOqRwjEBapUgboXSnoA8rvz2J
 udgqkuFotggeuOqKIjxCsodPVDC+PuM37/CMLrlN23e+h4UyJdVnCB69y2B3Qn6iUM/Idpz176Yx4
 LD8uz+MC6qcYIAeh4WhQImRCguBsbh1S0Jm1a4iOKiXFhrtExRSosNNDp9zYtJhDiocUnn5QdZMAR
 evH0kpB0ekI3Rqh7KNC7gaA37iE09NK9X0vG/k3ZSD57sFD7BNyOCcyu/QDWxuPYEuBc8QugnrHt3
 8nMFU+PQ==;
Received: from geoff by merlin.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1m71pj-009Biv-Td; Fri, 23 Jul 2021 20:31:47 +0000
Message-Id: <07e42ec30037d514c1d63f33efe4642364d89802.1627068552.git.geoff@infradead.org>
In-Reply-To: <cover.1627068552.git.geoff@infradead.org>
References: <cover.1627068552.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Patch-Date: Sat, 24 Jul 2021 13:02:14 -0700
Subject: [PATCH v4 08/10] net/ps3_gelic: Rename no to descr_count
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

In an effort to make the PS3 gelic driver easier to maintain, rename
the gelic_card_init_chain parameter 'no' to 'descr_count'.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 drivers/net/ethernet/toshiba/ps3_gelic_net.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/toshiba/ps3_gelic_net.c b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
index e55aa9fecfeb..60fcca5d20dd 100644
--- a/drivers/net/ethernet/toshiba/ps3_gelic_net.c
+++ b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
@@ -325,7 +325,7 @@ static void gelic_card_free_chain(struct gelic_card *card,
  * @card: card structure
  * @chain: address of chain
  * @start_descr: address of descriptor array
- * @no: number of descriptors
+ * @descr_count: number of descriptors
  *
  * we manage a circular list that mirrors the hardware structure,
  * except that the hardware uses bus addresses.
@@ -334,16 +334,16 @@ static void gelic_card_free_chain(struct gelic_card *card,
  */
 static int gelic_card_init_chain(struct gelic_card *card,
 	struct gelic_descr_chain *chain, struct gelic_descr *start_descr,
-	int no)
+	int descr_count)
 {
 	int i;
 	struct gelic_descr *descr;
 	struct device *dev = ctodev(card);
 
 	descr = start_descr;
-	memset(descr, 0, sizeof(*descr) * no);
+	memset(descr, 0, sizeof(*descr) *descr_count);
 
-	for (i = 0; i < no; i++, descr++) {
+	for (i = 0; i < descr_count; i++, descr++) {
 		descr->link.size = sizeof(struct gelic_hw_regs);
 		gelic_descr_set_status(descr, GELIC_DESCR_DMA_NOT_IN_USE);
 		descr->link.cpu_addr =
@@ -361,7 +361,7 @@ static int gelic_card_init_chain(struct gelic_card *card,
 	start_descr->prev = (descr - 1);
 
 	descr = start_descr;
-	for (i = 0; i < no; i++, descr++) {
+	for (i = 0; i < descr_count; i++, descr++) {
 		descr->hw_regs.next_descr_addr =
 			cpu_to_be32(descr->next->link.cpu_addr);
 	}
-- 
2.25.1


