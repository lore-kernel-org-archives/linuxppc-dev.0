Return-Path: <joel.stan@gmail.com>
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42GdVW0yMXzF3PG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2018 12:54:42 +1000 (AEST)
Received: by mail-pg1-x543.google.com with SMTP id r77-v6so218817pgr.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2018 19:54:42 -0700 (PDT)
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From: Joel Stanley <joel@jms.id.au>
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Christophe LEROY <christophe.leroy@c-s.fr>, Meelis Roos <mroos@linux.ee>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] lib/xz: Put CRC32_POLY_LE in xz_private.h
Date: Fri, 21 Sep 2018 12:24:31 +0930
Message-Id: <20180921025431.28366-1-joel@jms.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This fixes a regression introduced by faa16bc404d72a5 ("lib: Use
existing define with polynomial").

The cleanup added a dependency on include/linux, which broke the PowerPC
boot wrapper/decompresser when KERNEL_XZ is enabled:

  BOOTCC  arch/powerpc/boot/decompress.o
 In file included from arch/powerpc/boot/../../../lib/decompress_unxz.c:233,
                 from arch/powerpc/boot/decompress.c:42:
 arch/powerpc/boot/../../../lib/xz/xz_crc32.c:18:10: fatal error:
 linux/crc32poly.h: No such file or directory
  #include <linux/crc32poly.h>
           ^~~~~~~~~~~~~~~~~~~

The powerpc decompresser is a hairy corner of the kernel. Even while building
a 64-bit kernel it needs to build a 32-bit binary and therefore avoid including
files from include/linux.

This allows users of the xz library to avoid including headers from
'include/linux/' while still achieving the cleanup of the magic number.

Fixes: faa16bc404d72a5 ("lib: Use existing define with polynomial")
Reported-by: Meelis Roos <mroos@linux.ee>
Reported-by: kbuild test robot <lkp@intel.com>
Suggested-by: Christophe LEROY <christophe.leroy@c-s.fr>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 lib/xz/xz_crc32.c   | 1 -
 lib/xz/xz_private.h | 4 ++++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/xz/xz_crc32.c b/lib/xz/xz_crc32.c
index 25a5d87e2e4c..912aae5fa09e 100644
--- a/lib/xz/xz_crc32.c
+++ b/lib/xz/xz_crc32.c
@@ -15,7 +15,6 @@
  * but they are bigger and use more memory for the lookup table.
  */
 
-#include <linux/crc32poly.h>
 #include "xz_private.h"
 
 /*
diff --git a/lib/xz/xz_private.h b/lib/xz/xz_private.h
index 482b90f363fe..09360ebb510e 100644
--- a/lib/xz/xz_private.h
+++ b/lib/xz/xz_private.h
@@ -102,6 +102,10 @@
 #	endif
 #endif
 
+#ifndef CRC32_POLY_LE
+#define CRC32_POLY_LE 0xedb88320
+#endif
+
 /*
  * Allocate memory for LZMA2 decoder. xz_dec_lzma2_reset() must be used
  * before calling xz_dec_lzma2_run().
-- 
2.17.1
