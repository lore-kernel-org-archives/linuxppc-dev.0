Return-Path: <Joakim.Tjernlund@infinera.com>
Received: from smtp.transmode.se (smtp.transmode.se [31.15.61.139])
 by lists.ozlabs.org (Postfix) with ESMTP id 3xmllV6t0yzDrJF
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Sep 2017 22:05:10 +1000 (AEST)
From: Joakim Tjernlund <joakim.tjernlund@infinera.com>
To: linuxppc-dev linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 York Sun <york.sun@nxp.com>
Subject: [PATCH] fsl_pci: Correct fsl_pci_mcheck_exception
Date: Tue,  5 Sep 2017 13:59:43 +0200
Message-Id: <20170905115943.19919-1-joakim.tjernlund@infinera.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

get_user() had it args reversed causing NIP to be NULL:ed instead
of fixing up the PCI access.

Note: This still hangs my P1020 Freescale CPU hard, but at least
I get a NIP now.

Signed-off-by: Joakim Tjernlund <joakim.tjernlund@infinera.com>
---
 arch/powerpc/sysdev/fsl_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 7c8b779c329a..9e64c12dff6a 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -996,7 +996,7 @@ int fsl_pci_mcheck_exception(struct pt_regs *regs)
 	if (is_in_pci_mem_space(addr)) {
 		if (user_mode(regs)) {
 			pagefault_disable();
-			ret = get_user(regs->nip, &inst);
+			ret = get_user(inst, (__u32 __user *)regs->nip);
 			pagefault_enable();
 		} else {
 			ret = probe_kernel_address(regs->nip, inst);
-- 
2.13.5
