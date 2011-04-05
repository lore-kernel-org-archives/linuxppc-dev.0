Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp07.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F37B5B6FB6
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Apr 2011 16:14:20 +1000 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp07.au.ibm.com (8.14.4/8.13.1) with ESMTP id p356EK3L018915
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Apr 2011 16:14:20 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p356EKmh1671270
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Apr 2011 16:14:20 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p356EK96024365
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Apr 2011 16:14:20 +1000
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 01/15] powerpc: Add more Power7 specific definitions
Date: Tue,  5 Apr 2011 16:13:57 +1000
Message-Id: <1301984051-18413-2-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1301984051-18413-1-git-send-email-benh@kernel.crashing.org>
References: <1301984051-18413-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds more SPR definitions used on newer processors when running
in hypervisor mode. Along with some other P7 specific bits and pieces

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/ppc_asm.h |    1 +
 arch/powerpc/include/asm/reg.h     |   46 +++++++++++++++++++++++++++++++++++-
 2 files changed, 46 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index 9821006..1b42238 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -170,6 +170,7 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
 #define HMT_MEDIUM	or	2,2,2
 #define HMT_MEDIUM_HIGH or	5,5,5		# medium high priority
 #define HMT_HIGH	or	3,3,3
+#define HMT_EXTRA_HIGH	or	7,7,7		# power7 only
 
 #ifdef __KERNEL__
 #ifdef CONFIG_PPC64
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 7e4abeb..6eb1d77 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -210,8 +210,43 @@
 #define SPRN_TBWL	0x11C	/* Time Base Lower Register (super, R/W) */
 #define SPRN_TBWU	0x11D	/* Time Base Upper Register (super, R/W) */
 #define SPRN_SPURR	0x134	/* Scaled PURR */
+#define SPRN_HSPRG0	0x130	/* Hypervisor Scratch 0 */
+#define SPRN_HSPRG1	0x131	/* Hypervisor Scratch 1 */
+#define SPRN_HDSISR     0x132
+#define SPRN_HDAR       0x133
+#define SPRN_HDEC	0x136	/* Hypervisor Decrementer */
 #define SPRN_HIOR	0x137	/* 970 Hypervisor interrupt offset */
+#define SPRN_RMOR	0x138	/* Real mode offset register */
+#define SPRN_HRMOR	0x139	/* Real mode offset register */
+#define SPRN_HSRR0	0x13A	/* Hypervisor Save/Restore 0 */
+#define SPRN_HSRR1	0x13B	/* Hypervisor Save/Restore 1 */
 #define SPRN_LPCR	0x13E	/* LPAR Control Register */
+#define   LPCR_VPM0	(1ul << (63-0))
+#define   LPCR_VPM1	(1ul << (63-1))
+#define   LPCR_ISL	(1ul << (63-2))
+#define   LPCR_DPFD_SH	(63-11)
+#define   LPCR_VRMA_L	(1ul << (63-12))
+#define   LPCR_VRMA_LP0	(1ul << (63-15))
+#define   LPCR_VRMA_LP1	(1ul << (63-16))
+#define   LPCR_RMLS    0x1C000000      /* impl dependent rmo limit sel */
+#define   LPCR_ILE     0x02000000      /* !HV irqs set MSR:LE */
+#define   LPCR_PECE	0x00007000	/* powersave exit cause enable */
+#define     LPCR_PECE0	0x00004000	/* ext. exceptions can cause exit */
+#define     LPCR_PECE1	0x00002000	/* decrementer can cause exit */
+#define     LPCR_PECE2	0x00001000	/* machine check etc can cause exit */
+#define   LPCR_MER	0x00000800	/* Mediated External Exception */
+#define   LPCR_LPES0   0x00000008      /* LPAR Env selector 0 */
+#define   LPCR_LPES1   0x00000004      /* LPAR Env selector 1 */
+#define   LPCR_RMI     0x00000002      /* real mode is cache inhibit */
+#define   LPCR_HDICE   0x00000001      /* Hyp Decr enable (HV,PR,EE) */
+#define SPRN_LPID	0x13F	/* Logical Partition Identifier */
+#define	SPRN_HMER	0x150	/* Hardware m? error recovery */
+#define	SPRN_HMEER	0x151	/* Hardware m? enable error recovery */
+#define	SPRN_HEIR	0x153	/* Hypervisor Emulated Instruction Register */
+#define SPRN_TLBINDEXR	0x154	/* P7 TLB control register */
+#define SPRN_TLBVPNR	0x155	/* P7 TLB control register */
+#define SPRN_TLBRPNR	0x156	/* P7 TLB control register */
+#define SPRN_TLBLPIDR	0x157	/* P7 TLB control register */
 #define SPRN_DBAT0L	0x219	/* Data BAT 0 Lower Register */
 #define SPRN_DBAT0U	0x218	/* Data BAT 0 Upper Register */
 #define SPRN_DBAT1L	0x21B	/* Data BAT 1 Lower Register */
@@ -434,16 +469,23 @@
 #define SPRN_SRR0	0x01A	/* Save/Restore Register 0 */
 #define SPRN_SRR1	0x01B	/* Save/Restore Register 1 */
 #define   SRR1_WAKEMASK		0x00380000 /* reason for wakeup */
-#define   SRR1_WAKERESET	0x00380000 /* System reset */
 #define   SRR1_WAKESYSERR	0x00300000 /* System error */
 #define   SRR1_WAKEEE		0x00200000 /* External interrupt */
 #define   SRR1_WAKEMT		0x00280000 /* mtctrl */
+#define	  SRR1_WAKEHMI		0x00280000 /* Hypervisor maintenance */
 #define   SRR1_WAKEDEC		0x00180000 /* Decrementer interrupt */
 #define   SRR1_WAKETHERM	0x00100000 /* Thermal management interrupt */
+#define	  SRR1_WAKERESET	0x00100000 /* System reset */
+#define	  SRR1_WAKESTATE	0x00030000 /* Powersave exit mask [46:47] */
+#define	  SRR1_WS_DEEPEST	0x00030000 /* Some resources not maintained,
+					  * may not be recoverable */
+#define	  SRR1_WS_DEEPER	0x00020000 /* Some resources not maintained */
+#define	  SRR1_WS_DEEP		0x00010000 /* All resources maintained */
 #define   SRR1_PROGFPE		0x00100000 /* Floating Point Enabled */
 #define   SRR1_PROGPRIV		0x00040000 /* Privileged instruction */
 #define   SRR1_PROGTRAP		0x00020000 /* Trap */
 #define   SRR1_PROGADDR		0x00010000 /* SRR0 contains subsequent addr */
+
 #define SPRN_HSRR0	0x13A	/* Save/Restore Register 0 */
 #define SPRN_HSRR1	0x13B	/* Save/Restore Register 1 */
 
@@ -894,6 +936,8 @@
 #define PV_POWER5p	0x003B
 #define PV_POWER7	0x003F
 #define PV_970FX	0x003C
+#define PV_POWER6	0x003E
+#define PV_POWER7	0x003F
 #define PV_630		0x0040
 #define PV_630p	0x0041
 #define PV_970MP	0x0044
-- 
1.7.1
