Return-Path: <linuxppc-dev+bounces-18335-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7365AFF6E9A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Mar 2026 23:41:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fb7kz5V9Rz2xYw;
	Wed, 18 Mar 2026 10:41:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773790875;
	cv=none; b=GAkx+VLLECHitNiMp0EsNG7Dnn+FPY5eh2fYAUYRr79p973FhwUiLJGwxhOcC2vVwBa9zhMMZNitfQtaOthaoBUAWbXJCNNz4iVJBAZZfGx/JSqmWKeoPAc+0t1TNEiD64CmJssMRPx3nY8lfKn7mmIAf8U2+eIeMSohz6ZxCog/9Fx9exmu+oXvevvhSgdJCfnY0VqYuskJfaJtki6jVHNH/e+xW9TaiHCCVwZ/jyOUfwvhT11le3dK/eiBNCh1thUYj3Kfk9c3daVN2USliclOPtM609YJAM8I6BtuepPmgaqoLML+QrT+b4rcvRqUmSecpW17p5rULYA8L9EjqA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773790875; c=relaxed/relaxed;
	bh=EcyVBa8QhUX83nGJhBo+52ALpMVAdGIM1ws9wmODbRs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TwPZm2+xQssz2jM4/KvkSbYAf8vS5NF9aym/ZKmkm+zCfBRL/Xa6g5+uBp/AUZHkKnMdxHxfxA2o3+gfsdSN8OAqSQpYza1f7fZkh9FqnBu4uOwm3nRdGHv6zCSY0kU16NUSY2y2/elu4LPExzdkSU2D1a/r5FUkesEhXbp+2wx6eWaEiV0OKUO2x+DfotK9WIOYGAXqbtBT/mj6G3X/aqG1qgjPM89v5oBi1lOOYb4NwkzhMLK8Jtoklgb8xO1YCc3e9kWp8IscI7sLde3S8kzo2Jg+pNV1Gc3oq5xFW5W53EBRhK1QNuTjZOzKOw4RQsrXhooQdl0RuP69n0IVXg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=QIo25Pjl; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=gustavoars@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=QIo25Pjl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=gustavoars@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fb7ky3ZfXz2xQr
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2026 10:41:14 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id CF3E741848;
	Tue, 17 Mar 2026 23:41:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C2B0C4CEF7;
	Tue, 17 Mar 2026 23:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773790871;
	bh=CxvuzhT7yn1bxb43FXgVqaOVcDutqMVbXzRdDRs1+yE=;
	h=Date:From:To:Cc:Subject:From;
	b=QIo25PjlVhaTmhb36pwX1wX2Km+DffM55wYycacRAohJFZCYGrNhfiQfnjOJsbSKt
	 4texU/iWZwdc1Du8sscHMydOh+5PxvlkOyPr2hpsrW+fWwFcw2Q7hZe3bKMcxypqb4
	 1+x/jrtkZ/c8N1vkWqdtbykWDMVM5EmOnvcCfy5gYrZmSmcff5kSv/fufq2sgoqlQ+
	 7fEGBrxW2YdSJ07XhzCsyk4TGxOiprkbrK0BGbJ/5XM1FpwbtzC4PhuOD6g6sIwsZd
	 2a02DddgX7mQynN6C+72Nayvxs8PaPpGxMHc6IdVY55ebdONnszvbCeW7UpT/DPQoz
	 FEE9jcZanG5jQ==
Date: Tue, 17 Mar 2026 17:40:02 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Haren Myneni <haren@us.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH] crypto: nx - Fix packed layout in struct nx842_crypto_header
Message-ID: <abnmUvHzhgS9xA-m@kspp>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

struct nx842_crypto_header is declared with the __packed attribute,
however	the fields grouped with struct_group_tagged() were not packed.
This caused the grouped header portion of the structure to lose the
packed layout guarantees of the containing structure.

Fix this by replacing struct_group_tagged() with __struct_group(...,
..., __packed, ...) so the grouped fields are packed, and the original
layout is preserved, restoring the intended packed layout of the
structure.

Before changes:
struct nx842_crypto_header {
	union {
		struct {
			__be16     magic;                /*     0     2 */
			__be16     ignore;               /*     2     2 */
			u8         groups;               /*     4     1 */
		};                                       /*     0     6 */
		struct nx842_crypto_header_hdr hdr;      /*     0     6 */
	};                                               /*     0     6 */
	struct nx842_crypto_header_group group[];        /*     6     0 */

	/* size: 6, cachelines: 1, members: 2 */
	/* last cacheline: 6 bytes */
} __attribute__((__packed__));

After changes:
struct nx842_crypto_header {
	union {
		struct {
			__be16     magic;                /*     0     2 */
			__be16     ignore;               /*     2     2 */
			u8         groups;               /*     4     1 */
		} __attribute__((__packed__));           /*     0     5 */
		struct nx842_crypto_header_hdr hdr;      /*     0     5 */
	};                                               /*     0     5 */
	struct nx842_crypto_header_group group[];        /*     5     0 */

	/* size: 5, cachelines: 1, members: 2 */
	/* last cacheline: 5 bytes */
} __attribute__((__packed__));

Fixes: 1e6b251ce175 ("crypto: nx - Avoid -Wflex-array-member-not-at-end warning")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/crypto/nx/nx-842.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/nx/nx-842.h b/drivers/crypto/nx/nx-842.h
index f5e2c82ba876..cd3c1a433e8c 100644
--- a/drivers/crypto/nx/nx-842.h
+++ b/drivers/crypto/nx/nx-842.h
@@ -159,7 +159,7 @@ struct nx842_crypto_header_group {
 
 struct nx842_crypto_header {
 	/* New members MUST be added within the struct_group() macro below. */
-	struct_group_tagged(nx842_crypto_header_hdr, hdr,
+	__struct_group(nx842_crypto_header_hdr, hdr, __packed,
 		__be16 magic;		/* NX842_CRYPTO_MAGIC */
 		__be16 ignore;		/* decompressed end bytes to ignore */
 		u8 groups;		/* total groups in this header */
@@ -167,7 +167,7 @@ struct nx842_crypto_header {
 	struct nx842_crypto_header_group group[];
 } __packed;
 static_assert(offsetof(struct nx842_crypto_header, group) == sizeof(struct nx842_crypto_header_hdr),
-	      "struct member likely outside of struct_group_tagged()");
+	      "struct member likely outside of __struct_group()");
 
 #define NX842_CRYPTO_GROUP_MAX	(0x20)
 
-- 
2.43.0


