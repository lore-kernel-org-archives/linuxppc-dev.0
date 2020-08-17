Return-Path: <SRS0=WC9B=B3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC9CC433E1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2020 07:35:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D34220758
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2020 07:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nPKsqCwn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D34220758
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BVQn41HLCzDqQK
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2020 17:35:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=casper.srs.infradead.org (client-ip=2001:8b0:10b:1236::1;
 helo=casper.infradead.org;
 envelope-from=batv+1cabf852a0fb828109f5+6203+infradead.org+hch@casper.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=nPKsqCwn; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BVQjm4vk4zDqNB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2020 17:32:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=chkBUohlSENVG7jzFIol9qd0YuUufR27opLGYVm+1Ug=; b=nPKsqCwnley2pS/jGgzaWIWqdq
 +H7a88VNXjG35LPNiZ70Kq+7+6Gu3tLxQga7o8tF/RFW8obhq2FJOJAyEb27ONJcpWauRW+6jPNZZ
 s2p1syRBxG+7Zznv0MvH0KZCg4uUaXzvWNUzIrxQoH1qGhjKwe9+K8EoC8VMyfYHj2C+Rf7YmyUjB
 9cvFklBwOIFdee9QbYzjUx4FgKXyy5tI5cDIjL76f4STmRLqqZmkTKqKHi9k8VQ9XdmqFdtmBpO/1
 gEuSuTWhDc+hCkkOLVFdlq+dEoEZbvtg6iVS1PKVj0Gp7LURgpjFVXy1eb9fYkzUOMLCF0hqjeRd+
 mz7yZVjw==;
Received: from [2001:4bb8:188:3918:4550:cdf7:3d45:afb9] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k7Zd0-0000vz-Gj; Mon, 17 Aug 2020 07:32:22 +0000
From: Christoph Hellwig <hch@lst.de>
To: Al Viro <viro@zeniv.linux.org.uk>, Michael Ellerman <mpe@ellerman.id.au>,
 x86@kernel.org
Subject: [PATCH 05/11] test_bitmap: skip user bitmap tests for !CONFIG_SET_FS
Date: Mon, 17 Aug 2020 09:32:06 +0200
Message-Id: <20200817073212.830069-6-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817073212.830069-1-hch@lst.de>
References: <20200817073212.830069-1-hch@lst.de>
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
Cc: linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Kees Cook <keescook@chromium.org>,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

We can't run the tests for userspace bitmap parsing if set_fs() doesn't
exist.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/test_bitmap.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index df903c53952bb9..49b1d25fbaf546 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -365,6 +365,7 @@ static void __init __test_bitmap_parselist(int is_user)
 	for (i = 0; i < ARRAY_SIZE(parselist_tests); i++) {
 #define ptest parselist_tests[i]
 
+#ifdef CONFIG_SET_FS
 		if (is_user) {
 			mm_segment_t orig_fs = get_fs();
 			size_t len = strlen(ptest.in);
@@ -375,7 +376,9 @@ static void __init __test_bitmap_parselist(int is_user)
 						    bmap, ptest.nbits);
 			time = ktime_get() - time;
 			set_fs(orig_fs);
-		} else {
+		} else
+#endif /* CONFIG_SET_FS */
+		{
 			time = ktime_get();
 			err = bitmap_parselist(ptest.in, bmap, ptest.nbits);
 			time = ktime_get() - time;
@@ -454,6 +457,7 @@ static void __init __test_bitmap_parse(int is_user)
 	for (i = 0; i < ARRAY_SIZE(parse_tests); i++) {
 		struct test_bitmap_parselist test = parse_tests[i];
 
+#ifdef CONFIG_SET_FS
 		if (is_user) {
 			size_t len = strlen(test.in);
 			mm_segment_t orig_fs = get_fs();
@@ -464,7 +468,9 @@ static void __init __test_bitmap_parse(int is_user)
 						bmap, test.nbits);
 			time = ktime_get() - time;
 			set_fs(orig_fs);
-		} else {
+		} else
+#endif /* CONFIG_SET_FS */
+		{
 			size_t len = test.flags & NO_LEN ?
 				UINT_MAX : strlen(test.in);
 			time = ktime_get();
-- 
2.28.0

