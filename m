Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40QNCl0mDwzF1r1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2018 21:23:14 +1000 (AEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/misc: merge reloc_offset() and add_reloc_offset()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20180417112310.BD2686C07F@po15720vm.idsi0.si.c-s.fr>
Date: Tue, 17 Apr 2018 13:23:10 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

reloc_offset() is the same as add_reloc_offset(0)

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/misc.S | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/kernel/misc.S b/arch/powerpc/kernel/misc.S
index 384357cb8bc0..e1f3a5d054c4 100644
--- a/arch/powerpc/kernel/misc.S
+++ b/arch/powerpc/kernel/misc.S
@@ -25,23 +25,12 @@
 /*
  * Returns (address we are running at) - (address we were linked at)
  * for use before the text and data are mapped to KERNELBASE.
- */
-
-_GLOBAL(reloc_offset)
-	mflr	r0
-	bl	1f
-1:	mflr	r3
-	PPC_LL	r4,(2f-1b)(r3)
-	subf	r3,r4,r3
-	mtlr	r0
-	blr
 
-	.align	3
-2:	PPC_LONG 1b
-
-/*
  * add_reloc_offset(x) returns x + reloc_offset().
  */
+
+_GLOBAL(reloc_offset)
+	li	r3, 0
 _GLOBAL(add_reloc_offset)
 	mflr	r0
 	bl	1f
-- 
2.13.3
