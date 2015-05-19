Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 7084A1A05FF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2015 20:08:05 +1000 (AEST)
Message-Id: <ec1f6b96d7aa552974fcad3dafa9a7edd1deed82.1432012060.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1432012060.git.christophe.leroy@c-s.fr>
References: <cover.1432012060.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 6/6] powerpc32: Few optimisations in memcpy
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Date: Tue, 19 May 2015 12:07:57 +0200 (CEST)
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds a few optimisations in memcpy functions by using
lbzu/stbu instead of lxb/stb and by re-ordering insn inside a loop
to reduce latency due to loading

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/lib/copy_32.S | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/lib/copy_32.S b/arch/powerpc/lib/copy_32.S
index 1d49c74..2ef50c6 100644
--- a/arch/powerpc/lib/copy_32.S
+++ b/arch/powerpc/lib/copy_32.S
@@ -155,9 +155,9 @@ _GLOBAL(memcpy)
 	mtctr	r8
 	beq+	61f
 70:	lbz	r9,4(r4)		/* do some bytes */
-	stb	r9,4(r6)
 	addi	r4,r4,1
 	addi	r6,r6,1
+	stb	r9,3(r6)
 	bdnz	70b
 61:	srwi.	r0,r0,2
 	mtctr	r0
@@ -199,10 +199,10 @@ _GLOBAL(memcpy)
 64:	andi.	r0,r5,3
 	mtctr	r0
 	beq+	65f
-40:	lbz	r0,4(r4)
-	stb	r0,4(r6)
-	addi	r4,r4,1
-	addi	r6,r6,1
+	addi	r4,r4,3
+	addi	r6,r6,3
+40:	lbzu	r0,1(r4)
+	stbu	r0,1(r6)
 	bdnz	40b
 65:	blr
 
-- 
2.1.0
