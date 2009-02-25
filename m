Return-Path: <markn@au1.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp07.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6B940DDDFF
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Feb 2009 10:44:49 +1100 (EST)
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.31.243])
	by e23smtp07.au.ibm.com (8.13.1/8.13.1) with ESMTP id n1PNile8002164
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Feb 2009 10:44:47 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n1PNj5YV237954
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Feb 2009 10:45:05 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n1PNilx5015131
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Feb 2009 10:44:47 +1100
From: Mark Nelson <markn@au1.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH] powerpc: Fix 64bit __copy_tofrom_user() regression
Date: Thu, 26 Feb 2009 10:46:24 +1100
References: <49A2705D.9030008@in.ibm.com>
	<200902251752.56514.markn@au1.ibm.com>
	<200902261026.48183.markn@au1.ibm.com>
In-Reply-To: <200902261026.48183.markn@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200902261046.24367.markn@au1.ibm.com>
Cc: Jan Kara <jack@ucw.cz>, Jan Kara <jack@suse.cz>, Mel Gorman <mel@csn.ul.ie>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-ext4@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This fixes a regression introduced by commit
a4e22f02f5b6518c1484faea1f88d81802b9feac ("powerpc: Update 64bit
__copy_tofrom_user() using CPU_FTR_UNALIGNED_LD_STD").

The same bug that existed in the 64bit memcpy() also exists here so fix
it here too. The fix is the same as that applied to memcpy() with the
addition of fixes for the exception handling code required for
__copy_tofrom_user().

This stops us reading beyond the end of the source region we were told
to copy.

Signed-off-by: Mark Nelson <markn@au1.ibm.com>
---
 arch/powerpc/lib/copyuser_64.S |   38 +++++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

Index: upstream/arch/powerpc/lib/copyuser_64.S
===================================================================
--- upstream.orig/arch/powerpc/lib/copyuser_64.S
+++ upstream/arch/powerpc/lib/copyuser_64.S
@@ -62,18 +62,19 @@ END_FTR_SECTION_IFCLR(CPU_FTR_UNALIGNED_
 72:	std	r8,8(r3)
 	beq+	3f
 	addi	r3,r3,16
-23:	ld	r9,8(r4)
 .Ldo_tail:
 	bf	cr7*4+1,1f
-	rotldi	r9,r9,32
+23:	lwz	r9,8(r4)
+	addi	r4,r4,4
 73:	stw	r9,0(r3)
 	addi	r3,r3,4
 1:	bf	cr7*4+2,2f
-	rotldi	r9,r9,16
+44:	lhz	r9,8(r4)
+	addi	r4,r4,2
 74:	sth	r9,0(r3)
 	addi	r3,r3,2
 2:	bf	cr7*4+3,3f
-	rotldi	r9,r9,8
+45:	lbz	r9,8(r4)
 75:	stb	r9,0(r3)
 3:	li	r3,0
 	blr
@@ -141,11 +142,24 @@ END_FTR_SECTION_IFCLR(CPU_FTR_UNALIGNED_
 6:	cmpwi	cr1,r5,8
 	addi	r3,r3,32
 	sld	r9,r9,r10
-	ble	cr1,.Ldo_tail
+	ble	cr1,7f
 34:	ld	r0,8(r4)
 	srd	r7,r0,r11
 	or	r9,r7,r9
-	b	.Ldo_tail
+7:
+	bf	cr7*4+1,1f
+	rotldi	r9,r9,32
+94:	stw	r9,0(r3)
+	addi	r3,r3,4
+1:	bf	cr7*4+2,2f
+	rotldi	r9,r9,16
+95:	sth	r9,0(r3)
+	addi	r3,r3,2
+2:	bf	cr7*4+3,3f
+	rotldi	r9,r9,8
+96:	stb	r9,0(r3)
+3:	li	r3,0
+	blr
 
 .Ldst_unaligned:
 	PPC_MTOCRF	0x01,r6		/* put #bytes to 8B bdry into cr7 */
@@ -218,7 +232,6 @@ END_FTR_SECTION_IFCLR(CPU_FTR_UNALIGNED_
 121:
 132:
 	addi	r3,r3,8
-123:
 134:
 135:
 138:
@@ -226,6 +239,9 @@ END_FTR_SECTION_IFCLR(CPU_FTR_UNALIGNED_
 140:
 141:
 142:
+123:
+144:
+145:
 
 /*
  * here we have had a fault on a load and r3 points to the first
@@ -309,6 +325,9 @@ END_FTR_SECTION_IFCLR(CPU_FTR_UNALIGNED_
 187:
 188:
 189:	
+194:
+195:
+196:
 1:
 	ld	r6,-24(r1)
 	ld	r5,-8(r1)
@@ -329,7 +348,9 @@ END_FTR_SECTION_IFCLR(CPU_FTR_UNALIGNED_
 	.llong	72b,172b
 	.llong	23b,123b
 	.llong	73b,173b
+	.llong	44b,144b
 	.llong	74b,174b
+	.llong	45b,145b
 	.llong	75b,175b
 	.llong	24b,124b
 	.llong	25b,125b
@@ -347,6 +368,9 @@ END_FTR_SECTION_IFCLR(CPU_FTR_UNALIGNED_
 	.llong	79b,179b
 	.llong	80b,180b
 	.llong	34b,134b
+	.llong	94b,194b
+	.llong	95b,195b
+	.llong	96b,196b
 	.llong	35b,135b
 	.llong	81b,181b
 	.llong	36b,136b
