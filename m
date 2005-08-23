Return-Path: <galak@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id B8717680E1
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Aug 2005 09:32:58 +1000 (EST)
Date: Tue, 23 Aug 2005 18:32:53 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <Pine.LNX.4.61.0508231829240.18745@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH] ppc32: Only enable L2 prefetching if the L2 cache is enabled
 on 744x/745x
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

(Ben, this needs to be tested before sending upstream, but I think it 
looks good)

We run into problems if we blindly enable L2 prefetching with out checking
that the L2 cache is actually enabled.  Additionaly, if we disable the L2
cache we need to ensure that we disable L2 prefetching.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit d90fa018552f3c3515ec46beadc0f0ff64c54547
tree c0c85d3e5c478a184716c8f0e1543b0d9b0b60fa
parent f6fdd7d9c273bb2a20ab467cb57067494f932fa3
author Kumar K. Gala <kumar.gala@freescale.com> Tue, 23 Aug 2005 18:27:02 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Tue, 23 Aug 2005 18:27:02 -0500

 arch/ppc/kernel/cpu_setup_6xx.S |    5 ++++-
 arch/ppc/kernel/l2cr.S          |   31 ++++++++++++++++++++++++++++++-
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/arch/ppc/kernel/cpu_setup_6xx.S b/arch/ppc/kernel/cpu_setup_6xx.S
--- a/arch/ppc/kernel/cpu_setup_6xx.S
+++ b/arch/ppc/kernel/cpu_setup_6xx.S
@@ -249,8 +249,11 @@ END_FTR_SECTION_IFSET(CPU_FTR_NO_DPM)
 	sync
 	isync
 
-	/* Enable L2 HW prefetch
+	/* Enable L2 HW prefetch, if L2 is enabled
 	 */
+	mfspr	r3,SPRN_L2CR
+	andis.	r3,r3,L2CR_L2E@h
+	beqlr
 	mfspr	r3,SPRN_MSSCR0
 	ori	r3,r3,3
 	sync
diff --git a/arch/ppc/kernel/l2cr.S b/arch/ppc/kernel/l2cr.S
--- a/arch/ppc/kernel/l2cr.S
+++ b/arch/ppc/kernel/l2cr.S
@@ -156,6 +156,26 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 	       The bit moved on the 7450.....
 	  ****/
 
+BEGIN_FTR_SECTION
+	/* Disable L2 prefetch on some 745x and try to ensure
+	 * L2 prefetch engines are idle. As explained by errata
+	 * text, we can't be sure they are, we just hope very hard
+	 * that well be enough (sic !). At least I noticed Apple
+	 * doesn't even bother doing the dcbf's here...
+	 */
+	mfspr	r4,SPRN_MSSCR0
+	rlwinm	r4,r4,0,0,29
+	sync
+	mtspr	SPRN_MSSCR0,r4
+	sync
+	isync
+	lis	r4,KERNELBASE@h
+	dcbf	0,r4
+	dcbf	0,r4
+	dcbf	0,r4
+	dcbf	0,r4
+END_FTR_SECTION_IFSET(CPU_FTR_SPEC7450)
+
 	/* TODO: use HW flush assist when available */
 
 	lis	r4,0x0002
@@ -230,7 +250,16 @@ END_FTR_SECTION_IFSET(CPU_FTR_SPEC7450)
 	oris	r3,r3,0x8000
 	mtspr	SPRN_L2CR,r3
 	sync
-
+	
+	/* Enable L2 HW prefetch on 744x/745x */
+BEGIN_FTR_SECTION
+	mfspr	r3,SPRN_MSSCR0
+	ori	r3,r3,3
+	sync
+	mtspr	SPRN_MSSCR0,r3
+	sync
+	isync
+END_FTR_SECTION_IFSET(CPU_FTR_SPEC7450)
 4:
 
 	/* Restore HID0[DPM] to whatever it was before */
