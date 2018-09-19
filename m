Return-Path: <krzk@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42FVZc5xLZzF3Hs
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2018 16:39:20 +1000 (AEST)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7948C21508
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2018 06:39:17 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id j15-v6so413247wrt.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Sep 2018 23:39:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180918230756.26035-1-joel@jms.id.au>
In-Reply-To: <20180918230756.26035-1-joel@jms.id.au>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 19 Sep 2018 08:39:04 +0200
Message-ID: <CAJKOXPd4dCyuXKxAz-V=ujtiuKcumHzAx28y5J+6m+L7ZRLsZQ@mail.gmail.com>
Subject: Re: [PATCH] lib/xz: Fix powerpc build with KERNEL_XZ
To: joel@jms.id.au
Cc: herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
 mpe@ellerman.id.au, oohall@gmail.com, linuxppc-dev@lists.ozlabs.org,
 Christophe LEROY <christophe.leroy@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 19 Sep 2018 at 01:08, Joel Stanley <joel@jms.id.au> wrote:
>
> This partially reverts faa16bc404d72a5 ("lib: Use existing define with
> polynomial").
>
> The cleanup added a dependency on include/linux, which broke the PowerPC
> boot wrapper/decompresser when KERNEL_XZ is enabled:
>
>   BOOTCC  arch/powerpc/boot/decompress.o
>  In file included from arch/powerpc/boot/../../../lib/decompress_unxz.c:233,
>                  from arch/powerpc/boot/decompress.c:42:
>  arch/powerpc/boot/../../../lib/xz/xz_crc32.c:18:10: fatal error:
>  linux/crc32poly.h: No such file or directory
>   #include <linux/crc32poly.h>
>            ^~~~~~~~~~~~~~~~~~~
>
> The powerpc decompressor is a hairy corner of the kernel. Even while building
> a 64-bit kernel it needs to build a 32-bit binary and therefore avoid including
> files from include/linux.

I fixed the build error here:
https://lkml.org/lkml/2018/8/29/179

If you choose to remove any includes from /linux, then go ahead but
please use original reported-by :)

Best regards,
Krzysztof

>
> Fixes: faa16bc404d7 ("lib: Use existing define with polynomial")
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> We need to clean up the powerpc boot decompresser but that work will be
> more involved than we would include in a late -rc. Please consider
> merging this fix for 4.19. Thanks!
>
>  lib/xz/xz_crc32.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/lib/xz/xz_crc32.c b/lib/xz/xz_crc32.c
> index 25a5d87e2e4c..34532d14fd4c 100644
> --- a/lib/xz/xz_crc32.c
> +++ b/lib/xz/xz_crc32.c
> @@ -15,7 +15,6 @@
>   * but they are bigger and use more memory for the lookup table.
>   */
>
> -#include <linux/crc32poly.h>
>  #include "xz_private.h"
>
>  /*
> @@ -30,7 +29,7 @@ STATIC_RW_DATA uint32_t xz_crc32_table[256];
>
>  XZ_EXTERN void xz_crc32_init(void)
>  {
> -       const uint32_t poly = CRC32_POLY_LE;
> +       const uint32_t poly = 0xEDB88320;
>
>         uint32_t i;
>         uint32_t j;
> --
> 2.17.1
>
