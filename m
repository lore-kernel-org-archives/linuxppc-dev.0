Return-Path: <SRS0=UMO+=JB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D47C433B4
	for <linuxppc-dev@archiver.kernel.org>; Sun,  4 Apr 2021 08:55:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C64146137A
	for <linuxppc-dev@archiver.kernel.org>; Sun,  4 Apr 2021 08:55:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C64146137A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FCng612Qvz3c1g
	for <linuxppc-dev@archiver.kernel.org>; Sun,  4 Apr 2021 18:55:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=wanadoo.fr
 (client-ip=80.12.242.135; helo=smtp.smtpout.orange.fr;
 envelope-from=christophe.jaillet@wanadoo.fr; receiver=<UNKNOWN>)
Received: from smtp.smtpout.orange.fr (smtp13.smtpout.orange.fr
 [80.12.242.135])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FCnfg3Lryz303Q
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Apr 2021 18:54:49 +1000 (AEST)
Received: from localhost.localdomain ([90.126.11.170]) by mwinf5d76 with ME
 id oYuf240093g7mfN03YufPL; Sun, 04 Apr 2021 10:54:43 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 04 Apr 2021 10:54:43 +0200
X-ME-IP: 90.126.11.170
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
 drt@linux.ibm.com, ljp@linux.ibm.com, sukadev@linux.ibm.com,
 tlfalcon@linux.ibm.com, davem@davemloft.net, kuba@kernel.org
Subject: [PATCH] ibmvnic: Use 'skb_frag_address()' instead of hand coding it
Date: Sun,  4 Apr 2021 10:54:37 +0200
Message-Id: <1638085135ee32d5699983981b6a54a11c49ff23.1617526369.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.27.0
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
Cc: netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

'page_address(skb_frag_page()) + skb_frag_off()' can be replaced by an
equivalent 'skb_frag_address()' which is less verbose.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 9c6438d3b3a5..473411542911 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -1678,9 +1678,8 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 		for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
 			const skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
 
-			memcpy(dst + cur,
-			       page_address(skb_frag_page(frag)) +
-			       skb_frag_off(frag), skb_frag_size(frag));
+			memcpy(dst + cur, skb_frag_address(frag),
+			       skb_frag_size(frag));
 			cur += skb_frag_size(frag);
 		}
 	} else {
-- 
2.27.0

