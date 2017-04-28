Return-Path: <horia.geanta@nxp.com>
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0070.outbound.protection.outlook.com [104.47.1.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wDrfG4w32zDqG5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Apr 2017 21:08:38 +1000 (AEST)
From: =?iso-8859-2?Q?Horia_Geant=E3?= <horia.geanta@nxp.com>
To: Martin Hicks <mort@bork.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-crypto@vger.kernel.org"
 <linux-crypto@vger.kernel.org>
Subject: Re: [PATCH] crypto: talitos: Extend max key length for SHA384/512-HMAC
Date: Fri, 28 Apr 2017 11:08:31 +0000
Message-ID: <VI1PR0401MB259114A07C3644B4552A0A9998130@VI1PR0401MB2591.eurprd04.prod.outlook.com>
References: <20170427154046.GA5041@darwin.bork.org>
Content-Type: text/plain; charset="iso-8859-2"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 4/27/2017 6:46 PM, Martin Hicks wrote:=0A=
> =0A=
> The max keysize for both of these is 128, not 96.  Before, with keysizes=
=0A=
> over 96, the memcpy in ahash_setkey() would overwrite memory beyond the=
=0A=
> key field.=0A=
> =0A=
While here, what about aead_setkey()?=0A=
AFAICT, TALITOS_MAX_KEY_SIZE value has been incorrect since forever; it=0A=
does not cover the maximum values of encryption key + authentication key=0A=
for authenc algorithms.=0A=
=0A=
So, based on algorithms currently registered, I think this should be:=0A=
#define TALITOS_MAX_KEY_SIZE		(AES_MAX_KEY_SIZE + \=0A=
					 SHA512_BLOCK_SIZE)=0A=
=0A=
=0A=
> Signed-off-by: Martin Hicks <mort@bork.org>=0A=
Cc: stable@vger.kernel.org # 3.6+=0A=
Fixes: 357fb60502ede ("crypto: talitos - add sha224, sha384 and sha512=0A=
to existing AEAD algorithms")=0A=
=0A=
> ---=0A=
>  drivers/crypto/talitos.c |    2 +-=0A=
>  1 file changed, 1 insertion(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c=0A=
> index 0bba6a1..97dc85e 100644=0A=
> --- a/drivers/crypto/talitos.c=0A=
> +++ b/drivers/crypto/talitos.c=0A=
> @@ -816,7 +816,7 @@ static void talitos_unregister_rng(struct device *dev=
)=0A=
>   * HMAC_SNOOP_NO_AFEA (HSNA) instead of type IPSEC_ESP=0A=
>   */=0A=
>  #define TALITOS_CRA_PRIORITY_AEAD_HSNA	(TALITOS_CRA_PRIORITY - 1)=0A=
> -#define TALITOS_MAX_KEY_SIZE		96=0A=
> +#define TALITOS_MAX_KEY_SIZE		SHA512_BLOCK_SIZE /* SHA512 has the larges=
t keysize input */=0A=
>  #define TALITOS_MAX_IV_LENGTH		16 /* max of AES_BLOCK_SIZE, DES3_EDE_BLO=
CK_SIZE */=0A=
>  =0A=
>  struct talitos_ctx {=0A=
> =0A=
=0A=
