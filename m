Return-Path: <linuxppc-dev+bounces-21751-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77162CD6E49
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 22:05:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRy9J4rPZz2xVK;
	Sat, 30 May 2026 08:05:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780092356;
	cv=none; b=neHOQvr5a4PTKSd+PpG1MHYqlttCkOAbDVTvD0I19+aCtRUOckTy5H7ywctf2AzOtoSVMbodIBOZLvpbCeHhApHwb8yD2+wxx/BjXiGQ7lV9Ytve+L0zeCfFVGbaaNkg0d4T64cKVtHBz4tG3tDdRUOr21hQ7oH1JWjkTffSBKxeT1ma4vPWKCPfXVPF8yqyFosdRAWvQt8JA5BOvfosvIBgLduneVcXHB7k73Wpbwq9ldVfq9y+CfbMvF5KUM6gpPAJD83t96pwg/8E6ck2X5adHSLeqrzq1Lqx/75LPFmNktxYnqNeOcPBxGHAtPJjZAUQ939TsKbsKfwVQGNDXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780092356; c=relaxed/relaxed;
	bh=Kl6flcBu84jgTqywF8Efo372BSZV1TwotLetIP7TH+E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MHS1gdpx3TBDSe+GYv6kDFG3Hsu6tvrPWqPcz2j/VJRBDA5n1vvUFkh9EXM7nK9FQybBHTL93hkNqj8XPX25PjmJbI2LABQu8DBOtZfmLkMihaQyjN0ZMLTAoUqwQ1EmZtO/ZH0RZZeT4vBYtxhmfc0BBK6/TeYsnNHtSoTtbn9562gOSjoqAdhIDVXmS07LIaVlpa2riGFnlnllLnonQ1h78njE5vfZO8EspGPzCFl0ptBjs+qMf+6KuoVPQfyH/wFYHrp7ZCy7yi6L7bIsZXzz466OJr1lfFlDInb8/ki70IEdhuKM++JMZDsv7LziexhofTrs9ehu7kfPY0vgXQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=akEjEg2x; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=akEjEg2x;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRy9H1gt3z2xLs
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 May 2026 08:05:55 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id F1211605E2;
	Fri, 29 May 2026 22:05:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 678F21F00893;
	Fri, 29 May 2026 22:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780092351;
	bh=Kl6flcBu84jgTqywF8Efo372BSZV1TwotLetIP7TH+E=;
	h=From:To:Cc:Subject:Date;
	b=akEjEg2xai2zRUB11O7ILEXDf5sziOAGFIamK2DEty3zjK3rs64EnpSn9PghTlcZQ
	 siW0MF8usb/5O0YZeTDyHHv1YIMJKAHcHr44OyM5ZK2iD6T+9iSl+PXS9/CqOONPhe
	 Ac0gWboneIRAm3yFBt7qLlxW+5RBm4Hry8jmEZ5yIZeIeAa0B6lV6bFba7ce0JuJOn
	 /aGvwl0Prp94UDFGX+AAhM/1gca3iuhrPhNZPO2yk/16ntIDLyocHfyqNE+FPVDxE8
	 3E3u/bRFtf9PsJ3IXZA7ajIohFaXcTTVf7rl2m7pr885eR8tKocqnAhfsXXzmWXE3m
	 zUsZvOylliK4A==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: Christian Lamparter <chunkeey@gmail.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] crypto: crypto4xx - Remove insecure and unused rng_alg
Date: Fri, 29 May 2026 15:04:30 -0700
Message-ID: <20260529220430.34135-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.54.0
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

Remove crypto4xx_rng, as it is insecure and unused:

- It has only a 64-bit security strength, which is highly inadequate.
  This can be seen by the fact that crypto4xx_hw_init() seeds it with
  only 64 bits of entropy, and the fact that the original commit
  mentions that it implements ANSI X9.17 Annex C.

  Another issue was that this driver didn't implement the crypto_rng API
  correctly, as crypto4xx_prng_generate() didn't return 0 on success.

- No user of this code is known.  It's usable only theoretically via the
  "rng" algorithm type of AF_ALG.  But userspace actually just uses the
  actual Linux RNG (/dev/random etc) instead.  And rng_algs don't
  contribute entropy to the actual Linux RNG either.  (This may have
  been confused with hwrng, which does contribute entropy.)

Fixes: d072bfa48853 ("crypto: crypto4xx - add prng crypto support")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 drivers/crypto/Kconfig                  |  1 -
 drivers/crypto/amcc/crypto4xx_core.c    | 88 -------------------------
 drivers/crypto/amcc/crypto4xx_core.h    |  4 --
 drivers/crypto/amcc/crypto4xx_reg_def.h | 11 ----
 4 files changed, 104 deletions(-)

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 3449b3c9c6ad..5dab813a9f74 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -299,11 +299,10 @@ config CRYPTO_DEV_PPC4XX
 	select CRYPTO_AES
 	select CRYPTO_LIB_AES
 	select CRYPTO_CCM
 	select CRYPTO_CTR
 	select CRYPTO_GCM
