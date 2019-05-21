Return-Path: <SRS0=oIc7=TV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA99AC04AAF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 May 2019 14:12:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F007920863
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 May 2019 14:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="CjHJfRxo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F007920863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 457d4r5FxjzDqDY
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 May 2019 00:12:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="CjHJfRxo"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 457cDv4pbTzDqK1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 May 2019 23:34:23 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 457cDq1XBbz9v2Xd;
 Tue, 21 May 2019 15:34:19 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=CjHJfRxo; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id LBpr19dfm8xn; Tue, 21 May 2019 15:34:19 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 457cDq0QQNz9v2XX;
 Tue, 21 May 2019 15:34:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1558445659; bh=e4R1GxV4BLvdkAcYfG6P+bOpOR7fSCB+O6QW8jlVDQg=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=CjHJfRxoBz5hIT0XzNtGoYzOSJ6qp72Q8t7+nN+GJ9KXRKuZ+PniCX0ana0GZhFP1
 bMGkv0wI6BUfDfF5BlMAnKXotEH5YdkyKlfABx+8Nr7p+aNn/kcXQQ6yf6ow6SKpMt
 5+BbGdM2Ka85wCZQ/DquMdAjrnkUEcdw50ItHv0U=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 83AEC8B80C;
 Tue, 21 May 2019 15:34:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id o2Pqt-vI2WuY; Tue, 21 May 2019 15:34:20 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 543AB8B803;
 Tue, 21 May 2019 15:34:20 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 188DF68458; Tue, 21 May 2019 13:34:20 +0000 (UTC)
Message-Id: <0d6806d4de952f2ed7be8d1dbfde32a25da613bf.1558445259.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1558445259.git.christophe.leroy@c-s.fr>
References: <cover.1558445259.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 13/15] Revert "crypto: talitos - export the talitos_submit
 function"
To: Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, horia.geanta@nxp.com
Date: Tue, 21 May 2019 13:34:20 +0000 (UTC)
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

There is no other file using talitos_submit in the kernel tree,
so it doesn't need to be exported nor made global.

This reverts commit 865d506155b117edc7e668ced373030ce7108ce9.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Fixes: 865d506155b1 ("crypto: talitos - export the talitos_submit function")
---
 drivers/crypto/talitos.c | 11 +++++------
 drivers/crypto/talitos.h |  6 ------
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index 12917fd54bcb..6fe900d8e5d8 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -278,11 +278,11 @@ static int init_device(struct device *dev)
  * callback must check err and feedback in descriptor header
  * for device processing status.
  */
-int talitos_submit(struct device *dev, int ch, struct talitos_desc *desc,
-		   void (*callback)(struct device *dev,
-				    struct talitos_desc *desc,
-				    void *context, int error),
-		   void *context)
+static int talitos_submit(struct device *dev, int ch, struct talitos_desc *desc,
+			  void (*callback)(struct device *dev,
+					   struct talitos_desc *desc,
+					   void *context, int error),
+			  void *context)
 {
 	struct talitos_private *priv = dev_get_drvdata(dev);
 	struct talitos_request *request;
@@ -332,7 +332,6 @@ int talitos_submit(struct device *dev, int ch, struct talitos_desc *desc,
 
 	return -EINPROGRESS;
 }
-EXPORT_SYMBOL(talitos_submit);
 
 /*
  * process what was done, notify callback of error if not
diff --git a/drivers/crypto/talitos.h b/drivers/crypto/talitos.h
index dbedd0956c8a..95e97951b924 100644
--- a/drivers/crypto/talitos.h
+++ b/drivers/crypto/talitos.h
@@ -150,12 +150,6 @@ struct talitos_private {
 	bool rng_registered;
 };
 
-extern int talitos_submit(struct device *dev, int ch, struct talitos_desc *desc,
-			  void (*callback)(struct device *dev,
-					   struct talitos_desc *desc,
-					   void *context, int error),
-			  void *context);
-
 /* .features flag */
 #define TALITOS_FTR_SRC_LINK_TBL_LEN_INCLUDES_EXTENT 0x00000001
 #define TALITOS_FTR_HW_AUTH_CHECK 0x00000002
-- 
2.13.3

