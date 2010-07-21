Return-Path: <abounine@tundra.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 2F3FAB70C6
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jul 2010 23:07:56 +1000 (EST)
From: Alexandre Bounine <alexandre.bounine@idt.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Subject: [PATCH] RapidIO,powerpc/85xx: remove MCSR_MASK in fsl_rio
Date: Wed, 21 Jul 2010 12:46:50 -0400
Message-Id: <1279730810-24926-1-git-send-email-alexandre.bounine@idt.com>
Cc: Alexandre Bounine <alexandre.bounine@idt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fixes compile problem caused by MCSR_MASK removal from book-E definitions.

Signed-off-by: Alexandre Bounine <alexandre.bounine@idt.com>
Cc: Kumar Gala <galak@kernel.crashing.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Matt Porter <mporter@kernel.crashing.org>
---
 arch/powerpc/sysdev/fsl_rio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_rio.c b/arch/powerpc/sysdev/fsl_rio.c
index 30e1626..c58df58 100644
--- a/arch/powerpc/sysdev/fsl_rio.c
+++ b/arch/powerpc/sysdev/fsl_rio.c
@@ -245,7 +245,7 @@ static int (*saved_mcheck_exception)(struct pt_regs *regs);
 static int fsl_rio_mcheck_exception(struct pt_regs *regs)
 {
 	const struct exception_table_entry *entry = NULL;
-	unsigned long reason = (mfspr(SPRN_MCSR) & MCSR_MASK);
+	unsigned long reason = mfspr(SPRN_MCSR);
 
 	if (reason & MCSR_BUS_RBERR) {
 		reason = in_be32((u32 *)(rio_regs_win + RIO_LTLEDCSR));
-- 
1.7.0.5
