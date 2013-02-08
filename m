Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp04.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2DFF32C0087
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Feb 2013 12:47:19 +1100 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Fri, 8 Feb 2013 11:38:38 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 823982BB0050
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Feb 2013 12:47:14 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r181Z0oU61276204
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Feb 2013 12:35:00 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r181lDgA022382
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Feb 2013 12:47:14 +1100
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc: Add support for context switching the TAR register
Date: Fri,  8 Feb 2013 12:46:58 +1100
Message-Id: <1360288018-24353-1-git-send-email-imunsie@au1.ibm.com>
In-Reply-To: <E5260325-626C-47FA-AB0D-56AAA16E2FB1@kernel.crashing.org>
References: <E5260325-626C-47FA-AB0D-56AAA16E2FB1@kernel.crashing.org>
Cc: Michael Neuling <mikey@neuling.org>, Matt Evans <matt@ozlabs.org>,
 Ian Munsie <imunsie@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

This patch adds support for enabling and context switching the Target
Address Register in Power8. The TAR is a new special purpose register
that can be used for computed branches with the bctar[l] (branch
conditional to TAR) instruction in the same manner as the count and link
registers.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
Signed-off-by: Matt Evans <matt@ozlabs.org>
---

v2 changelog:
- Encased thread_struct->tar in #ifdef CONFIG_PPC_BOOK3S_64 as per Kumar's
  comments
- Rebased on powerpc/next
- Removed definition of CPU_FTR_BCTAR since this already got defined in
  "powerpc: Repack 64bit CPU features to remove holes"

 arch/powerpc/include/asm/cputable.h   |    2 +-
 arch/powerpc/include/asm/processor.h  |    3 +++
 arch/powerpc/include/asm/reg.h        |    3 +++
 arch/powerpc/kernel/asm-offsets.c     |    4 ++++
 arch/powerpc/kernel/cpu_setup_power.S |    7 +++++++
 arch/powerpc/kernel/entry_64.S        |   20 ++++++++++++++++++++
 6 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 06f7fb9..5f1938f 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -414,7 +414,7 @@ extern const char *powerpc_base_platform;
 	    CPU_FTR_DSCR | CPU_FTR_SAO  | \
 	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_POPCNTB | CPU_FTR_POPCNTD | \
 	    CPU_FTR_ICSWX | CPU_FTR_CFAR | CPU_FTR_HVMODE | CPU_FTR_VMX_COPY | \
-	    CPU_FTR_DBELL | CPU_FTR_HAS_PPR | CPU_FTR_DAWR)
+	    CPU_FTR_DBELL | CPU_FTR_HAS_PPR | CPU_FTR_DAWR | CPU_FTR_BCTAR)
 #define CPU_FTRS_CELL	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 7938658..42ac53c 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -257,6 +257,9 @@ struct thread_struct {
 	int		dscr_inherit;
 	unsigned long	ppr;	/* used to save/restore SMT priority */
 #endif
+#ifdef CONFIG_PPC_BOOK3S_64
+	unsigned long	tar;
+#endif
 };
 
 #define ARCH_MIN_TASKALIGN 16
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 1f59fbb..e09ac51 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -237,6 +237,9 @@
 #define SPRN_HRMOR	0x139	/* Real mode offset register */
 #define SPRN_HSRR0	0x13A	/* Hypervisor Save/Restore 0 */
 #define SPRN_HSRR1	0x13B	/* Hypervisor Save/Restore 1 */
+#define SPRN_FSCR	0x099	/* Facility Status & Control Register */
+#define FSCR_TAR	(1<<8)	/* Enable Target Adress Register */
+#define SPRN_TAR	0x32f	/* Target Address Register */
 #define SPRN_LPCR	0x13E	/* LPAR Control Register */
 #define   LPCR_VPM0	(1ul << (63-0))
 #define   LPCR_VPM1	(1ul << (63-1))
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index e39ca55..beddba4 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -122,6 +122,10 @@ int main(void)
 	DEFINE(THREAD_KVM_VCPU, offsetof(struct thread_struct, kvm_vcpu));
 #endif
 
+#ifdef CONFIG_PPC_BOOK3S_64
+	DEFINE(THREAD_TAR, offsetof(struct thread_struct, tar));
+#endif
+
 	DEFINE(TI_FLAGS, offsetof(struct thread_info, flags));
 	DEFINE(TI_LOCAL_FLAGS, offsetof(struct thread_info, local_flags));
 	DEFINE(TI_PREEMPT, offsetof(struct thread_info, preempt_count));
diff --git a/arch/powerpc/kernel/cpu_setup_power.S b/arch/powerpc/kernel/cpu_setup_power.S
index 57cf140..d29facb 100644
--- a/arch/powerpc/kernel/cpu_setup_power.S
+++ b/arch/powerpc/kernel/cpu_setup_power.S
@@ -56,6 +56,7 @@ _GLOBAL(__setup_cpu_power8)
 	mfspr	r3,SPRN_LPCR
 	oris	r3, r3, LPCR_AIL_3@h
 	bl	__init_LPCR
+	bl	__init_FSCR
 	bl	__init_TLB
 	mtlr	r11
 	blr
@@ -112,6 +113,12 @@ __init_LPCR:
 	isync
 	blr
 
+__init_FSCR:
+	mfspr	r3,SPRN_FSCR
+	ori	r3,r3,FSCR_TAR
+	mtspr	SPRN_FSCR,r3
+	blr
+
 __init_TLB:
 	/* Clear the TLB */
 	li	r6,128
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 44c733f..9ae8451 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -448,6 +448,19 @@ END_FTR_SECTION_IFSET(CPU_FTR_DSCR)
 	std	r23,_CCR(r1)
 	std	r1,KSP(r3)	/* Set old stack pointer */
 
+#ifdef CONFIG_PPC_BOOK3S_64
+BEGIN_FTR_SECTION
+	/*
+	 * Back up the TAR across context switches.  Note that the TAR is not
+	 * available for use in the kernel.  (To provide this, the TAR should
+	 * be backed up/restored on exception entry/exit instead, and be in
+	 * pt_regs.  FIXME, this should be in pt_regs anyway (for debug).)
+	 */
+	mfspr	r0,SPRN_TAR
+	std	r0,THREAD_TAR(r3)
+END_FTR_SECTION_IFSET(CPU_FTR_BCTAR)
+#endif
+
 #ifdef CONFIG_SMP
 	/* We need a sync somewhere here to make sure that if the
 	 * previous task gets rescheduled on another CPU, it sees all
@@ -530,6 +543,13 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_1T_SEGMENT)
 	mr	r1,r8		/* start using new stack pointer */
 	std	r7,PACAKSAVE(r13)
 
+#ifdef CONFIG_PPC_BOOK3S_64
+BEGIN_FTR_SECTION
+	ld	r0,THREAD_TAR(r4)
+	mtspr	SPRN_TAR,r0
+END_FTR_SECTION_IFSET(CPU_FTR_BCTAR)
+#endif
+
 #ifdef CONFIG_ALTIVEC
 BEGIN_FTR_SECTION
 	ld	r0,THREAD_VRSAVE(r4)
-- 
1.7.10.4
