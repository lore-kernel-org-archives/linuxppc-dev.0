Return-Path: <linuxppc-dev+bounces-21762-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D39CD6E49
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 May 2026 19:43:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gSVyr4DSxz2yT0;
	Sun, 31 May 2026 05:43:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=212.77.101.12
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780153927;
	cv=none; b=BtRkR85d1yruxAE1wH+COEhsnx8ODaF1TwHHFHKrhYb7bGprarjH6m0uYHHQZzn8LAeQXEnl5gkg7qxas4r5R8oiLGVUcmaPjr7HhUWJFB8bVTKykI4X7jl7v6mdrZoIaRuuEslAnl6vlg0qfxeecvFqNdN8o7zll+qg9UJcImFDCDXDiK5osVOsmoziQC8dyZCnlvFgLClzAy59WC+A2VaM+5ql8G5ETRORbl/KWYmzC/7/OzoypeHLCBHfxU81CDe7AfyAL3BSY4lkm0FOyZu+DthbLu/IlPRo1gzBAJId8R2Hfe23ugmtPFCCbMRYEKj+Om0XuXm5U/AGmXZz9w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780153927; c=relaxed/relaxed;
	bh=xPo/bbGmAInHPSGv6Wkd6ahTBmWwK5mZm9OGBLAeEDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BHBYOCELtUVGsydfuhbkMk8PmSNIno2LOmyXQy4HwSSVgkv2vtmm5cu9w8C57v7lqaeYQ0rjmmfZ9qjcwIxw4W1MgOsuLQobESzypIJtxLbixcgZL2NbpZgan/WnyPTBEsYel3Ob9+vpsukzMJMMP4zPWlSkW4rPwzpLpgK2EIrmNXAYMEKzj9t93zz8pZPSx0kfuYNjFNWn/6BLFX1Zh9g3zNtmUW43ejIbBy5D3A2fvzbH2gvoNG0Fpj7cUlJ8Ntf1XrGzzxnjH2E2addKhsnKPhyJL5FYf+U7G8MQApuyf2ZBXlCL6947lSBSkhrQmRBYYAgQchPrqGqFWbFFBg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=wp.pl; dkim=pass (2048-bit key; unprotected) header.d=wp.pl header.i=@wp.pl header.a=rsa-sha256 header.s=20241105 header.b=nHnMS44I; dkim-atps=neutral; spf=pass (client-ip=212.77.101.12; helo=mx4.wp.pl; envelope-from=olek2@wp.pl; receiver=lists.ozlabs.org) smtp.mailfrom=wp.pl
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=wp.pl header.i=@wp.pl header.a=rsa-sha256 header.s=20241105 header.b=nHnMS44I;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=wp.pl (client-ip=212.77.101.12; helo=mx4.wp.pl; envelope-from=olek2@wp.pl; receiver=lists.ozlabs.org)
X-Greylist: delayed 397 seconds by postgrey-1.37 at boromir; Sun, 31 May 2026 01:12:04 AEST
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gSNxJ60gBz2xqn
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 May 2026 01:12:04 +1000 (AEST)
Received: (wp-smtpd smtp.wp.pl 12143 invoked from network); 30 May 2026 17:05:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1780153519; bh=xPo/bbGmAInHPSGv6Wkd6ahTBmWwK5mZm9OGBLAeEDM=;
          h=Subject:To:Cc:From;
          b=nHnMS44IkKuFNZW+YlNxtfmFitEUMgrDPkyO49yccxpQUZ/OV0dUsfIlcFh9hhntz
           I5hKMyUybID93mctZf12DN2l/+pKPNaY+9WctrIKtZAWQwZcsjRC/eog3piglSI6S0
           UvVtjogIW5s1916hhbFKMFWkZaZCzOEKqBrSEDCZ4A+hYE9vUSXulk4EEunAq8bIz0
           wg+jityGzeMhb+vhg0vnQp4uwVlqhkch5+B88/z2EhQutj0lPDd8WxOysw9MeTQZVd
           ob3sF80int9TzhvVf3NZP6S/BjY1UiZXxs+zIuPrVLNREYg7xImZwEyPKOcsR4Lflj
           NRwo8k+JPUbjg==
Received: from 83.24.39.212.ipv4.supernova.orange.pl (HELO [192.168.3.203]) (olek2@wp.pl@[83.24.39.212])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <ebiggers@kernel.org>; 30 May 2026 17:05:19 +0200
Message-ID: <5c74c261-53cf-4185-a8a0-7554bc9fe5f7@wp.pl>
Date: Sat, 30 May 2026 17:05:19 +0200
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crypto: crypto4xx - Remove insecure and unused rng_alg
To: Eric Biggers <ebiggers@kernel.org>, linux-crypto@vger.kernel.org,
 Herbert Xu <herbert@gondor.apana.org.au>
