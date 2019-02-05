Return-Path: <SRS0=EZew=QM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02B3C282CB
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 22:22:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 484CD2184E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 22:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="EgjXTOrJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 484CD2184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43vJx43JKWzDqP2
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Feb 2019 09:22:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=163.com
 (client-ip=220.181.12.14; helo=m12-14.163.com;
 envelope-from=albin_yang@163.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=163.com header.i=@163.com header.b="EgjXTOrJ"; 
 dkim-atps=neutral
X-Greylist: delayed 941 seconds by postgrey-1.36 at bilbo;
 Wed, 06 Feb 2019 03:30:45 AEDT
Received: from m12-14.163.com (m12-14.163.com [220.181.12.14])
 by lists.ozlabs.org (Postfix) with ESMTP id 43v96s2M7vzDqMw
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Feb 2019 03:30:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=jARUoRW17FxakUWw4F
 dVktvIcRt/8JGS028HKSeeOmc=; b=EgjXTOrJP0eUbS5yw/0+SNXPV3m3YiZued
 0jXByFORjMJQZrm/uxe7/6vmVgK64IwspMeG3afZq5eDKfIQ1Dugm5lXbd5BRePa
 mWzxQfUjDU09LAXwW4x2EVAny8UsCoDt19vg/M+IJ355tTuqhm20nsu/ASThI+br
 D0QkicNOk=
Received: from localhost.localdomain (unknown [171.210.152.198])
 by smtp10 (Coremail) with SMTP id DsCowAD3hR59tllcWFqUEQ--.43198S3;
 Wed, 06 Feb 2019 00:14:55 +0800 (CST)
From: Yang Wei <albin_yang@163.com>
To: netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH net] net: fsl_ucc_hdlc: replace dev_kfree_skb_irq by
 dev_consume_skb_irq for drop profiles
Date: Wed,  6 Feb 2019 00:14:51 +0800
Message-Id: <1549383291-5511-1-git-send-email-albin_yang@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: DsCowAD3hR59tllcWFqUEQ--.43198S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrtrWDKF13XF4DKF1fKryfJFb_yoW3KFc_u3
 4Iqa1xZw17Xrn09w1xKF1FyFySvw15XFWvvryftFW3Xa42vF1UJrZ5XFZrWr9xKa18CryD
 KFZ2vFZ8ury3XjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0Uku7UUUUU==
X-Originating-IP: [171.210.152.198]
X-CM-SenderInfo: pdoex0xb1d0wi6rwjhhfrp/1tbiwB9SolXlixb4pAAAse
X-Mailman-Approved-At: Wed, 06 Feb 2019 09:21:15 +1100
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
Cc: yang.wei9@zte.com.cn, albin_yang@163.com, davem@davemloft.net,
 qiang.zhao@nxp.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Yang Wei <yang.wei9@zte.com.cn>

dev_consume_skb_irq() should be called in hdlc_tx_done() when skb
xmit done. It makes drop profiles(dropwatch, perf) more friendly.

Signed-off-by: Yang Wei <yang.wei9@zte.com.cn>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index 66d889d..a08f04c 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -482,7 +482,7 @@ static int hdlc_tx_done(struct ucc_hdlc_private *priv)
 		memset(priv->tx_buffer +
 		       (be32_to_cpu(bd->buf) - priv->dma_tx_addr),
 		       0, skb->len);
-		dev_kfree_skb_irq(skb);
+		dev_consume_skb_irq(skb);
 
 		priv->tx_skbuff[priv->skb_dirtytx] = NULL;
 		priv->skb_dirtytx =
-- 
2.7.4


