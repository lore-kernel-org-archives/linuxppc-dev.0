Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4ED8BDE960
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Aug 2007 06:24:59 +1000 (EST)
Date: Tue, 28 Aug 2007 15:17:21 -0500
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH 4/9] 8xx: Work around CPU15 erratum.
Message-ID: <20070828201721.GD24260@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070828201127.GA24068@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The CPU15 erratum on MPC8xx chips can cause incorrect code execution
under certain circumstances, where there is a conditional or indirect
branch in the last word of a page, with a target in the last cache line
of the next page.  This patch implements one of the suggested
workarounds, by forcing a TLB miss whenever execution crosses a page
boundary.  This is done by invalidating the pages before and after the
one being loaded into the TLB in the ITLB miss handler.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/kernel/head_8xx.S     |    6 ++++++
 arch/powerpc/platforms/8xx/Kconfig |   16 ++++++++++++++++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index e40e122..dd223df 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -301,6 +301,12 @@ InstructionTLBMiss:
 	stw	r10, 0(r0)
 	stw	r11, 4(r0)
 	mfspr	r10, SPRN_SRR0	/* Get effective address of fault */
+#ifdef CONFIG_8xx_CPU15
+	addi	r11, r10, 0x1000
+	tlbie	r11
+	addi	r11, r10, -0x1000
+	tlbie	r11
+#endif
 	DO_8xx_CPU6(0x3780, r3)
 	mtspr	SPRN_MD_EPN, r10	/* Have to use MD_EPN for walk, MI_EPN can't */
 	mfspr	r10, SPRN_M_TWB	/* Get level 1 table entry address */
diff --git a/arch/powerpc/platforms/8xx/Kconfig b/arch/powerpc/platforms/8xx/Kconfig
index 39bb8c5..b8dd515 100644
--- a/arch/powerpc/platforms/8xx/Kconfig
+++ b/arch/powerpc/platforms/8xx/Kconfig
@@ -99,6 +99,22 @@ config 8xx_CPU6
 
 	  If in doubt, say N here.
 
+config 8xx_CPU15
+	bool "CPU15 Silicon Errata"
+	default y
+	help
+	  This enables a workaround for erratum CPU15 on MPC8xx chips.
+	  This bug can cause incorrect code execution under certain
+	  circumstances.  This workaround adds some overhead (a TLB miss
+	  every time execution crosses a page boundary), and you may wish
+	  to disable it if you have worked around the bug in the compiler
+	  (by not placing conditional branches or branches to LR or CTR
+	  in the last word of a page, with a target of the last cache
+	  line in the next page), or if you have used some other
+	  workaround.
+
+	  If in doubt, say Y here.
+
 choice
 	prompt "Microcode patch selection"
 	default NO_UCODE_PATCH
-- 
1.5.0.3
