Return-Path: <xenidis@gmail.com>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D57AF1007D8
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 30 Sep 2011 06:55:21 +1000 (EST)
Received: by vws20 with SMTP id 20so954882vws.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 29 Sep 2011 13:55:18 -0700 (PDT)
Sender: "xenidis@gmail.com" <xenidis@gmail.com>
From: Jimi Xenidis <jimix@pobox.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/3 v3] powerpc: book3e: Add ICSWX/ACOP support to Book3e
	cores like A2
Date: Thu, 29 Sep 2011 15:55:13 -0500
Message-Id: <1317329714-22387-2-git-send-email-jimix@pobox.com>
In-Reply-To: <1317279773.29415.181.camel@pasglop>
References: <1317279773.29415.181.camel@pasglop>
Cc: Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

ICSWX is also used by the A2 processor to access coprocessors,
although not all "chips" that contain A2s have coprocessors.

Signed-off-by: Jimi Xenidis <jimix@pobox.com>

---
Re: galak@kernel.crashing.org
    Fix white space *embarrassed*
Re: benh@kernel.crashing.org
    rebase
---
 arch/powerpc/include/asm/cputable.h    |    2 +-
 arch/powerpc/include/asm/mmu-book3e.h  |    4 ++++
 arch/powerpc/include/asm/reg_booke.h   |    4 ++++
 arch/powerpc/kernel/cpu_setup_a2.S     |   10 ++++++++--
 arch/powerpc/platforms/Kconfig.cputype |    2 +-
 arch/powerpc/platforms/wsp/Kconfig     |    1 +
 6 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index e30442c..7044233 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -437,7 +437,7 @@ extern const char *powerpc_base_platform;
 #define CPU_FTRS_COMPATIBLE	(CPU_FTR_USE_TB | CPU_FTR_PPCAS_ARCH_V2)
 
 #define CPU_FTRS_A2 (CPU_FTR_USE_TB | CPU_FTR_SMT | CPU_FTR_DBELL | \
-		     CPU_FTR_NOEXECUTE | CPU_FTR_NODSISRALIGN)
+		     CPU_FTR_NOEXECUTE | CPU_FTR_NODSISRALIGN | CPU_FTR_ICSWX)
 
 #ifdef __powerpc64__
 #ifdef CONFIG_PPC_BOOK3E
diff --git a/arch/powerpc/include/asm/mmu-book3e.h b/arch/powerpc/include/asm/mmu-book3e.h
index 0260ea5..50210b9 100644
--- a/arch/powerpc/include/asm/mmu-book3e.h
+++ b/arch/powerpc/include/asm/mmu-book3e.h
@@ -214,6 +214,10 @@ typedef struct {
 	unsigned int	id;
 	unsigned int	active;
 	unsigned long	vdso_base;
+#ifdef CONFIG_PPC_ICSWX
+	struct spinlock *cop_lockp;	/* guard cop related stuff */
+	unsigned long acop;		/* mask of enabled coprocessor types */
+#endif /* CONFIG_PPC_ICSWX */
 #ifdef CONFIG_PPC_MM_SLICES
 	u64 low_slices_psize;   /* SLB page size encodings */
 	u64 high_slices_psize;  /* 4 bits per slice for now */
diff --git a/arch/powerpc/include/asm/reg_booke.h b/arch/powerpc/include/asm/reg_booke.h
index 9ec0b39..e927049 100644
--- a/arch/powerpc/include/asm/reg_booke.h
+++ b/arch/powerpc/include/asm/reg_booke.h
@@ -187,6 +187,10 @@
 #define SPRN_CSRR1	SPRN_SRR3 /* Critical Save and Restore Register 1 */
 #endif
 
+#ifdef CONFIG_PPC_ICSWX
+#define SPRN_HACOP	0x15F	/* Hypervisor Available Coprocessor Register */
+#endif
+
 /* Bit definitions for CCR1. */
 #define	CCR1_DPC	0x00000100 /* Disable L1 I-Cache/D-Cache parity checking */
 #define	CCR1_TCS	0x00000080 /* Timer Clock Select */
diff --git a/arch/powerpc/kernel/cpu_setup_a2.S b/arch/powerpc/kernel/cpu_setup_a2.S
index 7f818fe..ebc62f4 100644
--- a/arch/powerpc/kernel/cpu_setup_a2.S
+++ b/arch/powerpc/kernel/cpu_setup_a2.S
@@ -41,11 +41,16 @@ _GLOBAL(__setup_cpu_a2)
 	 * core local but doing it always won't hurt
 	 */
 
-#ifdef CONFIG_PPC_WSP_COPRO
+#ifdef CONFIG_PPC_ICSWX
 	/* Make sure ACOP starts out as zero */
 	li	r3,0
 	mtspr   SPRN_ACOP,r3
 
+	/* Skip the following if we are in Guest mode */
+	mfmsr	r3
+	andis.	r0,r3,MSR_GS@h
+	bne	_icswx_skip_guest
+
 	/* Enable icswx instruction */
 	mfspr   r3,SPRN_A2_CCR2
 	ori     r3,r3,A2_CCR2_ENABLE_ICSWX
@@ -54,7 +59,8 @@ _GLOBAL(__setup_cpu_a2)
 	/* Unmask all CTs in HACOP */
 	li      r3,-1
 	mtspr   SPRN_HACOP,r3
-#endif /* CONFIG_PPC_WSP_COPRO */
+_icswx_skip_guest:
+#endif /* CONFIG_PPC_ICSWX */
 
 	/* Enable doorbell */
 	mfspr   r3,SPRN_A2_CCR2
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 4868d1f..f71f5e0 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -236,7 +236,7 @@ config VSX
 
 config PPC_ICSWX
 	bool "Support for PowerPC icswx coprocessor instruction"
-	depends on POWER4
+	depends on POWER4 || PPC_A2
 	default n
 	---help---
 
diff --git a/arch/powerpc/platforms/wsp/Kconfig b/arch/powerpc/platforms/wsp/Kconfig
index f4fb837..ea2811c 100644
--- a/arch/powerpc/platforms/wsp/Kconfig
+++ b/arch/powerpc/platforms/wsp/Kconfig
@@ -1,6 +1,7 @@
 config PPC_WSP
 	bool
 	select PPC_A2
+	select PPC_ICSWX
 	select PPC_SCOM
 	select PPC_XICS
 	select PPC_ICP_NATIVE
-- 
1.7.0.4
