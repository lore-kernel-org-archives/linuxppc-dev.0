Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40rPPZ3vsLzDrp5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 17:33:06 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id w129-v6so10052682pfd.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 00:33:06 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "Naveen N.  Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Cyril Bur <cyrilbur@gmail.com>, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH v5 1/4] powerpc/64: Align bytes before fall back to .Lshort in
 powerpc64 memcmp()
Date: Wed, 23 May 2018 14:48:00 +0800
Message-Id: <1527058083-6998-2-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1527058083-6998-1-git-send-email-wei.guo.simon@gmail.com>
References: <1527058083-6998-1-git-send-email-wei.guo.simon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Simon Guo <wei.guo.simon@gmail.com>

Currently memcmp() 64bytes version in powerpc will fall back to .Lshort
(compare per byte mode) if either src or dst address is not 8 bytes aligned.
It can be opmitized in 2 situations:

1) if both addresses are with the same offset with 8 bytes boundary:
memcmp() can compare the unaligned bytes within 8 bytes boundary firstly
and then compare the rest 8-bytes-aligned content with .Llong mode.

2)  If src/dst addrs are not with the same offset of 8 bytes boundary:
memcmp() can align src addr with 8 bytes, increment dst addr accordingly,
 then load src with aligned mode and load dst with unaligned mode.

This patch optmizes memcmp() behavior in the above 2 situations.

Tested with both little/big endian. Performance result below is based on
little endian.

Following is the test result with src/dst having the same offset case:
(a similar result was observed when src/dst having different offset):
(1) 256 bytes
Test with the existing tools/testing/selftests/powerpc/stringloops/memcmp:
- without patch
	29.773018302 seconds time elapsed                                          ( +- 0.09% )
- with patch
	16.485568173 seconds time elapsed                                          ( +-  0.02% )
		-> There is ~+80% percent improvement

(2) 32 bytes
To observe performance impact on < 32 bytes, modify
tools/testing/selftests/powerpc/stringloops/memcmp.c with following:
-------
 #include <string.h>
 #include "utils.h"

-#define SIZE 256
+#define SIZE 32
 #define ITERATIONS 10000

 int test_memcmp(const void *s1, const void *s2, size_t n);
--------

- Without patch
	0.244746482 seconds time elapsed                                          ( +-  0.36%)
- with patch
	0.215069477 seconds time elapsed                                          ( +-  0.51%)
		-> There is ～+13% improvement

(3) 0~8 bytes
To observe <8 bytes performance impact, modify
tools/testing/selftests/powerpc/stringloops/memcmp.c with following:
-------
 #include <string.h>
 #include "utils.h"

-#define SIZE 256
-#define ITERATIONS 10000
+#define SIZE 8
+#define ITERATIONS 1000000

 int test_memcmp(const void *s1, const void *s2, size_t n);
-------
- Without patch
       1.845642503 seconds time elapsed                                          ( +- 0.12% )
- With patch
       1.849767135 seconds time elapsed                                          ( +- 0.26% )
		-> They are nearly the same. (-0.2%)

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 arch/powerpc/lib/memcmp_64.S | 143 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 136 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/lib/memcmp_64.S b/arch/powerpc/lib/memcmp_64.S
index d75d18b..f20e883 100644
--- a/arch/powerpc/lib/memcmp_64.S
+++ b/arch/powerpc/lib/memcmp_64.S
@@ -24,28 +24,41 @@
 #define rH	r31
 
 #ifdef __LITTLE_ENDIAN__
+#define LH	lhbrx
+#define LW	lwbrx
 #define LD	ldbrx
 #else
+#define LH	lhzx
+#define LW	lwzx
 #define LD	ldx
 #endif
 
+/*
+ * There are 2 categories for memcmp:
+ * 1) src/dst has the same offset to the 8 bytes boundary. The handlers
+ * are named like .Lsameoffset_xxxx
+ * 2) src/dst has different offset to the 8 bytes boundary. The handlers
+ * are named like .Ldiffoffset_xxxx
+ */
 _GLOBAL(memcmp)
 	cmpdi	cr1,r5,0
 
-	/* Use the short loop if both strings are not 8B aligned */
-	or	r6,r3,r4
+	/* Use the short loop if the src/dst addresses are not
+	 * with the same offset of 8 bytes align boundary.
+	 */
+	xor	r6,r3,r4
 	andi.	r6,r6,7
 
-	/* Use the short loop if length is less than 32B */
-	cmpdi	cr6,r5,31
+	/* Fall back to short loop if compare at aligned addrs
+	 * with less than 8 bytes.
+	 */
+	cmpdi   cr6,r5,7
 
 	beq	cr1,.Lzero
-	bne	.Lshort
-	bgt	cr6,.Llong
+	bgt	cr6,.Lno_short
 
 .Lshort:
 	mtctr	r5