-	select CRYPTO_RNG
 	select CRYPTO_SKCIPHER
 	help
 	  This option allows you to have support for AMCC crypto acceleration.
 
 config HW_RANDOM_PPC4XX
diff --git a/drivers/crypto/amcc/crypto4xx_core.c b/drivers/crypto/amcc/crypto4xx_core.c
index b7b6c97d2147..68c5ff7a85b4 100644
--- a/drivers/crypto/amcc/crypto4xx_core.c
+++ b/drivers/crypto/amcc/crypto4xx_core.c
@@ -29,15 +29,13 @@
 #include <crypto/aead.h>
 #include <crypto/aes.h>
 #include <crypto/ctr.h>
 #include <crypto/gcm.h>
 #include <crypto/sha1.h>
-#include <crypto/rng.h>
 #include <crypto/scatterwalk.h>
 #include <crypto/skcipher.h>
 #include <crypto/internal/aead.h>
-#include <crypto/internal/rng.h>
 #include <crypto/internal/skcipher.h>
 #include "crypto4xx_reg_def.h"
 #include "crypto4xx_core.h"
 #include "crypto4xx_sa.h"
 #include "crypto4xx_trng.h"
@@ -983,14 +981,10 @@ static int crypto4xx_register_alg(struct crypto4xx_device *sec_dev,
 		switch (alg->alg.type) {
 		case CRYPTO_ALG_TYPE_AEAD:
 			rc = crypto_register_aead(&alg->alg.u.aead);
 			break;
 
-		case CRYPTO_ALG_TYPE_RNG:
-			rc = crypto_register_rng(&alg->alg.u.rng);
-			break;
-
 		default:
 			rc = crypto_register_skcipher(&alg->alg.u.cipher);
 			break;
 		}
 
@@ -1012,14 +1006,10 @@ static void crypto4xx_unregister_alg(struct crypto4xx_device *sec_dev)
 		switch (alg->alg.type) {
 		case CRYPTO_ALG_TYPE_AEAD:
 			crypto_unregister_aead(&alg->alg.u.aead);
 			break;
 
-		case CRYPTO_ALG_TYPE_RNG:
-			crypto_unregister_rng(&alg->alg.u.rng);
-			break;
-
 		default:
 			crypto_unregister_skcipher(&alg->alg.u.cipher);
 		}
 		kfree(alg);
 	}
@@ -1074,73 +1064,10 @@ static irqreturn_t crypto4xx_ce_interrupt_handler_revb(int irq, void *data)
 {
 	return crypto4xx_interrupt_handler(irq, data, PPC4XX_INTERRUPT_CLR |
 		PPC4XX_TMO_ERR_INT);
 }
 
-static int ppc4xx_prng_data_read(struct crypto4xx_device *dev,
-				 u8 *data, unsigned int max)
-{
-	unsigned int i, curr = 0;
-	u32 val[2];
-
-	do {
-		/* trigger PRN generation */
-		writel(PPC4XX_PRNG_CTRL_AUTO_EN,
-		       dev->ce_base + CRYPTO4XX_PRNG_CTRL);
-
-		for (i = 0; i < 1024; i++) {
-			/* usually 19 iterations are enough */
-			if ((readl(dev->ce_base + CRYPTO4XX_PRNG_STAT) &
-			     CRYPTO4XX_PRNG_STAT_BUSY))
-				continue;
-
-			val[0] = readl_be(dev->ce_base + CRYPTO4XX_PRNG_RES_0);
-			val[1] = readl_be(dev->ce_base + CRYPTO4XX_PRNG_RES_1);
-			break;
-		}
-		if (i == 1024)
-			return -ETIMEDOUT;
-
-		if ((max - curr) >= 8) {
-			memcpy(data, &val, 8);
-			data += 8;
-			curr += 8;
-		} else {
-			/* copy only remaining bytes */
-			memcpy(data, &val, max - curr);
-			break;
-		}
-	} while (curr < max);
-
-	return curr;
-}
-
-static int crypto4xx_prng_generate(struct crypto_rng *tfm,
-				   const u8 *src, unsigned int slen,
-				   u8 *dstn, unsigned int dlen)
-{
-	struct rng_alg *alg = crypto_rng_alg(tfm);
-	struct crypto4xx_alg *amcc_alg;
-	struct crypto4xx_device *dev;
-	int ret;
-
-	amcc_alg = container_of(alg, struct crypto4xx_alg, alg.u.rng);
-	dev = amcc_alg->dev;
-
-	mutex_lock(&dev->core_dev->rng_lock);
-	ret = ppc4xx_prng_data_read(dev, dstn, dlen);
-	mutex_unlock(&dev->core_dev->rng_lock);
-	return ret;
-}
-
-
-static int crypto4xx_prng_seed(struct crypto_rng *tfm, const u8 *seed,
-			unsigned int slen)
-{
-	return 0;
-}
-
 /*
  * Supported Crypto Algorithms
  */
 static struct crypto4xx_alg_common crypto4xx_alg[] = {
 	/* Crypto AES modes */
@@ -1266,22 +1193,10 @@ static struct crypto4xx_alg_common crypto4xx_alg[] = {
 			.cra_blocksize	= 1,
 			.cra_ctxsize	= sizeof(struct crypto4xx_ctx),
 			.cra_module	= THIS_MODULE,
 		},
 	} },
