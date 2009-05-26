Return-Path: <Geoff.Thorpe@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 75EBADDFCF
	for <linuxppc-dev@ozlabs.org>; Wed, 27 May 2009 04:19:13 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n4QIJ7PS022730
	for <linuxppc-dev@ozlabs.org>; Tue, 26 May 2009 11:19:08 -0700 (MST)
From: Geoff Thorpe <Geoff.Thorpe@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] RFC: powerpc: expose the multi-bit ops that underlie
	single-bit ops.
Date: Tue, 26 May 2009 14:19:06 -0400
Message-Id: <1243361946-6771-1-git-send-email-Geoff.Thorpe@freescale.com>
Cc: Geoff Thorpe <Geoff.Thorpe@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

NOT FOR COMMIT, THIS IS A REQUEST FOR FEEDBACK.

The bitops.h functions that operate on a single bit in a bitfield are
implemented by operating on the corresponding word location. In all cases
the inner logic appears to be valid if the mask being applied has more
than one bit set, so this patch exposes those inner operations. Indeed,
set_bits() was already available, but it duplicated code from set_bit()
(rather than making the latter a wrapper) - it was also missing the
PPC405_ERR77() workaround and the "volatile" address qualifier present in
other APIs. This corrects that, and exposes the other multi-bit
equivalents.

One advantage of these multi-bit forms is that they allow word-sized
variables to essentially be their own spinlocks.

NB, the same factoring is possible in asm-generic/bitops/[non-]atomic.h.
I would be happy to provide corresponding patches if this approach is
deemed appropriate. Feedback would be most welcome.

Signed-off-by: Geoff Thorpe <Geoff.Thorpe@freescale.com>
---
 arch/powerpc/include/asm/bitops.h |  111 +++++++++++++++++++++++--------------
 1 files changed, 69 insertions(+), 42 deletions(-)

diff --git a/arch/powerpc/include/asm/bitops.h b/arch/powerpc/include/asm/bitops.h
index 897eade..72de28c 100644
--- a/arch/powerpc/include/asm/bitops.h
+++ b/arch/powerpc/include/asm/bitops.h
@@ -56,11 +56,10 @@
 #define BITOP_WORD(nr)		((nr) / BITS_PER_LONG)
 #define BITOP_LE_SWIZZLE	((BITS_PER_LONG-1) & ~0x7)
 
-static __inline__ void set_bit(int nr, volatile unsigned long *addr)
+static __inline__ void set_bits(unsigned long mask, volatile unsigned long *_p)
 {
 	unsigned long old;
-	unsigned long mask = BITOP_MASK(nr);
-	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
+	unsigned long *p = (unsigned long *)_p;
 
 	__asm__ __volatile__(
 "1:"	PPC_LLARX "%0,0,%3	# set_bit\n"
@@ -73,11 +72,16 @@ static __inline__ void set_bit(int nr, volatile unsigned long *addr)
 	: "cc" );
 }
 
-static __inline__ void clear_bit(int nr, volatile unsigned long *addr)
+static __inline__ void set_bit(int nr, volatile unsigned long *addr)
+{
+	set_bits(BITOP_MASK(nr), addr + BITOP_WORD(nr));
+}
+
+static __inline__ void clear_bits(unsigned long mask,
+				volatile unsigned long *_p)
 {
 	unsigned long old;
-	unsigned long mask = BITOP_MASK(nr);
-	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
+	unsigned long *p = (unsigned long *)_p;
 
 	__asm__ __volatile__(
 "1:"	PPC_LLARX "%0,0,%3	# clear_bit\n"
@@ -90,11 +94,16 @@ static __inline__ void clear_bit(int nr, volatile unsigned long *addr)
 	: "cc" );
 }
 
-static __inline__ void clear_bit_unlock(int nr, volatile unsigned long *addr)
+static __inline__ void clear_bit(int nr, volatile unsigned long *addr)
+{
+	clear_bits(BITOP_MASK(nr), addr + BITOP_WORD(nr));
+}
+
+static __inline__ void clear_bits_unlock(unsigned long mask,
+					volatile unsigned long *_p)
 {
 	unsigned long old;
-	unsigned long mask = BITOP_MASK(nr);
-	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
+	unsigned long *p = (unsigned long *)_p;
 
 	__asm__ __volatile__(
 	LWSYNC_ON_SMP
@@ -108,11 +117,16 @@ static __inline__ void clear_bit_unlock(int nr, volatile unsigned long *addr)
 	: "cc", "memory");
 }
 
-static __inline__ void change_bit(int nr, volatile unsigned long *addr)
+static __inline__ void clear_bit_unlock(int nr, volatile unsigned long *addr)
+{
+	clear_bits_unlock(BITOP_MASK(nr), addr + BITOP_WORD(nr));
+}
+
+static __inline__ void change_bits(unsigned long mask,
+				volatile unsigned long *_p)
 {
 	unsigned long old;
-	unsigned long mask = BITOP_MASK(nr);
-	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
+	unsigned long *p = (unsigned long *)_p;
 
 	__asm__ __volatile__(
 "1:"	PPC_LLARX "%0,0,%3	# change_bit\n"
@@ -125,12 +139,16 @@ static __inline__ void change_bit(int nr, volatile unsigned long *addr)
 	: "cc" );
 }
 
