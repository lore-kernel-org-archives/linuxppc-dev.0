Return-Path: <abdhalee@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40lfCz6rQPzF2VV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 May 2018 23:53:19 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4FDjqw0043475
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 May 2018 09:53:16 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2hywun0wnj-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 May 2018 09:53:13 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <abdhalee@linux.vnet.ibm.com>;
 Tue, 15 May 2018 09:53:12 -0400
Subject: Re: [PATCH] crypto: reorder paes test lexicographically
From: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
To: Gilad Ben-Yossef <gilad@benyossef.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller"
 <davem@davemloft.net>, sachinp <sachinp@linux.vnet.ibm.com>, Stephen
 Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org, linux-next
 <linux-next@vger.kernel.org>, linux-crypto@vger.kernel.org, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>, Ofir Drang <ofir.drang@arm.com>
Date: Tue, 15 May 2018 19:23:04 +0530
In-Reply-To: <1526025847-13134-1-git-send-email-gilad@benyossef.com>
References: <1526025847-13134-1-git-send-email-gilad@benyossef.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1526392384.19317.3.camel@abdul>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-05-11 at 09:04 +0100, Gilad Ben-Yossef wrote:
> Due to a snafu "paes" testmgr tests were not ordered
> lexicographically, which led to boot time warnings.
> Reorder the tests as needed.
> 
> Fixes: a794d8d ("crypto: ccree - enable support for hardware keys")
> Reported-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
> Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
> ---
>  crypto/testmgr.c | 44 ++++++++++++++++++++++----------------------
>  1 file changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/crypto/testmgr.c b/crypto/testmgr.c
> index c31da0f..b1b8ebb 100644
> --- a/crypto/testmgr.c
> +++ b/crypto/testmgr.c
> @@ -3012,13 +3012,6 @@ static const struct alg_test_desc alg_test_descs[] = {
>  			}
>  		}
>  	}, {
> -		/* Same as ecb(aes) except the key is stored in
> -		 * hardware secure memory which we reference by index
> -		 */
> -		.alg = "ecb(paes)",
> -		.test = alg_test_null,
> -		.fips_allowed = 1,
> -	}, {
>  		.alg = "ecb(khazad)",
>  		.test = alg_test_skcipher,
>  		.suite = {
> @@ -3028,6 +3021,13 @@ static const struct alg_test_desc alg_test_descs[] = {
>  			}
>  		}
>  	}, {
> +		/* Same as ecb(aes) except the key is stored in
> +		 * hardware secure memory which we reference by index
> +		 */
> +		.alg = "ecb(paes)",
> +		.test = alg_test_null,
> +		.fips_allowed = 1,
> +	}, {
>  		.alg = "ecb(seed)",
>  		.test = alg_test_skcipher,
>  		.suite = {
> @@ -3610,21 +3610,6 @@ static const struct alg_test_desc alg_test_descs[] = {
>  			}
>  		}
>  	}, {
> -		/* Same as xts(aes) except the key is stored in
> -		 * hardware secure memory which we reference by index
> -		 */
> -		.alg = "xts(paes)",
> -		.test = alg_test_null,
> -		.fips_allowed = 1,
> -	}, {
> -		.alg = "xts4096(paes)",
> -		.test = alg_test_null,
> -		.fips_allowed = 1,
> -	}, {
> -		.alg = "xts512(paes)",
> -		.test = alg_test_null,
> -		.fips_allowed = 1,
> -	}, {
>  		.alg = "xts(camellia)",
>  		.test = alg_test_skcipher,
>  		.suite = {
> @@ -3643,6 +3628,13 @@ static const struct alg_test_desc alg_test_descs[] = {
>  			}
>  		}
>  	}, {
> +		/* Same as xts(aes) except the key is stored in
> +		 * hardware secure memory which we reference by index
> +		 */
> +		.alg = "xts(paes)",
> +		.test = alg_test_null,
> +		.fips_allowed = 1,
> +	}, {
>  		.alg = "xts(serpent)",
>  		.test = alg_test_skcipher,
>  		.suite = {
> @@ -3679,6 +3671,14 @@ static const struct alg_test_desc alg_test_descs[] = {
>  			}
>  		}
>  	}, {
> +		.alg = "xts4096(paes)",
> +		.test = alg_test_null,
> +		.fips_allowed = 1,
> +	}, {
> +		.alg = "xts512(paes)",
> +		.test = alg_test_null,
> +		.fips_allowed = 1,
> +	}, {
>  		.alg = "zlib-deflate",
>  		.test = alg_test_comp,
>  		.fips_allowed = 1,


Gilad, 

The given patch fixes the boot warnings.

Tested-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>

Thanks for the fix.

-- 
Regard's

Abdul Haleem
IBM Linux Technology Centre