-
 1:	lbz	rA,0(r3)
 	lbz	rB,0(r4)
 	subf.	rC,rB,rA
@@ -78,11 +91,90 @@ _GLOBAL(memcmp)
 	li	r3,0
 	blr
 
+.Lno_short:
+	dcbt	0,r3
+	dcbt	0,r4
+	bne	.Ldiffoffset_8bytes_make_align_start
+
+
+.Lsameoffset_8bytes_make_align_start:
+	/* attempt to compare bytes not aligned with 8 bytes so that
+	 * rest comparison can run based on 8 bytes alignment.
+	 */
+	andi.   r6,r3,7
+
+	/* Try to compare the first double word which is not 8 bytes aligned:
+	 * load the first double word at (src & ~7UL) and shift left appropriate
+	 * bits before comparision.
+	 */
+	clrlwi  r6,r3,29
+	rlwinm  r6,r6,3,0,28
+	beq     .Lsameoffset_8bytes_aligned
+	clrrdi	r3,r3,3
+	clrrdi	r4,r4,3
+	LD	rA,0,r3
+	LD	rB,0,r4
+	sld	rA,rA,r6
+	sld	rB,rB,r6
+	cmpld	cr0,rA,rB
+	srwi	r6,r6,3
+	bne	cr0,.LcmpAB_lightweight
+	subfic  r6,r6,8
+	subfc.	r5,r6,r5
+	addi	r3,r3,8
+	addi	r4,r4,8
+	beq	.Lzero
+
+.Lsameoffset_8bytes_aligned:
+	/* now we are aligned with 8 bytes.
+	 * Use .Llong loop if left cmp bytes are equal or greater than 32B.
+	 */
+	cmpdi   cr6,r5,31
+	bgt	cr6,.Llong
+
+.Lcmp_lt32bytes:
+	/* compare 1 ~ 32 bytes, at least r3 addr is 8 bytes aligned now */
+	cmpdi   cr5,r5,7
+	srdi    r0,r5,3
+	ble	cr5,.Lcmp_rest_lt8bytes
+
+	/* handle 8 ~ 31 bytes */
+	clrldi  r5,r5,61
+	mtctr   r0
+2:
+	LD	rA,0,r3
+	LD	rB,0,r4
+	cmpld	cr0,rA,rB
+	addi	r3,r3,8
+	addi	r4,r4,8
+	bne	cr0,.LcmpAB_lightweight
+	bdnz	2b
+
+	cmpwi   r5,0
+	beq	.Lzero
+
+.Lcmp_rest_lt8bytes:
+	/* Here we have only less than 8 bytes to compare with. at least s1
+	 * Address is aligned with 8 bytes.
+	 * The next double words are load and shift right with appropriate
+	 * bits.
+	 */
+	subfic  r6,r5,8
+	rlwinm  r6,r6,3,0,28
+	LD	rA,0,r3
+	LD	rB,0,r4
+	srd	rA,rA,r6
+	srd	rB,rB,r6
+	cmpld	cr0,rA,rB
+	bne	cr0,.LcmpAB_lightweight
+	b	.Lzero
+
 .Lnon_zero:
 	mr	r3,rC
 	blr
 
 .Llong:
+	/* At least s1 addr is aligned with 8 bytes */
 	li	off8,8
 	li	off16,16
 	li	off24,24
@@ -232,4 +324,41 @@ _GLOBAL(memcmp)
 	ld	r28,-32(r1)
 	ld	r27,-40(r1)
 	blr
+
+.LcmpAB_lightweight:   /* skip NV GPRS restore */
+	li	r3,1
+	bgt	cr0,8f
+	li	r3,-1
+8:
+	blr
+
+.Ldiffoffset_8bytes_make_align_start:
+	/* now try to align s1 with 8 bytes */
+	andi.   r6,r3,0x7
+	rlwinm  r6,r6,3,0,28
+	beq     .Ldiffoffset_align_s1_8bytes
+
+	clrrdi	r3,r3,3
+	LD	rA,0,r3
+	LD	rB,0,r4  /* unaligned load */
+	sld	rA,rA,r6
+	srd	rA,rA,r6
+	srd	rB,rB,r6
+	cmpld	cr0,rA,rB
+	srwi	r6,r6,3
+	bne	cr0,.LcmpAB_lightweight
+
+	subfic  r6,r6,8
+	subfc.	r5,r6,r5
+	addi	r3,r3,8
+	add	r4,r4,r6
+
+	beq	.Lzero
+
+.Ldiffoffset_align_s1_8bytes:
+	/* now s1 is aligned with 8 bytes. */
+	cmpdi   cr5,r5,31
+	ble	cr5,.Lcmp_lt32bytes
+	b	.Llong
+
 EXPORT_SYMBOL(memcmp)
-- 
1.8.3.1
