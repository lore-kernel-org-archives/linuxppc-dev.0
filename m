Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rCsZW3YNDzDqDK
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 May 2016 18:45:55 +1000 (AEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc32: get rid of sub_reloc_offset()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20160523084549.A7B841A239A@localhost.localdomain>
Date: Mon, 23 May 2016 10:45:49 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

sub_reloc_offset() has not been used since
commit 917f0af9e5a9 ("powerpc: Remove arch/ppc and include/asm-ppc")
which removed include/asm-ppc/prom.h

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/misc_32.S | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index 285ca8c..d9c912b 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -104,20 +104,6 @@ _GLOBAL(mulhdu)
 	blr
 
 /*
- * sub_reloc_offset(x) returns x - reloc_offset().
- */
-_GLOBAL(sub_reloc_offset)
-	mflr	r0
-	bl	1f
-1:	mflr	r5
-	lis	r4,1b@ha
-	addi	r4,r4,1b@l
-	subf	r5,r4,r5
-	subf	r3,r5,r3
-	mtlr	r0
-	blr
-
-/*
  * reloc_got2 runs through the .got2 section adding an offset
  * to each entry.
  */
-- 
2.1.0
