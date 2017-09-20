Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xz2Mt4DSjzDrJL
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 15:38:50 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id h4so65827pfk.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Sep 2017 22:38:50 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "Naveen N.  Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 David Laight <David.Laight@ACULAB.COM>,
 Christophe LEROY <christophe.leroy@c-s.fr>,
 Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH v2 1/3] powerpc/64: Align bytes before fall back to .Lshort in
 powerpc64 memcmp().
Date: Thu, 21 Sep 2017 07:34:38 +0800
Message-Id: <1505950480-14830-2-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1505950480-14830-1-git-send-email-wei.guo.simon@gmail.com>
References: <1505950480-14830-1-git-send-email-wei.guo.simon@gmail.com>
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
(compare per byte mode) if either src or dst address is not 8 bytes
aligned. It can be opmitized if both addresses are with the same offset
with 8 bytes boundary.

memcmp() can compare the unaligned bytes within 8 bytes boundary firstly
and then compare the rest 8-bytes-aligned content with .Llong mode.

This patch optmizes memcmp() behavior in this situation.

Test result:

(1) 256 bytes
Test with the existing tools/testing/selftests/powerpc/stringloops/memcmp:
- without patch
      50.996607479 seconds time elapsed                                          ( +- 0.01% )
- with patch
      28.033316997 seconds time elapsed                                          ( +- 0.01% )
		-> There is ~+81% percent improvement

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
       0.392578831 seconds time elapsed                                          ( +- 0.05% )
- with patch
       0.358446662 seconds time elapsed                                          ( +- 0.04% )
		-> There is ～+9% improvement

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
       3.168752060 seconds time elapsed                                          ( +- 0.10% )
- With patch
       3.153030138 seconds time elapsed                                          ( +- 0.09% )
		-> They are nearly the same. (-0.4%)

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 arch/powerpc/lib/memcmp_64.S | 99 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 93 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/lib/memcmp_64.S b/arch/powerpc/lib/memcmp_64.S
index d75d18b..6dccfb8 100644
--- a/arch/powerpc/lib/memcmp_64.S
+++ b/arch/powerpc/lib/memcmp_64.S
@@ -24,28 +24,35 @@
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
+	/* fall back to short loop if compare at aligned addrs
+	 * with less than 8 bytes.
+	 */
+	cmpdi   cr6,r5,7
 
 	beq	cr1,.Lzero
 	bne	.Lshort
-	bgt	cr6,.Llong
+	bgt	cr6,.L8bytes_make_align_start
 
 .Lshort:
 	mtctr	r5
-
 1:	lbz	rA,0(r3)
 	lbz	rB,0(r4)
 	subf.	rC,rB,rA
@@ -78,6 +85,78 @@ _GLOBAL(memcmp)
 	li	r3,0
 	blr
 
+.L8bytes_make_align_start:
+	/* attempt to compare bytes not aligned with 8 bytes so that
+	 * left comparison can run based on 8 bytes alignment.
+	 */
+	andi.   r6,r3,7
+	beq     .L8bytes_aligned
+
+	/* Try to compare the first double word which is not 8 bytes aligned:
+	 * load the first double word at (src & ~7UL) and shift left appropriate
+	 * bits before comparision.
+	 */
+	clrlwi  r6,r3,29
+	rlwinm  r6,r6,3,0,28
+	clrrdi	r3,r3,3
+	clrrdi	r4,r4,3
+	LD	rA,0,r3
+	LD	rB,0,r4
+	sld	rA,rA,r6
+	sld	rB,rB,r6
+	cmpld	cr0,rA,rB
+	bne	cr0,.LcmpAB_lightweight
+	srwi	r6,r6,3
+	subfic  r6,r6,8
+	subfc.	r5,r6,r5
+	beq	.Lzero
+	addi	r3,r3,8
+	addi	r4,r4,8
+
+.L8bytes_aligned:
+	/* now we are aligned with 8 bytes.
+	 * Use .Llong loop if left cmp bytes are equal or greater than 32B.
+	 */
+	cmpdi   cr6,r5,31
+	bgt	cr6,.Llong
+
+	cmpdi   cr6,r5,7
+	bgt	cr6,.Lcmp_8bytes_31bytes
+
+.Lcmp_rest_lt8bytes:
+	/* Here we have only less than 8 bytes to compare with. Addresses
+	 * are aligned with 8 bytes.
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
+	beq	.Lzero
+
+.Lcmp_8bytes_31bytes:
+	/* compare 8 ~ 31 bytes with 8 bytes aligned */
+	srdi.   r0,r5,3
+	clrldi  r5,r5,61
+	mtctr   r0
+831:
+	LD	rA,0,r3
+	LD	rB,0,r4
+	cmpld	cr0,rA,rB
+	bne	cr0,.LcmpAB_lightweight
+	addi	r3,r3,8
+	addi	r4,r4,8
+	bdnz	831b
+
+	cmpwi   r5,0
+	beq	.Lzero
+	b	.Lcmp_rest_lt8bytes
+
 .Lnon_zero:
 	mr	r3,rC
 	blr
@@ -232,4 +311,12 @@ _GLOBAL(memcmp)
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
 EXPORT_SYMBOL(memcmp)
-- 
1.8.3.1