Cc: Christian Lamparter <chunkeey@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260529220430.34135-1-ebiggers@kernel.org>
Content-Language: pl
From: Aleksander Jan Bajkowski <olek2@wp.pl>
In-Reply-To: <20260529220430.34135-1-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-WP-MailID: 20d5490fd971a38e2c57a89d32903454
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000009 [Ifo3]                               

Hi Eric,

On 30/05/2026 00:04, Eric Biggers wrote:
> Remove crypto4xx_rng, as it is insecure and unused:
>
> - It has only a 64-bit security strength, which is highly inadequate.
>    This can be seen by the fact that crypto4xx_hw_init() seeds it with
>    only 64 bits of entropy, and the fact that the original commit
>    mentions that it implements ANSI X9.17 Annex C.

In addition to a seed, the PRNG also uses ring oscillators as sources of
entropy. The entropy should be higher than 64b. This is the Rambus EIP-73d
IP core. The same IP core is built into eip93 (EIP-73a), eip97 (EIP-73d),
and eip197 (EIP-73d). You can find the documentation online. The complete
"container" is actually Rambus EIP-94, and one of its parts is EIP-73d.

>
>    Another issue was that this driver didn't implement the crypto_rng API
>    correctly, as crypto4xx_prng_generate() didn't return 0 on success.
>
> - No user of this code is known.  It's usable only theoretically via the
>    "rng" algorithm type of AF_ALG.  But userspace actually just uses the
>    actual Linux RNG (/dev/random etc) instead.  And rng_algs don't
>    contribute entropy to the actual Linux RNG either.  (This may have
>    been confused with hwrng, which does contribute entropy.)

This PRNG is also used internally for Generation IV with IPSEC offload. The
IPSEC offload implementation for eip93 was recently submitted to upstream.
I am not sure whether eip94 shares some of the logic for IPSEC offload and
it will be possible to use some of the code.

