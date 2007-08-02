Return-Path: <bgill@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D2A35DDEA0
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Aug 2007 06:37:24 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l72KbIOO026853
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Aug 2007 13:37:18 -0700 (MST)
From: Becky Bruce <becky.bruce@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Fix FSL BookE machine check reporting
Date: Thu,  2 Aug 2007 15:37:15 -0500
Message-Id: <11860870353423-git-send-email-becky.bruce@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Reserved MCSR bits on FSL BookE parts may have spurious values
when mcheck occurs.  Mask these off when printing the MCSR to
avoid confusion.  Also, get rid of the MCSR_GL_CI bit defined
for e500 - this bit doesn't actually have any meaning.

Signed-off-by: Becky Bruce <becky.bruce@freescale.com>
---
 arch/powerpc/kernel/traps.c     |    4 +---
 include/asm-powerpc/reg_booke.h |   12 +++++++++++-
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 2bb1cb9..d8502e3 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -299,7 +299,7 @@ static inline int check_io_access(struct pt_regs *regs)
 #ifndef CONFIG_FSL_BOOKE
 #define get_mc_reason(regs)	((regs)->dsisr)
 #else
-#define get_mc_reason(regs)	(mfspr(SPRN_MCSR))
+#define get_mc_reason(regs)	(mfspr(SPRN_MCSR) & MCSR_MASK)
 #endif
 #define REASON_FP		ESR_FP
 #define REASON_ILLEGAL		(ESR_PIL | ESR_PUO)
@@ -414,8 +414,6 @@ void machine_check_exception(struct pt_regs *regs)
 		printk("Data Cache Push Parity Error\n");
 	if (reason & MCSR_DCPERR)
 		printk("Data Cache Parity Error\n");
-	if (reason & MCSR_GL_CI)
-		printk("Guarded Load or Cache-Inhibited stwcx.\n");
 	if (reason & MCSR_BUS_IAERR)
 		printk("Bus - Instruction Address Error\n");
 	if (reason & MCSR_BUS_RAERR)
diff --git a/include/asm-powerpc/reg_booke.h b/include/asm-powerpc/reg_booke.h
index 064405c..8fdc2b4 100644
--- a/include/asm-powerpc/reg_booke.h
+++ b/include/asm-powerpc/reg_booke.h
@@ -223,7 +223,6 @@
 #define MCSR_ICPERR 	0x40000000UL /* I-Cache Parity Error */
 #define MCSR_DCP_PERR 	0x20000000UL /* D-Cache Push Parity Error */
 #define MCSR_DCPERR 	0x10000000UL /* D-Cache Parity Error */
-#define MCSR_GL_CI 	0x00010000UL /* Guarded Load or Cache-Inhibited stwcx. */
 #define MCSR_BUS_IAERR 	0x00000080UL /* Instruction Address Error */
 #define MCSR_BUS_RAERR 	0x00000040UL /* Read Address Error */
 #define MCSR_BUS_WAERR 	0x00000020UL /* Write Address Error */
@@ -232,6 +231,12 @@
 #define MCSR_BUS_WBERR 	0x00000004UL /* Write Data Bus Error */
 #define MCSR_BUS_IPERR 	0x00000002UL /* Instruction parity Error */
 #define MCSR_BUS_RPERR 	0x00000001UL /* Read parity Error */
+
+/* e500 parts may set unused bits in MCSR; mask these off */
+#define MCSR_MASK	(MCSR_MCP | MCSR_ICPERR | MCSR_DCP_PERR | \
+			MCSR_DCPERR | MCSR_BUS_IAERR | MCSR_BUS_RAERR | \
+			MCSR_BUS_WAERR | MCSR_BUS_IBERR | MCSR_BUS_RBERR | \
+			MCSR_BUS_WBERR | MCSR_BUS_IPERR | MCSR_BUS_RPERR)
 #endif
 #ifdef CONFIG_E200
 #define MCSR_MCP 	0x80000000UL /* Machine Check Input Pin */
@@ -243,6 +248,11 @@
 #define MCSR_BUS_DRERR 	0x00000008UL /* Read Bus Error on data load */
 #define MCSR_BUS_WRERR 	0x00000004UL /* Write Bus Error on buffered
 					store or cache line push */
+
+/* e200 parts may set unused bits in MCSR; mask these off */
+#define MCSR_MASK	(MCSR_MCP | MCSR_CP_PERR | MCSR_CPERR | \
+			MCSR_EXCP_ERR | MCSR_BUS_IRERR | MCSR_BUS_DRERR | \
+			MCSR_BUS_WRERR)
 #endif
 
 /* Bit definitions for the DBSR. */
-- 
1.5.0.3
