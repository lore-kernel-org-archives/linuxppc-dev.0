Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t8YK160c6zDvQW
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Nov 2016 16:23:17 +1100 (AEDT)
Date: Thu, 3 Nov 2016 16:23:08 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 4/4] powerpc/64: Copy as much as possible in __copy_tofrom_user
Message-ID: <20161103052308.GF8368@fergus.ozlabs.ibm.com>
References: <20161103051949.GC8368@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161103051949.GC8368@fergus.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In __copy_tofrom_user, if we encounter an exception on a store, we
stop copying and return the number of bytes not copied.  However,
if the store is wider than one byte and is to an unaligned address,
it is possible that the store operand overlaps a page boundary
and the exception occurred on the latter part of the store operand,
meaning that it would be possible to copy a few more bytes.  Since
copy_to_user is generally expected to copy as much as possible,
it would be better to copy those extra few bytes.  This adds code
to do that.  Since this edge case is not performance-critical,
the code has been written to be compact rather than as fast as
possible.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/lib/copyuser_64.S | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/lib/copyuser_64.S b/arch/powerpc/lib/copyuser_64.S
index 668d816..c479256 100644
--- a/arch/powerpc/lib/copyuser_64.S
+++ b/arch/powerpc/lib/copyuser_64.S
@@ -409,8 +409,8 @@ stex;	stb	r0,0(r3)
 99:	blr
 
 /*
- * exception handlers for stores: we just need to work
- * out how many bytes weren't copied
+ * exception handlers for stores: we need to work out how many bytes
+ * weren't copied, and we may need to copy some more.
  * Note that the number of bytes of instructions for adjusting r3 needs
  * to equal the amount of the adjustment, due to the trick of using
  * .Lst_exc - r3_offset as the handler address.
@@ -430,10 +430,27 @@ stex;	stb	r0,0(r3)
 	/* adjust by 4 */
 	addi	r3,r3,4
 .Lst_exc:
-	ld	r6,-24(r1)
-	ld	r5,-8(r1)
-	add	r6,r6,r5
-	subf	r3,r3,r6	/* #bytes not copied in r3 */
+	ld	r6,-24(r1)	/* original destination pointer */
+	ld	r4,-16(r1)	/* original source pointer */
+	ld	r5,-8(r1)	/* original number of bytes */
+	add	r7,r6,r5
+	/*
+	 * If the destination pointer isn't 8-byte aligned,
+	 * we may have got the exception as a result of a
+	 * store that overlapped a page boundary, so we may be
+	 * able to copy a few more bytes.
+	 */
+17:	andi.	r0,r3,7
+	beq	19f
+	subf	r8,r6,r3	/* #bytes copied */
+	extable	19f
+	lbzx	r0,r8,r4
+	extable	19f
+	stb	r0,0(r3)
+	addi	r3,r3,1
+	cmpld	r3,r7
+	blt	17b
+19:	subf	r3,r3,r7	/* #bytes not copied in r3 */
 	blr
 
 /*
-- 
2.10.1