>
> Fixes: d072bfa48853 ("crypto: crypto4xx - add prng crypto support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> Acked-by: Christian Lamparter <chunkeey@gmail.com>
> ---
>   drivers/crypto/Kconfig                  |  1 -
>   drivers/crypto/amcc/crypto4xx_core.c    | 88 -------------------------
>   drivers/crypto/amcc/crypto4xx_core.h    |  4 --
>   drivers/crypto/amcc/crypto4xx_reg_def.h | 11 ----
>   4 files changed, 104 deletions(-)
>
>
> base-commit: 49e05bb00f2e8168695f7af4d694c39e1423e8a2
>
> diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
> index 3449b3c9c6ad..5dab813a9f74 100644
> --- a/drivers/crypto/Kconfig
> +++ b/drivers/crypto/Kconfig
> @@ -299,11 +299,10 @@ config CRYPTO_DEV_PPC4XX
>   	select CRYPTO_AES
>   	select CRYPTO_LIB_AES
>   	select CRYPTO_CCM
>   	select CRYPTO_CTR
>   	select CRYPTO_GCM
> -	select CRYPTO_RNG
>   	select CRYPTO_SKCIPHER
>   	help
>   	  This option allows you to have support for AMCC crypto acceleration.
>   
>   config HW_RANDOM_PPC4XX
> diff --git a/drivers/crypto/amcc/crypto4xx_core.c b/drivers/crypto/amcc/crypto4xx_core.c
> index b7b6c97d2147..68c5ff7a85b4 100644
> --- a/drivers/crypto/amcc/crypto4xx_core.c
> +++ b/drivers/crypto/amcc/crypto4xx_core.c
> @@ -29,15 +29,13 @@
>   #include <crypto/aead.h>
>   #include <crypto/aes.h>
>   #include <crypto/ctr.h>
>   #include <crypto/gcm.h>
>   #include <crypto/sha1.h>
> -#include <crypto/rng.h>
>   #include <crypto/scatterwalk.h>
>   #include <crypto/skcipher.h>
>   #include <crypto/internal/aead.h>
> -#include <crypto/internal/rng.h>
>   #include <crypto/internal/skcipher.h>
>   #include "crypto4xx_reg_def.h"
>   #include "crypto4xx_core.h"
>   #include "crypto4xx_sa.h"
>   #include "crypto4xx_trng.h"
> @@ -983,14 +981,10 @@ static int crypto4xx_register_alg(struct crypto4xx_device *sec_dev,
>   		switch (alg->alg.type) {
>   		case CRYPTO_ALG_TYPE_AEAD:
>   			rc = crypto_register_aead(&alg->alg.u.aead);
>   			break;
>   
> -		case CRYPTO_ALG_TYPE_RNG:
> -			rc = crypto_register_rng(&alg->alg.u.rng);
> -			break;
> -
>   		default:
>   			rc = crypto_register_skcipher(&alg->alg.u.cipher);
>   			break;
>   		}
>   
> @@ -1012,14 +1006,10 @@ static void crypto4xx_unregister_alg(struct crypto4xx_device *sec_dev)
>   		switch (alg->alg.type) {
>   		case CRYPTO_ALG_TYPE_AEAD:
>   			crypto_unregister_aead(&alg->alg.u.aead);
>   			break;
>   
> -		case CRYPTO_ALG_TYPE_RNG:
> -			crypto_unregister_rng(&alg->alg.u.rng);
> -			break;
> -
>   		default:
>   			crypto_unregister_skcipher(&alg->alg.u.cipher);
>   		}
>   		kfree(alg);
>   	}
> @@ -1074,73 +1064,10 @@ static irqreturn_t crypto4xx_ce_interrupt_handler_revb(int irq, void *data)
>   {
>   	return crypto4xx_interrupt_handler(irq, data, PPC4XX_INTERRUPT_CLR |
>   		PPC4XX_TMO_ERR_INT);
>   }
>   
> -static int ppc4xx_prng_data_read(struct crypto4xx_device *dev,
> -				 u8 *data, unsigned int max)
> -{
> -	unsigned int i, curr = 0;
> -	u32 val[2];
> -
> -	do {
> -		/* trigger PRN generation */
> -		writel(PPC4XX_PRNG_CTRL_AUTO_EN,
> -		       dev->ce_base + CRYPTO4XX_PRNG_CTRL);
> -
> -		for (i = 0; i < 1024; i++) {
> -			/* usually 19 iterations are enough */
> -			if ((readl(dev->ce_base + CRYPTO4XX_PRNG_STAT) &
> -			     CRYPTO4XX_PRNG_STAT_BUSY))
> -				continue;
> -
> -			val[0] = readl_be(dev->ce_base + CRYPTO4XX_PRNG_RES_0);
> -			val[1] = readl_be(dev->ce_base + CRYPTO4XX_PRNG_RES_1);
> -			break;
> -		}
> -		if (i == 1024)
> -			return -ETIMEDOUT;
> -
> -		if ((max - curr) >= 8) {
> -			memcpy(data, &val, 8);
> -			data += 8;
> -			curr += 8;
> -		} else {
> -			/* copy only remaining bytes */
> -			memcpy(data, &val, max - curr);
> -			break;
> -		}
> -	} while (curr < max);
> -
> -	return curr;
> -}
> -
> -static int crypto4xx_prng_generate(struct crypto_rng *tfm,
> -				   const u8 *src, unsigned int slen,
> -				   u8 *dstn, unsigned int dlen)
> -{
> -	struct rng_alg *alg = crypto_rng_alg(tfm);
> -	struct crypto4xx_alg *amcc_alg;
> -	struct crypto4xx_device *dev;
> -	int ret;
> -
> -	amcc_alg = container_of(alg, struct crypto4xx_alg, alg.u.rng);
> -	dev = amcc_alg->dev;
> -
> -	mutex_lock(&dev->core_dev->rng_lock);
> -	ret = ppc4xx_prng_data_read(dev, dstn, dlen);
> -	mutex_unlock(&dev->core_dev->rng_lock);
> -	return ret;
> -}
> -
> -
> -static int crypto4xx_prng_seed(struct crypto_rng *tfm, const u8 *seed,
> -			unsigned int slen)
> -{
> -	return 0;
> -}
> -
>   /*
>    * Supported Crypto Algorithms
>    */
>   static struct crypto4xx_alg_common crypto4xx_alg[] = {
>   	/* Crypto AES modes */
> @@ -1266,22 +1193,10 @@ static struct crypto4xx_alg_common crypto4xx_alg[] = {
>   			.cra_blocksize	= 1,
>   			.cra_ctxsize	= sizeof(struct crypto4xx_ctx),
>   			.cra_module	= THIS_MODULE,
>   		},
>   	} },
> -	{ .type = CRYPTO_ALG_TYPE_RNG, .u.rng = {
> -		.base = {
> -			.cra_name		= "stdrng",
> -			.cra_driver_name        = "crypto4xx_rng",
> -			.cra_priority		= 300,
> -			.cra_ctxsize		= 0,
> -			.cra_module		= THIS_MODULE,
> -		},
> -		.generate               = crypto4xx_prng_generate,
> -		.seed                   = crypto4xx_prng_seed,
> -		.seedsize               = 0,
> -	} },
>   };
>   
>   /*
>    * Module Initialization Routine
>    */
> @@ -1351,13 +1266,10 @@ static int crypto4xx_probe(struct platform_device *ofdev)
>   	}
>   
>   	core_dev->dev->core_dev = core_dev;
>   	core_dev->dev->is_revb = is_revb;
>   	core_dev->device = dev;
> -	rc = devm_mutex_init(&ofdev->dev, &core_dev->rng_lock);
> -	if (rc)
> -		return rc;
>   	spin_lock_init(&core_dev->lock);
>   	INIT_LIST_HEAD(&core_dev->dev->alg_list);
>   	ratelimit_default_init(&core_dev->dev->aead_ratelimit);
>   	rc = crypto4xx_build_sdr(core_dev->dev);
>   	if (rc)
> diff --git a/drivers/crypto/amcc/crypto4xx_core.h b/drivers/crypto/amcc/crypto4xx_core.h
> index ee36630c670f..3a028aec3f0c 100644
> --- a/drivers/crypto/amcc/crypto4xx_core.h
> +++ b/drivers/crypto/amcc/crypto4xx_core.h
> @@ -12,14 +12,12 @@
>   
>   #ifndef __CRYPTO4XX_CORE_H__
>   #define __CRYPTO4XX_CORE_H__
>   
>   #include <linux/ratelimit.h>
> -#include <linux/mutex.h>
>   #include <linux/scatterlist.h>
>   #include <crypto/internal/aead.h>
> -#include <crypto/internal/rng.h>
>   #include <crypto/internal/skcipher.h>
>   #include "crypto4xx_reg_def.h"
>   #include "crypto4xx_sa.h"
>   
>   #define PPC460SX_SDR0_SRST                      0x201
> @@ -109,11 +107,10 @@ struct crypto4xx_core_device {
>   	struct hwrng *trng;
>   	u32 int_status;
>   	u32 irq;
>   	struct tasklet_struct tasklet;
>   	spinlock_t lock;
> -	struct mutex rng_lock;
>   };
>   
>   struct crypto4xx_ctx {
>   	struct crypto4xx_device *dev;
>   	struct dynamic_sa_ctl *sa_in;
> @@ -133,11 +130,10 @@ struct crypto4xx_aead_reqctx {
>   struct crypto4xx_alg_common {
>   	u32 type;
>   	union {
>   		struct skcipher_alg cipher;
>   		struct aead_alg aead;
> -		struct rng_alg rng;
>   	} u;
>   };
>   
>   struct crypto4xx_alg {
>   	struct list_head  entry;
> diff --git a/drivers/crypto/amcc/crypto4xx_reg_def.h b/drivers/crypto/amcc/crypto4xx_reg_def.h
> index 1038061224da..73d626308a84 100644
> --- a/drivers/crypto/amcc/crypto4xx_reg_def.h
> +++ b/drivers/crypto/amcc/crypto4xx_reg_def.h
> @@ -88,24 +88,13 @@
>   
>   #define CRYPTO4XX_DMA_CFG	        	0x000600d4
>   #define CRYPTO4XX_BYTE_ORDER_CFG 		0x000600d8
>   #define CRYPTO4XX_ENDIAN_CFG			0x000600d8
>   
> -#define CRYPTO4XX_PRNG_STAT			0x00070000
> -#define CRYPTO4XX_PRNG_STAT_BUSY		0x1
>   #define CRYPTO4XX_PRNG_CTRL			0x00070004
>   #define CRYPTO4XX_PRNG_SEED_L			0x00070008
>   #define CRYPTO4XX_PRNG_SEED_H			0x0007000c
> -
> -#define CRYPTO4XX_PRNG_RES_0			0x00070020
> -#define CRYPTO4XX_PRNG_RES_1			0x00070024
> -#define CRYPTO4XX_PRNG_RES_2			0x00070028
> -#define CRYPTO4XX_PRNG_RES_3			0x0007002C
> -
> -#define CRYPTO4XX_PRNG_LFSR_L			0x00070030
> -#define CRYPTO4XX_PRNG_LFSR_H			0x00070034
> -
>   /*
>    * Initialize CRYPTO ENGINE registers, and memory bases.
>    */
>   #define PPC4XX_PDR_POLL				0x3ff
>   #define PPC4XX_OUTPUT_THRESHOLD			2

