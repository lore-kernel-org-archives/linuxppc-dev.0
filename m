Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xz2My0QsVzDsN0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 15:38:53 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id i130so86197pgc.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Sep 2017 22:38:53 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "Naveen N.  Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 David Laight <David.Laight@ACULAB.COM>,
 Christophe LEROY <christophe.leroy@c-s.fr>,
 Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH v2 2/3] powerpc/64: enhance memcmp() with VMX instruction for
 long bytes comparision
Date: Thu, 21 Sep 2017 07:34:39 +0800
Message-Id: <1505950480-14830-3-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1505950480-14830-1-git-send-email-wei.guo.simon@gmail.com>
References: <1505950480-14830-1-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Simon Guo <wei.guo.simon@gmail.com>

This patch add VMX primitives to do memcmp() in case the compare size
exceeds 4K bytes.

Test result with following test program(replace the "^>" with ""):
------
># cat tools/testing/selftests/powerpc/stringloops/memcmp.c
>#include <malloc.h>
>#include <stdlib.h>
>#include <string.h>
>#include <time.h>
>#include "utils.h"
>#define SIZE (1024 * 1024 * 900)
>#define ITERATIONS 40

int test_memcmp(const void *s1, const void *s2, size_t n);

static int testcase(void)
{
        char *s1;
        char *s2;
        unsigned long i;

        s1 = memalign(128, SIZE);
        if (!s1) {
                perror("memalign");
                exit(1);
        }

        s2 = memalign(128, SIZE);
        if (!s2) {
                perror("memalign");
                exit(1);
        }

        for (i = 0; i < SIZE; i++)  {
                s1[i] = i & 0xff;
                s2[i] = i & 0xff;
        }
        for (i = 0; i < ITERATIONS; i++) {
		int ret = test_memcmp(s1, s2, SIZE);

		if (ret) {
			printf("return %d at[%ld]! should have returned zero\n", ret, i);
			abort();
		}
	}

        return 0;
}

int main(void)
{
        return test_harness(testcase, "memcmp");
}
------
Without VMX patch:
       7.435191479 seconds time elapsed                                          ( +- 0.51% )
With VMX patch:
       6.802038938 seconds time elapsed                                          ( +- 0.56% )
		There is ~+8% improvement.

However I am not aware whether there is use case in kernel for memcmp on
large size yet.

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 arch/powerpc/include/asm/asm-prototypes.h |  2 +-
 arch/powerpc/lib/copypage_power7.S        |  2 +-
 arch/powerpc/lib/memcmp_64.S              | 82 +++++++++++++++++++++++++++++++
 arch/powerpc/lib/memcpy_power7.S          |  2 +-
 arch/powerpc/lib/vmx-helper.c             |  2 +-
 5 files changed, 86 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/asm-prototypes.h b/arch/powerpc/include/asm/asm-prototypes.h
