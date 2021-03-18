Return-Path: <SRS0=ebT8=IQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9596DC433DB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Mar 2021 05:01:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B57C64EF9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Mar 2021 05:01:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B57C64EF9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F1FGn3qxKz3c2m
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Mar 2021 16:01:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=E11zX/nx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=casper.srs.infradead.org (client-ip=2001:8b0:10b:1236::1;
 helo=casper.infradead.org;
 envelope-from=batv+3da9058682ed8a08391b+6416+infradead.org+hch@casper.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=E11zX/nx; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F1FDl2j6Hz3bvD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Mar 2021 15:59:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=OntMuyQvezkffkb0S1hX5CzLWQu3ErJ8mOHlHelvuXM=; b=E11zX/nxqWzDMDndJHZBXM4+Ky
 EAZBX95Mc+x7sTK2v8k4wdxoIyEUfJdf1ZVFDsAYmP/P8NE6fvrmySQCpZXbQ2PGSIi7org8Z0N14
 6PJX0PE4Cn7J9jxuud/cIpMA87Rqi0YQ+HUuzF4Dt0lsOP81Bt3zmiPKDCa0nyAMQWwifA5Md8cCm
 BKKihoJJoPc/B3cc0kMIesQpKSJnaAJj9pY0CypHSHWwUUSPzJpsXcYYsA/tCqngFL1KXb2fxwiFu
 mnJ3b6f7VQHKJeZr54PJoLcDBM9jVrTfno9mZpoXnCyU8WGdPkMGqCWE5f98YZmgZlP/KtG+5mZOj
 SFRoar5g==;
Received: from [2001:4bb8:18c:bb3:e1cf:ad2f:7ff7:7a0b] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lMkjg-002ZGW-W2; Thu, 18 Mar 2021 04:58:18 +0000
From: Christoph Hellwig <hch@lst.de>
To: "David S. Miller" <davem@davemloft.net>, Jens Axboe <axboe@kernel.dk>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 05/10] MIPS: switch workpad_defconfig from legacy IDE to libata
Date: Thu, 18 Mar 2021 05:57:01 +0100
Message-Id: <20210318045706.200458-6-hch@lst.de>
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

Use libata instead of the deprecated legacy ide driver in
workpad_defconfig.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/configs/workpad_defconfig | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/mips/configs/workpad_defconfig b/arch/mips/configs/workpad_defconfig
index 891a5f77305da1..4798dc86c9ceaf 100644
--- a/arch/mips/configs/workpad_defconfig
+++ b/arch/mips/configs/workpad_defconfig
@@ -26,9 +26,12 @@ CONFIG_IP_MULTICAST=y
 # CONFIG_IPV6 is not set
 CONFIG_NETWORK_SECMARK=y
 CONFIG_BLK_DEV_RAM=m
-CONFIG_IDE=y
-CONFIG_BLK_DEV_IDECS=m
-CONFIG_IDE_GENERIC=y
+# CONFIG_SCSI_PROC_FS is not set
+# CONFIG_SCSI_LOWLEVEL is not set
+CONFIG_ATA=y
+# CONFIG_ATA_VERBOSE_ERROR is not set
+# CONFIG_ATA_FORCE is not set
+# CONFIG_ATA_BMDMA is not set
 CONFIG_NETDEVICES=y
 CONFIG_PCMCIA_3C574=m
 CONFIG_PCMCIA_3C589=m
-- 
2.30.1

