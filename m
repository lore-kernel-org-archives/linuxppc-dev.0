Return-Path: <Horia.Geanta@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0130.outbound.protection.outlook.com [157.56.111.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AAD741A006F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Feb 2015 02:47:03 +1100 (AEDT)
Message-ID: <54F09163.5080007@freescale.com>
Date: Fri, 27 Feb 2015 17:46:43 +0200
From: =?UTF-8?B?SG9yaWEgR2VhbnTEgw==?= <horia.geanta@freescale.com>
MIME-Version: 1.0
To: Martin Hicks <mort@bork.org>, Kim Phillips <kim.phillips@freescale.com>,
 Scott Wood <scottwood@freescale.com>, Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/2] crypto: talitos: Add AES-XTS Support
References: <1424451610-5786-1-git-send-email-mort@bork.org>
 <1424451610-5786-3-git-send-email-mort@bork.org>
In-Reply-To: <1424451610-5786-3-git-send-email-mort@bork.org>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2/20/2015 7:00 PM, Martin Hicks wrote:
> The newer talitos hardware has support for AES in XTS mode.
> 
> Signed-off-by: Martin Hicks <mort@bork.org>
> ---

checkpatch complains about formatting, please check.

>  drivers/crypto/talitos.c |   33 +++++++++++++++++++++++++++++++++
>  drivers/crypto/talitos.h |    1 +
>  2 files changed, 34 insertions(+)
> 
> diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
> index 6b2a19a..38cbde1 100644
> --- a/drivers/crypto/talitos.c
> +++ b/drivers/crypto/talitos.c
> @@ -40,9 +40,11 @@
>  #include <linux/spinlock.h>
>  #include <linux/rtnetlink.h>
>  #include <linux/slab.h>
> +#include <linux/device-mapper.h>
>  
>  #include <crypto/algapi.h>
>  #include <crypto/aes.h>
> +#include <crypto/xts.h>
>  #include <crypto/des.h>
>  #include <crypto/sha.h>
>  #include <crypto/md5.h>
> @@ -1464,9 +1466,22 @@ static struct talitos_edesc *ablkcipher_edesc_alloc(struct ablkcipher_request *
>  						    areq, bool encrypt)
>  {
>  	struct crypto_ablkcipher *cipher = crypto_ablkcipher_reqtfm(areq);
> +	struct crypto_tfm *tfm = (struct crypto_tfm *)cipher;
>  	struct talitos_ctx *ctx = crypto_ablkcipher_ctx(cipher);
>  	unsigned int ivsize = crypto_ablkcipher_ivsize(cipher);
>  
> +	/*
> +	 * AES-XTS uses the first two AES Context registers for:
> +	 *
> +	 *     Register 1:   Sector Number (Little Endian)
> +	 *     Register 2:   Sector Size   (Big Endian)
> +	 *
> +	 * Whereas AES-CBC uses registers 1/2 as a 16-byte IV.
> +	 */
> +	if (!strcmp(crypto_tfm_alg_name(tfm),"xts(aes)"))

I guess it would be better to use ctx->desc_hdr_template instead of
string comparison.

> +		/* Fixed sized sector */
> +		*((u64 *)areq->info + 1) = cpu_to_be64((1<<SECTOR_SHIFT));
> +
>  	return talitos_edesc_alloc(ctx->dev, NULL, areq->src, areq->dst,
>  				   areq->info, 0, areq->nbytes, 0, ivsize, 0,
>  				   areq->base.flags, &areq->base, encrypt);
> @@ -2192,6 +2207,24 @@ static struct talitos_alg_template driver_algs[] = {
>  		                     DESC_HDR_MODE0_DEU_CBC |
>  		                     DESC_HDR_MODE0_DEU_3DES,
>  	},
> +	{	.type = CRYPTO_ALG_TYPE_ABLKCIPHER,
> +		.alg.crypto = {
> +			.cra_name = "xts(aes)",
> +			.cra_driver_name = "xts-aes-talitos",
> +			.cra_blocksize = XTS_BLOCK_SIZE,
> +			.cra_flags = CRYPTO_ALG_TYPE_ABLKCIPHER |
> +                                     CRYPTO_ALG_ASYNC,
> +			.cra_ablkcipher = {
> +				.min_keysize = AES_MIN_KEY_SIZE * 2,
> +				.max_keysize = AES_MAX_KEY_SIZE * 2,
> +				.ivsize = XTS_BLOCK_SIZE,
> +			}
> +		},
> +		.desc_hdr_template = DESC_HDR_TYPE_COMMON_NONSNOOP_NO_AFEU |
> +					DESC_HDR_SEL0_AESU |
> +					DESC_HDR_MODE0_AESU_XTS,
> +	},
> +
>  	/* AHASH algorithms. */
>  	{	.type = CRYPTO_ALG_TYPE_AHASH,
>  		.alg.hash = {
> diff --git a/drivers/crypto/talitos.h b/drivers/crypto/talitos.h
> index a6f73e2..735da82 100644
> --- a/drivers/crypto/talitos.h
> +++ b/drivers/crypto/talitos.h
> @@ -316,6 +316,7 @@ extern int talitos_submit(struct device *dev, int ch, struct talitos_edesc *edes
>  /* primary execution unit mode (MODE0) and derivatives */
>  #define	DESC_HDR_MODE0_ENCRYPT		cpu_to_be32(0x00100000)
>  #define	DESC_HDR_MODE0_AESU_CBC		cpu_to_be32(0x00200000)
> +#define	DESC_HDR_MODE0_AESU_XTS		cpu_to_be32(0x04200000)
>  #define	DESC_HDR_MODE0_DEU_CBC		cpu_to_be32(0x00400000)
>  #define	DESC_HDR_MODE0_DEU_3DES		cpu_to_be32(0x00200000)
>  #define	DESC_HDR_MODE0_MDEU_CONT	cpu_to_be32(0x08000000)
> 
