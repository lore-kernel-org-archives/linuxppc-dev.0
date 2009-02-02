Return-Path: <benh@ozlabs.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 02 Feb 2009 13:59:13 +1100
Subject: [PATCH] powerpc/4xx: Enable PCI domains on 4xx
Message-Id: <20090202025924.C9F47DDF40@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

4xx chips commonly now have multiple PHBs, there is no reason to not
enable PCI domains on them. The main issue with PCI domains is X but
currently its already somewhat busted for other reasons such as the
36-bit physical address space, which I'm fixing separately.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/sysdev/ppc4xx_pci.c |    2 ++
 1 file changed, 2 insertions(+)

--- linux-work.orig/arch/powerpc/sysdev/ppc4xx_pci.c	2009-01-05 13:39:26.000000000 +1100
+++ linux-work/arch/powerpc/sysdev/ppc4xx_pci.c	2009-01-14 13:57:48.000000000 +1100
@@ -1822,6 +1822,8 @@ static int __init ppc4xx_pci_find_bridge
 {
 	struct device_node *np;
 
+	ppc_pci_flags |= PPC_PCI_ENABLE_PROC_DOMAINS | PPC_PCI_COMPAT_DOMAIN_0;
+
 #ifdef CONFIG_PPC4xx_PCI_EXPRESS
 	for_each_compatible_node(np, NULL, "ibm,plb-pciex")
 		ppc4xx_probe_pciex_bridge(np);