-static __inline__ int test_and_set_bit(unsigned long nr,
-				       volatile unsigned long *addr)
+static __inline__ void change_bit(int nr, volatile unsigned long *addr)
+{
+	change_bits(BITOP_MASK(nr), addr + BITOP_WORD(nr));
+}
+
+static __inline__ unsigned long test_and_set_bits(unsigned long mask,
+						volatile unsigned long *_p)
 {
 	unsigned long old, t;
-	unsigned long mask = BITOP_MASK(nr);
-	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
+	unsigned long *p = (unsigned long *)_p;
 
 	__asm__ __volatile__(
 	LWSYNC_ON_SMP
@@ -144,15 +162,21 @@ static __inline__ int test_and_set_bit(unsigned long nr,
 	: "r" (mask), "r" (p)
 	: "cc", "memory");
 
-	return (old & mask) != 0;
+	return (old & mask);
 }
 
-static __inline__ int test_and_set_bit_lock(unsigned long nr,
+static __inline__ int test_and_set_bit(unsigned long nr,
 				       volatile unsigned long *addr)
 {
+	return test_and_set_bits(BITOP_MASK(nr), addr + BITOP_WORD(nr)) != 0;
+}
+
+static __inline__ unsigned long test_and_set_bits_lock(
+					unsigned long mask,
+					volatile unsigned long *_p)
+{
 	unsigned long old, t;
-	unsigned long mask = BITOP_MASK(nr);
-	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
+	unsigned long *p = (unsigned long *)_p;
 
 	__asm__ __volatile__(
 "1:"	PPC_LLARX "%0,0,%3		# test_and_set_bit_lock\n"
@@ -165,15 +189,21 @@ static __inline__ int test_and_set_bit_lock(unsigned long nr,
 	: "r" (mask), "r" (p)
 	: "cc", "memory");
 
-	return (old & mask) != 0;
+	return (old & mask);
 }
 
-static __inline__ int test_and_clear_bit(unsigned long nr,
-					 volatile unsigned long *addr)
+static __inline__ int test_and_set_bit_lock(unsigned long nr,
+				       volatile unsigned long *addr)
+{
+	return test_and_set_bits_lock(BITOP_MASK(nr),
+				addr + BITOP_WORD(nr)) != 0;
+}
+
+static __inline__ unsigned long test_and_clear_bits(unsigned long mask,
+					volatile unsigned long *_p)
 {
 	unsigned long old, t;
-	unsigned long mask = BITOP_MASK(nr);
-	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
+	unsigned long *p = (unsigned long *)_p;
 
 	__asm__ __volatile__(
 	LWSYNC_ON_SMP
@@ -187,15 +217,20 @@ static __inline__ int test_and_clear_bit(unsigned long nr,
 	: "r" (mask), "r" (p)
 	: "cc", "memory");
 
-	return (old & mask) != 0;
+	return (old & mask);
 }
 
-static __inline__ int test_and_change_bit(unsigned long nr,
-					  volatile unsigned long *addr)
+static __inline__ int test_and_clear_bit(unsigned long nr,
+					 volatile unsigned long *addr)
+{
+	return test_and_clear_bits(BITOP_MASK(nr), addr + BITOP_WORD(nr)) != 0;
+}
+
+static __inline__ unsigned long test_and_change_bits(unsigned long mask,
+						volatile unsigned long *_p)
 {
 	unsigned long old, t;
-	unsigned long mask = BITOP_MASK(nr);
-	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
+	unsigned long *p = (unsigned long *)_p;
 
 	__asm__ __volatile__(
 	LWSYNC_ON_SMP
@@ -209,21 +244,13 @@ static __inline__ int test_and_change_bit(unsigned long nr,
 	: "r" (mask), "r" (p)
 	: "cc", "memory");
 
-	return (old & mask) != 0;
+	return (old & mask);
 }
 
-static __inline__ void set_bits(unsigned long mask, unsigned long *addr)
+static __inline__ int test_and_change_bit(unsigned long nr,
+					  volatile unsigned long *addr)
 {
-        unsigned long old;
-
-	__asm__ __volatile__(
-"1:"	PPC_LLARX "%0,0,%3         # set_bits\n"
-	"or	%0,%0,%2\n"
-	PPC_STLCX "%0,0,%3\n"
-	"bne-	1b"
-	: "=&r" (old), "+m" (*addr)
-	: "r" (mask), "r" (addr)
-	: "cc");
+	return test_and_change_bits(BITOP_MASK(nr), addr + BITOP_WORD(nr)) != 0;
 }
 
 #include <asm-generic/bitops/non-atomic.h>
-- 
1.5.6.3
