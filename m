Return-Path: <SRS0=7LrA=K4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF7DC47083
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Jun 2021 07:07:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EF32601FF
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Jun 2021 07:07:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EF32601FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Fw0TP4tYVz3gBB
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Jun 2021 17:07:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=0A/jGm6O;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+e38fb55258da4e18a096+6492+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=bombadil.20210309 header.b=0A/jGm6O; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Fw0Dk4LfCz3c6g
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Jun 2021 16:56:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=e/ctmVcBKo8/4TfSYThwuDhurHZGsQmtrWLVmP8rYA8=; b=0A/jGm6O4Kj2j/Kx7dvigliFHC
 rITdmfIP63MHFDu3WSFM5d7dMu7+beFsioI4GrDpda176/3PUgnVrUbqyRWbSjWdcuAiJqiob1gTK
 AvRYkCVCw9w56bk5jObu58cLFiy6YDR/IPuribWTRblB+Qy/UxnevwGEDkt/f/knnTFZf15Y8vlCM
 5ocB4AhVAL+iOilDAuQ8GJXKzc8ZFMa3OISnsDLeHTuB1dBage0GQubfEEJs2dxaTysO0wL6PENPG
 HsubMhTFqnBjdPbq87DlkaqfHQIsjrwpF/ip3GpPNqk0nBPScEi1aAKtroJznPZbqZYyddYJMUb2K
 Z/qjGhrw==;
Received: from shol69.static.otenet.gr ([83.235.170.67] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1loKnJ-0026XD-03; Wed, 02 Jun 2021 06:56:01 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 28/30] amiflop: use blk_mq_alloc_disk and blk_cleanup_disk
Date: Wed,  2 Jun 2021 09:53:43 +0300
Message-Id: <20210602065345.355274-29-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210602065345.355274-1-hch@lst.de>
References: <20210602065345.355274-1-hch@lst.de>
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
Cc: Justin Sanders <justin@coraid.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Mike Snitzer <snitzer@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, virtualization@lists.linux-foundation.org,
 dm-devel@redhat.com, "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Jack Wang <jinpu.wang@ionos.com>,
 Tim Waugh <tim@cyberelk.net>, linux-s390@vger.kernel.org,
 Alex Dubov <oakad@yahoo.com>, Richard Weinberger <richard@nod.at>,
 Christian Borntraeger <borntraeger@de.ibm.com>, xen-devel@lists.xenproject.org,
 Ilya Dryomov <idryomov@gmail.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Heiko Carstens <hca@linux.ibm.com>, Josef Bacik <josef@toxicpanda.com>,
 Denis Efremov <efremov@linux.com>, nbd@other.debian.org,
 linux-block@vger.kernel.org, ceph-devel@vger.kernel.org,
 Maxim Levitsky <maximlevitsky@gmail.com>, Geoff Levand <geoff@infradead.org>,
 linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Use blk_mq_alloc_disk and blk_cleanup_disk to simplify the gendisk and
request_queue allocation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/amiflop.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/block/amiflop.c b/drivers/block/amiflop.c
index 9e2d0c6a3877..8b1714021498 100644
--- a/drivers/block/amiflop.c
+++ b/drivers/block/amiflop.c
@@ -1781,15 +1781,13 @@ static int fd_alloc_disk(int drive, int system)
 {
 	struct gendisk *disk;
 
-	disk = alloc_disk(1);
-	if (!disk)
-		goto out;
-	disk->queue = blk_mq_init_queue(&unit[drive].tag_set);
-	if (IS_ERR(disk->queue))
-		goto out_put_disk;
+	disk = blk_mq_alloc_disk(&unit[drive].tag_set, NULL);
+	if (IS_ERR(disk))
+		return PTR_ERR(disk);
 
 	disk->major = FLOPPY_MAJOR;
 	disk->first_minor = drive + system;
+	disk->minors = 1;
 	disk->fops = &floppy_fops;
 	disk->events = DISK_EVENT_MEDIA_CHANGE;
 	if (system)
@@ -1802,12 +1800,6 @@ static int fd_alloc_disk(int drive, int system)
 	unit[drive].gendisk[system] = disk;
 	add_disk(disk);
 	return 0;
-
-out_put_disk:
-	disk->queue = NULL;
-	put_disk(disk);
-out:
-	return -ENOMEM;
 }
 
 static int fd_alloc_drive(int drive)
-- 
2.30.2

