Return-Path: <SRS0=LxjK=MT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A576C4338F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Jul 2021 06:26:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 349906056B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Jul 2021 06:26:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 349906056B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GYmyH5LBSz3bbB
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Jul 2021 16:25:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=ZlPtXIOV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=casper.srs.infradead.org (client-ip=2001:8b0:10b:1236::1;
 helo=casper.infradead.org;
 envelope-from=batv+120c431586dc67e47307+6547+infradead.org+hch@casper.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=ZlPtXIOV; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GYmxq1cNrz2yMF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jul 2021 16:25:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=jFuNMKcRbcVnR+JgRWAcFH4S0wPCM0LhDW7OHMhdenM=; b=ZlPtXIOVwXE0aeEVhqPQ0pLddO
 rr5EooQEZ6+S9JLHdS21sBPJ1zXlGbUobbMssMsOIoajU/cNBcLZJUaVK4Cq1Vob1y9rvjIvfaLP2
 jLpBaotC3LPfh4M8MsZaVgWQopzUxvAs4oPgX7/CsaH6Tg3bzUa+ZnsFVTsnGZ8SKQM2ObR5Ktt06
 WsUeEtBSIekhebyDfQ2PaCHHjj4MGhZDYWrXqhTPqVBQoOEXwnJPZUVITViJeIx9mu07++3CnzVuD
 /ZSLyXN29uMKgcHN4h+6S9tjvi3olbm75aJXSRMnpdhi9hwLYuajBpxC0wX2qwNMJvHPzgYD+vaqb
 7LUmYtkA==;
Received: from [2001:4bb8:184:87c5:b7fb:1299:a9e5:ff56] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m8GRw-00Ejpq-EQ; Tue, 27 Jul 2021 06:20:46 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 15/15] block: use bvec_kmap_local in bio_integrity_process
Date: Tue, 27 Jul 2021 07:56:46 +0200
Message-Id: <20210727055646.118787-16-hch@lst.de>
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
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Mike Snitzer <snitzer@redhat.com>, Geoff Levand <geoff@infradead.org>,
 linuxppc-dev@lists.ozlabs.org, ceph-devel@vger.kernel.org,
 linux-mips@vger.kernel.org, Dongsheng Yang <dongsheng.yang@easystack.cn>,
 linux-kernel@vger.kernel.org,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 dm-devel@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
 Ira Weiny <ira.weiny@intel.com>, Ilya Dryomov <idryomov@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Using local kmaps slightly reduces the chances to stray writes, and
the bvec interface cleans up the code a little bit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 block/bio-integrity.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 4b4eb8964a6f..8f54d49dc500 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -172,18 +172,16 @@ static blk_status_t bio_integrity_process(struct bio *bio,
 	iter.prot_buf = prot_buf;
 
 	__bio_for_each_segment(bv, bio, bviter, *proc_iter) {
-		void *kaddr = kmap_atomic(bv.bv_page);
+		void *kaddr = bvec_kmap_local(&bv);
 
-		iter.data_buf = kaddr + bv.bv_offset;
+		iter.data_buf = kaddr;
 		iter.data_size = bv.bv_len;
-
 		ret = proc_fn(&iter);
-		if (ret) {
-			kunmap_atomic(kaddr);
-			return ret;
-		}
+		kunmap_local(kaddr);
+
+		if (ret)
+			break;
 
-		kunmap_atomic(kaddr);
 	}
 	return ret;
 }
-- 
2.30.2

