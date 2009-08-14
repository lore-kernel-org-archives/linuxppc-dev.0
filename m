Return-Path: <Paul.Gortmaker@windriver.com>
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: Linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] powerpc: issue fsl_soc reboot warning only when applicable
Date: Fri, 14 Aug 2009 12:13:53 -0400
Message-Id: <2d219a4998d568c5925727ce61ca440dfb25f5e7.1250266325.git.paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some CPU, like the MPC8560 don't have a RSTCR in the Global
Utilities Block.  These boards will implement their own reboot
call, and not use this code, so we should only warn about the
absence of the GUTS RSTCR when the default reboot code is used.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/sysdev/fsl_soc.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 95dbc64..adca4af 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -37,6 +37,7 @@
 #include <asm/irq.h>
 #include <asm/time.h>
 #include <asm/prom.h>
+#include <asm/machdep.h>
 #include <sysdev/fsl_soc.h>
 #include <mm/mmu_decl.h>
 #include <asm/cpm2.h>
@@ -383,8 +384,9 @@ static int __init setup_rstcr(void)
 		if (!rstcr)
 			printk (KERN_EMERG "Error: reset control register "
 					"not mapped!\n");
-	} else
-		printk (KERN_INFO "rstcr compatible register does not exist!\n");
+	} else if (ppc_md.restart == fsl_rstcr_restart)
+		printk(KERN_ERR "No RSTCR register, warm reboot won't work\n");
+
 	if (np)
 		of_node_put(np);
 	return 0;
-- 
1.6.3.3
