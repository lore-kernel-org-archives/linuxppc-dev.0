Return-Path: <SRS0=lnSH=6X=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A59C28CBC
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 May 2020 19:00:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEB6D208E4
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 May 2020 19:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ey0R8rFt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEB6D208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49KGjz74RTzDr5N
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 May 2020 05:00:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1231::1; helo=merlin.infradead.org;
 envelope-from=geoff@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49KGgv0mp9zDr5D
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 May 2020 04:58:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Date:Cc:To:Subject:From:References:
 In-Reply-To:Message-Id:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=w6PVlsHDLizRg66uVEwUAxJ6BYvUC3ZwsXimRPif9mY=; b=ey0R8rFtp01+2B4o3fxoldeaOg
 Uttm5ogGJtYHvXUgVXe+K2j9KOZ2r5hDZkuZhbkKu7VF7fOMsVz6eU1CHDfiySVR9wEPuXCrG/14e
 vcDbW78Iqnz8akPZhrAJjG0srwdRLsZn5hAPHxhjTyJeG54Au+BHRT+o28gWQLzZ0oQ/JVjsK/xoK
 vMPuz7m20294pQ7jmy0qzeVoHeeQhNbdb1gAN5uHdyUX+XlwF0jnoCsqRkZfkvYFR+kqQTL5Dx94b
 qKCUbO1GxuZNW1gvZkW3DqkjxoF8vnEqQpzR22W/JMcLLXm1cilY64/8WysgucVEk0h+t6BiwN6Sl
 /FzlpboA==;
Received: from geoff by merlin.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jXUgB-0003Dq-Vj; Sat, 09 May 2020 18:58:32 +0000
Message-Id: <c763425d8e6f680d3180b3246c9e77727df179d0.1589049250.git.geoff@infradead.org>
In-Reply-To: <cover.1589049250.git.geoff@infradead.org>
References: <cover.1589049250.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Patch-Date: Sat, 16 Dec 2017 12:32:42 +0100
Subject: [PATCH v2 4/9] drivers/ps3: Remove duplicate error messages
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Sat, 09 May 2020 18:58:31 +0000
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


