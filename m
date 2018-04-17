Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40QWsw2b6rzF1Rs
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Apr 2018 03:08:20 +1000 (AEST)
Message-Id: <7fbae252f24ec4d30f52f57a549901fa3f799f8f.1523984745.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 1/2] powerpc: avoid an unnecessary test and branch in
 longjmp()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 17 Apr 2018 19:08:16 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Doing the test at exit of the function avoids an unnecessary
test and branch inside longjmp()

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v2: Swapped both patches in the serie to reduce number of impacted lines

 arch/powerpc/kernel/misc.S | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/misc.S b/arch/powerpc/kernel/misc.S
index e1f3a5d054c4..746ee0320ad4 100644
--- a/arch/powerpc/kernel/misc.S
+++ b/arch/powerpc/kernel/misc.S
@@ -74,10 +74,7 @@ _GLOBAL(setjmp)
 	blr
 
 _GLOBAL(longjmp)
-	PPC_LCMPI r4,0
-	bne	1f
-	li	r4,1
-1:	PPC_LL	r13,4*SZL(r3)
+	PPC_LL	r13,4*SZL(r3)
 	PPC_LL	r14,5*SZL(r3)
 	PPC_LL	r15,6*SZL(r3)
 	PPC_LL	r16,7*SZL(r3)
@@ -102,7 +99,9 @@ _GLOBAL(longjmp)
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
