Return-Path: <SRS0=Ph+o=NX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79013C432BE
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Sep 2021 21:07:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C09D60F6C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Sep 2021 21:07:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0C09D60F6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H0GpJ5Gcyz3c9W
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Sep 2021 07:07:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=umTaGx9x;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=mcgrof@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=bombadil.20210309 header.b=umTaGx9x; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H0Gh34m4lz2xYR
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Sep 2021 07:01:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=adUhWGLmSwGDCmYJPL/wycZ+ESyOItTDyVeSKbBPSXk=; b=umTaGx9xje14epeqy42Bbujh2A
 ZoC7wjPbm0+6zTaI3JWxcPFpd1SVuV1aWnauPvnimangWfy+s2Q/9VLcTt+voKJrcvpRTX0fJ2CES
 NT/0sepfsS9ivwzi2NOdZd4iSZ9TwsfzkuMb2ctH5tDNebMFO47+gZ5rIVGt5OnqM2V30qnsnbcx4
 Ylej2AKlmxgrLM6SxK4y7zhh1gC4GI1pdBKhkwmoa4mG9XwIx8+sleU4H1apJfXOQW+g6YnAs86IC
 RZ6mRnhU/RRwmEAkiOrd5UI+ZZkV3+tBQuqo92zVqMai3LjlBs/pqRB+PT6kXrAfGLy7gxG1F4zcu
 HSqMoUvQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2
 (Red Hat Linux)) id 1mLXLR-007LW3-7L; Wed, 01 Sep 2021 21:00:29 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: axboe@kernel.dk, bhelgaas@google.com, liushixin2@huawei.com,
 thunder.leizhen@huawei.com, lee.jones@linaro.org, geoff@infradead.org,
 mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
 jim@jtan.com, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
 josh.h.morris@us.ibm.com, pjk1939@linux.ibm.com, tim@cyberelk.net,
 richard@nod.at, miquel.raynal@bootlin.com, vigneshr@ti.com
Subject: [PATCH 01/10] mtip32xx: add error handling support for add_disk()
Date: Wed,  1 Sep 2021 14:00:19 -0700
Message-Id: <20210901210028.1750956-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210901210028.1750956-1-mcgrof@kernel.org>
References: <20210901210028.1750956-1-mcgrof@kernel.org>
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
Cc: linux-block@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Luis Chamberlain <mcgrof@kernel.org>, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

We never checked for errors on add_disk() as this function
returned void. Now that this is fixed, use the shiny new
error handling.

The read_capacity_error error label already does what we need,
so just re-use that.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/block/mtip32xx/mtip32xx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 901855717cb5..d0b40309f47e 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -3633,7 +3633,9 @@ static int mtip_block_initialize(struct driver_data *dd)
 	set_capacity(dd->disk, capacity);
 
 	/* Enable the block device and add it to /dev */
-	device_add_disk(&dd->pdev->dev, dd->disk, mtip_disk_attr_groups);
+	rv = device_add_disk(&dd->pdev->dev, dd->disk, mtip_disk_attr_groups);
+	if (rv)
+		goto read_capacity_error;
 
 	if (dd->mtip_svc_handler) {
 		set_bit(MTIP_DDF_INIT_DONE_BIT, &dd->dd_flag);
-- 
2.30.2

