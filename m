Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42FTXv5sYrzDqjl
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2018 15:52:46 +1000 (AEST)
Subject: Re: [PATCH] lib/xz: Fix powerpc build with KERNEL_XZ
To: Joel Stanley <joel@jms.id.au>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, Oliver O'Halloran <oohall@gmail.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org
References: <20180918230756.26035-1-joel@jms.id.au>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <a3a97ebf-9a40-db6e-8225-7b9ccf9cfb4b@c-s.fr>
Date: Wed, 19 Sep 2018 07:52:42 +0200
MIME-Version: 1.0
In-Reply-To: <20180918230756.26035-1-joel@jms.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 19/09/2018 à 01:07, Joel Stanley a écrit :
> This partially reverts faa16bc404d72a5 ("lib: Use existing define with
> polynomial").
> 
> The cleanup added a dependency on include/linux, which broke the PowerPC
> boot wrapper/decompresser when KERNEL_XZ is enabled:
> 
>    BOOTCC  arch/powerpc/boot/decompress.o
>   In file included from arch/powerpc/boot/../../../lib/decompress_unxz.c:233,
>                   from arch/powerpc/boot/decompress.c:42:
>   arch/powerpc/boot/../../../lib/xz/xz_crc32.c:18:10: fatal error:
>   linux/crc32poly.h: No such file or directory
>    #include <linux/crc32poly.h>
>             ^~~~~~~~~~~~~~~~~~~
> 
> The powerpc decompressor is a hairy corner of the kernel. Even while building
> a 64-bit kernel it needs to build a 32-bit binary and therefore avoid including
> files from include/linux.
> 
> Fixes: faa16bc404d7 ("lib: Use existing define with polynomial")
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> We need to clean up the powerpc boot decompresser but that work will be
> more involved than we would include in a late -rc. Please consider
> merging this fix for 4.19. Thanks!
> 
>   lib/xz/xz_crc32.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/lib/xz/xz_crc32.c b/lib/xz/xz_crc32.c
> index 25a5d87e2e4c..34532d14fd4c 100644
> --- a/lib/xz/xz_crc32.c
> +++ b/lib/xz/xz_crc32.c
> @@ -15,7 +15,6 @@
>    * but they are bigger and use more memory for the lookup table.
>    */
>   
> -#include <linux/crc32poly.h>
>   #include "xz_private.h"
>   
>   /*
> @@ -30,7 +29,7 @@ STATIC_RW_DATA uint32_t xz_crc32_table[256];
>   
>   XZ_EXTERN void xz_crc32_init(void)
>   {
> -	const uint32_t poly = CRC32_POLY_LE;
> +	const uint32_t poly = 0xEDB88320;

Maybe avoid capital letters ?

What about adding something like the following in xz_private.h instead:

#define CRC32_POLY_LE 0xedb88320

Christophe

>   
>   	uint32_t i;
>   	uint32_t j;
> 
