Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id A79A41A03AA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2015 20:06:49 +1000 (AEST)
Message-Id: <77ae326f3637ae008e33875b7be792d64b24461f.1429696335.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1429696335.git.christophe.leroy@c-s.fr>
References: <cover.1429696335.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 3/3] powerpc/8xx: Implementation of PAGE_EXEC
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Date: Wed, 22 Apr 2015 12:06:45 +0200 (CEST)
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch implements PAGE_EXEC capability on the 8xx.

All pages PP exec bits are set to 000, which means Execute for
Supervisor and no Execute for User.
Then we use the APG to say whether accesses are according to Page
rules, "all Supervisor" rules (Exec for all) and
"all User" rules (Exec for noone)

Therefore, we define 4 APG groups. msb is _PAGE_EXEC,
lsb is _PAGE_USER. MI_AP is initialised as follows:
GP0 (00) => Not User, no exec => 11 (all accesses performed as user)
GP1 (01) => User but no exec => 11 (all accesses performed as user)
GP2 (10) => Not User, exec => 01 (rights according to page definition)
GP3 (11) => User, exec => 00 (all accesses performed as supervisor)

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/cputable.h |  2 +-
 arch/powerpc/include/asm/mmu-8xx.h  | 26 ++++++++++++++++++++++++++
 arch/powerpc/include/asm/pte-8xx.h  |  3 ++-
 arch/powerpc/kernel/head_8xx.S      | 12 +++++++++---
 4 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index daa5af9..c9aa2db 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -360,7 +360,7 @@ extern const char *powerpc_base_platform;
 	    CPU_FTR_USE_TB | CPU_FTR_MAYBE_CAN_NAP | \
 	    CPU_FTR_COMMON | CPU_FTR_FPU_UNAVAILABLE)
 #define CPU_FTRS_CLASSIC32	(CPU_FTR_COMMON | CPU_FTR_USE_TB)
-#define CPU_FTRS_8XX	(CPU_FTR_USE_TB)
+#define CPU_FTRS_8XX	(CPU_FTR_USE_TB | CPU_FTR_NOEXECUTE)
 #define CPU_FTRS_40X	(CPU_FTR_USE_TB | CPU_FTR_NODSISRALIGN | CPU_FTR_NOEXECUTE)
 #define CPU_FTRS_44X	(CPU_FTR_USE_TB | CPU_FTR_NODSISRALIGN | CPU_FTR_NOEXECUTE)
 #define CPU_FTRS_440x6	(CPU_FTR_USE_TB | CPU_FTR_NODSISRALIGN | CPU_FTR_NOEXECUTE | \
diff --git a/arch/powerpc/include/asm/mmu-8xx.h b/arch/powerpc/include/asm/mmu-8xx.h
index d41200c..1407034 100644
--- a/arch/powerpc/include/asm/mmu-8xx.h
+++ b/arch/powerpc/include/asm/mmu-8xx.h
@@ -27,6 +27,19 @@
 #define MI_Ks		0x80000000	/* Should not be set */
 #define MI_Kp		0x40000000	/* Should always be set */
 
+/*
+ * All pages PP exec bits are set to 000, which means Execute for Supervisor
+ * and no Execute for User.
+ * Then we use the APG to say whether accesses are according to Page rules,
+ * "all Supervisor" rules (Exec for all) and "all User" rules (Exec for noone)
+ * Therefore, we define 4 APG groups. msb is _PAGE_EXEC, lsb is _PAGE_USER
+ * 0 (00) => Not User, no exec => 11 (all accesses performed as user)
+ * 1 (01) => User but no exec => 11 (all accesses performed as user)
+ * 2 (10) => Not User, exec => 01 (rights according to page definition)
+ * 3 (11) => User, exec => 00 (all accesses performed as supervisor)
+ */
+#define MI_APG_INIT	0xf4ffffff
+
 /* The effective page number register.  When read, contains the information
  * about the last instruction TLB miss.  When MI_RPN is written, bits in
  * this register are used to create the TLB entry.
@@ -87,6 +100,19 @@
 #define MD_Ks		0x80000000	/* Should not be set */
 #define MD_Kp		0x40000000	/* Should always be set */
 
