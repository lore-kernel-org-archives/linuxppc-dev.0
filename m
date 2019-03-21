Return-Path: <SRS0=DN5o=RY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965ABC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 19:09:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1996218D4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 19:09:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1996218D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sdf.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44QGZ70K20zDq7N
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 06:09:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=sdf.org
 (client-ip=205.166.94.20; helo=mx.sdf.org; envelope-from=lkml@sdf.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=sdf.org
Received: from mx.sdf.org (mx.sdf.org [205.166.94.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Q7XL1DCGzDqLG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2019 00:52:49 +1100 (AEDT)
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
 by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id x2LAgNF8024005
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits) verified NO); 
 Thu, 21 Mar 2019 10:42:23 GMT
Received: (from lkml@localhost)
 by sdf.org (8.15.2/8.12.8/Submit) id x2LAgMp3003053;
 Thu, 21 Mar 2019 10:42:22 GMT
Date: Thu, 21 Mar 2019 10:42:22 GMT
Message-Id: <201903211042.x2LAgMp3003053@sdf.org>
From: George Spelvin <lkml@sdf.org>
Subject: [PATCH] arch/powerpc/crypto/crc-vpmsum_test: Use cheaper random
 numbers for self-test
To: Daniel Axtens <dja@axtens.net>, linuxppc-dev@lists.ozlabs.org
X-Mailman-Approved-At: Fri, 22 Mar 2019 06:05:42 +1100
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
Cc: George Spelvin <lkml@sdf.org>, Paul Mackerras <paulus@samba.org>,
 Herbert Xu <herbert@gondor.apana.org.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This code was filling a 64K buffer from /dev/urandom in order to
compute a CRC over (on average half of) it by two different methods,
comparing the CRCs, and repeating.

This is not a remotely security-critical application, so use the far
faster and cheaper prandom_u32() generator.

And, while we're at it, only fill as much of the buffer as we plan to use.

Signed-off-by: George Spelvin <lkml@sdf.org>
Cc: Daniel Axtens <dja@axtens.net>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/crypto/crc-vpmsum_test.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/crypto/crc-vpmsum_test.c b/arch/powerpc/crypto/crc-vpmsum_test.c
index 0153a9c6f4af..98ea4f4d3dde 100644
--- a/arch/powerpc/crypto/crc-vpmsum_test.c
+++ b/arch/powerpc/crypto/crc-vpmsum_test.c
@@ -78,16 +78,12 @@ static int __init crc_test_init(void)
 
 		pr_info("crc-vpmsum_test begins, %lu iterations\n", iterations);
 		for (i=0; i<iterations; i++) {
-			size_t len, offset;
+			size_t offset = prandom_u32_max(16);
+			size_t len = prandom_u32_max(MAX_CRC_LENGTH);
 
-			get_random_bytes(data, MAX_CRC_LENGTH);
-			get_random_bytes(&len, sizeof(len));
-			get_random_bytes(&offset, sizeof(offset));
-
-			len %= MAX_CRC_LENGTH;
-			offset &= 15;
 			if (len <= offset)
 				continue;
+			prandom_bytes(data, len);
 			len -= offset;
 
 			crypto_shash_update(crct10dif_shash, data+offset, len);
-- 
2.20.1

