Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qXqrr4j2GzDqJ7
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 19:26:52 +1100 (AEDT)
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 27 Mar 2016 04:26:50 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id EADAC38C8026
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 04:26:48 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2R8Qm1F22675556
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 08:26:48 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2R8QmTM021931
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 04:26:48 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 65/65] powerpc/mm/radix: Cputable update for radix
Date: Sun, 27 Mar 2016 13:54:13 +0530
Message-Id: <1459067053-10835-65-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1459067053-10835-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1459067053-10835-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch move the existing p9 hash to a different PVR and add
radix feature with p9 PVR. That implies we will not be able to
runtime select P9 hash. With P9 Radix we need to do

* set UPRT = 0 in cpu setup
* set different TLB set count

We ideally want to use ibm,pa-features to enable disable radix. But
we have already done setup cpu by the time we reach pa-features check.

So for now use this hack.

Not-Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h |  1 +
 arch/powerpc/include/asm/reg.h                |  4 +++
 arch/powerpc/kernel/cpu_setup_power.S         | 35 +++++++++++++++++++++++++++
 arch/powerpc/kernel/cputable.c                | 29 +++++++++++++++++++---
 arch/powerpc/kernel/mce_power.c               |  4 +++
 5 files changed, 70 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index 7da61b85406b..290157e8d5b2 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -119,6 +119,7 @@
 #define POWER7_TLB_SETS		128	/* # sets in POWER7 TLB */
 #define POWER8_TLB_SETS		512	/* # sets in POWER8 TLB */
 #define POWER9_TLB_SETS_HASH	256	/* # sets in POWER9 TLB Hash mode */
+#define POWER9_TLB_SETS_RADIX	128	/* # sets in POWER9 TLB Radix mode */
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 257251ada3a3..d39b5fedabfd 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -347,6 +347,10 @@
 #define   LPCR_LPES_SH	2
 #define   LPCR_RMI     0x00000002      /* real mode is cache inhibit */
 #define   LPCR_HDICE   0x00000001      /* Hyp Decr enable (HV,PR,EE) */
+/*
+ * Used in asm code, hence we don't want to use PPC_BITCOUNT
+ */
+#define	  LPCR_UPRT	(ASM_CONST(0x1) << (64 - 42))
 #ifndef SPRN_LPID
 #define SPRN_LPID	0x13F	/* Logical Partition Identifier */
 #endif
diff --git a/arch/powerpc/kernel/cpu_setup_power.S b/arch/powerpc/kernel/cpu_setup_power.S
index 584e119fa8b0..e9b76c651bd1 100644
--- a/arch/powerpc/kernel/cpu_setup_power.S
+++ b/arch/powerpc/kernel/cpu_setup_power.S
@@ -117,6 +117,41 @@ _GLOBAL(__restore_cpu_power9)
 	mtlr	r11
 	blr
 
+_GLOBAL(__setup_cpu_power9_uprt)
+	mflr	r11
+	bl	__init_FSCR
+	bl	__init_hvmode_206
+	mtlr	r11
+	beqlr
+	li	r0,0
+	mtspr	SPRN_LPID,r0
+	mfspr	r3,SPRN_LPCR
+	ori	r3, r3, LPCR_PECEDH
+	oris	r3,r3,(LPCR_UPRT >> 16)
+	bl	__init_LPCR
+	bl	__init_HFSCR
+	bl	__init_tlb_power7
+	mtlr	r11
+	blr
+
+_GLOBAL(__restore_cpu_power9_uprt)
+	mflr	r11
+	bl	__init_FSCR
+	mfmsr	r3
+	rldicl.	r0,r3,4,63
+	mtlr	r11
+	beqlr
+	li	r0,0
+	mtspr	SPRN_LPID,r0
+	mfspr   r3,SPRN_LPCR
+	ori	r3, r3, LPCR_PECEDH
+	oris	r3,r3,(LPCR_UPRT >> 16)
+	bl	__init_LPCR
+	bl	__init_HFSCR
+	bl	__init_tlb_power7
+	mtlr	r11
+	blr
+
 __init_hvmode_206:
 	/* Disable CPU_FTR_HVMODE and exit if MSR:HV is not set */
 	mfmsr	r3
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index be4d73053bed..878bcc46ea04 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -72,10 +72,13 @@ extern void __setup_cpu_power8(unsigned long offset, struct cpu_spec* spec);
 extern void __restore_cpu_power8(void);
 extern void __setup_cpu_power9(unsigned long offset, struct cpu_spec* spec);
 extern void __restore_cpu_power9(void);
