Return-Path: <linuxppc-dev+bounces-24047-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 360C5C43458
	for <linuxppc-dev@archiver.kernel.org>; Sat, 11 Jul 2026 14:53:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gyBXr5Rwmz2xlY;
	Sun, 12 Jul 2026 00:53:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=91.218.175.185
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783781628;
	cv=none; b=SqeZkTP39Qsk4Yryi08NVU6bG7hH/zIXfJiGlJpuFyj7NSbx1T9otZOQUX5KOesM6u6U4o408zDdc2hSFkZAxRuzyDjAKbfTEeLy9/SjPLAFcJV1KbzeDG4zlWDFWnmtV80voofOGPVSnsUXc4rk3SJtG2VTJwlT+FZCge2BVa1i3HkPuLqXlm9XKxhqbqSEYuFU7LfCmlwtpRwmj+nszf+28gS2+p0u5pgTExZpnnpxMXG7rBAlIRoJC0ixPQMplygIB5X/QWeBxnwyr+zDqXdceWNa2LuSkeN4LLBol6Bl3nN4epKhmzmW1nRMht/zpYCwgwbtDOYG4crGYNYhoA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783781628; c=relaxed/relaxed;
	bh=aZtHVuRO2nxmJugmNN9a89pfeJYPUJKY7mYAI9yqz4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fGYbNj2OiTNeMj0Ka+hW+VZXrb0Rv5ZsJfW/beZaCgFRImilVUVMPA1N0PyOJJ7x9u829MuruXwi32KqSUzz9sYa2USjQCRWDfY5nyGTusugxBb2Sm4PwijC9gGyhQAbMISGkQPtG7/qb2cNRO4n4Sse0MUte/BREBkOxjkleZLH6y6ZmgI8+6J3B1cfSKmrRfmqTm6yKIZ2pzpOZgqT2h0pRGVbq4YeKpIOAAXA3I8kXoawQXyRy3zMpdXCn6wnJX8I8xDVoXURiSvP+E6LKpHRUSeJpkKBxOQWmHG7DcpnEqNjWG19zRIPD9/F2mWTjFSieMVNlxIBMuNr9UYROQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ZwLBM+Pr; dkim-atps=neutral; spf=pass (client-ip=91.218.175.185; helo=out-185.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ZwLBM+Pr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=91.218.175.185; helo=out-185.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org)
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gyBXn467tz2xjd
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Jul 2026 00:53:43 +1000 (AEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783781602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aZtHVuRO2nxmJugmNN9a89pfeJYPUJKY7mYAI9yqz4Q=;
	b=ZwLBM+Prxzi72yW7EV+6MvJuM3ROokiTbHd5DIazgdBzC6OV/mhrGAyB15HEwFzWGU39Su
	zCpOt2D18CKk5ETaBKkOhe/IvuhXo1yjwJmuPlBPOIFjT3pzffG167Oso7MiEU9c0eVLm6
	m84wdUt8HVFCPggR/3MyPWnlyH0w+nY=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: =?UTF-8?q?Breno=20Leit=C3=A3o?= <leitao@debian.org>,
	Nayna Jain <nayna@linux.ibm.com>,
	Paulo Flabiano Smorigo <pfsmorigo@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-crypto@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: powerpc/aes - use bool for encryption/decryption flag
Date: Sat, 11 Jul 2026 16:52:17 +0200
Message-ID: <20260711145216.747128-3-thorsten.blum@linux.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2073; i=thorsten.blum@linux.dev; h=from:subject; bh=/rlW6l0xR2wdtg1H+Pws5RiWM86Rbb+yDyIqU8+10pQ=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFlBEQv+3Pg0ufzyLEXdyVmXBVc942tZweRfeedI+48G6 wbDLXmFHaUsDGJcDLJiiiwPZv2Y4VtaU7nJJGInzBxWJpAhDFycAjCRB3mMDNuuPgtIcY408L7d 8/5bym73eec1qp4VTr9WM/FGcq2E7R2Gf8oHM88daags1bxrYHsocX64rTknK2fBcpfynQVphl4 NHAA=
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use bool for the CBC encryption/decryption flag passed through
p8_aes_cbc_crypt() to aes_p8_cbc_encrypt().

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/powerpc/crypto/aes_cbc.c | 6 +++---
 include/crypto/aes.h          | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/crypto/aes_cbc.c b/arch/powerpc/crypto/aes_cbc.c
index 4a9f285f0970..9c271b4642c8 100644
--- a/arch/powerpc/crypto/aes_cbc.c
+++ b/arch/powerpc/crypto/aes_cbc.c
@@ -72,7 +72,7 @@ static int p8_aes_cbc_setkey(struct crypto_skcipher *tfm, const u8 *key,
 	return ret ? -EINVAL : 0;
 }
 
-static int p8_aes_cbc_crypt(struct skcipher_request *req, int enc)
+static int p8_aes_cbc_crypt(struct skcipher_request *req, bool enc)
 {
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
 	const struct p8_aes_cbc_ctx *ctx = crypto_skcipher_ctx(tfm);
@@ -110,12 +110,12 @@ static int p8_aes_cbc_crypt(struct skcipher_request *req, int enc)
 
 static int p8_aes_cbc_encrypt(struct skcipher_request *req)
 {
-	return p8_aes_cbc_crypt(req, 1);
+	return p8_aes_cbc_crypt(req, true);
 }
 
 static int p8_aes_cbc_decrypt(struct skcipher_request *req)
 {
-	return p8_aes_cbc_crypt(req, 0);
+	return p8_aes_cbc_crypt(req, false);
 }
 
 struct skcipher_alg p8_aes_cbc_alg = {
diff --git a/include/crypto/aes.h b/include/crypto/aes.h
index 16fbfd93e2bd..3279cfa54608 100644
--- a/include/crypto/aes.h
+++ b/include/crypto/aes.h
@@ -259,7 +259,7 @@ int aes_p8_set_decrypt_key(const u8 *userKey, const int bits,
 void aes_p8_encrypt(const u8 *in, u8 *out, const struct p8_aes_key *key);
 void aes_p8_decrypt(const u8 *in, u8 *out, const struct p8_aes_key *key);
 void aes_p8_cbc_encrypt(const u8 *in, u8 *out, size_t len,
-			const struct p8_aes_key *key, u8 *iv, const int enc);
+			const struct p8_aes_key *key, u8 *iv, bool enc);
 void aes_p8_ctr32_encrypt_blocks(const u8 *in, u8 *out, size_t len,
 				 const struct p8_aes_key *key, const u8 *iv);
 void aes_p8_xts_encrypt(const u8 *in, u8 *out, size_t len,

