Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 64FFB1A0338
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Feb 2016 21:23:54 +1100 (AEDT)
Message-Id: <525b6412d4d9006f60f8e48137eadad11076f8ae.1454932181.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1454932181.git.christophe.leroy@c-s.fr>
References: <cover.1454932181.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v7 23/23] powerpc32: Remove one insn in mulhdu
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue,  9 Feb 2016 11:23:51 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove one instruction in mulhdu

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
v2: new
v3: no change
v4: no change
v5: no change
v6: no change
v7: no change

 arch/powerpc/kernel/misc_32.S | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index 3ec5a22..bf5160f 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -91,17 +91,16 @@ _GLOBAL(mulhdu)
 	addc	r7,r0,r7
 	addze	r4,r4
 1:	beqlr	cr1		/* all done if high part of A is 0 */
-	mr	r10,r3
 	mullw	r9,r3,r5
-	mulhwu	r3,r3,r5
+	mulhwu	r10,r3,r5
 	beq	2f
-	mullw	r0,r10,r6
-	mulhwu	r8,r10,r6
+	mullw	r0,r3,r6
+	mulhwu	r8,r3,r6
 	addc	r7,r0,r7
 	adde	r4,r4,r8
-	addze	r3,r3
+	addze	r10,r10
 2:	addc	r4,r4,r9
-	addze	r3,r3
+	addze	r3,r10
 	blr
 
 /*
-- 
2.1.0
