Return-Path: <jstancek@redhat.com>
Received: from mx4-phx2.redhat.com (mx4-phx2.redhat.com [209.132.183.25])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3skWqL5wJvzDrVH
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Sep 2016 18:59:42 +1000 (AEST)
Date: Wed, 28 Sep 2016 04:59:31 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
To: Marcelo Cerri <marcelo.cerri@canonical.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
 rui y wang <rui.y.wang@intel.com>, mhcerri@linux.vnet.ibm.com,
 leosilva@linux.vnet.ibm.com, pfsmorigo@linux.vnet.ibm.com,
 linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Message-ID: <269752859.97552.1475053171837.JavaMail.zimbra@redhat.com>
In-Reply-To: <20160927194644.GB15729@gallifrey>
References: <450861381.1559123.1474673197124.JavaMail.zimbra@redhat.com>
 <1655600242.1561022.1474676547316.JavaMail.zimbra@redhat.com>
 <20160926145934.GA5520@gondor.apana.org.au>
 <20160926174317.GA21317@gallifrey>
 <20160927030826.GB8579@gondor.apana.org.au>
 <346154437.225735.1474966863173.JavaMail.zimbra@redhat.com>
 <20160927120414.GC21317@gallifrey> <20160927194644.GB15729@gallifrey>
Subject: Re: [bug] crypto/vmx/p8_ghash memory corruption in 4.8-rc7
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Jan,
> 
> Can you check if the problem occurs with this patch?

No issues in over-night test with this patch.

> --- a/drivers/crypto/vmx/vmx.c
> +++ b/drivers/crypto/vmx/vmx.c
> @@ -28,6 +28,8 @@
>  #include <asm/cputable.h>
>  #include <crypto/internal/hash.h>
>  
> +int p8_ghash_fallback_descsize(void);
> +
>  extern struct shash_alg p8_ghash_alg;
>  extern struct crypto_alg p8_aes_alg;
>  extern struct crypto_alg p8_aes_cbc_alg;
> @@ -45,6 +47,7 @@ int __init p8_init(void)
>  {
>  	int ret = 0;
>  	struct crypto_alg **alg_it;
> +	int ghash_descsize;
>  
>  	for (alg_it = algs; *alg_it; alg_it++) {
>  		ret = crypto_register_alg(*alg_it);
> @@ -59,6 +62,12 @@ int __init p8_init(void)
>  	if (ret)
>  		return ret;
>  
> +	ghash_descsize = p8_ghash_fallback_descsize();
> +	if (ghash_descsize < 0) {
> +		printk(KERN_ERR "Cannot get descsize for p8_ghash fallback\n");
> +		return ghash_descsize;
> +	}
> +	p8_ghash_alg.descsize += ghash_descsize;
>  	ret = crypto_register_shash(&p8_ghash_alg);
>  	if (ret) {
>  		for (alg_it = algs; *alg_it; alg_it++)

I'd suggest to move this inside vmx/ghash.c to a new function, so all p8_ghash
related code is at single place. Then p8_init() would just call the new
function:
-    ret = crypto_register_shash(&p8_ghash_alg);
+    ret = register_p8_ghash();

Regards,
Jan
