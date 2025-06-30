Return-Path: <linuxppc-dev+bounces-9924-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A14BC8302B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Jun 2025 16:10:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bWB1k6QWSz3brt;
	Tue,  1 Jul 2025 02:09:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751299770;
	cv=none; b=HlwtF6iMZMG120Eds1fzMgTBhExPh/6nzRke3OXIEQudtIbjniytL9BtGPCBe4/rw6PRjrYqFH2fP2V3PvOcD1rosemeQ0QXbkKcsiNwUQjz3Ojrzt1mN/MjA6m3pz3mNgLTEvp/ayVRiVPj+A38J621MZkwEO930YwI4MQf74WiSW0wb/0v+lF2I1EGJyL4FwggOtRGV9YFOWzpIQzxw9BzVB3sWN7FGz8MCkHeDajZYcYmeg4aVP4Q6mBQfkvbfsNVxCDqR6BiQXpCTU4pQLXSQCmfMlUko/VO9RddqpBFHdTV+pZFrE0hmaxEN7QXzifFVa6Ti2RaM3e3eZRAkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751299770; c=relaxed/relaxed;
	bh=gJx0i07CwXuFGqbhsxqRsci+9AwrhLjTRKyXGDwSAJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VE4gzdkTrgF1OEHv6AmDSZbENLuR5OM3u0sjIWxo/epk1RjTlLZu0QZZZ6R1Pw0y/0RdFRxn3rRWZgw1d8AAM5otiWoWxntsB8NRUFs09eASpezSOm4o6zSSHOEkqvYHU4reFGK0ZSi0BNvsZQGGjwU55sogbuz0nqApqMbgx4iqhkLmnBU3/ENepKqgxnE3OUekXvRmpWfEVh0n/0uhLQYNfpgg72zIpgwx6EYzPFdO6VTQCownZ4o6K6M2olRkfEQPZM2i+0qP41gfvquz5akEDSBx3ad9scrarbz648gXrerP6RtnYXcIDnIl5QEF1/BcxbDG/VJ90A9LUDbAgw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YUEz13tr; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YUEz13tr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bWB1f3mw3z2xd4
	for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Jul 2025 02:09:25 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 5C36D613AA;
	Mon, 30 Jun 2025 16:09:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB4A6C4CEF2;
	Mon, 30 Jun 2025 16:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751299763;
	bh=6di/lemdUUuURN063IywyRZhcwaKdCBZPfLQhM19GXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YUEz13trRmGOF1EnTtptvIlzO1jaL21f4T0TLFxkW98FzmMLj6qDaW0ODvpbNWxVx
	 tfzJ5ASzjGW+jCVRJoRjoHWBYInTKNgLLwpEMauVZBla27IPaaN+Sguq8bUNybwcZ4
	 m+N6TBi5X7Aay6IJ+JyWUd5O6u3c4w4eAXAtYJv0zGGmEokWNCcro5PhDuNp1zwNIV
	 7GOiv6OLqYq9c2mtptz2nJBsjhusfEek4rvPdyXbAKJYVSSGkIMS15fAWfrnJ7CW2r
	 CftvB1tqiZa/uHE5fCme+6m0uY6xzuSfr5q5bF9mchP3IO8KvUpNaXsOLzSyGIIoJR
	 H3sy/rJqdx/Hw==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v2 05/14] lib/crypto: sha256: Add sha224() and sha224_update()
Date: Mon, 30 Jun 2025 09:06:36 -0700
Message-ID: <20250630160645.3198-6-ebiggers@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250630160645.3198-1-ebiggers@kernel.org>
References: <20250630160645.3198-1-ebiggers@kernel.org>
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
Content-Transfer-Encoding: 8bit

Add a one-shot SHA-224 computation function sha224(), for consistency
with sha256(), sha384(), and sha512() which all already exist.

Similarly, add sha224_update().  While for now it's identical to
sha256_update(), omitting it makes the API harder to use since users
have to "know" which functions are the same between SHA-224 and SHA-256.
Also, this is a prerequisite for using different context types for each.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 include/crypto/sha2.h | 10 ++++++++--
 lib/crypto/sha256.c   | 10 ++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/crypto/sha2.h b/include/crypto/sha2.h
index bb181b7996cdc..e31da0743a522 100644
--- a/include/crypto/sha2.h
+++ b/include/crypto/sha2.h
@@ -112,22 +112,28 @@ struct sha512_state {
 	u64 state[SHA512_DIGEST_SIZE / 8];
 	u64 count[2];
 	u8 buf[SHA512_BLOCK_SIZE];
 };
 
+void sha256_update(struct sha256_state *sctx, const u8 *data, size_t len);
+
 static inline void sha224_init(struct sha256_state *sctx)
 {
 	sha224_block_init(&sctx->ctx);
 }
-/* Simply use sha256_update as it is equivalent to sha224_update. */
+static inline void sha224_update(struct sha256_state *sctx,
+				 const u8 *data, size_t len)
+{
+	sha256_update(sctx, data, len);
+}
 void sha224_final(struct sha256_state *sctx, u8 out[SHA224_DIGEST_SIZE]);
+void sha224(const u8 *data, size_t len, u8 out[SHA224_DIGEST_SIZE]);
 
 static inline void sha256_init(struct sha256_state *sctx)
 {
 	sha256_block_init(&sctx->ctx);
 }
-void sha256_update(struct sha256_state *sctx, const u8 *data, size_t len);
 void sha256_final(struct sha256_state *sctx, u8 out[SHA256_DIGEST_SIZE]);
 void sha256(const u8 *data, size_t len, u8 out[SHA256_DIGEST_SIZE]);
 
 /* State for the SHA-512 (and SHA-384) compression function */
 struct sha512_block_state {
diff --git a/lib/crypto/sha256.c b/lib/crypto/sha256.c
index 573ccecbf48bf..ccaae70880166 100644
--- a/lib/crypto/sha256.c
+++ b/lib/crypto/sha256.c
@@ -68,10 +68,20 @@ void sha256_final(struct sha256_state *sctx, u8 out[SHA256_DIGEST_SIZE])
 {
 	__sha256_final(sctx, out, SHA256_DIGEST_SIZE);
 }
 EXPORT_SYMBOL(sha256_final);
 
+void sha224(const u8 *data, size_t len, u8 out[SHA224_DIGEST_SIZE])
+{
+	struct sha256_state sctx;
+
+	sha224_init(&sctx);
+	sha224_update(&sctx, data, len);
+	sha224_final(&sctx, out);
+}
+EXPORT_SYMBOL(sha224);
+
 void sha256(const u8 *data, size_t len, u8 out[SHA256_DIGEST_SIZE])
 {
 	struct sha256_state sctx;
 
 	sha256_init(&sctx);
-- 
2.50.0


