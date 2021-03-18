Return-Path: <SRS0=ebT8=IQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297C1C433DB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Mar 2021 05:01:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD1E864E04
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Mar 2021 05:01:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD1E864E04
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F1FHm3HJkz3c7X
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Mar 2021 16:01:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=pzJ0Yf2l;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=casper.srs.infradead.org (client-ip=2001:8b0:10b:1236::1;
 helo=casper.infradead.org;
 envelope-from=batv+3da9058682ed8a08391b+6416+infradead.org+hch@casper.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=pzJ0Yf2l; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F1FFW1q6cz3cFN
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Mar 2021 15:59:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=D+S8wlSiI4RJjZ5iJm2sxYRqVVY2Unydlyni8O7HV7o=; b=pzJ0Yf2lHvDqADXeBYbA1uMzpD
 I6mDgP2SEN/7rGW4D7M0Ki28esLEuHEzgcaB+m4I0HZb9ICnfb8uKmfHkgbct9yI3HZpieLHqlQEh
 8ZbEn5zQGPKudyNhU8V8cHI31vqq6hKIZ1nqgkPeMR1uuWM6Oxoidcm4R8IxXu0YYrCico+vv8b0e
 k+rwed8gxoGnWEhv0Hg3mbM4FuSQJxw8Qo8gIeaBe+lgf/aXSBWdZLIDAFI/vcihYht+9pWlSAmEG
 4Th3oOBd6lEMeB1Lb+YDe+H2jNV89dT/d7RDozI5Gdo0MLhPGOE1hDuCpQQpdvquZpbflKIZbTYYf
 bGwozUuw==;
Received: from [2001:4bb8:18c:bb3:e1cf:ad2f:7ff7:7a0b] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lMkk1-002ZIG-2u; Thu, 18 Mar 2021 04:58:40 +0000
From: Christoph Hellwig <hch@lst.de>
To: "David S. Miller" <davem@davemloft.net>, Jens Axboe <axboe@kernel.dk>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 07/10] MIPS: disable CONFIG_IDE in bigsur_defconfig
Date: Thu, 18 Mar 2021 05:57:03 +0100
Message-Id: <20210318045706.200458-8-hch@lst.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210318045706.200458-1-hch@lst.de>
References: <20210318045706.200458-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-doc@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-alpha@vger.kernel.org,
 Matt Turner <mattst88@gmail.com>, linux-mips@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

bigsur_defconfig enables CONFIG_IDE for the tc86c001 ide driver, which
is a Toshiba plug in card that does not make much sense to use on bigsur
platforms.  For all other ATA cards libata support is already enabled.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/configs/bigsur_defconfig | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/mips/configs/bigsur_defconfig b/arch/mips/configs/bigsur_defconfig
index eea9b613bb7402..d83e7d600b0a56 100644
--- a/arch/mips/configs/bigsur_defconfig
+++ b/arch/mips/configs/bigsur_defconfig
@@ -105,10 +105,6 @@ CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_EEPROM_LEGACY=y
 CONFIG_EEPROM_MAX6875=y
-CONFIG_IDE=y
-CONFIG_BLK_DEV_IDECD=y
-CONFIG_BLK_DEV_IDETAPE=y
-CONFIG_BLK_DEV_TC86C001=m
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_ST=y
 CONFIG_BLK_DEV_SR=y
-- 
2.30.1

