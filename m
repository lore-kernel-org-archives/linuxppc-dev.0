Return-Path: <SRS0=7LrA=K4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4139FC47097
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Jun 2021 06:54:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB1456108C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Jun 2021 06:54:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB1456108C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Fw0C53WlWz309B
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Jun 2021 16:54:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=RfiXqx1b;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+e38fb55258da4e18a096+6492+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=bombadil.20210309 header.b=RfiXqx1b; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Fw0BY3wRvz2xvc
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Jun 2021 16:54:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=SnRF2RasuO3TzWzCcWD7psRmahwH4O2DjzNGyzgJCxM=; b=RfiXqx1buYxjqGM6Ru6s2uXbtK
 szP8Lp35KdwoBLpRViL7iCBQHBOTXZ4Qu5LJOvN43OaaHCTJwbYuBSl2SqXNEe3Ty441iVm62zV/q
 FK7bqtRTYnR/sNzxWhxA2AWxTTSYR0R47li/OgrbNqJ/z/C247XNi+vyVCBUJz2HWLNRhHDg9jROf
 W37wVhanz0woIFa4DI1Hiypd6xGuMEzMDW+t6oSvgQDur5ioE4KQTAUXWM04CshX1rW4l4k5bAsYt
 fMWsLaqDTkxSQegnpPyUc9dgQ8DJelIKHSJsddjUREuKapJzcCJM+AP8gSr/w6bRFlEnBsoDVPXvd
 WWIbvGOQ==;
Received: from shol69.static.otenet.gr ([83.235.170.67] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1loKlG-0025Fb-J7; Wed, 02 Jun 2021 06:53:55 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 01/30] blk-mq: factor out a blk_mq_alloc_sq_tag_set helper
Date: Wed,  2 Jun 2021 09:53:16 +0300
Message-Id: <20210602065345.355274-2-hch@lst.de>
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

Factour out a helper to initialize a simple single hw queue tag_set from
blk_mq_init_sq_queue.  This will allow to phase out blk_mq_init_sq_queue
in favor of a more symmetric and general API.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c         | 32 ++++++++++++++++++--------------
 include/linux/blk-mq.h |  3 +++
 2 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f11d4018ce2e..eaacfa963a73 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3152,24 +3152,12 @@ struct request_queue *blk_mq_init_sq_queue(struct blk_mq_tag_set *set,
 	struct request_queue *q;
 	int ret;
 
-	memset(set, 0, sizeof(*set));
-	set->ops = ops;
-	set->nr_hw_queues = 1;
-	set->nr_maps = 1;
-	set->queue_depth = queue_depth;
-	set->numa_node = NUMA_NO_NODE;
-	set->flags = set_flags;
-
-	ret = blk_mq_alloc_tag_set(set);
+	ret = blk_mq_alloc_sq_tag_set(set, ops, queue_depth, set_flags);
 	if (ret)
 		return ERR_PTR(ret);
-
 	q = blk_mq_init_queue(set);
-	if (IS_ERR(q)) {
+	if (IS_ERR(q))
 		blk_mq_free_tag_set(set);
-		return q;
-	}
-
 	return q;
 }
 EXPORT_SYMBOL(blk_mq_init_sq_queue);
@@ -3589,6 +3577,22 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 }
 EXPORT_SYMBOL(blk_mq_alloc_tag_set);
 
+/* allocate and initialize a tagset for a simple single-queue device */
+int blk_mq_alloc_sq_tag_set(struct blk_mq_tag_set *set,
+		const struct blk_mq_ops *ops, unsigned int queue_depth,
+		unsigned int set_flags)
+{
+	memset(set, 0, sizeof(*set));
+	set->ops = ops;
+	set->nr_hw_queues = 1;
+	set->nr_maps = 1;
+	set->queue_depth = queue_depth;
+	set->numa_node = NUMA_NO_NODE;
+	set->flags = set_flags;
+	return blk_mq_alloc_tag_set(set);
+}
+EXPORT_SYMBOL_GPL(blk_mq_alloc_sq_tag_set);
+
 void blk_mq_free_tag_set(struct blk_mq_tag_set *set)
 {
 	int i, j;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 359486940fa0..bb950fc669ef 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -439,6 +439,9 @@ struct request_queue *blk_mq_init_sq_queue(struct blk_mq_tag_set *set,
 void blk_mq_unregister_dev(struct device *, struct request_queue *);
 
 int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set);
+int blk_mq_alloc_sq_tag_set(struct blk_mq_tag_set *set,
+		const struct blk_mq_ops *ops, unsigned int queue_depth,
+		unsigned int set_flags);
 void blk_mq_free_tag_set(struct blk_mq_tag_set *set);
 
 void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule);
-- 
2.30.2

