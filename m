Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 51FC8B7010
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Oct 2011 23:53:47 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id p96Crfb3021921
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Oct 2011 07:53:42 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/4] powerpc: Revert show_regs() define for readability
Date: Thu,  6 Oct 2011 07:53:38 -0500
Message-Id: <1317905621-5537-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We had an existing ifdef for 4xx & BOOKE processors that got changed to
CONFIG_PPC_ADV_DEBUG_REGS.  The define has nothing to do with
CONFIG_PPC_ADV_DEBUG_REGS.  The define really should be:

 #if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)

and not

 #ifdef CONFIG_PPC_ADV_DEBUG_REGS

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/kernel/process.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 8f53954..a1b5981 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -657,7 +657,7 @@ void show_regs(struct pt_regs * regs)
 	if ((regs->trap != 0xc00) && cpu_has_feature(CPU_FTR_CFAR))
 		printk("CFAR: "REG"\n", regs->orig_gpr3);
 	if (trap == 0x300 || trap == 0x600)
-#ifdef CONFIG_PPC_ADV_DEBUG_REGS
+#if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
 		printk("DEAR: "REG", ESR: "REG"\n", regs->dar, regs->dsisr);
 #else
 		printk("DAR: "REG", DSISR: %08lx\n", regs->dar, regs->dsisr);
-- 
1.7.3.4
