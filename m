Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yMLYT35QqzDqkp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Oct 2017 17:57:33 +1100 (AEDT)
Date: Wed, 25 Oct 2017 17:57:26 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Matthew Wilcox <mawilcox@microsoft.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, lkml@vger.kernel.org
Cc: linuxppc-dev@ozlabs.org, linux-s390@vger.kernel.org
Subject: [PATCH] bitmap: Fix optimization of bitmap_set/clear for big-endian
 machines
Message-ID: <20171025065726.GA25140@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 2a98dc028f91 ("include/linux/bitmap.h: turn bitmap_set and
bitmap_clear into memset when possible", 2017-07-10) added an
optimization which effectively assumes that a contiguous set of
bits in a bitmap will be stored in a contiguous set of bytes of
the bitmap, in the case where the starting bit number and number of
bits are multiples of 8.  This is true for a little-endian
representation, but not for a big-endian representation, because we
number the bits of a long from right to left for both little-endian
and big-endian representations.

The optimization can still be done for big-endian platforms, but
only if the starting bit number and number of bits are multiples
of BITS_PER_LONG.  This adjusts the code to use 8 for little-endian
and BITS_PER_LONG for big-endian platforms.

Cc: stable@vger.kernel.org # v4.13
Fixes: 2a98dc028f91 ("include/linux/bitmap.h: turn bitmap_set and bitmap_clear into memset when possible")
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
This was found by inspection.

I'm pretty sure commit 2c6deb01525a is wrong as well on big-endian
machines.

 include/linux/bitmap.h | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 700cf5f..44e2eb4 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -174,8 +174,10 @@ extern unsigned int bitmap_to_u32array(u32 *buf,
 				       unsigned int nbits);
 #ifdef __BIG_ENDIAN
 extern void bitmap_copy_le(unsigned long *dst, const unsigned long *src, unsigned int nbits);
+#define BITMAP_MIN_UNIT	BITS_PER_LONG	/* have to access as longs */
 #else
 #define bitmap_copy_le bitmap_copy
+#define BITMAP_MIN_UNIT	8		/* can access as bytes if desired */
 #endif
 extern unsigned int bitmap_ord_to_pos(const unsigned long *bitmap, unsigned int ord, unsigned int nbits);
 extern int bitmap_print_to_pagebuf(bool list, char *buf,
@@ -317,8 +319,10 @@ static __always_inline void bitmap_set(unsigned long *map, unsigned int start,
 {
 	if (__builtin_constant_p(nbits) && nbits == 1)
 		__set_bit(start, map);
-	else if (__builtin_constant_p(start & 7) && IS_ALIGNED(start, 8) &&
-		 __builtin_constant_p(nbits & 7) && IS_ALIGNED(nbits, 8))
+	else if (__builtin_constant_p(start & (BITMAP_MIN_UNIT-1)) &&
+		 IS_ALIGNED(start, BITMAP_MIN_UNIT) &&
+		 __builtin_constant_p(nbits & (BITMAP_MIN_UNIT-1)) &&
+		 IS_ALIGNED(nbits, BITMAP_MIN_UNIT))
 		memset((char *)map + start / 8, 0xff, nbits / 8);
 	else
 		__bitmap_set(map, start, nbits);
@@ -329,8 +333,10 @@ static __always_inline void bitmap_clear(unsigned long *map, unsigned int start,
 {
 	if (__builtin_constant_p(nbits) && nbits == 1)
 		__clear_bit(start, map);
-	else if (__builtin_constant_p(start & 7) && IS_ALIGNED(start, 8) &&
-		 __builtin_constant_p(nbits & 7) && IS_ALIGNED(nbits, 8))
+	else if (__builtin_constant_p(start & (BITMAP_MIN_UNIT-1)) &&
+		 IS_ALIGNED(start, BITMAP_MIN_UNIT) &&
+		 __builtin_constant_p(nbits & (BITMAP_MIN_UNIT-1)) &&
+		 IS_ALIGNED(nbits, BITMAP_MIN_UNIT))
 		memset((char *)map + start / 8, 0, nbits / 8);
 	else
 		__bitmap_clear(map, start, nbits);
-- 
2.7.4
