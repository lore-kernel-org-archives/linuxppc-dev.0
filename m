Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xxJPj02LrzDq8f
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Sep 2017 20:04:25 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id i130so1797045pgc.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Sep 2017 03:04:24 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "Naveen N.  Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH v1 1/3] powerpc: Align bytes before fall back to .Lshort in
 powerpc memcmp
Date: Tue, 19 Sep 2017 18:03:57 +0800
Message-Id: <1505815439-18720-2-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1505815439-18720-1-git-send-email-wei.guo.simon@gmail.com>
References: <1505815439-18720-1-git-send-email-wei.guo.simon@gmail.com>
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

Currently memcmp() in powerpc will fall back to .Lshort (compare per byte
mode) if either src or dst address is not 8 bytes aligned. It can be
opmitized if both addresses are with the same offset with 8 bytes boundary.

memcmp() can align the src/dst address with 8 bytes firstly and then
compare with .Llong mode.

This patch optmizes memcmp() behavior in this situation.

Test result:

(1) 256 bytes
Test with the existing tools/testing/selftests/powerpc/stringloops/memcmp:
- without patch
	50.715169506 seconds time elapsed                                          ( +-  0.04% )
- with patch
	28.906602373 seconds time elapsed                                          ( +-  0.02% )
		-> There is ~+75% percent improvement.

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
	0.390677136 seconds time elapsed                                          ( +-  0.03% )
- with patch
	0.375685926 seconds time elapsed                                          ( +-  0.05% )
		-> There is ～+4% improvement

(3) 0~8 bytes
To observe <8 bytes performance impact, modify
tools/testing/selftests/powerpc/stringloops/memcmp.c with following:
-------
 #include <string.h>
 #include "utils.h"

-#define SIZE 256
-#define ITERATIONS 10000
+#define SIZE 8
+#define ITERATIONS 100000

 int test_memcmp(const void *s1, const void *s2, size_t n);
-------
- Without patch
	3.169203981 seconds time elapsed                                          ( +-  0.23% )
- With patch
	3.208257362 seconds time elapsed                                          ( +-  0.13% )
		-> There is ~ -1% decrease.
(I don't know why yet, since there are the same number of instructions
in the code path for 0~8 bytes memcmp() with/without this patch.  Any
comments will be appreciated).

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 arch/powerpc/lib/memcmp_64.S | 86 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 82 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/lib/memcmp_64.S b/arch/powerpc/lib/memcmp_64.S
index d75d18b..6dbafdb 100644
--- a/arch/powerpc/lib/memcmp_64.S
+++ b/arch/powerpc/lib/memcmp_64.S
@@ -24,25 +24,95 @@
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
+	 * with no greater than 8 bytes.
+	 */
+	cmpdi   cr6,r5,8
 
 	beq	cr1,.Lzero
 	bne	.Lshort
+	ble	cr6,.Lshort
+
+.Lalignbytes_start:
+	/* The bits 0/1/2 of src/dst addr are the same. */
+	neg	r0,r3
+	andi.	r0,r0,7
+	beq	.Lalign8bytes
+
+	PPC_MTOCRF(1,r0)
+	bf	31,.Lalign2bytes
+	lbz	rA,0(r3)
+	lbz	rB,0(r4)
+	cmplw	cr0,rA,rB
+	bne	cr0,.LcmpAB_lightweight
+	addi	r3,r3,1
+	addi	r4,r4,1
+	subi	r5,r5,1
+.Lalign2bytes:
+	bf	30,.Lalign4bytes
+	LH	rA,0,r3
+	LH	rB,0,r4
+	cmplw	cr0,rA,rB
+	bne	cr0,.LcmpAB_lightweight
+	bne	.Lnon_zero
+	addi	r3,r3,2
+	addi	r4,r4,2
+	subi	r5,r5,2
+.Lalign4bytes:
+	bf	29,.Lalign8bytes
+	LW	rA,0,r3
+	LW	rB,0,r4
+	cmpld	cr0,rA,rB
+	bne	cr0,.LcmpAB_lightweight
+	addi	r3,r3,4
+	addi	r4,r4,4
+	subi	r5,r5,4
+.Lalign8bytes:
+	/* Now addrs are aligned with 8 bytes. Use the short loop if left
+	 * bytes are less than 8B.
+	 */
+	cmpdi   cr6,r5,7
+	ble	cr6,.Lshort
+
+	/* Use .Llong loop if left cmp bytes are equal or greater than 32B */
+	cmpdi   cr6,r5,31
 	bgt	cr6,.Llong
 
+.Lcmploop_8bytes_31bytes:
+	/* handle 8 ~ 31 bytes with 8 bytes aligned addrs */
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
+
 .Lshort:
 	mtctr	r5
 
@@ -232,4 +302,12 @@ _GLOBAL(memcmp)
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
