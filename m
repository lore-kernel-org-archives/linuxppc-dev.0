Return-Path: <akinobu.mita@gmail.com>
Received: from mail-pa0-f45.google.com (mail-pa0-f45.google.com
 [209.85.220.45])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A55EA2C02F3
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  3 Mar 2013 01:06:49 +1100 (EST)
Received: by mail-pa0-f45.google.com with SMTP id kl14so2342048pab.32
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 02 Mar 2013 06:06:47 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: remove unused BITOP_LE_SWIZZLE macro
Date: Sat,  2 Mar 2013 23:06:30 +0900
Message-Id: <1362233190-4362-1-git-send-email-akinobu.mita@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>, Akinobu Mita <akinobu.mita@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The BITOP_LE_SWIZZLE macro was used in the little-endian bitops functions
for powerpc.  But these functions were converted to generic bitops and
the BITOP_LE_SWIZZLE is not used anymore.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/include/asm/bitops.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/include/asm/bitops.h b/arch/powerpc/include/asm/bitops.h
index ef918a2..08bd299 100644
--- a/arch/powerpc/include/asm/bitops.h
+++ b/arch/powerpc/include/asm/bitops.h
@@ -52,8 +52,6 @@
 #define smp_mb__before_clear_bit()	smp_mb()
 #define smp_mb__after_clear_bit()	smp_mb()
 
-#define BITOP_LE_SWIZZLE	((BITS_PER_LONG-1) & ~0x7)
-
 /* Macro for generating the ***_bits() functions */
 #define DEFINE_BITOP(fn, op, prefix, postfix)	\
 static __inline__ void fn(unsigned long mask,	\
-- 
1.8.1.2
