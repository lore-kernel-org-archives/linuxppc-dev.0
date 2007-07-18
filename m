Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3D026DDEF1
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 11:33:06 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l6I1X1OH018456
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 18:33:02 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.83.16.18])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6I1X09T001143
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:33:01 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l6I18JBw007820
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:08:20 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 1BF35AEFC9
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:33:00 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l6I1WxrO015255
	for linuxppc-dev@ozlabs.org; Tue, 17 Jul 2007 20:32:59 -0500
Date: Tue, 17 Jul 2007 20:32:59 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 04/61] 8xx: Work around CPU15 erratum.
Message-ID: <20070718013259.GC15238@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070718013137.GA15217@ld0162-tx32.am.freescale.net>
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
index 901be47..7488f30 100644
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
