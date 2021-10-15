Return-Path: <SRS0=ZqAX=PD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73120C433F5
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Oct 2021 23:54:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0954261101
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Oct 2021 23:54:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0954261101
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HWNRX0yNlz3cK8
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Oct 2021 10:54:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Jjlk8pvA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=mcgrof@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=bombadil.20210309 header.b=Jjlk8pvA; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HWNPS6YPPz2yy3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Oct 2021 10:53:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=+2LEMN1XpiXKACzO2eJ6NkEHApTLeNqeZiilGza0YlE=; b=Jjlk8pvArEGMnx4jkmd2938ccV
 ob+hr+a1J3MtEl2X0rDuA8TL+WP3gCuxl30kYrFyV8X0i9xaOxYLaXHc/Alp1hJWbVPwuxWdcqyVs
 gIdLRUBfIKutjBUP3eTW8MVIGPp8BofTZ9vvIv2RzLIXWmU924dlWbeaQVGq4Xqv0PUwBccp0qJHP
 jbs8GF+gSRDcGeDm6xm+yCHucQhkZsUxuN+j9J9c0PbGSi2o4OyuhdYJscVdmK3d0938vB9eSP/g4
 xUx3XqpUyB5m9VQVzTZaaUigf6jY54ZsR0OkgjwU4P6pmIqWY4+BYbpuWPnPZJFVmJcGIV/qLlH1i
 7U18sTtg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2
 (Red Hat Linux)) id 1mbWzs-009C2v-VN; Fri, 15 Oct 2021 23:52:20 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: axboe@kernel.dk, geoff@infradead.org, mpe@ellerman.id.au,
 benh@kernel.crashing.org, paulus@samba.org, jim@jtan.com,
 minchan@kernel.org, ngupta@vflare.org, senozhatsky@chromium.org,
 richard@nod.at, miquel.raynal@bootlin.com, vigneshr@ti.com,
 dan.j.williams@intel.com, vishal.l.verma@intel.com, dave.jiang@intel.com,
 ira.weiny@intel.com, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Subject: [PATCH 01/13] block/brd: add error handling support for add_disk()
Date: Fri, 15 Oct 2021 16:52:07 -0700
Message-Id: <20211015235219.2191207-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211015235219.2191207-1-mcgrof@kernel.org>
References: <20211015235219.2191207-1-mcgrof@kernel.org>
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
Cc: nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Luis Chamberlain <mcgrof@kernel.org>, linux-mtd@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

We never checked for errors on add_disk() as this function
returned void. Now that this is fixed, use the shiny new
error handling.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/block/brd.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 530b31240203..6065f493876f 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -372,6 +372,7 @@ static int brd_alloc(int i)
 	struct brd_device *brd;
 	struct gendisk *disk;
 	char buf[DISK_NAME_LEN];
+	int err = -ENOMEM;
 
 	mutex_lock(&brd_devices_mutex);
 	list_for_each_entry(brd, &brd_devices, brd_list) {
@@ -422,16 +423,20 @@ static int brd_alloc(int i)
 	/* Tell the block layer that this is not a rotational device */
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, disk->queue);
 	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, disk->queue);
-	add_disk(disk);
+	err = add_disk(disk);
+	if (err)
+		goto out_cleanup_disk;
 
 	return 0;
 
+out_cleanup_disk:
+	blk_cleanup_disk(disk);
 out_free_dev:
 	mutex_lock(&brd_devices_mutex);
 	list_del(&brd->brd_list);
 	mutex_unlock(&brd_devices_mutex);
 	kfree(brd);
-	return -ENOMEM;
+	return err;
 }
 
 static void brd_probe(dev_t dev)
-- 
2.30.2

