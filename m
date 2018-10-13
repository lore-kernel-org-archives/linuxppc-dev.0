Return-Path: <SRS0=nAH3=MZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6814C28CF8
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 15:41:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19F5620659
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 15:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u8uhjz0l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19F5620659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42XTSh6VVmzF3Jw
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Oct 2018 02:41:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infradead.org header.i=@infradead.org header.b="u8uhjz0l";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+5d6e0690757439347628+5529+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="u8uhjz0l"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42XTQ52rhKzF2Dv
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Oct 2018 02:38:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
 To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Nm1QlJJRyF2xjNFv5r9tVlXvgAX48gyY7OQjIrXdCSc=; b=u8uhjz0lZngbDcIKcg5qNt426
 YkKfsSRjwZ3cLStdWta2VyBxc+01C+Mi/TY0LDWDQ7YJGGdaAhUSXIZXP3ocph17HlSSra8Gd7w90
 lsNiWfi9iFx/mAX/HvWHxPlPca15h1BeoeJHg4Rv1mkde5kRSOqUPGwVRKdqHkBmFWRPAhXaLa4fx
 cnmiChYcq1gX7rGOBJfS4/fazXWrN8/xPrBTiyr5WiozImhWVmEc8j/1oVCQmpu/ubp9seWGlgPtv
 6FYYYdHBJOiHyn+mpwxYJVDqjcts6A9pW8XvuxM+IWYFsoXd9g5w+rUtxWDy6M+OEIynThgS8Bg6+
 eWPKSWrYw==;
Received: from 089144199123.atnat0008.highway.a1.net ([89.144.199.123]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gBLYb-0002rE-H6; Sat, 13 Oct 2018 15:10:21 +0000
From: Christoph Hellwig <hch@lst.de>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 1/8] aha152x: rename the PCMCIA define
Date: Sat, 13 Oct 2018 17:10:09 +0200
Message-Id: <20181013151016.31674-2-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181013151016.31674-1-hch@lst.de>
References: <20181013151016.31674-1-hch@lst.de>
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
 Alexandre Bounine <alex.bou9@gmail.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

We plan to enable building the pcmcia core and drivers, and the
non-prefixed PCMCIA name clashes with some arch headers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
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

