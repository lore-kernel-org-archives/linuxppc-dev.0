Return-Path: <markn@au1.ibm.com>
Received: from e23smtp03.au.ibm.com (E23SMTP03.au.ibm.com [202.81.18.172])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4CF15DDDE6
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Oct 2008 21:46:21 +1100 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp03.au.ibm.com (8.13.1/8.13.1) with ESMTP id m9RAixci016040
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Oct 2008 21:44:59 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m9RAkGxM273344
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Oct 2008 21:46:16 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m9RAkGe7003680
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Oct 2008 21:46:16 +1100
Received: from ozlabs.au.ibm.com (ozlabs.au.ibm.com [9.190.163.12])
	by d23av03.au.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m9RAkG2T003677
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Oct 2008 21:46:16 +1100
Received: from wecm00-9-185-92-166.au.ibm.com (WECM00-9-185-92-166.au.ibm.com
	[9.185.92.166])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.au.ibm.com (Postfix) with ESMTP id 20B7573744
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Oct 2008 21:46:15 +1100 (EST)
From: Mark Nelson <markn@au1.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] powerpc: Update 64bit memcpy() using
	CPU_FTR_UNALIGNED_LD_STD
Date: Mon, 27 Oct 2008 21:46:51 +1100
MIME-Version: 1.0
Message-Id: <200810272146.51433.markn@au1.ibm.com>
Content-Type: text/plain;
  charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Update memcpy() to add two new feature sections: one for aligning the
destination before copying and one for copying using aligned load
and store doubles.

These new feature sections will only affect Power6 and Cell because
the CPU feature bit was only added to these two processors.

Power6 gets its best performance in memcpy() when aligning neither the
source nor the destination, while Cell gets its best performance when
just the destination is aligned. But in order to save on CPU feature
bits we can use the previously added CPU_FTR_CP_USE_DCBTZ feature bit
to differentiate between Power6 and Cell (because CPU_FTR_CP_USE_DCBTZ
was added to Cell but not Power6).

The first feature section acts to nop out the branch that takes us to
the code that aligns us to an eight byte boundary for the destination.
We only want to nop out this branch on Power6.

So the ALT_FTR_SECTION_END() for this feature section creates a test
mask of the two feature bits ORed together and provides an expected
result of just CPU_FTR_UNALIGNED_LD_STD, thus we nop out the branch
if we're on a CPU that has CPU_FTR_UNALIGNED_LD_STD set and
CPU_FTR_CP_USE_DCBTZ unset.

For the second feature section added, if we're on a CPU that has the
CPU_FTR_UNALIGNED_LD_STD bit set then we don't want to do the copy
with aligned loads and stores (and the appropriate shifting left and
right instructions), so we want to nop out the branch to
.Lsrc_unaligned.

The andi. used for this branch is moved to just above the branch
because this allows us to nop out both instructions with just one
feature section which gives us better performance and doesn't hurt
readability which two separate feature sections did.

Moving the andi. to just above the branch doesn't have any noticeable
negative effect on the remaining 64bit processors (the ones that
didn't have this feature bit added).

On Cell this simple modification results in an improvement to measured
memcpy() bandwidth of up to 50% in the hot cache case and up to 15% in
the cold cache case

On Power6 we get memory bandwidth results that are up to three times
faster in the hot cache case and up to 50% faster in the cold cache
case.

CPU_FTR_CP_USE_DCBTZ was added in commit
2a9294369bd020db89bfdf78b84c3615b39a5c84.

To say that Cell gets its best performance in memcpy() with just the
destination aligned is true but only for the reason that the indirect
shift and rotate instructions, sld and srd, are microcoded on Cell.
This means that either the destination or the source can be aligned,
but not both, and seeing as we get better performance with the
destination aligned we choose this option.

While we're at it make a one line change from cmpldi r1,... to
cmpldi cr1,... for consistency.

Signed-off-by: Mark Nelson <markn@au1.ibm.com>
---
 arch/powerpc/lib/memcpy_64.S |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

Index: upstream/arch/powerpc/lib/memcpy_64.S
===================================================================
--- upstream.orig/arch/powerpc/lib/memcpy_64.S
+++ upstream/arch/powerpc/lib/memcpy_64.S
@@ -18,11 +18,23 @@ _GLOBAL(memcpy)
 	andi.	r6,r6,7
 	dcbt	0,r4
 	blt	cr1,.Lshort_copy
+/* Below we want to nop out the bne if we're on a CPU that has the
+   CPU_FTR_UNALIGNED_LD_STD bit set and the CPU_FTR_CP_USE_DCBTZ bit
+   cleared.
+   At the time of writing the only CPU that has this combination of bits
+   set is Power6. */
+BEGIN_FTR_SECTION
+	nop
+FTR_SECTION_ELSE
 	bne	.Ldst_unaligned
+ALT_FTR_SECTION_END(CPU_FTR_UNALIGNED_LD_STD | CPU_FTR_CP_USE_DCBTZ, \
+                    CPU_FTR_UNALIGNED_LD_STD)
 .Ldst_aligned:
-	andi.	r0,r4,7
 	addi	r3,r3,-16
+BEGIN_FTR_SECTION
+	andi.	r0,r4,7
 	bne	.Lsrc_unaligned
+END_FTR_SECTION_IFCLR(CPU_FTR_UNALIGNED_LD_STD)
 	srdi	r7,r5,4
 	ld	r9,0(r4)
 	addi	r4,r4,-8
@@ -131,7 +143,7 @@ _GLOBAL(memcpy)
 	PPC_MTOCRF	0x01,r6		# put #bytes to 8B bdry into cr7
 	subf	r5,r6,r5
 	li	r7,0
-	cmpldi	r1,r5,16
+	cmpldi	cr1,r5,16
 	bf	cr7*4+3,1f
 	lbz	r0,0(r4)
 	stb	r0,0(r3)
