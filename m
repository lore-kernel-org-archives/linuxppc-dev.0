Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41hjYB6wlZzF2DD
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Aug 2018 20:13:18 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 41hjYB4kD8z9s5c
 for <linuxppc-dev@ozlabs.org>; Fri,  3 Aug 2018 20:13:18 +1000 (AEST)
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v3 4/4] powerpc/64: Copy as much as possible in
 __copy_tofrom_user
Date: Fri,  3 Aug 2018 20:13:06 +1000
Message-Id: <1533291186-5374-5-git-send-email-paulus@ozlabs.org>
In-Reply-To: <1533291186-5374-1-git-send-email-paulus@ozlabs.org>
References: <1533291186-5374-1-git-send-email-paulus@ozlabs.org>
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
index 2197a35..96c514b 100644
--- a/arch/powerpc/lib/copyuser_64.S
+++ b/arch/powerpc/lib/copyuser_64.S
@@ -379,8 +379,8 @@ stex;	stb	r0,0(r3)
 	blr
 
 /*
- * exception handlers for stores: we just need to work
- * out how many bytes weren't copied
+ * exception handlers for stores: we need to work out how many bytes
+ * weren't copied, and we may need to copy some more.
  * Note that the number of bytes of instructions for adjusting r3 needs
  * to equal the amount of the adjustment, due to the trick of using
  * .Lst_exc - r3_offset as the handler address.
@@ -400,10 +400,27 @@ stex;	stb	r0,0(r3)
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
+100:	EX_TABLE(100b,19f)
+	lbzx	r0,r8,r4
+100:	EX_TABLE(100b,19f)
+	stb	r0,0(r3)
+	addi	r3,r3,1
+	cmpld	r3,r7
+	blt	17b
+19:	subf	r3,r3,r7	/* #bytes not copied in r3 */
 	blr
 
 /*
-- 
2.7.4