index 7330150..e6530d8 100644
--- a/arch/powerpc/include/asm/asm-prototypes.h
+++ b/arch/powerpc/include/asm/asm-prototypes.h
@@ -49,7 +49,7 @@ void __trace_hcall_exit(long opcode, unsigned long retval,
 /* VMX copying */
 int enter_vmx_usercopy(void);
 int exit_vmx_usercopy(void);
-int enter_vmx_copy(void);
+int enter_vmx_ops(void);
 void * exit_vmx_copy(void *dest);
 
 /* Traps */
diff --git a/arch/powerpc/lib/copypage_power7.S b/arch/powerpc/lib/copypage_power7.S
index ca5fc8f..9e7729e 100644
--- a/arch/powerpc/lib/copypage_power7.S
+++ b/arch/powerpc/lib/copypage_power7.S
@@ -60,7 +60,7 @@ _GLOBAL(copypage_power7)
 	std	r4,-STACKFRAMESIZE+STK_REG(R30)(r1)
 	std	r0,16(r1)
 	stdu	r1,-STACKFRAMESIZE(r1)
-	bl	enter_vmx_copy
+	bl	enter_vmx_ops
 	cmpwi	r3,0
 	ld	r0,STACKFRAMESIZE+16(r1)
 	ld	r3,STK_REG(R31)(r1)
diff --git a/arch/powerpc/lib/memcmp_64.S b/arch/powerpc/lib/memcmp_64.S
index 6dccfb8..40218fc 100644
--- a/arch/powerpc/lib/memcmp_64.S
+++ b/arch/powerpc/lib/memcmp_64.S
@@ -162,6 +162,13 @@ _GLOBAL(memcmp)
 	blr
 
 .Llong:
+#ifdef CONFIG_ALTIVEC
+	/* Try to use vmx loop if length is larger than 4K */
+	cmpldi  cr6,r5,4096
+	bgt	cr6,.Lvmx_cmp
+
+.Llong_novmx_cmp:
+#endif
 	li	off8,8
 	li	off16,16
 	li	off24,24
@@ -319,4 +326,79 @@ _GLOBAL(memcmp)
 8:
 	blr
 
+#ifdef CONFIG_ALTIVEC
+.Lvmx_cmp:
+	mflr    r0
+	std     r3,-STACKFRAMESIZE+STK_REG(R31)(r1)
+	std     r4,-STACKFRAMESIZE+STK_REG(R30)(r1)
+	std     r5,-STACKFRAMESIZE+STK_REG(R29)(r1)
+	std     r0,16(r1)
+	stdu    r1,-STACKFRAMESIZE(r1)
+	bl      enter_vmx_ops
+	cmpwi   cr1,r3,0
+	ld      r0,STACKFRAMESIZE+16(r1)
+	ld      r3,STK_REG(R31)(r1)
+	ld      r4,STK_REG(R30)(r1)
+	ld      r5,STK_REG(R29)(r1)
+	addi	r1,r1,STACKFRAMESIZE
+	mtlr    r0
+	beq     cr1,.Llong_novmx_cmp
+
+3:
+	/* Enter with src/dst address 8 bytes aligned, and len is
+	 * no less than 4KB. Need to align with 16 bytes further.
+	 */
+	andi.	rA,r3,8
+	beq	4f
+	LD	rA,0,r3
+	LD	rB,0,r4
+	cmpld	cr0,rA,rB
+	bne	cr0,.LcmpAB_lightweight
+
+	addi	r3,r3,8
+	addi	r4,r4,8
+	addi	r5,r5,-8
+
+4:
+	/* compare 32 bytes for each loop */
+	srdi	r0,r5,5
+	mtctr	r0
+	andi.	r5,r5,31
+	li	off16,16
+
+.balign 16
+5:
+	lvx 	v0,0,r3
+	lvx 	v1,0,r4
+	vcmpequd. v0,v0,v1
+	bf	24,7f
+	lvx 	v0,off16,r3
+	lvx 	v1,off16,r4
+	vcmpequd. v0,v0,v1
+	bf	24,6f
+	addi	r3,r3,32
+	addi	r4,r4,32
+	bdnz	5b
+
+	cmpdi	r5,0
+	beq	.Lzero
+	b	.L8bytes_aligned
+
+6:
+	addi	r3,r3,16
+	addi	r4,r4,16
+
+7:
+	LD	rA,0,r3
+	LD	rB,0,r4
+	cmpld	cr0,rA,rB
+	bne	cr0,.LcmpAB_lightweight
+
+	li	off8,8
+	LD	rA,off8,r3
+	LD	rB,off8,r4
+	cmpld	cr0,rA,rB
+	bne	cr0,.LcmpAB_lightweight
+	b	.Lzero
+#endif
 EXPORT_SYMBOL(memcmp)
diff --git a/arch/powerpc/lib/memcpy_power7.S b/arch/powerpc/lib/memcpy_power7.S
index 193909a..682e386 100644
--- a/arch/powerpc/lib/memcpy_power7.S
+++ b/arch/powerpc/lib/memcpy_power7.S
@@ -230,7 +230,7 @@ _GLOBAL(memcpy_power7)
 	std	r5,-STACKFRAMESIZE+STK_REG(R29)(r1)
 	std	r0,16(r1)
 	stdu	r1,-STACKFRAMESIZE(r1)
-	bl	enter_vmx_copy
+	bl	enter_vmx_ops
 	cmpwi	cr1,r3,0
 	ld	r0,STACKFRAMESIZE+16(r1)
 	ld	r3,STK_REG(R31)(r1)
diff --git a/arch/powerpc/lib/vmx-helper.c b/arch/powerpc/lib/vmx-helper.c
index bf925cd..923a9ab 100644
--- a/arch/powerpc/lib/vmx-helper.c
+++ b/arch/powerpc/lib/vmx-helper.c
@@ -53,7 +53,7 @@ int exit_vmx_usercopy(void)
 	return 0;
 }
 
-int enter_vmx_copy(void)
+int enter_vmx_ops(void)
 {
 	if (in_interrupt())
 		return 0;
-- 
1.8.3.1
