Return-Path: <SRS0=q2Dt=QN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4214AC282CB
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Feb 2019 00:38:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 780B220818
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Feb 2019 00:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HvuIvSW2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 780B220818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43vMy15lhqzDqN0
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Feb 2019 11:38:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="HvuIvSW2"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43vMwC067MzDqMs
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Feb 2019 11:37:14 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id i12so2297206pfo.7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Feb 2019 16:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WfdCioFzbTseBaawu0KavZtAtUhME0p1BmaW9QG2WgI=;
 b=HvuIvSW2IfmAaHbpFtcXVD8h9OB5ItVxD1COY8G9IjKrUu/DIP2vn3UKzwjR2cteHq
 xfKvTH7HTwlKaxbsm2oY1gvn2fzvIqtrwYDGg++tWaY0cxNfbPLfUSt6Rnp6qkYKK7l4
 6fdslErzASbL4QxK+2hFU+xDr61ImsBISPgajx9XORGmrghCBSFVlv3gdsgF8L5qxJbs
 9HflCbYk7FXmrcpxdIUSAdUpvZ1XsVspqd30SH/+r8q5A2v0VGqjfaPELR6PbpSkoXFo
 H8OXWggxLvpt3la9hFRfmVPXGeuxbPIfajutuQJboLyt0dQ7uHAH4lmSF+OLYvQV2FlU
 UJZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=WfdCioFzbTseBaawu0KavZtAtUhME0p1BmaW9QG2WgI=;
 b=p8ZWC4iEmn0WI7kjDBsxvTBUFo8ptHBvdbEBQzhNS7/eMLTxiwPesZxENO1ul7+VtH
 uWSy7wkjLd85FwTuXVvHk+v1s+hBhHg0IccoCvvPti68T6uzKjGwOrroHNo/PwnnMHwd
 ylV5Th0qLhBXGWn7xlujbmHg/qpJKjZk1RTMPFwxN2nejXFgEKa5Jk0vG4v4zpR+AJ6G
 IJ2QRQ4102aGxfi++WATPbXzPBdBOLdnoc8LMXv8g63p0g8KDzr0wa/ZTgrERaWVt44V
 wCd9689St4ia0eOlQKyFqh3GGyTBDgfn/L9wwQrFpCVtW32Kg2wSiQmMmeOuYQvmYx8w
 ErnA==
X-Gm-Message-State: AHQUAuaeBwY6Wko4rSTQ584cWcyG9ClKsQYWs5lPL3Y3ufXt9iOOEW0S
 ftaElKktz0DOdR9LjVTn2Kc=
X-Google-Smtp-Source: AHgI3Ia1lQvagj/wMFSvfYFeEW9H/pWNyuQSBw5wL9k10zMCUCVgiF0xOwknBHUbXkk13acwLXyS1g==
X-Received: by 2002:a63:26c1:: with SMTP id m184mr6600295pgm.367.1549413432820; 
 Tue, 05 Feb 2019 16:37:12 -0800 (PST)
Received: from voyager.jms.id.au ([45.124.203.0])
 by smtp.gmail.com with ESMTPSA id t3sm5474688pgp.5.2019.02.05.16.37.08
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 05 Feb 2019 16:37:12 -0800 (PST)
Received: by voyager.jms.id.au (sSMTP sendmail emulation);
 Wed, 06 Feb 2019 11:07:05 +1030
From: Joel Stanley <joel@jms.id.au>
To: David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Boris Brezillon <bbrezillon@kernel.org>,
 Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>
Subject: [PATCH] mtd: powernv: SPDX and comment fixups
Date: Wed,  6 Feb 2019 11:06:58 +1030
Message-Id: <20190206003659.27107-1-joel@jms.id.au>
X-Mailer: git-send-email 2.20.1
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
Cc: linux-mtd@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This converts the powernv flash driver to use SPDX, and adds some
clarifying comments that came out of a discussion on how the mtd driver
works.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/mtd/devices/powernv_flash.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/mtd/devices/powernv_flash.c b/drivers/mtd/devices/powernv_flash.c
index 22f753e555ac..0bf43336c3f7 100644
--- a/drivers/mtd/devices/powernv_flash.c
+++ b/drivers/mtd/devices/powernv_flash.c
@@ -1,17 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
+
 /*
  * OPAL PNOR flash MTD abstraction
  *
  * Copyright IBM 2015
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/kernel.h>
@@ -261,6 +253,14 @@ static int powernv_flash_probe(struct platform_device *pdev)
 	 * The current flash that skiboot exposes is one contiguous flash chip
 	 * with an ffs partition at the start, it should prove easier for users
 	 * to deal with partitions or not as they see fit
+	 *
+	 * When developing the skiboot MTD driver an experiment with FFS
+	 * parsing in the kernel, and exposing a seperate /dev/mtdX for each
+	 * partition (eg BOOTKERNEL, PAYLOAD, NVRAM, etc), was done.
+	 *
+	 * We didn't go with that as it meant users couldn't do a full flash
+	 * re-write, as this can cause a partition to change size, and there
+	 * wasn't a way to tell the MTD layer that a device has shrunk/grown.
 	 */
 	return mtd_device_register(&data->mtd, NULL, 0);
 }
-- 
2.20.1

