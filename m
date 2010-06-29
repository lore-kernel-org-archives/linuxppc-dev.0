Return-Path: <stevedeiters@basler.com>
Received: from tethra.basler.com (tethra.basler.com [206.107.254.19])
	by ozlabs.org (Postfix) with ESMTP id 2E0F1B6F19
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 30 Jun 2010 02:04:29 +1000 (EST)
Received: from exchserver.basler.com (unknown [192.168.1.5])
	by tethra.basler.com (Postfix) with ESMTP id F19423449
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 29 Jun 2010 11:04:25 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: [PATCH] arch/powerpc/lib/copy_32.S: Use alternate memcpy for MPC512x
	and MPC52xx
Date: Tue, 29 Jun 2010 11:04:22 -0500
Message-ID: <181804936ABC2349BE503168465576460F272CA4@exchserver.basler.com>
From: "Steve Deiters" <SteveDeiters@BASLER.com>
To: <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These processors will corrupt data if accessing the local bus with
unaligned
addresses. This version fixes the typical case of copying from Flash on
the
local bus by keeping the source address always aligned.

Signed-off-by: Steve Deiters <SteveDeiters@basler.com>
---
 arch/powerpc/lib/copy_32.S |   56
++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 56 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/lib/copy_32.S b/arch/powerpc/lib/copy_32.S
index 74a7f41..42e7df5 100644
--- a/arch/powerpc/lib/copy_32.S
+++ b/arch/powerpc/lib/copy_32.S
@@ -226,6 +226,60 @@ _GLOBAL(memmove)
 	bgt	backwards_memcpy
 	/* fall through */
=20
+#if defined(CONFIG_PPC_MPC512x) || defined(CONFIG_PPC_MPC52xx)
+
+/*
+ * Alternate memcpy for MPC512x and MPC52xx to guarantee source
+ * address is always aligned to prevent corruption issues when
+ * copying unaligned from the local bus. This only fixes the usage
+ * when copying from the local bus (e.g. Flash) and will not fix
+ * issues copying to the local bus
+ */
+_GLOBAL(memcpy)
+	srwi.	r7,r5,3
+	addi	r6,r3,-4
+	addi	r4,r4,-4
+	beq	2f			/* if less than 8 bytes to do */
+	andi.	r0,r4,3			/* get src word aligned */
+	mtctr	r7
+	bne	5f
+1:	lwz	r7,4(r4)
+	lwzu	r8,8(r4)
+	stw	r7,4(r6)
+	stwu	r8,8(r6)
+	bdnz	1b
+	andi.	r5,r5,7
+2:	cmplwi	0,r5,4
+	blt	3f
+	andi.	r0,r4,3
+	bne	3f
+	lwzu	r0,4(r4)
+	addi	r5,r5,-4
+	stwu	r0,4(r6)
+3:	cmpwi	0,r5,0
+	beqlr
+	mtctr	r5
+	addi	r4,r4,3
+	addi	r6,r6,3
+4:	lbzu	r0,1(r4)
+	stbu	r0,1(r6)
+	bdnz	4b
+	blr
+5:	subfic	r0,r0,4
+	mtctr	r0
+6:	lbz	r7,4(r4)
+	addi	r4,r4,1
+	stb	r7,4(r6)
+	addi	r6,r6,1
+	bdnz	6b
+	subf	r5,r0,r5
+	rlwinm.	r7,r5,32-3,3,31
+	beq	2b
+	mtctr	r7
+	b	1b
+
+#else
+
 _GLOBAL(memcpy)
 	srwi.	r7,r5,3
 	addi	r6,r3,-4
@@ -267,6 +321,8 @@ _GLOBAL(memcpy)
 	mtctr	r7
 	b	1b
=20
+#endif
+
 _GLOBAL(backwards_memcpy)
 	rlwinm.	r7,r5,32-3,3,31		/* r0 =3D r5 >> 3 */
 	add	r6,r3,r5
--=20
1.5.4.3
