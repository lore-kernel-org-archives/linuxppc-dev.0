Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pl0-x242.google.com (mail-pl0-x242.google.com
 [IPv6:2607:f8b0:400e:c01::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 411TGK0m78zF324
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2018 11:58:17 +1000 (AEST)
Received: by mail-pl0-x242.google.com with SMTP id a7-v6so2488740plp.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Jun 2018 18:58:17 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "Naveen N.  Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Cyril Bur <cyrilbur@gmail.com>, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH v8 3/5] powerpc/64: enhance memcmp() with VMX instruction for
 long bytes comparision
Date: Thu,  7 Jun 2018 09:57:53 +0800
Message-Id: <1528336675-10879-4-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1528336675-10879-1-git-send-email-wei.guo.simon@gmail.com>
References: <1528336675-10879-1-git-send-email-wei.guo.simon@gmail.com>
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
is equal or greater than 4K bytes. KSM feature can benefit from this.

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
Without this patch (but with the first patch "powerpc/64: Align bytes
before fall back to .Lshort in powerpc64 memcmp()." in the series):
	4.726728762 seconds time elapsed                                          ( +-  3.54%)
With VMX patch:
	4.234335473 seconds time elapsed                                          ( +-  2.63%)
		There is ~+10% improvement.

Testing with unaligned and different offset version (make s1 and s2 shift
random offset within 16 bytes) can archieve higher improvement than 10%..

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 arch/powerpc/include/asm/asm-prototypes.h |   4 +-
 arch/powerpc/lib/copypage_power7.S        |   4 +-
 arch/powerpc/lib/memcmp_64.S              | 241 +++++++++++++++++++++++++++++-
 arch/powerpc/lib/memcpy_power7.S          |   6 +-
 arch/powerpc/lib/vmx-helper.c             |   4 +-
 5 files changed, 248 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/asm-prototypes.h b/arch/powerpc/include/asm/asm-prototypes.h
index d9713ad..31fdcee 100644
--- a/arch/powerpc/include/asm/asm-prototypes.h
+++ b/arch/powerpc/include/asm/asm-prototypes.h
@@ -49,8 +49,8 @@ void __trace_hcall_exit(long opcode, unsigned long retval,
 /* VMX copying */
 int enter_vmx_usercopy(void);
 int exit_vmx_usercopy(void);
-int enter_vmx_copy(void);
-void * exit_vmx_copy(void *dest);
+int enter_vmx_ops(void);
+void *exit_vmx_ops(void *dest);
 
 /* Traps */
 long machine_check_early(struct pt_regs *regs);
diff --git a/arch/powerpc/lib/copypage_power7.S b/arch/powerpc/lib/copypage_power7.S
index 8fa73b7..e38f956 100644
--- a/arch/powerpc/lib/copypage_power7.S
+++ b/arch/powerpc/lib/copypage_power7.S
@@ -57,7 +57,7 @@ _GLOBAL(copypage_power7)
 	std	r4,-STACKFRAMESIZE+STK_REG(R30)(r1)
 	std	r0,16(r1)
 	stdu	r1,-STACKFRAMESIZE(r1)
-	bl	enter_vmx_copy
+	bl	enter_vmx_ops
 	cmpwi	r3,0
 	ld	r0,STACKFRAMESIZE+16(r1)
 	ld	r3,STK_REG(R31)(r1)
@@ -100,7 +100,7 @@ _GLOBAL(copypage_power7)
 	addi	r3,r3,128
 	bdnz	1b
 
-	b	exit_vmx_copy		/* tail call optimise */
+	b	exit_vmx_ops		/* tail call optimise */
 
 #else
 	li	r0,(PAGE_SIZE/128)
diff --git a/arch/powerpc/lib/memcmp_64.S b/arch/powerpc/lib/memcmp_64.S
index 5776f91..be2f792 100644
--- a/arch/powerpc/lib/memcmp_64.S
+++ b/arch/powerpc/lib/memcmp_64.S
@@ -9,6 +9,7 @@
  */
 #include <asm/ppc_asm.h>
 #include <asm/export.h>
+#include <asm/ppc-opcode.h>
 
 #define off8	r6
 #define off16	r7
@@ -27,12 +28,73 @@
 #define LH	lhbrx
 #define LW	lwbrx
 #define LD	ldbrx
+#define LVS	lvsr
+#define VPERM(_VRT,_VRA,_VRB,_VRC) \
+	vperm _VRT,_VRB,_VRA,_VRC
 #else
 #define LH	lhzx
 #define LW	lwzx
 #define LD	ldx
+#define LVS	lvsl
+#define VPERM(_VRT,_VRA,_VRB,_VRC) \
+	vperm _VRT,_VRA,_VRB,_VRC
 #endif
 
+#define VMX_THRESH 4096
+#define ENTER_VMX_OPS	\
+	mflr    r0;	\
+	std     r3,-STACKFRAMESIZE+STK_REG(R31)(r1); \
+	std     r4,-STACKFRAMESIZE+STK_REG(R30)(r1); \
+	std     r5,-STACKFRAMESIZE+STK_REG(R29)(r1); \
+	std     r0,16(r1); \
+	stdu    r1,-STACKFRAMESIZE(r1); \
+	bl      enter_vmx_ops; \
+	cmpwi   cr1,r3,0; \
+	ld      r0,STACKFRAMESIZE+16(r1); \
+	ld      r3,STK_REG(R31)(r1); \
+	ld      r4,STK_REG(R30)(r1); \
+	ld      r5,STK_REG(R29)(r1); \
+	addi	r1,r1,STACKFRAMESIZE; \
+	mtlr    r0
+
+#define EXIT_VMX_OPS \
+	mflr    r0; \
+	std     r3,-STACKFRAMESIZE+STK_REG(R31)(r1); \
+	std     r4,-STACKFRAMESIZE+STK_REG(R30)(r1); \
+	std     r5,-STACKFRAMESIZE+STK_REG(R29)(r1); \
+	std     r0,16(r1); \
+	stdu    r1,-STACKFRAMESIZE(r1); \
+	bl      exit_vmx_ops; \
+	ld      r0,STACKFRAMESIZE+16(r1); \
+	ld      r3,STK_REG(R31)(r1); \
+	ld      r4,STK_REG(R30)(r1); \
+	ld      r5,STK_REG(R29)(r1); \
+	addi	r1,r1,STACKFRAMESIZE; \
+	mtlr    r0
+
+/*
+ * LD_VSR_CROSS16B load the 2nd 16 bytes for _vaddr which is unaligned with
+ * 16 bytes boundary and permute the result with the 1st 16 bytes.
+
+ *    |  y y y y y y y y y y y y y 0 1 2 | 3 4 5 6 7 8 9 a b c d e f z z z |
+ *    ^                                  ^                                 ^
+ * 0xbbbb10                          0xbbbb20                          0xbbb30
+ *                                 ^
+ *                                _vaddr
+ *
+ *
+ * _vmask is the mask generated by LVS
+ * _v1st_qw is the 1st aligned QW of current addr which is already loaded.
+ *   for example: 0xyyyyyyyyyyyyy012 for big endian
+ * _v2nd_qw is the 2nd aligned QW of cur _vaddr to be loaded.
+ *   for example: 0x3456789abcdefzzz for big endian
+ * The permute result is saved in _v_res.
+ *   for example: 0x0123456789abcdef for big endian.
+ */
+#define LD_VSR_CROSS16B(_vaddr,_vmask,_v1st_qw,_v2nd_qw,_v_res) \
+        lvx     _v2nd_qw,_vaddr,off16; \
+        VPERM(_v_res,_v1st_qw,_v2nd_qw,_vmask)
+
 /*
  * There are 2 categories for memcmp:
  * 1) src/dst has the same offset to the 8 bytes boundary. The handlers
@@ -40,7 +102,7 @@
  * 2) src/dst has different offset to the 8 bytes boundary. The handlers
  * are named like .Ldiffoffset_xxxx
  */
-_GLOBAL(memcmp)
+_GLOBAL_TOC(memcmp)
 	cmpdi	cr1,r5,0
 
 	/* Use the short loop if the src/dst addresses are not
@@ -132,7 +194,7 @@ _GLOBAL(memcmp)
 	bgt	cr6,.Llong
 
 .Lcmp_lt32bytes:
-	/* compare 1 ~ 32 bytes, at least r3 addr is 8 bytes aligned now */
+	/* compare 1 ~ 31 bytes, at least r3 addr is 8 bytes aligned now */
 	cmpdi   cr5,r5,7
 	srdi    r0,r5,3
 	ble	cr5,.Lcmp_rest_lt8bytes
@@ -173,6 +235,15 @@ _GLOBAL(memcmp)
 	blr
 
 .Llong:
+#ifdef CONFIG_ALTIVEC
+BEGIN_FTR_SECTION
+	/* Try to use vmx loop if length is equal or greater than 4K */
+	cmpldi  cr6,r5,VMX_THRESH
+	bge	cr6,.Lsameoffset_vmx_cmp
+END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
+
+.Llong_novmx_cmp:
+#endif
 	/* At least s1 addr is aligned with 8 bytes */
 	li	off8,8
 	li	off16,16
@@ -330,7 +401,97 @@ _GLOBAL(memcmp)
 	li	r3,-1
 	blr
 
+#ifdef CONFIG_ALTIVEC
+.Lsameoffset_vmx_cmp:
+	/* Enter with src/dst addrs has the same offset with 8 bytes
+	 * align boundary
+	 */
+	ENTER_VMX_OPS
+	beq     cr1,.Llong_novmx_cmp
+
+3:
+	/* need to check whether r4 has the same offset with r3
+	 * for 16 bytes boundary.
+	 */
+	xor	r0,r3,r4
+	andi.	r0,r0,0xf
+	bne	.Ldiffoffset_vmx_cmp_start
+
+	/* len is no less than 4KB. Need to align with 16 bytes further.
+	 */
+	andi.	rA,r3,8
+	LD	rA,0,r3
+	beq	4f
+	LD	rB,0,r4
+	cmpld	cr0,rA,rB
+	addi	r3,r3,8
+	addi	r4,r4,8
+	addi	r5,r5,-8
+
+	beq	cr0,4f
+	/* save and restore cr0 */
+	mfocrf  r5,128
+	EXIT_VMX_OPS
+	mtocrf  128,r5
+	b	.LcmpAB_lightweight
+
+4:
+	/* compare 32 bytes for each loop */
+	srdi	r0,r5,5
+	mtctr	r0
+	clrldi  r5,r5,59
+	li	off16,16
+
+.balign 16
+5:
+	lvx 	v0,0,r3
+	lvx 	v1,0,r4
+	VCMPEQUD_RC(v0,v0,v1)
+	bnl	cr6,7f
+	lvx 	v0,off16,r3
+	lvx 	v1,off16,r4
+	VCMPEQUD_RC(v0,v0,v1)
+	bnl	cr6,6f
+	addi	r3,r3,32
+	addi	r4,r4,32
+	bdnz	5b
+
+	EXIT_VMX_OPS
+	cmpdi	r5,0
+	beq	.Lzero
+	b	.Lcmp_lt32bytes
+
+6:
+	addi	r3,r3,16
+	addi	r4,r4,16
+
+7:
+	/* diff the last 16 bytes */
+	EXIT_VMX_OPS
+	LD	rA,0,r3
+	LD	rB,0,r4
+	cmpld	cr0,rA,rB
+	li	off8,8
+	bne	cr0,.LcmpAB_lightweight
+
+	LD	rA,off8,r3
+	LD	rB,off8,r4
+	cmpld	cr0,rA,rB
+	bne	cr0,.LcmpAB_lightweight
+	b	.Lzero
+#endif
+
 .Ldiffoffset_8bytes_make_align_start:
+#ifdef CONFIG_ALTIVEC
+BEGIN_FTR_SECTION
+	/* only do vmx ops when the size equal or greater than 4K bytes */
+	cmpdi	cr5,r5,VMX_THRESH
+	bge	cr5,.Ldiffoffset_vmx_cmp
+END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
+
+.Ldiffoffset_novmx_cmp:
+#endif
+
 	/* now try to align s1 with 8 bytes */
 	rlwinm  r6,r3,3,26,28
 	beq     .Ldiffoffset_align_s1_8bytes
@@ -356,6 +517,82 @@ _GLOBAL(memcmp)
 	/* now s1 is aligned with 8 bytes. */
 	cmpdi   cr5,r5,31
 	ble	cr5,.Lcmp_lt32bytes
+
+#ifdef CONFIG_ALTIVEC
+	b	.Llong_novmx_cmp
+#else
 	b	.Llong
+#endif
+
+#ifdef CONFIG_ALTIVEC
+.Ldiffoffset_vmx_cmp:
+	ENTER_VMX_OPS
+	beq     cr1,.Ldiffoffset_novmx_cmp
+
+.Ldiffoffset_vmx_cmp_start:
+	/* Firstly try to align r3 with 16 bytes */
+	andi.   r6,r3,0xf
+	li	off16,16
+	beq     .Ldiffoffset_vmx_s1_16bytes_align
 
+	LVS	v3,0,r3
+	LVS	v4,0,r4
+
+	lvx     v5,0,r3
+	lvx     v6,0,r4
+	LD_VSR_CROSS16B(r3,v3,v5,v7,v9)
+	LD_VSR_CROSS16B(r4,v4,v6,v8,v10)
+
+	VCMPEQUB_RC(v7,v9,v10)
+	bnl	cr6,.Ldiffoffset_vmx_diff_found
+
+	subfic  r6,r6,16
+	subf    r5,r6,r5
+	add     r3,r3,r6
+	add     r4,r4,r6
+
+.Ldiffoffset_vmx_s1_16bytes_align:
+	/* now s1 is aligned with 16 bytes */
+	lvx     v6,0,r4
+	LVS	v4,0,r4
+	srdi	r6,r5,5  /* loop for 32 bytes each */
+	clrldi  r5,r5,59
+	mtctr	r6
+
+.balign	16
+.Ldiffoffset_vmx_32bytesloop:
+	/* the first qw of r4 was saved in v6 */
+	lvx	v9,0,r3
+	LD_VSR_CROSS16B(r4,v4,v6,v8,v10)
+	VCMPEQUB_RC(v7,v9,v10)
+	vor	v6,v8,v8
+	bnl	cr6,.Ldiffoffset_vmx_diff_found
+
+	addi	r3,r3,16
+	addi	r4,r4,16
+
+	lvx	v9,0,r3
+	LD_VSR_CROSS16B(r4,v4,v6,v8,v10)
+	VCMPEQUB_RC(v7,v9,v10)
+	vor	v6,v8,v8
+	bnl	cr6,.Ldiffoffset_vmx_diff_found
+
+	addi	r3,r3,16
+	addi	r4,r4,16
+
+	bdnz	.Ldiffoffset_vmx_32bytesloop
+
+	EXIT_VMX_OPS
+
+	cmpdi	r5,0
+	beq	.Lzero
+	b	.Lcmp_lt32bytes
+
+.Ldiffoffset_vmx_diff_found:
+	EXIT_VMX_OPS
+	/* anyway, the diff will appear in next 16 bytes */
+	li	r5,16
+	b	.Lcmp_lt32bytes
+
+#endif
 EXPORT_SYMBOL(memcmp)
diff --git a/arch/powerpc/lib/memcpy_power7.S b/arch/powerpc/lib/memcpy_power7.S
index df7de9d..070cdf6 100644
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
@@ -445,7 +445,7 @@ _GLOBAL(memcpy_power7)
 
 15:	addi	r1,r1,STACKFRAMESIZE
 	ld	r3,-STACKFRAMESIZE+STK_REG(R31)(r1)
-	b	exit_vmx_copy		/* tail call optimise */
+	b	exit_vmx_ops		/* tail call optimise */
 
 .Lvmx_unaligned_copy:
 	/* Get the destination 16B aligned */
@@ -649,5 +649,5 @@ _GLOBAL(memcpy_power7)
 
 15:	addi	r1,r1,STACKFRAMESIZE
 	ld	r3,-STACKFRAMESIZE+STK_REG(R31)(r1)
-	b	exit_vmx_copy		/* tail call optimise */
+	b	exit_vmx_ops		/* tail call optimise */
 #endif /* CONFIG_ALTIVEC */
diff --git a/arch/powerpc/lib/vmx-helper.c b/arch/powerpc/lib/vmx-helper.c
index bf925cd..9f34049 100644
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
@@ -70,7 +70,7 @@ int enter_vmx_copy(void)
  * passed a pointer to the destination which we return as required by a
  * memcpy implementation.
  */
-void *exit_vmx_copy(void *dest)
+void *exit_vmx_ops(void *dest)
 {
 	disable_kernel_altivec();
 	preempt_enable();
-- 
1.8.3.1
