Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 1C89EDDEF7
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2008 13:51:44 +1000 (EST)
To: Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <96343fe00bd43a12b1739ff1513ba07224e3f302.1217476198.git.tony@bakeyournoodle.com>
In-Reply-To: <cac86e24e42bd05087b43663b687f04df91326ba.1217476198.git.tony@bakeyournoodle.com>
References: <cac86e24e42bd05087b43663b687f04df91326ba.1217476198.git.tony@bakeyournoodle.com>
From: Tony Breeds <tony@bakeyournoodle.com>
Subject: [PATCH 4/8] Silence warnings in
	arch/powerpc/platforms/52xx/mpc52xx_pci.c
Date: Thu, 31 Jul 2008 13:51:43 +1000 (EST)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Explicitly cast resource fields to unsigned long long, and match format
specifier.

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
---
 arch/powerpc/platforms/52xx/mpc52xx_pci.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pci.c b/arch/powerpc/platforms/52xx/mpc52xx_pci.c
index 5a382bb..b49a185 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pci.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pci.c
@@ -265,8 +265,11 @@ mpc52xx_pci_setup(struct pci_controller *hose,
 	/* Memory windows */
 	res = &hose->mem_resources[0];
 	if (res->flags) {
-		pr_debug("mem_resource[0] = {.start=%x, .end=%x, .flags=%lx}\n",
-		         res->start, res->end, res->flags);
+		pr_debug("mem_resource[0] = "
+		         "{.start=%llx, .end=%llx, .flags=%llx}\n",
+		         (unsigned long long)res->start,
+			 (unsigned long long)res->end,
+			 (unsigned long long)res->flags);
 		out_be32(&pci_regs->iw0btar,
 		         MPC52xx_PCI_IWBTAR_TRANSLATION(res->start, res->start,
 		                  res->end - res->start + 1));
@@ -297,9 +300,11 @@ mpc52xx_pci_setup(struct pci_controller *hose,
 		printk(KERN_ERR "%s: Didn't find IO resources\n", __FILE__);
 		return;
 	}
-	pr_debug(".io_resource={.start=%x,.end=%x,.flags=%lx} "
+	pr_debug(".io_resource={.start=%llx,.end=%llx,.flags=%llx} "
 	         ".io_base_phys=0x%p\n",
-	         res->start, res->end, res->flags, (void*)hose->io_base_phys);
+	         (unsigned long long)res->start,
+		 (unsigned long long)res->end,
+		 (unsigned long long)res->flags, (void*)hose->io_base_phys);
 	out_be32(&pci_regs->iw2btar,
 	         MPC52xx_PCI_IWBTAR_TRANSLATION(hose->io_base_phys,
 	                                        res->start,
-- 
1.5.6.3
