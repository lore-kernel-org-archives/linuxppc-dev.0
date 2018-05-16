Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40m75x645bzF1QT
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 May 2018 18:34:45 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id c10-v6so1441059pfi.12
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 May 2018 01:34:45 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "Naveen N.  Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Cyril Bur <cyrilbur@gmail.com>, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH v4 3/4] powerpc/64: add 32 bytes prechecking before using VMX
 optimization on memcmp()
Date: Wed, 16 May 2018 16:34:20 +0800
Message-Id: <1526459661-17323-4-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1526459661-17323-1-git-send-email-wei.guo.simon@gmail.com>
References: <1526459661-17323-1-git-send-email-wei.guo.simon@gmail.com>
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

This patch adds a 32 bytes pre-checking firstly before jumping into VMX
operations, to avoid the unnecessary VMX penalty. And the testing shows
~20% improvement on memcmp() average execution time with this patch.

The detail data and analysis is at:
https://github.com/justdoitqd/publicFiles/blob/master/memcmp/README.md

Any suggestion is welcome.

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 arch/powerpc/lib/memcmp_64.S | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/powerpc/lib/memcmp_64.S b/arch/powerpc/lib/memcmp_64.S
index 6303bbf..df2eec0 100644
--- a/arch/powerpc/lib/memcmp_64.S
+++ b/arch/powerpc/lib/memcmp_64.S
@@ -405,6 +405,35 @@ _GLOBAL(memcmp)
 	/* Enter with src/dst addrs has the same offset with 8 bytes
 	 * align boundary
 	 */
+
+#ifdef CONFIG_KSM
+	/* KSM will always compare at page boundary so it falls into
+	 * .Lsameoffset_vmx_cmp.
+	 *
+	 * There is an optimization for KSM based on following fact:
+	 * KSM pages memcmp() prones to fail early at the first bytes. In
+	 * a statisis data, it shows 76% KSM memcmp() fails at the first
+	 * 16 bytes, and 83% KSM memcmp() fails at the first 32 bytes, 84%
+	 * KSM memcmp() fails at the first 64 bytes.
+	 *
+	 * Before applying VMX instructions which will lead to 32x128bits VMX
+	 * regs load/restore penalty, let us compares the first 32 bytes
+	 * so that we can catch the ~80% fail cases.
+	 */
+
+	li	r0,4
+	mtctr	r0
+.Lksm_32B_loop:
+	LD	rA,0,r3
+	LD	rB,0,r4
+	cmpld	cr0,rA,rB
+	addi	r3,r3,8
+	addi	r4,r4,8
+	bne     cr0,.LcmpAB_lightweight
+	addi	r5,r5,-8
+	bdnz	.Lksm_32B_loop
+#endif
+
 	ENTER_VMX_OPS
 	beq     cr1,.Llong_novmx_cmp
 
-- 
1.8.3.1
