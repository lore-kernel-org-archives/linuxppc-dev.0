Return-Path: <markn@au1.ibm.com>
Received: from ausmtp05.au.ibm.com (ausmtp05.au.ibm.com [202.81.18.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CA802DDDDB
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Nov 2008 21:59:33 +1100 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by ausmtp05.au.ibm.com (8.13.8/8.13.8) with ESMTP id mABAxBlb3817554
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Nov 2008 21:59:11 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mABArD211822730
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Nov 2008 21:53:14 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mABAr5an001555
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Nov 2008 21:53:05 +1100
Received: from ozlabs.au.ibm.com (ozlabs.au.ibm.com [9.190.163.12])
	by d23av02.au.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	mABAr520001552
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Nov 2008 21:53:05 +1100
Received: from wecm01-9-185-116-31.au.ibm.com (WECM01-9-185-116-31.au.ibm.com
	[9.185.116.31])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.au.ibm.com (Postfix) with ESMTP id AC998735F7
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Nov 2008 21:52:55 +1100 (EST)
From: Mark Nelson <markn@au1.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Update 64bit __copy_tofrom_user() using
	CPU_FTR_UNALIGNED_LD_STD
Date: Tue, 11 Nov 2008 21:53:34 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200811112153.34133.markn@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In exactly the same way that we updated memcpy() with new feature sections
in commit 25d6e2d7c58ddc4a3b614fc5381591c0cfe66556 we do the same thing
here for __copy_tofrom_user(). Once again this is purely a performance
tweak for Cell and Power6 - this has no effect on all the other 64bit
powerpc chips.

We can make these same changes to __copy_tofrom_user() because the basic
copy algorithm is the same as in memcpy() - this version just has all the
exception handling logic needed when copying to or from userspace as well
as a special case for copying whole 4K pages that are page aligned.

CPU_FTR_UNALIGNED_LD_STD CPU was added in commit
4ec577a28980a0790df3c3dfe9c81f6e2222acfb

We also make the same simple one line change from cmpldi r1,... to cmpldi
cr1,... for consistency.

Signed-off-by: Mark Nelson <markn@au1.ibm.com>
---
 arch/powerpc/lib/copyuser_64.S |   17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

Index: upstream/arch/powerpc/lib/copyuser_64.S
===================================================================
--- upstream.orig/arch/powerpc/lib/copyuser_64.S
+++ upstream/arch/powerpc/lib/copyuser_64.S
@@ -26,11 +26,24 @@ _GLOBAL(__copy_tofrom_user)
 	andi.	r6,r6,7
 	PPC_MTOCRF	0x01,r5
 	blt	cr1,.Lshort_copy
+/* Below we want to nop out the bne if we're on a CPU that has the
+ * CPU_FTR_UNALIGNED_LD_STD bit set and the CPU_FTR_CP_USE_DCBTZ bit
+ * cleared.
+ * At the time of writing the only CPU that has this combination of bits
+ * set is Power6.
+ */
+BEGIN_FTR_SECTION
+	nop
+FTR_SECTION_ELSE
 	bne	.Ldst_unaligned
+ALT_FTR_SECTION_END(CPU_FTR_UNALIGNED_LD_STD | CPU_FTR_CP_USE_DCBTZ, \
+		    CPU_FTR_UNALIGNED_LD_STD)
 .Ldst_aligned:
-	andi.	r0,r4,7
 	addi	r3,r3,-16
+BEGIN_FTR_SECTION
+	andi.	r0,r4,7
 	bne	.Lsrc_unaligned
+END_FTR_SECTION_IFCLR(CPU_FTR_UNALIGNED_LD_STD)
 	srdi	r7,r5,4
 20:	ld	r9,0(r4)
 	addi	r4,r4,-8
@@ -138,7 +151,7 @@ _GLOBAL(__copy_tofrom_user)
 	PPC_MTOCRF	0x01,r6		/* put #bytes to 8B bdry into cr7 */
 	subf	r5,r6,r5
 	li	r7,0
-	cmpldi	r1,r5,16
+	cmpldi	cr1,r5,16
 	bf	cr7*4+3,1f
 35:	lbz	r0,0(r4)
 81:	stb	r0,0(r3)
