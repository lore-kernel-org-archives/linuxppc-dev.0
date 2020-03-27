Return-Path: <SRS0=yRDn=5M=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5D3C43331
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2020 20:43:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E88E206F1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2020 20:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pj5pcsnE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E88E206F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48pv2J2vnbzDrPj
	for <linuxppc-dev@archiver.kernel.org>; Sat, 28 Mar 2020 07:43:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1231::1; helo=merlin.infradead.org;
 envelope-from=geoff@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=merlin.20170209 header.b=pj5pcsnE; 
 dkim-atps=neutral
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48ptgC0Yj0zDrJq
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2020 07:26:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Date:Cc:To:Subject:From:References:
 In-Reply-To:Message-Id:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=w6PVlsHDLizRg66uVEwUAxJ6BYvUC3ZwsXimRPif9mY=; b=pj5pcsnEWN07zIu5netfLgeFel
 JtyHjbIotP/J0i4ujyMIFa12RVk2pwyepTReO9xEpKxkDDS+18Ceg9R6JMqj/PEqpPcBVOUW1ChZx
 B6zaN0w2k543oBvgX9T4ccs6ROfyp8OLjTPSwgPaY7jD2X89A1+eFawATxP/UEVseqBWrJN6TO+mn
 6mOe/hlPrSp0khyMbLdib63D3qp9m3R8B7uZ++6U9v4qOW/JWe4kevNO/eRyytih4+8UypMWTWbOz
 r3yci6rDDNIRyQ7jUhOWoAk1kQfUz5+sn6eP/+JxhWDPTdMftkNh3vR1EFgyo4fmBiYSBNxwM9BkD
 BL4fPXww==;
Received: from geoff by merlin.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jHvYd-0003IZ-8u; Fri, 27 Mar 2020 20:26:23 +0000
Message-Id: <589b295fa341b6f73151e5cb4429d4557c58dbff.1585340156.git.geoff@infradead.org>
In-Reply-To: <cover.1585340156.git.geoff@infradead.org>
References: <cover.1585340156.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Patch-Date: Sat, 16 Dec 2017 12:32:42 +0100
Subject: [PATCH 2/9] drivers/ps3: Remove duplicate error messages
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Fri, 27 Mar 2020 20:26:23 +0000
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
Cc: linuxppc-dev@lists.ozlabs.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 Markus Elfring <elfring@users.sourceforge.net>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 Emmanuel Nicolet <emmanuel.nicolet@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Markus Elfring <elfring@users.sourceforge.net>

Remove duplicate memory allocation failure error messages.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 drivers/ps3/ps3-lpm.c   | 2 --
 drivers/ps3/ps3-vuart.c | 1 -
 2 files changed, 3 deletions(-)

diff --git a/drivers/ps3/ps3-lpm.c b/drivers/ps3/ps3-lpm.c
index 83c45659bc9d..fcc346296e3a 100644
--- a/drivers/ps3/ps3-lpm.c
+++ b/drivers/ps3/ps3-lpm.c
@@ -1111,8 +1111,6 @@ int ps3_lpm_open(enum ps3_lpm_tb_type tb_type, void *tb_cache,
 		lpm_priv->tb_cache_internal = kzalloc(
 			lpm_priv->tb_cache_size + 127, GFP_KERNEL);
 		if (!lpm_priv->tb_cache_internal) {
-			dev_err(sbd_core(), "%s:%u: alloc internal tb_cache "
-				"failed\n", __func__, __LINE__);
 			result = -ENOMEM;
 			goto fail_malloc;
 		}
diff --git a/drivers/ps3/ps3-vuart.c b/drivers/ps3/ps3-vuart.c
index ddaa5ea5801a..3b5878edc6c2 100644
--- a/drivers/ps3/ps3-vuart.c
+++ b/drivers/ps3/ps3-vuart.c
@@ -917,7 +917,6 @@ static int ps3_vuart_bus_interrupt_get(void)
 	vuart_bus_priv.bmp = kzalloc(sizeof(struct ports_bmp), GFP_KERNEL);
 
 	if (!vuart_bus_priv.bmp) {
-		pr_debug("%s:%d: kzalloc failed.\n", __func__, __LINE__);
 		result = -ENOMEM;
 		goto fail_bmp_malloc;
 	}
-- 
2.20.1


