Return-Path: <Dongdong.Deng@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id B038FB70A3
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 16 Nov 2010 23:57:42 +1100 (EST)
From: Dongdong Deng <dongdong.deng@windriver.com>
To: jason.wessel@windriver.com
Subject: [PATCH] kgdb,
	ppc: Corrected the address using of current->thread.evr register
Date: Tue, 16 Nov 2010 20:58:36 +0800
Message-Id: <1289912316-4580-1-git-send-email-dongdong.deng@windriver.com>
Cc: kgdb-bugreport@lists.sourceforge.net, shan.hai@windriver.com,
	linuxppc-dev@lists.ozlabs.org, miltonm@bga.com, dongdong.deng@windriver.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Passing the address of current->thread.evr register to memcpy function.

Signed-off-by: Dongdong Deng <dongdong.deng@windriver.com>
CC: Hai Shan <shan.hai@windriver.com>
CC: Milton Miller <miltonm@bga.com>
CC: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/kernel/kgdb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
index 7a9db64..781acff 100644
--- a/arch/powerpc/kernel/kgdb.c
+++ b/arch/powerpc/kernel/kgdb.c
@@ -337,7 +337,7 @@ char *dbg_get_reg(int regno, void *mem, struct pt_regs *regs)
 		/* FP registers 32 -> 63 */
 #if defined(CONFIG_FSL_BOOKE) && defined(CONFIG_SPE)
 		if (current)
-			memcpy(mem, current->thread.evr[regno-32],
+			memcpy(mem, (void *)&current->thread.evr[regno-32],
 					dbg_reg_def[regno].size);
 #else
 		/* fp registers not used by kernel, leave zero */
@@ -362,7 +362,7 @@ int dbg_set_reg(int regno, void *mem, struct pt_regs *regs)
 	if (regno >= 32 && regno < 64) {
 		/* FP registers 32 -> 63 */
 #if defined(CONFIG_FSL_BOOKE) && defined(CONFIG_SPE)
-		memcpy(current->thread.evr[regno-32], mem,
+		memcpy((void *)&current->thread.evr[regno-32], mem,
 				dbg_reg_def[regno].size);
 #else
 		/* fp registers not used by kernel, leave zero */
-- 
1.6.0.4
