Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4E4A9B6F69
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  5 Aug 2011 16:03:44 +1000 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id p7563duY027894
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Aug 2011 01:03:40 -0500
Subject: [PATCH] powerpc/4xx: Fix build of PCI code on 405
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 05 Aug 2011 16:03:37 +1000
Message-ID: <1312524217.8598.24.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 112d1fe9f7715db423ffeec5ac1beccff6093dc4
"powerpc/4xx: Add check_link to struct ppc4xx_pciex_hwops" inadvertently
broke 405 builds due to some functions being over protected by an
ifdef CONFIG_44x.

Move them back out.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/sysdev/ppc4xx_pci.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/ppc4xx_pci.c b/arch/powerpc/sysdev/ppc4xx_pci.c
index a59ba96..dbfe96b 100644
--- a/arch/powerpc/sysdev/ppc4xx_pci.c
+++ b/arch/powerpc/sysdev/ppc4xx_pci.c
@@ -655,8 +655,6 @@ struct ppc4xx_pciex_hwops
 
 static struct ppc4xx_pciex_hwops *ppc4xx_pciex_hwops;
 
-#ifdef CONFIG_44x
-
 static int __init ppc4xx_pciex_wait_on_sdr(struct ppc4xx_pciex_port *port,
 					   unsigned int sdr_offset,
 					   unsigned int mask,
@@ -688,6 +686,7 @@ static int __init ppc4xx_pciex_port_reset_sdr(struct ppc4xx_pciex_port *port)
 	return 0;
 }
 
+
 static void __init ppc4xx_pciex_check_link_sdr(struct ppc4xx_pciex_port *port)
 {
 	printk(KERN_INFO "PCIE%d: Checking link...\n", port->index);
@@ -718,6 +717,8 @@ static void __init ppc4xx_pciex_check_link_sdr(struct ppc4xx_pciex_port *port)
 		printk(KERN_INFO "PCIE%d: No device detected.\n", port->index);
 }
 
+#ifdef CONFIG_44x
+
 /* Check various reset bits of the 440SPe PCIe core */
 static int __init ppc440spe_pciex_check_reset(struct device_node *np)
 {
