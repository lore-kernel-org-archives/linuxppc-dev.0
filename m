Return-Path: <B07421@freescale.com>
Received: from AM1EHSOBE006.bigfish.com (am1ehsobe006.messaging.microsoft.com
	[213.199.154.209])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4EB10B6F83
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jun 2011 05:09:33 +1000 (EST)
Date: Thu, 16 Jun 2011 14:09:17 -0500
From: Scott Wood <scottwood@freescale.com>
To: <galak@kernel.crashing.org>
Subject: [PATCH] powerpc/e500: fix breakage with fsl_rio_mcheck_exception
Message-ID: <20110616190916.GA31367@schlenkerla.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The wrong MCSR bit was being used on e500mc.  MCSR_BUS_RBERR only exists
on e500v1/v2.  Use MCSR_LD on e500mc, and remove all MCSR checking
in fsl_rio_mcheck_exception as we now no longer call that function
if the appropriate bit in MCSR is not set.

If RIO support was enabled at compile-time, but was never probed, just
return from fsl_rio_mcheck_exception rather than dereference a NULL
pointer.

TODO: There is still a remaining, though comparitively minor, issue in
that this recovery mechanism will falsely engage if there's an unrelated
MCSR_LD event at the same time as a RIO error.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/kernel/traps.c   |    2 +-
 arch/powerpc/sysdev/fsl_rio.c |   33 +++++++++++++++++----------------
 2 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 0ff4ab9..6414a0d 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -425,7 +425,7 @@ int machine_check_e500mc(struct pt_regs *regs)
 	unsigned long reason = mcsr;
 	int recoverable = 1;
 
-	if (reason & MCSR_BUS_RBERR) {
+	if (reason & MCSR_LD) {
 		recoverable = fsl_rio_mcheck_exception(regs);
 		if (recoverable == 1)
 			goto silent_out;
diff --git a/arch/powerpc/sysdev/fsl_rio.c b/arch/powerpc/sysdev/fsl_rio.c
index 5b206a2..b3fd081 100644
--- a/arch/powerpc/sysdev/fsl_rio.c
+++ b/arch/powerpc/sysdev/fsl_rio.c
@@ -283,23 +283,24 @@ static void __iomem *rio_regs_win;
 #ifdef CONFIG_E500
 int fsl_rio_mcheck_exception(struct pt_regs *regs)
 {
-	const struct exception_table_entry *entry = NULL;
-	unsigned long reason = mfspr(SPRN_MCSR);
-
-	if (reason & MCSR_BUS_RBERR) {
-		reason = in_be32((u32 *)(rio_regs_win + RIO_LTLEDCSR));
-		if (reason & (RIO_LTLEDCSR_IER | RIO_LTLEDCSR_PRT)) {
-			/* Check if we are prepared to handle this fault */
-			entry = search_exception_tables(regs->nip);
-			if (entry) {
-				pr_debug("RIO: %s - MC Exception handled\n",
-					 __func__);
-				out_be32((u32 *)(rio_regs_win + RIO_LTLEDCSR),
-					 0);
-				regs->msr |= MSR_RI;
-				regs->nip = entry->fixup;
-				return 1;
-			}
+	const struct exception_table_entry *entry;
+	unsigned long reason;
+
+	if (!rio_regs_win)
+		return 0;
+
+	reason = in_be32((u32 *)(rio_regs_win + RIO_LTLEDCSR));
+	if (reason & (RIO_LTLEDCSR_IER | RIO_LTLEDCSR_PRT)) {
+		/* Check if we are prepared to handle this fault */
+		entry = search_exception_tables(regs->nip);
+		if (entry) {
+			pr_debug("RIO: %s - MC Exception handled\n",
+				 __func__);
+			out_be32((u32 *)(rio_regs_win + RIO_LTLEDCSR),
+				 0);
+			regs->msr |= MSR_RI;
+			regs->nip = entry->fixup;
+			return 1;
 		}
 	}
 
-- 
1.7.4.1
