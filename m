Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcr740RMszDqZ1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 00:54:39 +1000 (AEST)
Message-Id: <7c2934cbc0d787eda6f740327449d7e6e3becd9a.1503277387.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1503277387.git.christophe.leroy@c-s.fr>
References: <cover.1503277387.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 3/4] powerpc/32: optimise memset()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 23 Aug 2017 16:54:36 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There is no need to extend the set value to an int when the length
is lower than 4 as in that case we only do byte stores.
We can therefore immediately branch to the part handling it.
By separating it from the normal case, we are able to eliminate
a few actions on the destination pointer.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/lib/copy_32.S | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/lib/copy_32.S b/arch/powerpc/lib/copy_32.S
index a3ffeac69eca..05aaee20590f 100644
--- a/arch/powerpc/lib/copy_32.S
+++ b/arch/powerpc/lib/copy_32.S
@@ -91,17 +91,17 @@ EXPORT_SYMBOL(memset16)
  * replaced by a nop once cache is active. This is done in machine_init()
  */
 _GLOBAL(memset)
+	cmplwi	0,r5,4
+	blt	7f
+
 	rlwimi	r4,r4,8,16,23
 	rlwimi	r4,r4,16,0,15
 
-	addi	r6,r3,-4
-	cmplwi	0,r5,4
-	blt	7f
-	stwu	r4,4(r6)
+	stw	r4,0(r3)
 	beqlr
-	andi.	r0,r6,3
+	andi.	r0,r3,3
 	add	r5,r0,r5
-	subf	r6,r0,r6
+	subf	r6,r0,r3
 	cmplwi	0,r4,0
 	bne	2f	/* Use normal procedure if r4 is not zero */
 _GLOBAL(memset_nocache_branch)
@@ -132,13 +132,20 @@ _GLOBAL(memset_nocache_branch)
 1:	stwu	r4,4(r6)
 	bdnz	1b
 6:	andi.	r5,r5,3
-7:	cmpwi	0,r5,0
 	beqlr
 	mtctr	r5
 	addi	r6,r6,3
 8:	stbu	r4,1(r6)
 	bdnz	8b
 	blr
+
+7:	cmpwi	0,r5,0
+	beqlr
+	mtctr	r5
+	addi	r6,r3,-1
+9:	stbu	r4,1(r6)
+	bdnz	9b
+	blr
 EXPORT_SYMBOL(memset)
 
 /*
-- 
2.13.3
