Return-Path: <SRS0=EeCa=TU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB9FC04AAC
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 May 2019 16:49:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 164E3214DA
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 May 2019 16:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SmQKeZic"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 164E3214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4574c70yjzzDqKy
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 May 2019 02:49:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=ebiggers@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="SmQKeZic"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4574Zn4FC7zDqBg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 May 2019 02:48:01 +1000 (AEST)
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown
 [104.132.1.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 40F94214DA;
 Mon, 20 May 2019 16:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1558370879;
 bh=Yf+g9vOAw+X4k2U7oH5BvDUno0r4HEDvWSu3dcvz51c=;
 h=From:To:Cc:Subject:Date:From;
 b=SmQKeZicVRyYIsGrcWFhIi/RJTPpZFz9GLddrCrZqh4GQYosr2+3qeK0DVIkcHCFL
 9lAO8KdBH5mdjfRiEpfxWV+51VvdNm6jd+9zGVq8e2wEsDwKgE3G0qE72NY8/UzkZj
 yZlQrtD2RT/etzbJRBUrgnaQ14cTtAexc0fiRrng=
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH] crypto: testmgr - fix length truncation with large page size
Date: Mon, 20 May 2019 09:47:19 -0700
Message-Id: <20190520164719.160956-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Eric Biggers <ebiggers@google.com>

On PowerPC with CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y, there is sometimes
a crash in generate_random_aead_testvec().  The problem is that the
generated test vectors use data lengths of up to about 2 * PAGE_SIZE,
which is 128 KiB on PowerPC; however, the data length fields in the test
vectors are 'unsigned short', so the lengths get truncated.  Fix this by
changing the relevant fields to 'unsigned int'.

Fixes: 40153b10d91c ("crypto: testmgr - fuzz AEADs against their generic implementation")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 crypto/testmgr.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/crypto/testmgr.h b/crypto/testmgr.h
index 9a13c634b2077..fb2afdd544e00 100644
--- a/crypto/testmgr.h
+++ b/crypto/testmgr.h
@@ -43,7 +43,7 @@ struct hash_testvec {
 	const char *key;
 	const char *plaintext;
 	const char *digest;
-	unsigned short psize;
+	unsigned int psize;
 	unsigned short ksize;
 	int setkey_error;
 	int digest_error;
@@ -74,7 +74,7 @@ struct cipher_testvec {
 	const char *ctext;
 	unsigned char wk; /* weak key flag */
 	unsigned short klen;
-	unsigned short len;
+	unsigned int len;
 	bool fips_skip;
 	bool generates_iv;
 	int setkey_error;
@@ -110,9 +110,9 @@ struct aead_testvec {
 	unsigned char novrfy;
 	unsigned char wk;
 	unsigned char klen;
-	unsigned short plen;
-	unsigned short clen;
-	unsigned short alen;
+	unsigned int plen;
+	unsigned int clen;
+	unsigned int alen;
 	int setkey_error;
 	int setauthsize_error;
 	int crypt_error;
-- 
2.21.0.1020.gf2820cf01a-goog

