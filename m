Return-Path: <SRS0=G0Pv=6Q=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CC5C3A5A9
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 May 2020 18:32:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1DA3206CD
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 May 2020 18:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="r7M5DGle"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1DA3206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49DyQ70sq7zDr3N
	for <linuxppc-dev@archiver.kernel.org>; Sun,  3 May 2020 04:31:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=ebiggers@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=r7M5DGle; dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49DyKk4VxwzDr1x
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  3 May 2020 04:28:10 +1000 (AEST)
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net
 [107.3.166.239])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 672BA20775;
 Sat,  2 May 2020 18:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588444088;
 bh=MpOpLyRp32OcEAeGdDPZsgk7eR7jNOoThKxfaag+uuU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=r7M5DGleg8HtwnRWGrZDYKUoXl1liD0BSvTxyqAANiFELjUZgVrniqTADhg/TCk3E
 uF0p8KFSTKCi+I4YKGOKoYEfHstkiLieaID0OTBJq/kvF8W0nyBd1KrTBhCmaxzDNc
 juGKbyxbNDMbRB5V3Zm/k6KTFlKzpVpQlLHWWzKw=
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Subject: [PATCH 3/7] crypto: powerpc/sha1 - prefix the "sha1_" functions
Date: Sat,  2 May 2020 11:24:23 -0700
Message-Id: <20200502182427.104383-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200502182427.104383-1-ebiggers@kernel.org>
References: <20200502182427.104383-1-ebiggers@kernel.org>
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
Cc: "Jason A . Donenfeld" <Jason@zx2c4.com>, Theodore Ts'o <tytso@mit.edu>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Eric Biggers <ebiggers@google.com>

Prefix the PowerPC SHA-1 functions with "powerpc_sha1_" rather than
"sha1_".  This allows us to rename the library function sha_init() to
sha1_init() without causing a naming collision.

Cc: linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/powerpc/crypto/sha1.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/crypto/sha1.c b/arch/powerpc/crypto/sha1.c
index db46b6130a9642..b40dc50a6908ae 100644
--- a/arch/powerpc/crypto/sha1.c
+++ b/arch/powerpc/crypto/sha1.c
@@ -22,7 +22,7 @@
 
 void powerpc_sha_transform(u32 *state, const u8 *src);
 
-static int sha1_init(struct shash_desc *desc)
+static int powerpc_sha1_init(struct shash_desc *desc)
 {
 	struct sha1_state *sctx = shash_desc_ctx(desc);
 
@@ -33,8 +33,8 @@ static int sha1_init(struct shash_desc *desc)
 	return 0;
 }
 
-static int sha1_update(struct shash_desc *desc, const u8 *data,
-			unsigned int len)
+static int powerpc_sha1_update(struct shash_desc *desc, const u8 *data,
+			       unsigned int len)
 {
 	struct sha1_state *sctx = shash_desc_ctx(desc);
 	unsigned int partial, done;
@@ -68,7 +68,7 @@ static int sha1_update(struct shash_desc *desc, const u8 *data,
 
 
 /* Add padding and return the message digest. */
-static int sha1_final(struct shash_desc *desc, u8 *out)
+static int powerpc_sha1_final(struct shash_desc *desc, u8 *out)
 {
 	struct sha1_state *sctx = shash_desc_ctx(desc);
 	__be32 *dst = (__be32 *)out;
@@ -81,10 +81,10 @@ static int sha1_final(struct shash_desc *desc, u8 *out)
 	/* Pad out to 56 mod 64 */
 	index = sctx->count & 0x3f;
 	padlen = (index < 56) ? (56 - index) : ((64+56) - index);
-	sha1_update(desc, padding, padlen);
+	powerpc_sha1_update(desc, padding, padlen);
 
 	/* Append length */
-	sha1_update(desc, (const u8 *)&bits, sizeof(bits));
+	powerpc_sha1_update(desc, (const u8 *)&bits, sizeof(bits));
 
 	/* Store state in digest */
 	for (i = 0; i < 5; i++)
@@ -96,7 +96,7 @@ static int sha1_final(struct shash_desc *desc, u8 *out)
 	return 0;
 }
 
-static int sha1_export(struct shash_desc *desc, void *out)
+static int powerpc_sha1_export(struct shash_desc *desc, void *out)
 {
 	struct sha1_state *sctx = shash_desc_ctx(desc);
 
@@ -104,7 +104,7 @@ static int sha1_export(struct shash_desc *desc, void *out)
 	return 0;
 }
 
-static int sha1_import(struct shash_desc *desc, const void *in)
+static int powerpc_sha1_import(struct shash_desc *desc, const void *in)
 {
 	struct sha1_state *sctx = shash_desc_ctx(desc);
 
@@ -114,11 +114,11 @@ static int sha1_import(struct shash_desc *desc, const void *in)
 
 static struct shash_alg alg = {
 	.digestsize	=	SHA1_DIGEST_SIZE,
-	.init		=	sha1_init,
-	.update		=	sha1_update,
-	.final		=	sha1_final,
-	.export		=	sha1_export,
-	.import		=	sha1_import,
+	.init		=	powerpc_sha1_init,
+	.update		=	powerpc_sha1_update,
+	.final		=	powerpc_sha1_final,
+	.export		=	powerpc_sha1_export,
+	.import		=	powerpc_sha1_import,
 	.descsize	=	sizeof(struct sha1_state),
 	.statesize	=	sizeof(struct sha1_state),
 	.base		=	{
-- 
2.26.2

