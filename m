Return-Path: <SRS0=GbMY=KQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A697C433B4
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 May 2021 05:58:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E63060FD8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 May 2021 05:58:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E63060FD8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FmbVy5xWxz3cGR
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 May 2021 15:58:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=gTvJfqIc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+940d4f53d1157bf1ee93+6480+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=bombadil.20210309 header.b=gTvJfqIc; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FmbNM0TNJz3bt6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 May 2021 15:52:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=jZkT+4psi6ph2wRk+l9KSW/tYTO6iyA31KtsYsWzBgk=; b=gTvJfqIchvXjSFkKDd6k63hHCF
 HmXWz2+G4jM58pGsTWQB42xemCLlQJUhts0XnRfbD4wMN1PVYvr0P/KPJj4SvCnY8wGuR/p6fs3Vv
 pe9aVmHLh37anrADvL2A6tBFdkzZ35+FU9WeEQBp4Y7VFv4qJomaUHyJz4stopkYwlecIkiOV5TqV
 yB9ucKNbR/t/GN6LlVcWbbgLApSItXSlfB5jjMKNhHNM6Sm7Zb5/9EuzfQrWM4I7q9U099TEHhhcj
 kysQ+DqqAYqfAZdOCQpfJkKTntid+LbAnyRue0zwha2pfj4O946vAEcmJkBJOVAGmJZ2SvP/Fdi3p
 5x4KaAQA==;
Received: from [2001:4bb8:180:5add:4fd7:4137:d2f2:46e6] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1ljy4i-00Gq1p-Er; Fri, 21 May 2021 05:51:56 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>, Jim Paris <jim@jtan.com>,
 Joshua Morris <josh.h.morris@us.ibm.com>,
 Philip Kelleher <pjk1939@linux.ibm.com>, Minchan Kim <minchan@kernel.org>,
 Nitin Gupta <ngupta@vflare.org>, Matias Bjorling <mb@lightnvm.io>,
 Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
 Song Liu <song@kernel.org>, Maxim Levitsky <maximlevitsky@gmail.com>,
 Alex Dubov <oakad@yahoo.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 12/26] bcache: convert to blk_alloc_disk/blk_cleanup_disk
Date: Fri, 21 May 2021 07:51:02 +0200
Message-Id: <20210521055116.1053587-13-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210521055116.1053587-1-hch@lst.de>
References: <20210521055116.1053587-1-hch@lst.de>
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
Cc: linux-bcache@vger.kernel.org, linux-xtensa@linux-xtensa.org,
 linux-raid@vger.kernel.org, nvdimm@lists.linux.dev, linux-s390@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 dm-devel@redhat.com, linuxppc-dev@lists.ozlabs.org, drbd-dev@lists.linbit.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Convert the bcache driver to use the blk_alloc_disk and blk_cleanup_disk
helpers to simplify gendisk and request_queue allocation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/bcache/super.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index bea8c4429ae8..185246a0d855 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -890,13 +890,9 @@ static void bcache_device_free(struct bcache_device *d)
 		if (disk_added)
 			del_gendisk(disk);
 
-		if (disk->queue)
-			blk_cleanup_queue(disk->queue);
-
+		blk_cleanup_disk(disk);
 		ida_simple_remove(&bcache_device_idx,
 				  first_minor_to_idx(disk->first_minor));
-		if (disk_added)
-			put_disk(disk);
 	}
 
 	bioset_exit(&d->bio_split);
@@ -946,7 +942,7 @@ static int bcache_device_init(struct bcache_device *d, unsigned int block_size,
 			BIOSET_NEED_BVECS|BIOSET_NEED_RESCUER))
 		goto err;
 
-	d->disk = alloc_disk(BCACHE_MINORS);
+	d->disk = blk_alloc_disk(NUMA_NO_NODE);
 	if (!d->disk)
 		goto err;
 
@@ -955,14 +951,11 @@ static int bcache_device_init(struct bcache_device *d, unsigned int block_size,
 
 	d->disk->major		= bcache_major;
 	d->disk->first_minor	= idx_to_first_minor(idx);
+	d->disk->minors		= BCACHE_MINORS;
 	d->disk->fops		= ops;
 	d->disk->private_data	= d;
 
-	q = blk_alloc_queue(NUMA_NO_NODE);
-	if (!q)
-		return -ENOMEM;
-
-	d->disk->queue			= q;
+	q = d->disk->queue;
 	q->limits.max_hw_sectors	= UINT_MAX;
 	q->limits.max_sectors		= UINT_MAX;
 	q->limits.max_segment_size	= UINT_MAX;
-- 
2.30.2

