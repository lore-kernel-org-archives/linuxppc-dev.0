Return-Path: <SRS0=4s7t=M7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA734ECDE43
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 12:21:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50FC321486
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 12:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UOynJtN6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50FC321486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42c4lH4nGHzF3Vc
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 23:21:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infradead.org header.i=@infradead.org header.b="UOynJtN6";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+1390e5f2eb4877bdb648+5535+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="UOynJtN6"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42c4Vg1qJvzF3Vc
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 23:10:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OLdpU/Lx2kG/LtqEJaUA/6yYmO6K2xQpzfu8jS6tJX0=; b=UOynJtN6fLkjrjEuEDJdlfRI7r
 rJKtlO3dI54AaE6B6RSOAyJxw1hxddhhm/0oNeZqt8s95JOErgutKjT2yiDBr1So6LvguiCYNCEID
 +HKNIbfIaCgJkRonBCbU+oLJFfWzzDv/aiIkwlAnuUGMM1C9OGxnD2g7u//Ab+/VBxnf1deDqqnjw
 JNQmBU4m9TEpLdU1sxH028jNNnqizi9n0zJ/CW2K8flUJEn5+FM5l6knlCPypUfxR7sb8oeEoJ/9g
 YUvdPwrXuwgwHbIZJITzO5L98+821rws8Nfkja3HvsFnUPh87VFo7CvLKPBRfe0ED+tERWUclITOF
 kWfX3dfQ==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gDTbN-0000uR-Jn; Fri, 19 Oct 2018 12:10:02 +0000
From: Christoph Hellwig <hch@lst.de>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 2/9] arm: remove EISA kconfig option
Date: Fri, 19 Oct 2018 14:09:45 +0200
Message-Id: <20181019120952.32763-3-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181019120952.32763-1-hch@lst.de>
References: <20181019120952.32763-1-hch@lst.de>
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
 Alexandre Bounine <alex.bou9@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

No arm config enables EISA, and arm does not include drivers/eisa/Kconfig
which provides support for things like PCI to EISA bridges, so it is most
likely dead.

If this is wrong we will be able to resurrect it easily by selecting
HAVE_EISA for the right arm configs after this series.

Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/Kconfig | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e8cd55a5b04c..e33735ce1c14 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -165,21 +165,6 @@ config HAVE_PROC_CPU
 config NO_IOPORT_MAP
 	bool
 
-config EISA
-	bool
-	---help---
-	  The Extended Industry Standard Architecture (EISA) bus was
-	  developed as an open alternative to the IBM MicroChannel bus.
-
-	  The EISA bus provided some of the features of the IBM MicroChannel
-	  bus while maintaining backward compatibility with cards made for
-	  the older ISA bus.  The EISA bus saw limited use between 1988 and
-	  1995 when it was made obsolete by the PCI bus.
-
-	  Say Y here if you are building a kernel for an EISA-based machine.
-
-	  Otherwise, say N.
-
 config SBUS
 	bool
 
-- 
2.19.1

