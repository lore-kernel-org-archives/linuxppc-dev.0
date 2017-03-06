Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::147:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vc44B1bm9zDqFh
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Mar 2017 13:48:57 +1100 (AEDT)
Date: Mon, 6 Mar 2017 13:48:45 +1100
From: Anton Blanchard <anton@samba.org>
To: Daniel Axtens <dja@axtens.net>
Cc: linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH] crypto: powerpc - Fix initialisation of crc32c context
Message-ID: <20170306134845.133a1980@kryten>
In-Reply-To: <20170303065655.7317-1-dja@axtens.net>
References: <20170303065655.7317-1-dja@axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Daniel,

> Turning on crypto self-tests on a POWER8 shows:
> 
>     alg: hash: Test 1 failed for crc32c-vpmsum
>     00000000: ff ff ff ff
> 
> Comparing the code with the Intel CRC32c implementation on which
> ours is based shows that we are doing an init with 0, not ~0
> as CRC32c requires.
> 
> This probably wasn't caught because btrfs does its own weird
> open-coded initialisation.
> 
> Initialise our internal context to ~0 on init.
> 
> This makes the self-tests pass, and btrfs continues to work.

Thanks! Not sure how I screwed that up.

Acked-by: Anton Blanchard <anton@samba.org>

> Fixes: 6dd7a82cc54e ("crypto: powerpc - Add POWER8 optimised crc32c")
> Cc: Anton Blanchard <anton@samba.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> ---
>  arch/powerpc/crypto/crc32c-vpmsum_glue.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/crypto/crc32c-vpmsum_glue.c
> b/arch/powerpc/crypto/crc32c-vpmsum_glue.c index
> 9fa046d56eba..411994551afc 100644 ---
> a/arch/powerpc/crypto/crc32c-vpmsum_glue.c +++
> b/arch/powerpc/crypto/crc32c-vpmsum_glue.c @@ -52,7 +52,7 @@ static
> int crc32c_vpmsum_cra_init(struct crypto_tfm *tfm) {
>  	u32 *key = crypto_tfm_ctx(tfm);
>  
> -	*key = 0;
> +	*key = ~0;
>  
>  	return 0;
>  }
