Return-Path: <linuxppc-dev+bounces-25179-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76883C54F54
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 Jul 2026 12:30:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hBQPg48rHz2yYq;
	Fri, 31 Jul 2026 22:29:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785491351;
	cv=none; b=oRCjsp5FKjEO+5Cqsbjn0fFbi65QDevXgyB5HG/WbR+/4dEg6bNb03bSFp97zhVcN8eV76QGk5l6lQPNguoTiaCgwZo51mIR/suSRSxb9I7wbPo9IYI/gO1BjMCpKafRV18vbnNxcYUsCqgG1vZjONFd51RKoP5blwNlj3X+Qfdx7Z4NNoYDclvNB9eXd1nB2sY/vGDY7OH2Hja3yC6L6B+GrEi7/Rtoab52PvkIvpE2mQ3AXCE08CdUS6YXK6rZDDNh8dmMF06lz+G6Bt9xJ8ZEvMDUg10GoYGjLf4sx8aqCOojzuTO+i2AfmYb2tYcJyXV62YZQIehi+diD/NuYw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785491351; c=relaxed/relaxed;
	bh=/XqHLIespMK4FmpYtmZNRSfYgiJneXTfEmUorgews3s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AIo+lPQPb4hxcIzP75y0G839dH6dIgH2DCwDr3VX24/UKWBSaTCtekWKgJWVf2t5GNj0FpavIisNfBz8VRJOOqJKb6UtJFSTQHXlRbucjaRVplMDYjRgE9WovUYGpQ/u2tgS4+25bc5cR+jGwm8OYjKDDw4HzCw/S4fbd8pbXUL4htpjxvpO30MPcFGnVgeuDSCxGWJAEHvaKki0OUTw8Hn1bTdiUifNnr45mJ6CX43TN8gazDPerMmsYpI627lhHi8liLkh8abDenIKvSaWdozAVSvI8WoLxctu/zYG646eCaSMdAGJ/77SWvENEgdHWmMl0tjLaMbqutM+SZTAzQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass (client-ip=124.126.103.232; helo=mailgw.kylinos.cn; envelope-from=gonglinkai@kylinos.cn; receiver=lists.ozlabs.org) smtp.mailfrom=kylinos.cn
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kylinos.cn (client-ip=124.126.103.232; helo=mailgw.kylinos.cn; envelope-from=gonglinkai@kylinos.cn; receiver=lists.ozlabs.org)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hBLr613kYz2xlQ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2026 19:49:09 +1000 (AEST)
X-UUID: 0d5ed6068cc411f1aa26b74ffac11d73-20260731
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:a5f57544-9df9-4891-87f4-541aad19b3f3,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:e7bac3a,CLOUDID:adc4faf56fb77f26a2ccdb6a84aa5eac,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0d5ed6068cc411f1aa26b74ffac11d73-20260731
X-User: gonglinkai@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <gonglinkai@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1035839986; Fri, 31 Jul 2026 17:41:49 +0800
From: Linkai Gong <gonglinkai@kylinos.cn>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org,
	Linkai Gong <gonglinkai@kylinos.cn>
Subject: [PATCH] macintosh/ans-lcd: check ioremap() return value
Date: Fri, 31 Jul 2026 17:41:44 +0800
Message-Id: <20260731094144.1820681-1-gonglinkai@kylinos.cn>
X-Mailer: git-send-email 2.25.1
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

anslcd_init() used ioremap() without checking for failure and then
called anslcd_write_byte_*() which dereference anslcd_ptr. Return
-ENOMEM if the mapping fails.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Linkai Gong <gonglinkai@kylinos.cn>
---
 drivers/macintosh/ans-lcd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/macintosh/ans-lcd.c b/drivers/macintosh/ans-lcd.c
index fa904b24a600..6ea7fb8666f7 100644
--- a/drivers/macintosh/ans-lcd.c
+++ b/drivers/macintosh/ans-lcd.c
@@ -168,9 +168,11 @@ anslcd_init(void)
 	of_node_put(node);
 
 	anslcd_ptr = ioremap(ANSLCD_ADDR, 0x20);
-	
+	if (!anslcd_ptr)
+		return -ENOMEM;
+
 	retval = misc_register(&anslcd_dev);
-	if(retval < 0){
+	if (retval < 0) {
 		printk(KERN_INFO "LCD: misc_register failed\n");
 		iounmap(anslcd_ptr);
 		return retval;
-- 
2.25.1


