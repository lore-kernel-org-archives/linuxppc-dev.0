Return-Path: <SRS0=4s7t=M7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29AAECDE43
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 12:14:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5336220645
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 12:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hIuucJV4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5336220645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42c4bf1lRGzF3Fl
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 23:14:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infradead.org header.i=@infradead.org header.b="hIuucJV4";
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
 header.b="hIuucJV4"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42c4VS59nCzF3Tp
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 23:10:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
 To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wa8mXHNqTbUu054mBu2kjK6L8KueXUky9nnr1sHKXVs=; b=hIuucJV43asLn2SscvQuG6pFb
 51LjdB7NMUgaT3eIagvM5e9ET31GGsN0mgMLSteWt8XFzpkTr3Tr5/WRLdH5C8MpAlvg7m0C6MW9D
 dDRa53T3xe4e4mz3yIOhIxCivsEWjqqFBmoQnhST6OIdoMmN6aznMRd2I5jevLXUD8nxMtG7ydtF8
 c96adbVVB7J/0DgdK8c7TfiT1oCbXnVZIyTXPpc/lH472clTUAL9B/kvkjHl0CbkqS4hi+hrS56B1
 Hq7S8OwcdSBPi/A0AZhwzwY/v/bA5k7qzgWempHup4Gl+L+NKDHXIkF7dHuvDOS4Ut4727FcfYsq/
 xJjAwP9mw==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gDTbK-0000te-C7; Fri, 19 Oct 2018 12:09:58 +0000
From: Christoph Hellwig <hch@lst.de>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 1/9] aha152x: rename the PCMCIA define
Date: Fri, 19 Oct 2018 14:09:44 +0200
Message-Id: <20181019120952.32763-2-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181019120952.32763-1-hch@lst.de>
References: <20181019120952.32763-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

We plan to enable building the PCMCIA core and drivers, and the
non-prefixed PCMCIA name clashes with some arch headers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/scsi/aha152x.c             | 14 +++++++-------
 drivers/scsi/pcmcia/aha152x_core.c |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/aha152x.c b/drivers/scsi/aha152x.c
index 4d7b0e0adbf7..301b3cad15f8 100644
--- a/drivers/scsi/aha152x.c
+++ b/drivers/scsi/aha152x.c
@@ -269,7 +269,7 @@ static LIST_HEAD(aha152x_host_list);
 /* DEFINES */
 
 /* For PCMCIA cards, always use AUTOCONF */
-#if defined(PCMCIA) || defined(MODULE)
+#if defined(AHA152X_PCMCIA) || defined(MODULE)
 #if !defined(AUTOCONF)
 #define AUTOCONF
 #endif
@@ -297,7 +297,7 @@ CMD_INC_RESID(struct scsi_cmnd *cmd, int inc)
 
 #define DELAY_DEFAULT 1000
 
-#if defined(PCMCIA)
+#if defined(AHA152X_PCMCIA)
 #define IRQ_MIN 0
 #define IRQ_MAX 16
 #else
@@ -328,7 +328,7 @@ MODULE_AUTHOR("Jürgen Fischer");
 MODULE_DESCRIPTION(AHA152X_REVID);
 MODULE_LICENSE("GPL");
 
-#if !defined(PCMCIA)
+#if !defined(AHA152X_PCMCIA)
 #if defined(MODULE)
 static int io[] = {0, 0};
 module_param_hw_array(io, int, ioport, NULL, 0);
@@ -391,7 +391,7 @@ static struct isapnp_device_id id_table[] = {
 MODULE_DEVICE_TABLE(isapnp, id_table);
 #endif /* ISAPNP */
 
-#endif /* !PCMCIA */
+#endif /* !AHA152X_PCMCIA */
 
 static struct scsi_host_template aha152x_driver_template;
 
@@ -863,7 +863,7 @@ void aha152x_release(struct Scsi_Host *shpnt)
 	if (shpnt->irq)
 		free_irq(shpnt->irq, shpnt);
 
-#if !defined(PCMCIA)
+#if !defined(AHA152X_PCMCIA)
 	if (shpnt->io_port)
 		release_region(shpnt->io_port, IO_RANGE);
 #endif
@@ -2924,7 +2924,7 @@ static struct scsi_host_template aha152x_driver_template = {
 	.slave_alloc			= aha152x_adjust_queue,
 };
 
-#if !defined(PCMCIA)
+#if !defined(AHA152X_PCMCIA)
 static int setup_count;
 static struct aha152x_setup setup[2];
 
@@ -3392,4 +3392,4 @@ static int __init aha152x_setup(char *str)
 __setup("aha152x=", aha152x_setup);
 #endif
 
-#endif /* !PCMCIA */
+#endif /* !AHA152X_PCMCIA */
diff --git a/drivers/scsi/pcmcia/aha152x_core.c b/drivers/scsi/pcmcia/aha152x_core.c
index dba3716511c5..24b89228b241 100644
--- a/drivers/scsi/pcmcia/aha152x_core.c
+++ b/drivers/scsi/pcmcia/aha152x_core.c
@@ -1,3 +1,3 @@
-#define PCMCIA	1
+#define AHA152X_PCMCIA 1
 #define AHA152X_STAT 1
 #include "aha152x.c"
-- 
2.19.1

