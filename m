Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s4jxj3h4mzDqQ1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Aug 2016 18:38:01 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anton Blanchard <anton@ozlabs.org>, benh@kernel.crashing.org,
 paulus@samba.org, herbert@gondor.apana.org.au, davem@davemloft.net
Cc: alastair@d-silva.org, linuxppc-dev@lists.ozlabs.org,
 linux-crypto@vger.kernel.org
Subject: Re: [PATCH] crypto: crc32c-vpmsum - Convert to CPU feature based
 module autoloading
In-Reply-To: <1470292695-9829-1-git-send-email-anton@ozlabs.org>
References: <1470292695-9829-1-git-send-email-anton@ozlabs.org>
Date: Thu, 04 Aug 2016 18:38:00 +1000
Message-ID: <87lh0dexp3.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anton Blanchard <anton@ozlabs.org> writes:

> From: Anton Blanchard <anton@samba.org>
>
> This patch utilises the GENERIC_CPU_AUTOPROBE infrastructure
> to automatically load the crc32c-vpmsum module if the CPU supports
> it.
>
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
>  arch/powerpc/crypto/crc32c-vpmsum_glue.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/crypto/crc32c-vpmsum_glue.c b/arch/powerpc/crypto/crc32c-vpmsum_glue.c
> index bfe3d37..9fa046d 100644
> --- a/arch/powerpc/crypto/crc32c-vpmsum_glue.c
> +++ b/arch/powerpc/crypto/crc32c-vpmsum_glue.c
> @@ -4,6 +4,7 @@
>  #include <linux/module.h>
>  #include <linux/string.h>
>  #include <linux/kernel.h>
> +#include <linux/cpufeature.h>
>  #include <asm/switch_to.h>
>  
>  #define CHKSUM_BLOCK_SIZE	1
> @@ -157,7 +158,7 @@ static void __exit crc32c_vpmsum_mod_fini(void)
>  	crypto_unregister_shash(&alg);
>  }
>  
> -module_init(crc32c_vpmsum_mod_init);
> +module_cpu_feature_match(PPC_MODULE_FEATURE_VEC_CRYPTO, crc32c_vpmsum_mod_init);

Is VEC_CRYPTO the right feature?

That's new power8 crypto stuff.

I thought this only used VMX? (but I haven't looked closely)

cheers