-	{ .type = CRYPTO_ALG_TYPE_RNG, .u.rng = {
-		.base = {
-			.cra_name		= "stdrng",
-			.cra_driver_name        = "crypto4xx_rng",
-			.cra_priority		= 300,
-			.cra_ctxsize		= 0,
-			.cra_module		= THIS_MODULE,
-		},
-		.generate               = crypto4xx_prng_generate,
-		.seed                   = crypto4xx_prng_seed,
-		.seedsize               = 0,
-	} },
 };
 
 /*
  * Module Initialization Routine
  */
@@ -1351,13 +1266,10 @@ static int crypto4xx_probe(struct platform_device *ofdev)
 	}
 
 	core_dev->dev->core_dev = core_dev;
 	core_dev->dev->is_revb = is_revb;
 	core_dev->device = dev;
-	rc = devm_mutex_init(&ofdev->dev, &core_dev->rng_lock);
-	if (rc)
-		return rc;
 	spin_lock_init(&core_dev->lock);
 	INIT_LIST_HEAD(&core_dev->dev->alg_list);
 	ratelimit_default_init(&core_dev->dev->aead_ratelimit);
 	rc = crypto4xx_build_sdr(core_dev->dev);
 	if (rc)
diff --git a/drivers/crypto/amcc/crypto4xx_core.h b/drivers/crypto/amcc/crypto4xx_core.h
index ee36630c670f..3a028aec3f0c 100644
--- a/drivers/crypto/amcc/crypto4xx_core.h
+++ b/drivers/crypto/amcc/crypto4xx_core.h
@@ -12,14 +12,12 @@
 
 #ifndef __CRYPTO4XX_CORE_H__
 #define __CRYPTO4XX_CORE_H__
 
 #include <linux/ratelimit.h>
-#include <linux/mutex.h>
 #include <linux/scatterlist.h>
 #include <crypto/internal/aead.h>
-#include <crypto/internal/rng.h>
 #include <crypto/internal/skcipher.h>
 #include "crypto4xx_reg_def.h"
 #include "crypto4xx_sa.h"
 
 #define PPC460SX_SDR0_SRST                      0x201
@@ -109,11 +107,10 @@ struct crypto4xx_core_device {
 	struct hwrng *trng;
 	u32 int_status;
 	u32 irq;
 	struct tasklet_struct tasklet;
 	spinlock_t lock;
-	struct mutex rng_lock;
 };
 
 struct crypto4xx_ctx {
 	struct crypto4xx_device *dev;
 	struct dynamic_sa_ctl *sa_in;
@@ -133,11 +130,10 @@ struct crypto4xx_aead_reqctx {
 struct crypto4xx_alg_common {
 	u32 type;
 	union {
 		struct skcipher_alg cipher;
 		struct aead_alg aead;
-		struct rng_alg rng;
 	} u;
 };
 
 struct crypto4xx_alg {
 	struct list_head  entry;
diff --git a/drivers/crypto/amcc/crypto4xx_reg_def.h b/drivers/crypto/amcc/crypto4xx_reg_def.h
index 1038061224da..73d626308a84 100644
--- a/drivers/crypto/amcc/crypto4xx_reg_def.h
+++ b/drivers/crypto/amcc/crypto4xx_reg_def.h
@@ -88,24 +88,13 @@
 
 #define CRYPTO4XX_DMA_CFG	        	0x000600d4
 #define CRYPTO4XX_BYTE_ORDER_CFG 		0x000600d8
 #define CRYPTO4XX_ENDIAN_CFG			0x000600d8
 
-#define CRYPTO4XX_PRNG_STAT			0x00070000
-#define CRYPTO4XX_PRNG_STAT_BUSY		0x1
 #define CRYPTO4XX_PRNG_CTRL			0x00070004
 #define CRYPTO4XX_PRNG_SEED_L			0x00070008
 #define CRYPTO4XX_PRNG_SEED_H			0x0007000c
-
-#define CRYPTO4XX_PRNG_RES_0			0x00070020
-#define CRYPTO4XX_PRNG_RES_1			0x00070024
-#define CRYPTO4XX_PRNG_RES_2			0x00070028
-#define CRYPTO4XX_PRNG_RES_3			0x0007002C
-
-#define CRYPTO4XX_PRNG_LFSR_L			0x00070030
-#define CRYPTO4XX_PRNG_LFSR_H			0x00070034
-
 /*
  * Initialize CRYPTO ENGINE registers, and memory bases.
  */
 #define PPC4XX_PDR_POLL				0x3ff
 #define PPC4XX_OUTPUT_THRESHOLD			2

base-commit: 49e05bb00f2e8168695f7af4d694c39e1423e8a2
-- 
2.54.0


