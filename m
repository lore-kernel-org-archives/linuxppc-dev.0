Return-Path: <SRS0=yiwx=H3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACAB3C433E0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Feb 2021 08:57:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B5E764DF3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Feb 2021 08:57:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B5E764DF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DmRWM6WBgz3cLS
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Feb 2021 19:57:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133;
 helo=out30-133.freemail.mail.aliyun.com;
 envelope-from=yang.lee@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DmRW14Xg7z3cGP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2021 19:57:15 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=yang.lee@linux.alibaba.com;
 NM=1; PH=DS; RN=9; SR=0; TI=SMTPD_---0UPX1XpO_1614243418; 
Received: from
 j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com
 fp:SMTPD_---0UPX1XpO_1614243418) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 25 Feb 2021 16:56:59 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: herbert@gondor.apana.org.au
Subject: [PATCH] crypto/nx: add missing call to of_node_put()
Date: Thu, 25 Feb 2021 16:56:57 +0800
Message-Id: <1614243417-48556-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
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
Cc: linux-kernel@vger.kernel.org, paulus@samba.org,
 linux-crypto@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

In one of the error paths of the for_each_child_of_node() loop,
add missing call to of_node_put().

Fix the following coccicheck warning:
./drivers/crypto/nx/nx-common-powernv.c:927:1-23: WARNING: Function
"for_each_child_of_node" should have of_node_put() before return around
line 936.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/crypto/nx/nx-common-powernv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/nx/nx-common-powernv.c b/drivers/crypto/nx/nx-common-powernv.c
index 13c65de..b43c457 100644
--- a/drivers/crypto/nx/nx-common-powernv.c
+++ b/drivers/crypto/nx/nx-common-powernv.c
@@ -933,6 +933,7 @@ static int __init nx_powernv_probe_vas(struct device_node *pn)
 				NX_CT_GZIP, "ibm,p9-nx-gzip", &ct_gzip);
 
 		if (ret)
+			of_node_put(dn);
 			return ret;
 	}
 
-- 
1.8.3.1

