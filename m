Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x6vmf5glFzDqjY
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 20:08:50 +1000 (AEST)
Message-Id: <11f0359a43d67bab8bc7ce71e10bd592c30aacef.1499633349.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1499633349.git.christophe.leroy@c-s.fr>
References: <cover.1499633349.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 2/7] powerpc/8xx: Remove macro that checks kernel address
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 12 Jul 2017 12:08:47 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The macro to check if an address is a kernel address or not is
not used anymore in DTLBmiss handler. It is used in ITLB miss handler
and in DTLB error handler. DTLB error handler is not a hot path, it
doesn't need such optimisation.

In order to simplify a following patch which will rework ITLB miss
handler, we remove the macros and reintroduce them inside the handler.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_8xx.S | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index c032fe8c2d26..02671e33905c 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -50,16 +50,9 @@
 	mtspr	spr, reg
 #endif
 
-/* Macro to test if an address is a kernel address */
 #if CONFIG_TASK_SIZE <= 0x80000000 && CONFIG_PAGE_OFFSET >= 0x80000000
-#define IS_KERNEL(tmp, addr)		\
-	andis.	tmp, addr, 0x8000	/* Address >= 0x80000000 */
-#define BRANCH_UNLESS_KERNEL(label)	beq	label
-#else
-#define IS_KERNEL(tmp, addr)		\
-	rlwinm	tmp, addr, 16, 16, 31;	\
-	cmpli	cr0, tmp, PAGE_OFFSET >> 16
-#define BRANCH_UNLESS_KERNEL(label)	blt	label
+/* By simply checking Address >= 0x80000000, we know if its a kernel address */
+#define SIMPLE_KERNEL_ADDRESS		1
 #endif
 
 
@@ -347,11 +340,20 @@ InstructionTLBMiss:
 	mfcr	r3
 #endif
 #if defined(CONFIG_MODULES) || defined (CONFIG_DEBUG_PAGEALLOC)
-	IS_KERNEL(r11, r10)
+#ifdef SIMPLE_KERNEL_ADDRESS
+	andis.	r11, r10, 0x8000	/* Address >= 0x80000000 */
+#else
+	rlwinm	r11, r10, 16, 0xfff8
+	cmpli	cr0, r11, PAGE_OFFSET@h
+#endif
 #endif
 	mfspr	r11, SPRN_M_TW	/* Get level 1 table */
 #if defined(CONFIG_MODULES) || defined (CONFIG_DEBUG_PAGEALLOC)
-	BRANCH_UNLESS_KERNEL(3f)
+#ifdef SIMPLE_KERNEL_ADDRESS
+	beq+	3f
+#else
+	blt+	3f
+#endif
 	lis	r11, (swapper_pg_dir-PAGE_OFFSET)@ha
 3:
 #endif
@@ -705,9 +707,10 @@ FixupDAR:/* Entry point for dcbx workaround. */
 	mtspr	SPRN_SPRG_SCRATCH2, r10
 	/* fetch instruction from memory. */
 	mfspr	r10, SPRN_SRR0
-	IS_KERNEL(r11, r10)
+	rlwinm	r11, r10, 16, 0xfff8
+	cmpli	cr0, r11, PAGE_OFFSET@h
 	mfspr	r11, SPRN_M_TW	/* Get level 1 table */
-	BRANCH_UNLESS_KERNEL(3f)
+	blt+	3f
 	rlwinm	r11, r10, 16, 0xfff8
 _ENTRY(FixupDAR_cmp)
 	cmpli	cr7, r11, (PAGE_OFFSET + 0x1800000)@h
-- 
2.12.0
