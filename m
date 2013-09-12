Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by ozlabs.org (Postfix) with ESMTP id 4E0ED2C035C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Sep 2013 04:26:00 +1000 (EST)
Date: Thu, 12 Sep 2013 20:25:53 +0200
Message-Id: <201309121825.r8CIPrkI005690@localhost.localdomain>
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, scottwood@freescale.com
Subject: [PATCH v2] powerpc 8xx: Fixing issue with CONFIG_PIN_TLB
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a reorganisation of the setup of the TLB at kernel startup, in order
to handle the CONFIG_PIN_TLB case in accordance with chapter 8.10.3 of MPC866
and MPC885 reference manuals.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

diff -ur linux-3.11.org/arch/powerpc/kernel/head_8xx.S linux-3.11/arch/powerpc/kernel/head_8xx.S
--- linux-3.11.org/arch/powerpc/kernel/head_8xx.S	2013-09-02 22:46:10.000000000 +0200
+++ linux-3.11/arch/powerpc/kernel/head_8xx.S	2013-09-09 11:28:54.000000000 +0200
@@ -785,27 +785,24 @@
  * these mappings is mapped by page tables.
  */
 initial_mmu:
-	tlbia			/* Invalidate all TLB entries */
-/* Always pin the first 8 MB ITLB to prevent ITLB
-   misses while mucking around with SRR0/SRR1 in asm
-*/
-	lis	r8, MI_RSV4I@h
-	ori	r8, r8, 0x1c00
-
+	lis	r8, MI_RESETVAL@h
 	mtspr	SPRN_MI_CTR, r8	/* Set instruction MMU control */
 
-#ifdef CONFIG_PIN_TLB
-	lis	r10, (MD_RSV4I | MD_RESETVAL)@h
-	ori	r10, r10, 0x1c00
-	mr	r8, r10
-#else
 	lis	r10, MD_RESETVAL@h
-#endif
 #ifndef CONFIG_8xx_COPYBACK
 	oris	r10, r10, MD_WTDEF@h
 #endif
 	mtspr	SPRN_MD_CTR, r10	/* Set data TLB control */
 
+	tlbia			/* Invalidate all TLB entries */
+
+	ori	r8, r8, 0x1c00
+	mtspr	SPRN_MI_CTR, r8	/* Set instruction MMU control */
+#ifdef CONFIG_PIN_TLB
+	ori	r10, r10, 0x1c00
+	mtspr	SPRN_MD_CTR, r10	/* Set data TLB control */
+#endif
+
 	/* Now map the lower 8 Meg into the TLBs.  For this quick hack,
 	 * we can load the instruction and data TLB registers with the
 	 * same values.
@@ -825,6 +822,12 @@
 	mtspr	SPRN_MI_AP, r8
 	mtspr	SPRN_MD_AP, r8
 
+	/* Always pin the first 8 MB ITLB to prevent ITLB
+	 * misses while mucking around with SRR0/SRR1 in asm
+	 */
+	lis	r8, (MI_RSV4I | MI_RESETVAL)@h
+	mtspr	SPRN_MI_CTR, r8	/* Set instruction MMU control */
+
 	/* Map another 8 MByte at the IMMR to get the processor
 	 * internal registers (among other things).
 	 */
@@ -870,7 +873,15 @@
 	mtspr	SPRN_MD_TWC, r9
 	addis	r11, r11, 0x0080	/* Add 8M */
 	mtspr	SPRN_MD_RPN, r11
+
+	lis	r10, (MD_RSV4I | MD_RESETVAL)@h
+#else
+	lis	r10, MD_RESETVAL@h
 #endif
+#ifndef CONFIG_8xx_COPYBACK
+	oris	r10, r10, MD_WTDEF@h
+#endif
+	mtspr	SPRN_MD_CTR, r10	/* Set data TLB control */
 
 	/* Since the cache is enabled according to the information we
 	 * just loaded into the TLB, invalidate and enable the caches here.
