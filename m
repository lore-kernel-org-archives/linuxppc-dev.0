Return-Path: <galak@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id E2E806815F
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Sep 2005 04:14:20 +1000 (EST)
Date: Thu, 1 Sep 2005 13:14:01 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
To: Andrew Morton <akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0509011313340.7294@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ppc32: Added cputable entry for 7448
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Added cputable entry for 7448 as well adding it to checks for saving and
restoring of cpu state.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 10c7d4720428b8b8486a45e5c4086b8ab7088967
tree ec3b0bda4cf730b6872b62a7a8b33acca1d95dd0
parent 18428d3c5db638b3d92e662890bedbc95737e052
author Kumar K. Gala <kumar.gala@freescale.com> Thu, 01 Sep 2005 13:13:03 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Thu, 01 Sep 2005 13:13:03 -0500

 arch/ppc/kernel/cpu_setup_6xx.S |    4 ++++
 arch/ppc/kernel/cputable.c      |   16 ++++++++++++++++
 2 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/ppc/kernel/cpu_setup_6xx.S b/arch/ppc/kernel/cpu_setup_6xx.S
--- a/arch/ppc/kernel/cpu_setup_6xx.S
+++ b/arch/ppc/kernel/cpu_setup_6xx.S
@@ -327,6 +327,7 @@ _GLOBAL(__save_cpu_setup)
 	cmplwi	cr4,r3,0x8002	/* 7457 */
 	cmplwi	cr5,r3,0x8003	/* 7447A */
 	cmplwi	cr6,r3,0x7000	/* 750FX */
+	cmplwi	cr7,r3,0x8004	/* 7448 */
 	/* cr1 is 7400 || 7410 */
 	cror	4*cr1+eq,4*cr1+eq,4*cr2+eq
 	/* cr0 is 74xx */
@@ -334,6 +335,7 @@ _GLOBAL(__save_cpu_setup)
 	cror	4*cr0+eq,4*cr0+eq,4*cr4+eq
 	cror	4*cr0+eq,4*cr0+eq,4*cr1+eq
 	cror	4*cr0+eq,4*cr0+eq,4*cr5+eq
+	cror	4*cr0+eq,4*cr0+eq,4*cr7+eq
 	bne	1f
 	/* Backup 74xx specific regs */
 	mfspr	r4,SPRN_MSSCR0
@@ -396,6 +398,7 @@ _GLOBAL(__restore_cpu_setup)
 	cmplwi	cr4,r3,0x8002	/* 7457 */
 	cmplwi	cr5,r3,0x8003	/* 7447A */
 	cmplwi	cr6,r3,0x7000	/* 750FX */
+	cmplwi	cr7,r3,0x8004	/* 7448 */
 	/* cr1 is 7400 || 7410 */
 	cror	4*cr1+eq,4*cr1+eq,4*cr2+eq
 	/* cr0 is 74xx */
@@ -403,6 +406,7 @@ _GLOBAL(__restore_cpu_setup)
 	cror	4*cr0+eq,4*cr0+eq,4*cr4+eq
 	cror	4*cr0+eq,4*cr0+eq,4*cr1+eq
 	cror	4*cr0+eq,4*cr0+eq,4*cr5+eq
+	cror	4*cr0+eq,4*cr0+eq,4*cr7+eq
 	bne	2f
 	/* Restore 74xx specific regs */
 	lwz	r4,CS_MSSCR0(r5)
diff --git a/arch/ppc/kernel/cputable.c b/arch/ppc/kernel/cputable.c
--- a/arch/ppc/kernel/cputable.c
+++ b/arch/ppc/kernel/cputable.c
@@ -536,6 +536,22 @@ struct cpu_spec	cpu_specs[] = {
 		.num_pmcs		= 6,
 		.cpu_setup		= __setup_cpu_745x
 	},
+	{	/* 7448 */
+		.pvr_mask		= 0xffff0000,
+		.pvr_value		= 0x80040000,
+		.cpu_name		= "7448",
+		.cpu_features		= CPU_FTR_COMMON |
+			CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
+			CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_L2CR |
+			CPU_FTR_ALTIVEC_COMP | CPU_FTR_HPTE_TABLE |
+			CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR |
+			CPU_FTR_HAS_HIGH_BATS | CPU_FTR_NEED_COHERENT,
+		.cpu_user_features	= COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.num_pmcs		= 6,
+		.cpu_setup		= __setup_cpu_745x
+	},
 	{	/* 82xx (8240, 8245, 8260 are all 603e cores) */
 		.pvr_mask		= 0x7fff0000,
 		.pvr_value		= 0x00810000,
