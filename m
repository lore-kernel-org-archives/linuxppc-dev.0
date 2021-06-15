Return-Path: <SRS0=IFQS=LJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6682C48BE8
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jun 2021 13:34:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E7EF61480
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jun 2021 13:34:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E7EF61480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G48Rc71C0z3c7C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jun 2021 23:34:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=o9rlvoNl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=casper.srs.infradead.org (client-ip=2001:8b0:10b:1236::1;
 helo=casper.infradead.org;
 envelope-from=batv+01b1093948f83d17b939+6505+infradead.org+hch@casper.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=o9rlvoNl; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G48KW0QVgz3clg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jun 2021 23:28:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=fwYY4cSIlXZUYhtFYDVp8X4pn3Su5FY8BPl+PlDQj0g=; b=o9rlvoNlNXNdcekDmTn200bHY3
 du7q+hb5J/7l7Mmff9Frg7gGmQSc1zn1ny8mabmMdI1BR1VvKpaSCb2W3kFfgmB5Wn0ypoLANru6K
 0JyShqr627zVnXx3hdSjEHc5BRqaxcSXp6Lv41q3Vlpz9bnuGI+IDYeMnY+/4hXs2q0cqYlOfXVY0
 qWfc4SgsvwzQszydwfkZOw+gVh4V8ZlrQTPw5FSbbhfjFqbbTuUSS97XHewV2dusDFIBy8Y/ssZNq
 j5kIz+H15DstpmzoIdDZzwETQ220TxaVmb4fr0nBQwM2aPWzWB+SyYB9LT1e3W4NDUUJhbhy2WEM6
 DAhmxf9A==;
Received: from [2001:4bb8:19b:fdce:9045:1e63:20f0:ca9] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lt962-006o4C-KU; Tue, 15 Jun 2021 13:27:19 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 07/18] bvec: add memcpy_{from, to}_bvec and memzero_bvec helper
Date: Tue, 15 Jun 2021 15:24:45 +0200
Message-Id: <20210615132456.753241-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210615132456.753241-1-hch@lst.de>
References: <20210615132456.753241-1-hch@lst.de>
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
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Mike Snitzer <snitzer@redhat.com>, Geoff Levand <geoff@infradead.org>,
 linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org,
 Dongsheng Yang <dongsheng.yang@easystack.cn>, linux-kernel@vger.kernel.org,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 dm-devel@redhat.com, Ilya Dryomov <idryomov@gmail.com>,
 Ira Weiny <ira.weiny@intel.com>, ceph-devel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Add helpers to perform common memory operation on a bvec.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
---
 include/linux/bvec.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index f8710af18eef..f9fa43b940ff 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -196,4 +196,37 @@ static inline void *bvec_kmap_local(struct bio_vec *bvec)
 	return kmap_local_page(bvec->bv_page) + bvec->bv_offset;
 }
 
+/**
+ * memcpy_from_bvec - copy data from a bvec
+ * @bvec: bvec to copy from
+ *
+ * Must be called on single-page bvecs only.
+ */
+static inline void memcpy_from_bvec(char *to, struct bio_vec *bvec)
+{
+	memcpy_from_page(to, bvec->bv_page, bvec->bv_offset, bvec->bv_len);
+}
+
+/**
+ * memcpy_to_bvec - copy data to a bvec
+ * @bvec: bvec to copy to
+ *
+ * Must be called on single-page bvecs only.
+ */
+static inline void memcpy_to_bvec(struct bio_vec *bvec, const char *from)
+{
+	memcpy_to_page(bvec->bv_page, bvec->bv_offset, from, bvec->bv_len);
+}
+
+/**
+ * memzero_bvec - zero all data in a bvec
+ * @bvec: bvec to zero
+ *
+ * Must be called on single-page bvecs only.
+ */
+static inline void memzero_bvec(struct bio_vec *bvec)
+{
+	memzero_page(bvec->bv_page, bvec->bv_offset, bvec->bv_len);
+}
+
 #endif /* __LINUX_BVEC_H */
-- 
2.30.2

