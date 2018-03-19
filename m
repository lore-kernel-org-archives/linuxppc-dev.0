Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 404ZwY348mzF1Sw
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Mar 2018 23:23:24 +1100 (AEDT)
Message-Id: <894fb1323062072749a9d9af461b59ddac26db11.1521461897.git.christophe.leroy@c-s.fr>
In-Reply-To: <8c39109dbf91dd464fee381da3d8ad3354273ed2.1521461897.git.christophe.leroy@c-s.fr>
References: <8c39109dbf91dd464fee381da3d8ad3354273ed2.1521461897.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH  2/2] powerpc: avoid an unnecessary test and branch in
 longjmp()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Mon, 19 Mar 2018 13:23:17 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Doing the test at exit of the function avoids an unnecessary
test and branch in longjmp()

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/misc.S | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/misc.S b/arch/powerpc/kernel/misc.S
index 739977a6be80..9b9207f60d28 100644
--- a/arch/powerpc/kernel/misc.S
+++ b/arch/powerpc/kernel/misc.S
@@ -90,14 +90,11 @@ _GLOBAL(setjmp)
 	blr
 
 _GLOBAL(longjmp)
-	PPC_LCMPI r4,0
-	bne	1f
-	li	r4,1
 #if defined(CONFIG_PPC32) && defined(CONFIG_CPU_BIG_ENDIAN)
-1:	lmw	r12, 3*SZL(r3)
+	lmw	r12, 3*SZL(r3)
 	mtcrf	0x38, r12
 #else
-1:	PPC_LL	r13,4*SZL(r3)
+	PPC_LL	r13,4*SZL(r3)
 	PPC_LL	r14,5*SZL(r3)
 	PPC_LL	r15,6*SZL(r3)
 	PPC_LL	r16,7*SZL(r3)
@@ -123,7 +120,9 @@ _GLOBAL(longjmp)
 	PPC_LL	r1,SZL(r3)
 	PPC_LL	r2,2*SZL(r3)
 	mtlr	r0
-	mr	r3,r4
+	mr.	r3, r4
+	bnelr
+	li	r3, 1
 	blr
 
 _GLOBAL(current_stack_pointer)
-- 
2.13.3
