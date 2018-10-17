Return-Path: <SRS0=nnl5=M5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46262ECDE32
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 08:07:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85DC82151D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 08:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X7MU2yqV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85DC82151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42ZlCP4YLzzF3Y4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 19:07:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infradead.org header.i=@infradead.org header.b="X7MU2yqV";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=198.137.202.133;
 helo=bombadil.infradead.org;
 envelope-from=batv+09575c8a9ff34f5a189b+5533+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Zl5g2pSQzF3VB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2018 19:02:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yoAjUj25y4R5GH19rZSL/JJsy5pd/GhDvZgdcIB62yA=; b=X7MU2yqVEazsuPyRnacvedaPZs
 CsZ3UgrEyqpk+KX71xFAxo5avenQuxLrMo7sZNbYJ01awLxfPLW8rsyOF+CwbMVqupXfm0slqPxVc
 sxkswDsXfRb5hlcpbirxzqTf9FtK4uTSZ4m27wjj5ryNrZ0V1AYA97KSgtZKcUScHKL0g1HW3+evo
 jia79FxVUj7IP24meksQRq3pUqQGZYI6hGJRHlhBPnJ7BMIGmP2RuwgSvz8ShsYQVBRPNzu4bB8jt
 VhXbgJApHbyDQG5NhN2gmUJ1B8GbDycaQyJ4uh1P5OzLsQoWTX5vEIew8hki7y1N4dAkvPIkQ8EIq
 PP3PF9gQ==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gCgmR-0003GY-0K; Wed, 17 Oct 2018 08:02:11 +0000
From: Christoph Hellwig <hch@lst.de>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 2/8] powerpc: remove CONFIG_PCI_QSPAN
Date: Wed, 17 Oct 2018 10:01:55 +0200
Message-Id: <20181017080201.10866-3-hch@lst.de>
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

This option isn't actually used anywhere.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/Kconfig | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index a80669209155..e8c8970248bc 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -955,7 +955,6 @@ config PCI
 	bool "PCI support" if PPC_PCI_CHOICE
 	default y if !40x && !CPM2 && !PPC_8xx && !PPC_83xx \
 		&& !PPC_85xx && !PPC_86xx && !GAMECUBE_COMMON
-	default PCI_QSPAN if PPC_8xx
 	select GENERIC_PCI_IOMAP
 	help
 	  Find out whether your system includes a PCI bus. PCI is the name of
@@ -969,14 +968,6 @@ config PCI_DOMAINS
 config PCI_SYSCALL
 	def_bool PCI
 
-config PCI_QSPAN
-	bool "QSpan PCI"
-	depends on PPC_8xx
-	select PPC_I8259
-	help
-	  Say Y here if you have a system based on a Motorola 8xx-series
-	  embedded processor with a QSPAN PCI interface, otherwise say N.
-
 config PCI_8260
 	bool
 	depends on PCI && 8260
-- 
2.19.1

