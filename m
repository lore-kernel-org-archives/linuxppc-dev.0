Return-Path: <herbert@gondor.apana.org.au>
Received: from helcar.apana.org.au (helcar.hengli.com.au [209.40.204.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vTXmQ3DkYzDq8M
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 22:57:42 +1100 (AEDT)
Date: Thu, 23 Feb 2017 19:20:53 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Paulo Flabiano Smorigo <pfsmorigo@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, davem@davemloft.net,
 linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 pfsmorigo@linux.vnet.ibm.com
Subject: Re: [PATCH 1/2] crypto: vmx - Use skcipher for cbc fallback
Message-ID: <20170223112052.GA14019@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170222180015.27573-1-pfsmorigo@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paulo Flabiano Smorigo <pfsmorigo@linux.vnet.ibm.com> wrote:
>
>        fallback =
> -           crypto_alloc_blkcipher(alg, 0, CRYPTO_ALG_NEED_FALLBACK);
> +           crypto_alloc_skcipher(alg, 0, CRYPTO_ALG_NEED_FALLBACK);

You need to add CRYPTO_ALG_ASYNC to the mask in order to ensure
that you get a sync algorithm.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
