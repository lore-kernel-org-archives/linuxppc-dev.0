Return-Path: <jdmason@us.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7AF74679A6
	for <linuxppc-dev@ozlabs.org>; Sat, 20 May 2006 06:35:41 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k4JKZaGS022554
	for <linuxppc-dev@ozlabs.org>; Fri, 19 May 2006 16:35:36 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k4JKZasL221868
	for <linuxppc-dev@ozlabs.org>; Fri, 19 May 2006 16:35:36 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k4JKZabg005565
	for <linuxppc-dev@ozlabs.org>; Fri, 19 May 2006 16:35:36 -0400
Date: Fri, 19 May 2006 15:35:32 -0500
From: Jon Mason <jdmason@us.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] remove powerpc bitops infavor of existing generic bitops
Message-ID: <20060519203532.GB10666@us.ibm.com>
References: <20060515180108.GB17646@us.ibm.com>
	<17517.20729.170817.242398@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17517.20729.170817.242398@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 19, 2006 at 03:00:41PM +1000, Paul Mackerras wrote:
> Jon Mason writes:
> 
> > There already exists a big endian safe bitops implementation in
> > lib/find_next_bit.c.  The code in it is 90%+ common with the powerpc
> > specific version, so the powerpc version is redundant.  This patch
> > makes the necessary changes to use the generic bitops in powerpc, and
> > removes the powerpc specific version.
> 
> This patch breaks ARCH=ppc builds.  Please resubmit with the necessary
> changes to arch/ppc/Kconfig as well.
> 
> Paul.

Sorry.  Here is the patch with the necessary correction.

Thanks,
Jon

Signed-off-by: Jon Mason <jdmason@us.ibm.com>

diff -r a89fd2f124df arch/powerpc/Kconfig
--- a/arch/powerpc/Kconfig	Fri May 19 16:17:18 2006 +0700
+++ b/arch/powerpc/Kconfig	Fri May 19 15:34:39 2006 -0500
@@ -42,6 +42,10 @@ config GENERIC_HWEIGHT
 	default y
 
 config GENERIC_CALIBRATE_DELAY
+	bool
+	default y
+
+config GENERIC_FIND_NEXT_BIT
 	bool
 	default y
 
diff -r a89fd2f124df arch/powerpc/lib/Makefile
--- a/arch/powerpc/lib/Makefile	Fri May 19 16:17:18 2006 +0700
+++ b/arch/powerpc/lib/Makefile	Fri May 19 15:34:39 2006 -0500
@@ -7,7 +7,6 @@ obj-$(CONFIG_PPC32)	+= div64.o copy_32.o
 obj-$(CONFIG_PPC32)	+= div64.o copy_32.o checksum_32.o
 endif
 
-obj-y			+= bitops.o
 obj-$(CONFIG_PPC64)	+= checksum_64.o copypage_64.o copyuser_64.o \
 			   memcpy_64.o usercopy_64.o mem_64.o string.o \
 			   strcase.o
diff -r a89fd2f124df arch/ppc/Kconfig
--- a/arch/ppc/Kconfig	Fri May 19 16:17:18 2006 +0700
+++ b/arch/ppc/Kconfig	Fri May 19 15:34:39 2006 -0500
@@ -37,6 +37,10 @@ config PPC32
 
 # All PPCs use generic nvram driver through ppc_md
 config GENERIC_NVRAM
+	bool
+	default y
+
+config GENERIC_FIND_NEXT_BIT
 	bool
 	default y
 