+extern void __setup_cpu_power9_uprt(unsigned long offset, struct cpu_spec* spec);
+extern void __restore_cpu_power9_uprt(void);
 extern void __restore_cpu_a2(void);
 extern void __flush_tlb_power7(unsigned int action);
 extern void __flush_tlb_power8(unsigned int action);
 extern void __flush_tlb_power9(unsigned int action);
+extern void __flush_tlb_power9_radix(unsigned int action);
 extern long __machine_check_early_realmode_p7(struct pt_regs *regs);
 extern long __machine_check_early_realmode_p8(struct pt_regs *regs);
 #endif /* CONFIG_PPC64 */
@@ -508,9 +511,9 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.platform		= "power8",
 	},
 	{	/* Power9 */
-		.pvr_mask		= 0xffff0000,
-		.pvr_value		= 0x004e0000,
-		.cpu_name		= "POWER9 (raw)",
+		.pvr_mask		= 0xffffff00,
+		.pvr_value		= 0x004e0200,
+		.cpu_name		= "POWER9/hash (raw)",
 		.cpu_features		= CPU_FTRS_POWER9,
 		.cpu_user_features	= COMMON_USER_POWER9,
 		.cpu_user_features2	= COMMON_USER2_POWER9,
@@ -526,6 +529,26 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.flush_tlb		= __flush_tlb_power9,
 		.platform		= "power9",
 	},
+	{	/*  Power9 */
+		.pvr_mask		= 0xffff0000,
+		.pvr_value		= 0x004e0000,
+		.cpu_name		= "POWER9/radix (raw)",
+		.cpu_features		= CPU_FTRS_POWER9,
+		.cpu_user_features	= COMMON_USER_POWER9,
+		.cpu_user_features2	= COMMON_USER2_POWER9,
+		.mmu_features		= MMU_FTRS_POWER9 | MMU_FTR_RADIX,
+		.icache_bsize		= 128,
+		.dcache_bsize		= 128,
+		.num_pmcs		= 6,
+		.pmc_type		= PPC_PMC_IBM,
+		.oprofile_cpu_type	= "ppc64/power8",
+		.oprofile_type		= PPC_OPROFILE_INVALID,
+		.cpu_setup		= __setup_cpu_power9_uprt,
+		.cpu_restore		= __restore_cpu_power9_uprt,
+		.flush_tlb		= __flush_tlb_power9_radix,
+		.machine_check_early	= __machine_check_early_realmode_p8,
+		.platform		= "power9",
+	},
 	{	/* Cell Broadband Engine */
 		.pvr_mask		= 0xffff0000,
 		.pvr_value		= 0x00700000,
diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
index 92a66a2a9b85..f902ede263ab 100644
--- a/arch/powerpc/kernel/mce_power.c
+++ b/arch/powerpc/kernel/mce_power.c
@@ -75,6 +75,10 @@ void __flush_tlb_power9(unsigned int action)
 	flush_tlb_206(POWER9_TLB_SETS_HASH, action);
 }
 
+void __flush_tlb_power9_radix(unsigned int action)
+{
+	flush_tlb_206(POWER9_TLB_SETS_RADIX, action);
+}
 
 /* flush SLBs and reload */
 #ifdef CONFIG_PPC_MMU_STD_64
-- 
2.5.0
