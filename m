Return-Path: <SRS0=LxjK=MT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4979C4338F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Jul 2021 06:04:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48BA660FE3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Jul 2021 06:04:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 48BA660FE3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GYmTQ6xjGz3clG
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Jul 2021 16:04:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=F1zxkw09;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=casper.srs.infradead.org (client-ip=2001:8b0:10b:1236::1;
 helo=casper.infradead.org;
 envelope-from=batv+120c431586dc67e47307+6547+infradead.org+hch@casper.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=F1zxkw09; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GYmSy07gcz2xZL
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jul 2021 16:04:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=v8qmxMjLxIzlD6RqvjykX0yBn4O2X8VoNuXIPKQ0DWs=; b=F1zxkw09un7Q7ywy8fFGyj0VQi
 i0Hwfanb4ZPab9UkwO3hM+KrlapC6OX+d4CgcwAwbOrB0qqpyy2JSGTWIdud2I5r39EazVdQYpiiI
 dvmgodgiOp1dL3vAAr7+VbwSAXdj9tZuD3rJF2M3L40WNCQwdPLFtRAR5CFj1uSGA7jE4V7yFC6w2
 0nUeZHjoY30POJBukQtnDQxgCaT/4+FSg6JzOrGU/p+m0fNf/UsW1wV8tSahJa1MxYHfaRZyv8uaO
 uHy5Uho9HBxe8lnFUSQraMHiA0VrrYPDuDZNXU/XmNXgnBQBVccIV4EImTr8hbAnLXGUpGJuKvjCf
 6mSmSB/A==;
Received: from [2001:4bb8:184:87c5:b7fb:1299:a9e5:ff56] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m8G8U-00EiTR-JU; Tue, 27 Jul 2021 06:00:44 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 02/15] bvec: fix the include guards for bvec.h
Date: Tue, 27 Jul 2021 07:56:33 +0200
Message-Id: <20210727055646.118787-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727055646.118787-1-hch@lst.de>
References: <20210727055646.118787-1-hch@lst.de>
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
Cc: linux-arch@vger.kernel.org, linux-block@vger.kernel.org,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Bart Van Assche <bvanassche@acm.org>, Mike Snitzer <snitzer@redhat.com>,
 Geoff Levand <geoff@infradead.org>, linuxppc-dev@lists.ozlabs.org,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, ceph-devel@vger.kernel.org,
 linux-mips@vger.kernel.org, Dongsheng Yang <dongsheng.yang@easystack.cn>,
 linux-kernel@vger.kernel.org,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 dm-devel@redhat.com, "Martin K . Petersen" <martin.petersen@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, Ira Weiny <ira.weiny@intel.com>,
 Ilya Dryomov <idryomov@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Fix the include guards to match the file naming.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
---
 include/linux/bvec.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index ff832e698efb..883faf5f1523 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -4,8 +4,8 @@
  *
  * Copyright (C) 2001 Ming Lei <ming.lei@canonical.com>
  */
-#ifndef __LINUX_BVEC_ITER_H
-#define __LINUX_BVEC_ITER_H
+#ifndef __LINUX_BVEC_H
+#define __LINUX_BVEC_H
 
 #include <linux/bug.h>
 #include <linux/errno.h>
@@ -183,4 +183,4 @@ static inline void bvec_advance(const struct bio_vec *bvec,
 	}
 }
 
-#endif /* __LINUX_BVEC_ITER_H */
+#endif /* __LINUX_BVEC_H */
-- 
2.30.2