diff -r a89fd2f124df include/asm-powerpc/bitops.h
--- a/include/asm-powerpc/bitops.h	Fri May 19 16:17:18 2006 +0700
+++ b/include/asm-powerpc/bitops.h	Fri May 19 15:34:39 2006 -0500
@@ -288,8 +288,8 @@ static __inline__ int test_le_bit(unsign
 #define __test_and_clear_le_bit(nr, addr) \
 	__test_and_clear_bit((nr) ^ BITOP_LE_SWIZZLE, (addr))
 
-#define find_first_zero_le_bit(addr, size) find_next_zero_le_bit((addr), (size), 0)
-unsigned long find_next_zero_le_bit(const unsigned long *addr,
+#define find_first_zero_le_bit(addr, size) generic_find_next_zero_le_bit((addr), (size), 0)
+unsigned long generic_find_next_zero_le_bit(const unsigned long *addr,
 				    unsigned long size, unsigned long offset);
 
 /* Bitmap functions for the ext2 filesystem */
@@ -309,7 +309,7 @@ unsigned long find_next_zero_le_bit(cons
 #define ext2_find_first_zero_bit(addr, size) \
 	find_first_zero_le_bit((unsigned long*)addr, size)
 #define ext2_find_next_zero_bit(addr, size, off) \
-	find_next_zero_le_bit((unsigned long*)addr, size, off)
+	generic_find_next_zero_le_bit((unsigned long*)addr, size, off)
 
 /* Bitmap functions for the minix filesystem.  */
 
diff -r a89fd2f124df arch/powerpc/lib/bitops.c
--- a/arch/powerpc/lib/bitops.c	Fri May 19 16:17:18 2006 +0700
+++ /dev/null	Thu Jan  1 00:00:00 1970 +0000
@@ -1,150 +0,0 @@
-#include <linux/types.h>
-#include <linux/module.h>
-#include <asm/byteorder.h>
-#include <asm/bitops.h>
-
-/**
- * find_next_bit - find the next set bit in a memory region
- * @addr: The address to base the search on
- * @offset: The bitnumber to start searching at
- * @size: The maximum size to search
- */
-unsigned long find_next_bit(const unsigned long *addr, unsigned long size,
-			    unsigned long offset)
-{
-	const unsigned long *p = addr + BITOP_WORD(offset);
-	unsigned long result = offset & ~(BITS_PER_LONG-1);
-	unsigned long tmp;
-
-	if (offset >= size)
-		return size;
-	size -= result;
-	offset %= BITS_PER_LONG;
-	if (offset) {
-		tmp = *(p++);
-		tmp &= (~0UL << offset);
-		if (size < BITS_PER_LONG)
-			goto found_first;
-		if (tmp)
-			goto found_middle;
-		size -= BITS_PER_LONG;
-		result += BITS_PER_LONG;
-	}
-	while (size & ~(BITS_PER_LONG-1)) {
-		if ((tmp = *(p++)))
-			goto found_middle;
-		result += BITS_PER_LONG;
-		size -= BITS_PER_LONG;
-	}
-	if (!size)
-		return result;
-	tmp = *p;
-
-found_first:
-	tmp &= (~0UL >> (BITS_PER_LONG - size));
-	if (tmp == 0UL)		/* Are any bits set? */
-		return result + size;	/* Nope. */
-found_middle:
-	return result + __ffs(tmp);
-}
-EXPORT_SYMBOL(find_next_bit);
-
-/*
- * This implementation of find_{first,next}_zero_bit was stolen from
- * Linus' asm-alpha/bitops.h.
- */
-unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
-				 unsigned long offset)
-{
-	const unsigned long *p = addr + BITOP_WORD(offset);
-	unsigned long result = offset & ~(BITS_PER_LONG-1);
-	unsigned long tmp;
-
-	if (offset >= size)
-		return size;
-	size -= result;
-	offset %= BITS_PER_LONG;
-	if (offset) {
-		tmp = *(p++);
-		tmp |= ~0UL >> (BITS_PER_LONG - offset);
-		if (size < BITS_PER_LONG)
-			goto found_first;
-		if (~tmp)
-			goto found_middle;
-		size -= BITS_PER_LONG;
-		result += BITS_PER_LONG;
-	}
-	while (size & ~(BITS_PER_LONG-1)) {
-		if (~(tmp = *(p++)))
-			goto found_middle;
-		result += BITS_PER_LONG;
-		size -= BITS_PER_LONG;
-	}
-	if (!size)
-		return result;
-	tmp = *p;
-
-found_first:
-	tmp |= ~0UL << size;
-	if (tmp == ~0UL)	/* Are any bits zero? */
-		return result + size;	/* Nope. */
-found_middle:
-	return result + ffz(tmp);
-}
-EXPORT_SYMBOL(find_next_zero_bit);
-
-static inline unsigned int ext2_ilog2(unsigned int x)
-{
-	int lz;
-
-	asm("cntlzw %0,%1": "=r"(lz):"r"(x));
-	return 31 - lz;
-}
-
-static inline unsigned int ext2_ffz(unsigned int x)
-{
-	u32 rc;
-	if ((x = ~x) == 0)
-		return 32;
-	rc = ext2_ilog2(x & -x);
-	return rc;
-}
-
-unsigned long find_next_zero_le_bit(const unsigned long *addr,
-				    unsigned long size, unsigned long offset)
-{
-	const unsigned int *p = ((const unsigned int *)addr) + (offset >> 5);
-	unsigned int result = offset & ~31;
-	unsigned int tmp;
-
-	if (offset >= size)
-		return size;
-	size -= result;
-	offset &= 31;
-	if (offset) {
-		tmp = cpu_to_le32p(p++);
-		tmp |= ~0U >> (32 - offset);	/* bug or feature ? */
-		if (size < 32)
-			goto found_first;
-		if (tmp != ~0)
-			goto found_middle;
-		size -= 32;
-		result += 32;
-	}
-	while (size >= 32) {
-		if ((tmp = cpu_to_le32p(p++)) != ~0)
-			goto found_middle;
-		result += 32;
-		size -= 32;
-	}
-	if (!size)
-		return result;
-	tmp = cpu_to_le32p(p);
-found_first:
-	tmp |= ~0 << size;
-	if (tmp == ~0)		/* Are any bits zero? */
-		return result + size;	/* Nope. */
-found_middle:
-	return result + ext2_ffz(tmp);
-}
-EXPORT_SYMBOL(find_next_zero_le_bit);