+/*
+ * All pages PP exec bits are set to either 000 or 011, which means respectively
+ * RW for Supervisor and no access for User, or RO for Supervisor and no access
+ * for user.
+ * Then we use the APG to say whether accesses are according to Page rules or
+ * "all Supervisor" rules (Access to all)
+ * Therefore, we define 2 APG groups. lsb is _PAGE_USER
+ * 0 => No user => 01 (all accesses performed according to page definition)
+ * 1 => User => 00 (all accesses performed as supervisor
+ *                                 according to page definition)
+ */
+#define MD_APG_INIT	0x4fffffff
+
 /* The effective page number register.  When read, contains the information
  * about the last instruction TLB miss.  When MD_RPN is written, bits in
  * this register are used to create the TLB entry.
diff --git a/arch/powerpc/include/asm/pte-8xx.h b/arch/powerpc/include/asm/pte-8xx.h
index 7926d4e..eae9b05 100644
--- a/arch/powerpc/include/asm/pte-8xx.h
+++ b/arch/powerpc/include/asm/pte-8xx.h
@@ -40,8 +40,9 @@
  */
 #define _PAGE_GUARDED	0x0010	/* Copied to L1 G entry in DTLB */
 #define _PAGE_USER	0x0020	/* Copied to L1 APG lsb */
-#define _PAGE_ACCESSED	0x0040	/* software: page referenced */
+#define _PAGE_EXEC	0x0040	/* Copied to L1 APG */
 #define _PAGE_WRITETHRU	0x0080	/* software: caching is write through */
+#define _PAGE_ACCESSED	0x0800	/* software: page referenced */
 
 #define _PAGE_RO	0x0600	/* Supervisor RO, User no access */
 
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 508c645..29a5c1a 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -369,7 +369,7 @@ InstructionTLBMiss:
 	lwz	r10, 0(r10)	/* Get the pte */
 
 	/* Insert the APG into the TWC from the Linux PTE. */
-	rlwimi	r11, r10, 0, 26, 26
+	rlwimi	r11, r10, 0, 25, 26
 	/* Load the MI_TWC with the attributes for this "segment." */
 	MTSPR_CPU6(SPRN_MI_TWC, r11, r3)	/* Set segment attributes */
 
@@ -469,6 +469,7 @@ DataStoreTLBMiss:
 	 */
 	li	r11, RPN_PATTERN
 	rlwimi	r10, r11, 0, 24, 28	/* Set 24-27, clear 28 */
+	rlwimi	r10, r11, 0, 20, 20	/* clear 20 */
 	MTSPR_CPU6(SPRN_MD_RPN, r10, r3)	/* Update TLB entry */
 
 	/* Restore registers */
@@ -789,15 +790,20 @@ initial_mmu:
 	ori	r8, r8, MI_EVALID	/* Mark it valid */
 	mtspr	SPRN_MI_EPN, r8
 	mtspr	SPRN_MD_EPN, r8
-	li	r8, MI_PS8MEG		/* Set 8M byte page */
+	li	r8, MI_PS8MEG | (2 << 5)	/* Set 8M byte page, APG 2 */
 	ori	r8, r8, MI_SVALID	/* Make it valid */
 	mtspr	SPRN_MI_TWC, r8
+	li	r8, MI_PS8MEG		/* Set 8M byte page, APG 0 */
+	ori	r8, r8, MI_SVALID	/* Make it valid */
 	mtspr	SPRN_MD_TWC, r8
 	li	r8, MI_BOOTINIT		/* Create RPN for address 0 */
 	mtspr	SPRN_MI_RPN, r8		/* Store TLB entry */
 	mtspr	SPRN_MD_RPN, r8
-	lis	r8, MI_Kp@h		/* Set the protection mode */
+	lis	r8, MI_APG_INIT@h	/* Set protection modes */
+	ori	r8, r8, MI_APG_INIT@l
 	mtspr	SPRN_MI_AP, r8
+	lis	r8, MD_APG_INIT@h
+	ori	r8, r8, MD_APG_INIT@l
 	mtspr	SPRN_MD_AP, r8
 
 	/* Map another 8 MByte at the IMMR to get the processor
-- 
2.1.0
