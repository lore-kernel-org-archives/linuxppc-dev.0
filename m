Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D8F5EB7173
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Jun 2009 18:30:02 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 34AA6DDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Jun 2009 18:30:01 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: Fix output from show_regs
Date: Fri, 19 Jun 2009 03:29:55 -0500
Message-Id: <1245400195-4220-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For some reason we've had an explicit KERN_INFO for GPR dumps.  With
recent changes we get output like:

<6>GPR00: 00000000 ef855eb0 ef858000 00000001 000000d0 f1000000 ffbc8000 ffffffff

The KERN_INFO is causing the <6>.  Don't see any reason to keep it
around.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/kernel/process.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 3e7135b..892a9f2 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -528,7 +528,7 @@ void show_regs(struct pt_regs * regs)
 
 	for (i = 0;  i < 32;  i++) {
 		if ((i % REGS_PER_LINE) == 0)
-			printk("\n" KERN_INFO "GPR%02d: ", i);
+			printk("\nGPR%02d: ", i);
 		printk(REG " ", regs->gpr[i]);
 		if (i == LAST_VOLATILE && !FULL_REGS(regs))
 			break;
-- 
1.6.0.6
