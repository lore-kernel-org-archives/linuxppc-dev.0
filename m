Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Ls986V8JzF1LY
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jul 2018 18:54:04 +1000 (AEST)
Message-Id: <a7b89147bd6ee3ffa34669b97624ff4261ec4a22.1530780629.git.christophe.leroy@c-s.fr>
In-Reply-To: <a272622d3444a1787a0fc4bf61e9192fb0c3cd64.1530780629.git.christophe.leroy@c-s.fr>
References: <a272622d3444a1787a0fc4bf61e9192fb0c3cd64.1530780629.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH 3/3] powerpc/lib: Optimised strlen() for POWER6+
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 wei.guo.simon@gmail.com, segher@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Thu,  5 Jul 2018 08:54:01 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 Untested

 arch/powerpc/lib/strlen_64.S | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/lib/strlen_64.S b/arch/powerpc/lib/strlen_64.S
index c9704f2b697d..3f756902653c 100644
--- a/arch/powerpc/lib/strlen_64.S
+++ b/arch/powerpc/lib/strlen_64.S
@@ -45,8 +45,12 @@
 
 _GLOBAL(strlen)
 	andi.   r0, r3, 7
-	lis	r7, 0x0101
 	addi	r10, r3, -8
+BEGIN_FTR_SECTION
+	lis	r7, 0x0101
+FTR_SECTION_ELSE
+	b	strlen_power6
+ALT_FTR_SECTION_END_IFCLR(CPU_FTR_CFAR) /* power6++ */
 	addic	r7, r7, 0x0101	/* r7 = 0x01010101 (lomagic) & clear XER[CA] */
 	rldimi	r7, r7, 32, 0	/* r7 = 0x0101010101010101 (lomagic) */
 	rotldi	r6, r7, 31 	/* r6 = 0x8080808080808080 (himagic) */
@@ -84,5 +88,32 @@ _GLOBAL(strlen)
 	slwi	r0, r0, 3
 	srw	r8, r8, r0
 	orc	r9, r9, r8
+BEGIN_FTR_SECTION
 	b	2b
-EXPORT_SYMBOL(strlen)
+FTR_SECTION_ELSE
+	b	12f
+ALT_FTR_SECTION_END_IFCLR(CPU_FTR_CFAR) /* power6++ */
+
+strlen_power6:
+	li	r7, 0
+	bne-	3b
+	.balign IFETCH_ALIGN_BYTES
+11:	ldu	r9, 8(r10)
+12:	cmpb	r8, r9, r7
+	cmpld	r8, r7
+	beq+	11b
+#ifdef CONFIG_CPU_BIG_ENDIAN
+	cntlzd	r8, r8
+	subf	r3, r3, r10
+	srdi	r8, r8, 3
+	add	r3, r3, r8
+#else
+	addi	r9, r8, -1
+	addi	r10, r10, 7
+	andc	r8, r9, r8
+	cntlzd	r8, r8
+	subf	r3, r3, r10
+	srdi	r8, r8, 3
+	subf	r3, r8, r3
+#endif
+	blr
-- 
2.13.3
