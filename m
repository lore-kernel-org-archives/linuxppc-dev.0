Return-Path: <linuxppc-dev+bounces-18429-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC481075260
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Mar 2026 06:21:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbwX96yWrz2xZK;
	Thu, 19 Mar 2026 17:19:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773901177;
	cv=none; b=n9lGxBgclh7/yRIhaJyAvtGSw2OiZgPepMkhu3KQy/XZ0b/FEmp6hUuxpN/agaFQYhhQiQ68ZNk/MuCaiG9cqXDmumAAKoitjhMxbjzNPbhOr13ZqpASIDoBX1i2FfYGKeen01HBiMjhTq006QLc+lKFtQgMOZjd4uJElBS8z73qjGpAXhzV1rTyQgebZOnMs6wnQWRKeGzET+aL52Iepf3fI7toJR8fHRN70wjYQZCbYY+ZH1IxzqsbBmaK2LWdE5eyHFibl54Gqas5FjxHM6ww3pt/U51v5goyg/PeEk7JwD/rAX9aM1yTfepTKij8PgVTFsGITwJ6MICuU/Htrg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773901177; c=relaxed/relaxed;
	bh=9vSxpeIw4WgU6sQTDAhICZ86BWyj+COIM5e/68wkb8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e4+U2DUudR18Ku98RRNWKCzHMc9OcMPPp+G9orJ+k1MWGJz9WqXRC4G3B8W1DGdrM+0Ncy2swyi7dhCERo2ZP1k2IC3x45Sr9udIwmST9+fPGWNLnepmRkOVVNftviIHW3WI0deY+lMbyRfaw18VOpV59zqJ4I/jBF0h20CmGKbwV7YbF77pIZzh74nktUw5/TlTfI1nco8djt7KJ+h92LdYos8Eu+YCfeDEWl0ohz4Q37qiPb9F5JsDvRkww49QBVCRP1WvtgC9nYNmeVhcvJwWdDU48n9exJWam4jQI2bgk6mUoyxJRDYmNCB9FJ4pHjhbCkQpX8mu+q90RvPKIg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=lb5YamRu; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=lb5YamRu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fbwX306fhz30Sx
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2026 17:19:30 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A400D6011F;
	Thu, 19 Mar 2026 06:19:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BE38C2BCB7;
	Thu, 19 Mar 2026 06:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773901163;
	bh=30YR8O9RGszwoyHMoelh/TUtAbWKLQ7inDpOxAFZk7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lb5YamRuffHIic0o3S+n53i4qR5e6SehVWlaTLv8p1LyBsgjpRVs/k1Cx/Xp7ce1W
	 Zf0W4HoFFtWz5rRWKO4sKN81SffR9WDMIBpwl0xK1/I00zBhZVV5MF6ckGERn1BU6Z
	 m2OAlKc80xW5wLY01FrtxijQ0aLm3eKC9uTS1nN6KW82CQkUXIMv6Jl62fACy+VPm+
	 TMTPRYFNjVleqEA95/N+pxM69ANF2eFCsbQwyUDCmDZ2rKjS12BzFcRwNqGEV8EbLp
	 8f7Bo8/Jb08B8sDDi2wv+tf5yku4WvsNXYwoIrg79Hvcy/49rLVT1DjimFh74VZ0LU
	 uLuXhujkLXMCg==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	x86@kernel.org,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 18/19] lib/crypto: gf128hash: Remove unused content from ghash.h
Date: Wed, 18 Mar 2026 23:17:19 -0700
Message-ID: <20260319061723.1140720-19-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319061723.1140720-1-ebiggers@kernel.org>
References: <20260319061723.1140720-1-ebiggers@kernel.org>
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

Now that the structures in <crypto/ghash.h> are no longer used, remove
them.  Since this leaves <crypto/ghash.h> as just containing constants,
include it from <crypto/gf128hash.h> to deduplicate these definitions.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 include/crypto/gf128hash.h |  3 +--
 include/crypto/ghash.h     | 12 ------------
 2 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/include/crypto/gf128hash.h b/include/crypto/gf128hash.h
index 0bc649d01e12..41c557d55965 100644
--- a/include/crypto/gf128hash.h
+++ b/include/crypto/gf128hash.h
@@ -6,15 +6,14 @@
  */
 
 #ifndef _CRYPTO_GF128HASH_H
 #define _CRYPTO_GF128HASH_H
 
+#include <crypto/ghash.h>
 #include <linux/string.h>
 #include <linux/types.h>
 
-#define GHASH_BLOCK_SIZE	16
-#define GHASH_DIGEST_SIZE	16
 #define POLYVAL_BLOCK_SIZE	16
 #define POLYVAL_DIGEST_SIZE	16
 
 /**
  * struct polyval_elem - An element of the POLYVAL finite field
diff --git a/include/crypto/ghash.h b/include/crypto/ghash.h
index 043d938e9a2c..d187e5af9925 100644
--- a/include/crypto/ghash.h
+++ b/include/crypto/ghash.h
@@ -4,21 +4,9 @@
  */
 
 #ifndef __CRYPTO_GHASH_H__
 #define __CRYPTO_GHASH_H__
 
-#include <linux/types.h>
-
 #define GHASH_BLOCK_SIZE	16
 #define GHASH_DIGEST_SIZE	16
 
-struct gf128mul_4k;
-
-struct ghash_ctx {
-	struct gf128mul_4k *gf128;
-};
-
-struct ghash_desc_ctx {
-	u8 buffer[GHASH_BLOCK_SIZE];
-};
-
 #endif
-- 
2.53.0


