Return-Path: <joel.stan@gmail.com>
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42FJZ81XfMzF3JC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2018 09:08:15 +1000 (AEST)
Received: by mail-pf1-x442.google.com with SMTP id p12-v6so1729995pfh.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Sep 2018 16:08:15 -0700 (PDT)
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From: Joel Stanley <joel@jms.id.au>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>,
 Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] lib/xz: Fix powerpc build with KERNEL_XZ
Date: Wed, 19 Sep 2018 08:37:56 +0930
Message-Id: <20180918230756.26035-1-joel@jms.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This partially reverts faa16bc404d72a5 ("lib: Use existing define with
polynomial").

The cleanup added a dependency on include/linux, which broke the PowerPC
boot wrapper/decompresser when KERNEL_XZ is enabled:

  BOOTCC  arch/powerpc/boot/decompress.o
 In file included from arch/powerpc/boot/../../../lib/decompress_unxz.c:233,
                 from arch/powerpc/boot/decompress.c:42:
 arch/powerpc/boot/../../../lib/xz/xz_crc32.c:18:10: fatal error:
 linux/crc32poly.h: No such file or directory
  #include <linux/crc32poly.h>
           ^~~~~~~~~~~~~~~~~~~

The powerpc decompressor is a hairy corner of the kernel. Even while building
a 64-bit kernel it needs to build a 32-bit binary and therefore avoid including
files from include/linux.

Fixes: faa16bc404d7 ("lib: Use existing define with polynomial")
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
We need to clean up the powerpc boot decompresser but that work will be
more involved than we would include in a late -rc. Please consider
merging this fix for 4.19. Thanks!

 lib/xz/xz_crc32.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/xz/xz_crc32.c b/lib/xz/xz_crc32.c
index 25a5d87e2e4c..34532d14fd4c 100644
--- a/lib/xz/xz_crc32.c
+++ b/lib/xz/xz_crc32.c
@@ -15,7 +15,6 @@
  * but they are bigger and use more memory for the lookup table.
  */
 
-#include <linux/crc32poly.h>
 #include "xz_private.h"
 
 /*
@@ -30,7 +29,7 @@ STATIC_RW_DATA uint32_t xz_crc32_table[256];
 
 XZ_EXTERN void xz_crc32_init(void)
 {
-	const uint32_t poly = CRC32_POLY_LE;
+	const uint32_t poly = 0xEDB88320;
 
 	uint32_t i;
 	uint32_t j;
-- 
2.17.1
