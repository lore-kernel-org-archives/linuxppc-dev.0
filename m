Return-Path: <SRS0=nnl5=M5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC3BECDE32
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 08:22:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF1AB21523
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 08:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u/6mX1Tv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF1AB21523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42ZlXN3J1XzF3Jb
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 19:22:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infradead.org header.i=@infradead.org header.b="u/6mX1Tv";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+09575c8a9ff34f5a189b+5533+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="u/6mX1Tv"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Zl5q2PP0zDqrV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2018 19:02:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DSIcN8qvKnhJpO2lDoKlSVpfkVyqz30hx1fZYoixgSg=; b=u/6mX1TvMw8AdPho/rmSRqorzT
 kXVR0CCU+M1Y4bbWm8f+lgDZRNR4TwqFs9Y3GWuK+ydrNqU5BhbtVBvR0djiWYBQc2jghEfFet0CP
 h+E4l+5lNFTtAegER7DLVr4KDp9VK4eW2yjWN6Bomq/dBd70yg9BK7ARTJDCUHA+nSL8kgbmvsWSS
 XaPoRGDrihh3DsK2+lEYCYwQHVH+XtuoMZ9f4henXgfJoxifdBbtc+RAYM833AMmt6brR0NqFJVoo
 Uy+eY2oUBk1FQX+2U1ChxFrWEBWWYHabd8RAnJjbvXYKzmij2UGoe6zx0roLJSwOH7QqYBP6tPlox
 U9nGemPw==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gCgmi-0003O9-51; Wed, 17 Oct 2018 08:02:28 +0000
From: Christoph Hellwig <hch@lst.de>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 8/8] kconfig: remove CONFIG_MCA leftovers
Date: Wed, 17 Oct 2018 10:02:01 +0200
Message-Id: <20181017080201.10866-9-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181017080201.10866-1-hch@lst.de>
References: <20181017080201.10866-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: linux-arch@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dominik Brodowski <linux@dominikbrodowski.net>,
 Alexandre Bounine <alex.bou9@gmail.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/powerpc/Kconfig | 4 ----
 drivers/scsi/Kconfig | 6 +++---
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index f2001fff14d1..f3ec13765639 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -944,10 +944,6 @@ config FSL_GTM
 	help
 	  Freescale General-purpose Timers support
 
-# Yes MCA RS/6000s exist but Linux-PPC does not currently support any
-config MCA
-	bool
-
 config PCI_DOMAINS
 	def_bool PCI
 
diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index 7c097006c54d..d3734c54aec9 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -535,7 +535,7 @@ config SCSI_HPTIOP
 
 config SCSI_BUSLOGIC
 	tristate "BusLogic SCSI support"
-	depends on (PCI || ISA || MCA) && SCSI && ISA_DMA_API && VIRT_TO_BUS
+	depends on (PCI || ISA) && SCSI && ISA_DMA_API && VIRT_TO_BUS
 	---help---
 	  This is support for BusLogic MultiMaster and FlashPoint SCSI Host
 	  Adapters. Consult the SCSI-HOWTO, available from
@@ -1142,12 +1142,12 @@ config SCSI_LPFC_DEBUG_FS
 
 config SCSI_SIM710
 	tristate "Simple 53c710 SCSI support (Compaq, NCR machines)"
-	depends on (EISA || MCA) && SCSI
+	depends on EISA && SCSI
 	select SCSI_SPI_ATTRS
 	---help---
 	  This driver is for NCR53c710 based SCSI host adapters.
 
-	  It currently supports Compaq EISA cards and NCR MCA cards
+	  It currently supports Compaq EISA cards.
 
 config SCSI_DC395x
 	tristate "Tekram DC395(U/UW/F) and DC315(U) SCSI support"
-- 
2.19.1

