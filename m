Return-Path: <SRS0=1oDC=MP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128BBC4338F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Jul 2021 20:32:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6432160BD3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Jul 2021 20:32:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6432160BD3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GWgwp6VBkz3cc6
	for <linuxppc-dev@archiver.kernel.org>; Sat, 24 Jul 2021 06:32:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=merlin.20170209 header.b=PRJwKuak;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1234::107; helo=merlin.infradead.org;
 envelope-from=geoff@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=merlin.20170209 header.b=PRJwKuak; 
 dkim-atps=neutral
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1234::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GWgwL0QKvz30FS
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Jul 2021 06:31:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Date:Cc:To:Subject:From:References:
 In-Reply-To:Message-Id:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=1TYWW0rzWbWcSSyHi+XDS9UVjhzJx7NyYyJH9V4T3k4=; b=PRJwKuakm6zA9j8iJJ74WtG9x2
 8/owyFtkZrdRCTLSyV5ZtJKjatWdPHf+NOre/VlGuqwPSIetHZ6ZxFACqpBtQcDiWhywjS80ovO82
 BU3xLTHe+2GnZg6GcN/9kUNhgS1tK9HNu4RgI6U2Fzb6xRR0xbLj5ps6qOmE9aaPKN7Hmo+1x4mKo
 +g4T8Voc1120Pv6+yHIF749rLH9Fuvg+VY9o32ZeBVoMhq4NvgRSOufbzOIPpXqVfDVCrUFNIWf22
 hC+sseGApTlS4RDgYAc7wjzXtkzzG4XZGpdokV3sqUiTI4Yj/RIxJk2ro6xG20YODVgk+u5RvnisZ
 mdO4Ci4g==;
Received: from geoff by merlin.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1m71pj-009Bip-I7; Fri, 23 Jul 2021 20:31:47 +0000
Message-Id: <1cdd7f718dde93dcaebf7ddd025869901aa30523.1627068552.git.geoff@infradead.org>
In-Reply-To: <cover.1627068552.git.geoff@infradead.org>
References: <cover.1627068552.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Patch-Date: Sat, 24 Jul 2021 13:02:14 -0700
Subject: [PATCH v4 05/10] net/ps3_gelic: Add vlan_id structure
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

In an effort to make the PS3 gelic driver easier to maintain, add
a definition for the vlan_id structure.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 drivers/net/ethernet/toshiba/ps3_gelic_net.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/toshiba/ps3_gelic_net.c b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
index 946e9bfa071b..54e50ad9e629 100644
--- a/drivers/net/ethernet/toshiba/ps3_gelic_net.c
+++ b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
@@ -1614,13 +1614,14 @@ static struct gelic_card *gelic_alloc_card_net(struct net_device **netdev)
 static void gelic_card_get_vlan_info(struct gelic_card *card)
 {
 	struct device *dev = ctodev(card);
+	unsigned int i;
 	u64 v1, v2;
 	int status;
-	unsigned int i;
-	struct {
+	struct vlan_id {
 		int tx;
 		int rx;
-	} vlan_id_ix[2] = {
+	};
+	struct vlan_id vlan_id_ix[2] = {
 		[GELIC_PORT_ETHERNET_0] = {
 			.tx = GELIC_LV1_VLAN_TX_ETHERNET_0,
 			.rx = GELIC_LV1_VLAN_RX_ETHERNET_0
-- 
2.25.1


