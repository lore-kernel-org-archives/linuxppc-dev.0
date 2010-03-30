Return-Path: <fkan@amcc.com>
Received: from sdcmail01.amcc.com (sdcmail01.amcc.com [198.137.200.72])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 27B8FB7CB6
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Mar 2010 04:53:07 +1100 (EST)
From: Feng Kan <fkan@amcc.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] fix the problem where pcix node is probed again as pci node.
Date: Tue, 30 Mar 2010 10:41:18 -0700
Message-Id: <1269970878-5080-1-git-send-email-fkan@amcc.com>
Cc: Feng Kan <fkan@appliedmicro.com>,
	Tirumala R Marri <tmarri@appliedmicro.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Feng Kan <fkan@appliedmicro.com>

The current matching scheme make the pci node match to pcix or pciex node.
To avoid the match, change the method so only one type of initialization
is called per node.

Signed-off-by: Feng Kan <fkan@appliedmicro.com>
Signed-off-by: Tirumala R Marri <tmarri@appliedmicro.com>
---
 arch/powerpc/sysdev/ppc4xx_pci.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/sysdev/ppc4xx_pci.c b/arch/powerpc/sysdev/ppc4xx_pci.c
index 8aa3302..1e67c74 100644
--- a/arch/powerpc/sysdev/ppc4xx_pci.c
+++ b/arch/powerpc/sysdev/ppc4xx_pci.c
@@ -1842,14 +1842,16 @@ static int __init ppc4xx_pci_find_bridges(void)
 
 	ppc_pci_flags |= PPC_PCI_ENABLE_PROC_DOMAINS | PPC_PCI_COMPAT_DOMAIN_0;
 
+	for_each_compatible_node(np, NULL, "ibm,plb-pci") {
+		if (of_device_is_compatible(np, "ibm,plb-pcix"))
+			ppc4xx_probe_pcix_bridge(np);
 #ifdef CONFIG_PPC4xx_PCI_EXPRESS
-	for_each_compatible_node(np, NULL, "ibm,plb-pciex")
-		ppc4xx_probe_pciex_bridge(np);
+		else if (of_device_is_compatible(np, "ibm,plb-pciex"))
+			ppc4xx_probe_pciex_bridge(np);
 #endif
-	for_each_compatible_node(np, NULL, "ibm,plb-pcix")
-		ppc4xx_probe_pcix_bridge(np);
-	for_each_compatible_node(np, NULL, "ibm,plb-pci")
-		ppc4xx_probe_pci_bridge(np);
+		else
+			ppc4xx_probe_pci_bridge(np);
+	}
 
 	return 0;
 }
-- 
1.5.5
