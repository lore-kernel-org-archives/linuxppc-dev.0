Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x6vmt0mYPzDqk6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 20:09:01 +1000 (AEST)
Message-Id: <129a139ac5d1625b8e2e48b01f5ef2752d36203f.1499633349.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1499633349.git.christophe.leroy@c-s.fr>
References: <cover.1499633349.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 7/7] powerpc/8xx: Reduce DTLB miss handler by one insn
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 12 Jul 2017 12:08:57 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This reduces the DTLB miss handler hot path (user address path)
by one instruction by preserving r10.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_8xx.S | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index b889b5812274..7365148219fd 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -466,23 +466,23 @@ DataStoreTLBMiss:
 	 * kernel page tables.
 	 */
 	mfspr	r10, SPRN_MD_EPN
-	rlwinm	r10, r10, 16, 0xfff8
-	cmpli	cr0, r10, PAGE_OFFSET@h
+	rlwinm	r11, r10, 16, 0xfff8
+	cmpli	cr0, r11, PAGE_OFFSET@h
 	mfspr	r11, SPRN_M_TW	/* Get level 1 table */
 	blt+	3f
+	rlwinm	r11, r10, 16, 0xfff8
 #ifndef CONFIG_PIN_TLB_IMMR
-	cmpli	cr0, r10, VIRT_IMMR_BASE@h
+	cmpli	cr0, r11, VIRT_IMMR_BASE@h
 #endif
 _ENTRY(DTLBMiss_cmp)
-	cmpli	cr7, r10, (PAGE_OFFSET + 0x1800000)@h
-	lis	r11, (swapper_pg_dir-PAGE_OFFSET)@ha
+	cmpli	cr7, r11, (PAGE_OFFSET + 0x1800000)@h
 #ifndef CONFIG_PIN_TLB_IMMR
 _ENTRY(DTLBMiss_jmp)
 	beq-	DTLBMissIMMR
 #endif
 	blt	cr7, DTLBMissLinear
+	lis	r11, (swapper_pg_dir-PAGE_OFFSET)@ha
 3:
-	mfspr	r10, SPRN_MD_EPN
 
 	/* Insert level 1 index */
 	rlwimi	r11, r10, 32 - ((PAGE_SHIFT - 2) << 1), (PAGE_SHIFT - 2) << 1, 29
@@ -703,7 +703,7 @@ DTLBMissLinear:
 	/* Set 8M byte page and mark it valid */
 	li	r11, MD_PS8MEG | MD_SVALID
 	MTSPR_CPU6(SPRN_MD_TWC, r11, r3)
-	rlwinm	r10, r10, 16, 0x0f800000	/* 8xx supports max 256Mb RAM */
+	rlwinm	r10, r10, 0, 0x0f800000	/* 8xx supports max 256Mb RAM */
 	ori	r10, r10, 0xf0 | MD_SPS16K | _PAGE_SHARED | _PAGE_DIRTY	| \
 			  _PAGE_PRESENT
 	MTSPR_CPU6(SPRN_MD_RPN, r10, r11)	/* Update TLB entry */
-- 
2.12.0
