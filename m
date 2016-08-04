Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s4d7R08GxzDqRv
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Aug 2016 15:01:07 +1000 (AEST)
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3s4d7Q3bh6z9stY
 for <linuxppc-dev@ozlabs.org>; Thu,  4 Aug 2016 15:01:06 +1000 (AEST)
Date: Thu, 4 Aug 2016 15:00:48 +1000
From: Anton Blanchard <anton@samba.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: herbert@gondor.apana.org.au, <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] crypto: powerpc - CRYPT_CRC32C_VPMSUM should depend on
 ALTIVEC
Message-ID: <20160804150048.005f5c02@kryten>
In-Reply-To: <1470048886-8899-1-git-send-email-mpe@ellerman.id.au>
References: <1470048886-8899-1-git-send-email-mpe@ellerman.id.au>
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

Hi Michael,

> The optimised crc32c implementation depends on VMX (aka. Altivec)
> instructions, so the kernel must be built with Altivec support in
> order for the crc32c code to build.

Thanks for that, looks good.

Acked-by: Anton Blanchard <anton@samba.org>

> Fixes: 6dd7a82cc54e ("crypto: powerpc - Add POWER8 optimised crc32c")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  crypto/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/crypto/Kconfig b/crypto/Kconfig
> index a9377bef25e3..84d71482bf08 100644
> --- a/crypto/Kconfig
> +++ b/crypto/Kconfig
> @@ -439,7 +439,7 @@ config CRYPTO_CRC32C_INTEL
>  
>  config CRYPT_CRC32C_VPMSUM
>  	tristate "CRC32c CRC algorithm (powerpc64)"
> -	depends on PPC64
> +	depends on PPC64 && ALTIVEC
>  	select CRYPTO_HASH
>  	select CRC32
>  	help
