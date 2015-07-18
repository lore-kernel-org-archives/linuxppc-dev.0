Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0130.outbound.protection.outlook.com [157.56.110.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EB9921A1955
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Jul 2015 06:09:36 +1000 (AEST)
From: Scott Wood <scottwood@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
CC: Tiejun Chen <tiejun.chen@intel.com>, <kexec@lists.infradead.org>, "Tiejun
 Chen" <tiejun.chen@windriver.com>, Scott Wood <scottwood@freescale.com>
Subject: [RFC PATCH 13/17] powerpc/book3e-64/kexec: create an identity TLB
 mapping
Date: Sat, 18 Jul 2015 15:08:50 -0500
Message-ID: <1437250134-307-14-git-send-email-scottwood@freescale.com>
In-Reply-To: <1437250134-307-1-git-send-email-scottwood@freescale.com>
References: <1437250134-307-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Tiejun Chen <tiejun.chen@windriver.com>

book3e has no real MMU mode so we have to create an identity TLB
mapping to make sure we can access the real physical address.

Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
[scottwood: cleanup, and split off some changes]
Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/kernel/misc_64.S | 52 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
index 4e314b9..c5915f0 100644
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -26,6 +26,7 @@
 #include <asm/thread_info.h>
 #include <asm/kexec.h>
 #include <asm/ptrace.h>
+#include <asm/mmu.h>
 
 	.text
 
@@ -487,6 +488,51 @@ kexec_flag:
 
 
 #ifdef CONFIG_KEXEC
+#ifdef CONFIG_PPC_BOOK3E
+/*
+ * BOOK3E has no real MMU mode, so we have to setup the initial TLB
+ * for a core to identity map v:0 to p:0.  This current implementation
+ * assumes that 1G is enough for kexec.
+ */
+kexec_create_tlb:
+	/*
+	 * Invalidate all non-IPROT TLB entries to avoid any TLB conflict.
+	 * IPROT TLB entries should be >= PAGE_OFFSET and thus not conflict.
+	 */
+	PPC_TLBILX_ALL(0,R0)
+	sync
+	isync
+
+	mfspr	r10,SPRN_TLB1CFG
+	andi.	r10,r10,TLBnCFG_N_ENTRY	/* Extract # entries */
+	subi	r10,r10,1	/* Last entry: no conflict with kernel text */
+	lis	r9,MAS0_TLBSEL(1)@h
+	rlwimi	r9,r10,16,4,15		/* Setup MAS0 = TLBSEL | ESEL(r9) */
+
+/* Set up a temp identity mapping v:0 to p:0 and return to it. */
+#if defined(CONFIG_SMP) || defined(CONFIG_PPC_E500MC)
+#define M_IF_NEEDED	MAS2_M
+#else
+#define M_IF_NEEDED	0
+#endif
+	mtspr	SPRN_MAS0,r9
+
+	lis	r9,(MAS1_VALID|MAS1_IPROT)@h
+	ori	r9,r9,(MAS1_TSIZE(BOOK3E_PAGESZ_1GB))@l
+	mtspr	SPRN_MAS1,r9
+
+	LOAD_REG_IMMEDIATE(r9, 0x0 | M_IF_NEEDED)
+	mtspr	SPRN_MAS2,r9
+
+	LOAD_REG_IMMEDIATE(r9, 0x0 | MAS3_SR | MAS3_SW | MAS3_SX)
+	mtspr	SPRN_MAS3,r9
+	li	r9,0
+	mtspr	SPRN_MAS7,r9
+
+	tlbwe
+	isync
+	blr
+#endif
 
 /* kexec_smp_wait(void)
  *
@@ -516,6 +562,10 @@ _GLOBAL(kexec_smp_wait)
  * don't overwrite r3 here, it is live for kexec_wait above.
  */
 real_mode:	/* assume normal blr return */
+#ifdef CONFIG_PPC_BOOK3E
+	/* Create an identity mapping. */
+	b	kexec_create_tlb
+#else
 1:	li	r9,MSR_RI
 	li	r10,MSR_DR|MSR_IR
 	mflr	r11		/* return address to SRR0 */
@@ -527,7 +577,7 @@ real_mode:	/* assume normal blr return */
 	mtspr	SPRN_SRR1,r10
 	mtspr	SPRN_SRR0,r11
 	rfid
-
+#endif
 
 /*
  * kexec_sequence(newstack, start, image, control, clear_all())
-- 
2.1.4
