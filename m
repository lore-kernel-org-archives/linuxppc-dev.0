Return-Path: <mroos@linux.ee>
Received: from smtp1.it.da.ut.ee (smtp1.it.da.ut.ee
 [IPv6:2001:bb8:2002:500::46])
 by lists.ozlabs.org (Postfix) with ESMTP id 42HQfP2151zF3Nj
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Sep 2018 19:49:15 +1000 (AEST)
Date: Sat, 22 Sep 2018 12:49:06 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
Sender: mroos@math.ut.ee
To: Joel Stanley <joel@jms.id.au>
cc: Krzysztof Kozlowski <krzk@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Christophe LEROY <christophe.leroy@c-s.fr>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/xz: Put CRC32_POLY_LE in xz_private.h
In-Reply-To: <20180921025431.28366-1-joel@jms.id.au>
Message-ID: <alpine.LRH.2.21.1809221248410.17835@math.ut.ee>
References: <20180921025431.28366-1-joel@jms.id.au>
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

> This fixes a regression introduced by faa16bc404d72a5 ("lib: Use
> existing define with polynomial").
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
> The powerpc decompresser is a hairy corner of the kernel. Even while building
> a 64-bit kernel it needs to build a 32-bit binary and therefore avoid including
> files from include/linux.
> 
> This allows users of the xz library to avoid including headers from
> 'include/linux/' while still achieving the cleanup of the magic number.
> 
> Fixes: faa16bc404d72a5 ("lib: Use existing define with polynomial")
> Reported-by: Meelis Roos <mroos@linux.ee>
> Reported-by: kbuild test robot <lkp@intel.com>
> Suggested-by: Christophe LEROY <christophe.leroy@c-s.fr>
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Tested-by: Meelis Roos <mroos@linux.ee>

-- 
Meelis Roos (mroos@linux.ee)
