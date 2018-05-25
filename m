Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40sXlz2QlXzF1fr
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 14:07:59 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id p14-v6so1912699pfh.9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 21:07:59 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "Naveen N.  Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Cyril Bur <cyrilbur@gmail.com>, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH v6 3/4] powerpc/64: add 32 bytes prechecking before using VMX
 optimization on memcmp()
Date: Fri, 25 May 2018 12:07:35 +0800
Message-Id: <1527221256-17029-4-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1527221256-17029-1-git-send-email-wei.guo.simon@gmail.com>
References: <1527221256-17029-1-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Simon Guo <wei.guo.simon@gmail.com>

This patch is based on the previous VMX patch on memcmp().

To optimize ppc64 memcmp() with VMX instruction, we need to think about
the VMX penalty brought with: If kernel uses VMX instruction, it needs
to save/restore current thread's VMX registers. There are 32 x 128 bits
VMX registers in PPC, which means 32 x 16 = 512 bytes for load and store.

The major concern regarding the memcmp() performance in kernel is KSM,
who will use memcmp() frequently to merge identical pages. So it will
make sense to take some measures/enhancement on KSM to see whether any
improvement can be done here.  Cyril Bur indicates that the memcmp() for
KSM has a higher possibility to fail (unmatch) early in previous bytes
in following mail.
	https://patchwork.ozlabs.org/patch/817322/#1773629
And I am taking a follow-up on this with this patch.

Per some testing, it shows KSM memcmp() will fail early at previous 32
bytes.  More specifically:
    - 76% cases will fail/unmatch before 16 bytes;
    - 83% cases will fail/unmatch before 32 bytes;
    - 84% cases will fail/unmatch before 64 bytes;
So 32 bytes looks a better choice than other bytes for pre-checking.

The early failure is also true for memcmp() for non-KSM case. With a
non-typical call load, it shows ~73% cases fail before first 32 bytes.

This patch adds a 32 bytes pre-checking firstly before jumping into VMX
operations, to avoid the unnecessary VMX penalty. It is not limited to
KSM case. And the testing shows ~20% improvement on memcmp() average
execution time with this patch.

And note the 32B pre-checking is only performed when the compare size
is long enough (>=4K currently) to allow VMX operation.

The detail data and analysis is at:
https://github.com/justdoitqd/publicFiles/blob/master/memcmp/README.md

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 arch/powerpc/lib/memcmp_64.S | 50 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 42 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/lib/memcmp_64.S b/arch/powerpc/lib/memcmp_64.S
index 4ba7bb6..96eb08b 100644
--- a/arch/powerpc/lib/memcmp_64.S
+++ b/arch/powerpc/lib/memcmp_64.S
@@ -403,8 +403,27 @@ _GLOBAL(memcmp)
 #ifdef CONFIG_ALTIVEC
 .Lsameoffset_vmx_cmp:
 	/* Enter with src/dst addrs has the same offset with 8 bytes
-	 * align boundary
+	 * align boundary.
+	 *
+	 * There is an optimization based on following fact: memcmp()
+	 * prones to fail early at the first 32 bytes.
+	 * Before applying VMX instructions which will lead to 32x128bits
+	 * VMX regs load/restore penalty, we compare the first 32 bytes
+	 * so that we can catch the ~80% fail cases.
 	 */
+
+	li	r0,4
+	mtctr	r0
+.Lsameoffset_prechk_32B_loop:
+	LD	rA,0,r3
+	LD	rB,0,r4
+	cmpld	cr0,rA,rB
+	addi	r3,r3,8
+	addi	r4,r4,8
+	bne     cr0,.LcmpAB_lightweight
+	addi	r5,r5,-8
+	bdnz	.Lsameoffset_prechk_32B_loop
+
 	ENTER_VMX_OPS
 	beq     cr1,.Llong_novmx_cmp
 
@@ -481,13 +500,6 @@ _GLOBAL(memcmp)
 #endif
 
 .Ldiffoffset_8bytes_make_align_start:
-#ifdef CONFIG_ALTIVEC
-	/* only do vmx ops when the size equal or greater than 4K bytes */
-	cmpdi	cr5,r5,VMX_THRESH
-	bge	cr5,.Ldiffoffset_vmx_cmp
-.Ldiffoffset_novmx_cmp:
-#endif
-
 	/* now try to align s1 with 8 bytes */
 	andi.   r6,r3,0x7
 	rlwinm  r6,r6,3,0,28
@@ -512,6 +524,13 @@ _GLOBAL(memcmp)
 
 .Ldiffoffset_align_s1_8bytes:
 	/* now s1 is aligned with 8 bytes. */
+#ifdef CONFIG_ALTIVEC
+	/* only do vmx ops when the size is equal or greater than 4K bytes */
+	cmpdi	cr5,r5,VMX_THRESH
+	bge	cr5,.Ldiffoffset_vmx_cmp
+.Ldiffoffset_novmx_cmp:
+#endif
+
 	cmpdi   cr5,r5,31
 	ble	cr5,.Lcmp_lt32bytes
 
@@ -523,6 +542,21 @@ _GLOBAL(memcmp)
 
 #ifdef CONFIG_ALTIVEC
 .Ldiffoffset_vmx_cmp:
+	/* perform a 32 bytes pre-checking before
+	 * enable VMX operations.
+	 */
+	li	r0,4
+	mtctr	r0
+.Ldiffoffset_prechk_32B_loop:
+	LD	rA,0,r3
+	LD	rB,0,r4
+	cmpld	cr0,rA,rB
+	addi	r3,r3,8
+	addi	r4,r4,8
+	bne     cr0,.LcmpAB_lightweight
+	addi	r5,r5,-8
+	bdnz	.Ldiffoffset_prechk_32B_loop
+
 	ENTER_VMX_OPS
 	beq     cr1,.Ldiffoffset_novmx_cmp
 
-- 
1.8.3.1
