Return-Path: <tony@bakeyournoodle.com>
From: Tony Breeds <tony@bakeyournoodle.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Josh Boyer <jwboyer@gmail.com>
Subject: [PATCH 2/8] 44x/pci: Add a want_sdr flag into ppc4xx_pciex_hwops
Date: Thu,  1 Dec 2011 18:39:18 +1100
Message-Id: <1322725164-4391-3-git-send-email-tony@bakeyournoodle.com>
In-Reply-To: <1322725164-4391-1-git-send-email-tony@bakeyournoodle.com>
References: <1322725164-4391-1-git-send-email-tony@bakeyournoodle.com>
Cc: LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currituck doesn't need nor use SDR so aborting the pci setup if there is
no sdr-base would be bad.

Add a flag to ppc4xx_pciex_hwops for the backends to state if they need
SDR and then only complain and abort if they do and it's not found in
the device tree.

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
---
 arch/powerpc/sysdev/ppc4xx_pci.c |   20 ++++++++++++++------
 1 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/sysdev/ppc4xx_pci.c b/arch/powerpc/sysdev/ppc4xx_pci.c
index 16f5eba..ab3293a 100644
--- a/arch/powerpc/sysdev/ppc4xx_pci.c
+++ b/arch/powerpc/sysdev/ppc4xx_pci.c
@@ -647,6 +647,7 @@ static unsigned int ppc4xx_pciex_port_count;
 
 struct ppc4xx_pciex_hwops
 {
+	bool want_sdr;
 	int (*core_init)(struct device_node *np);
 	int (*port_init_hw)(struct ppc4xx_pciex_port *port);
 	int (*setup_utl)(struct ppc4xx_pciex_port *port);
@@ -916,6 +917,7 @@ static int ppc440speB_pciex_init_utl(struct ppc4xx_pciex_port *port)
 
 static struct ppc4xx_pciex_hwops ppc440speA_pcie_hwops __initdata =
 {
+	.want_sdr	= true,
 	.core_init	= ppc440spe_pciex_core_init,
 	.port_init_hw	= ppc440speA_pciex_init_port_hw,
 	.setup_utl	= ppc440speA_pciex_init_utl,
@@ -924,6 +926,7 @@ static struct ppc4xx_pciex_hwops ppc440speA_pcie_hwops __initdata =
 
 static struct ppc4xx_pciex_hwops ppc440speB_pcie_hwops __initdata =
 {
+	.want_sdr	= true,
 	.core_init	= ppc440spe_pciex_core_init,
 	.port_init_hw	= ppc440speB_pciex_init_port_hw,
 	.setup_utl	= ppc440speB_pciex_init_utl,
@@ -1034,6 +1037,7 @@ static int ppc460ex_pciex_init_utl(struct ppc4xx_pciex_port *port)
 
 static struct ppc4xx_pciex_hwops ppc460ex_pcie_hwops __initdata =
 {
+	.want_sdr	= true,
 	.core_init	= ppc460ex_pciex_core_init,
 	.port_init_hw	= ppc460ex_pciex_init_port_hw,
 	.setup_utl	= ppc460ex_pciex_init_utl,
@@ -1181,6 +1185,7 @@ done:
 }
 
 static struct ppc4xx_pciex_hwops ppc460sx_pcie_hwops __initdata = {
+	.want_sdr	= true,
 	.core_init	= ppc460sx_pciex_core_init,
 	.port_init_hw	= ppc460sx_pciex_init_port_hw,
 	.setup_utl	= ppc460sx_pciex_init_utl,
@@ -1276,6 +1281,7 @@ static int ppc405ex_pciex_init_utl(struct ppc4xx_pciex_port *port)
 
 static struct ppc4xx_pciex_hwops ppc405ex_pcie_hwops __initdata =
 {
+	.want_sdr	= true,
 	.core_init	= ppc405ex_pciex_core_init,
 	.port_init_hw	= ppc405ex_pciex_init_port_hw,
 	.setup_utl	= ppc405ex_pciex_init_utl,
@@ -1972,13 +1978,15 @@ static void __init ppc4xx_probe_pciex_bridge(struct device_node *np)
 	}
 
 	port->node = of_node_get(np);
-	pval = of_get_property(np, "sdr-base", NULL);
-	if (pval == NULL) {
-		printk(KERN_ERR "PCIE: missing sdr-base for %s\n",
-		       np->full_name);
-		return;
+	if (ppc4xx_pciex_hwops->want_sdr == true) {
+		pval = of_get_property(np, "sdr-base", NULL);
+		if (pval == NULL) {
+			printk(KERN_ERR "PCIE: missing sdr-base for %s\n",
+			       np->full_name);
+			return;
+		}
+		port->sdr_base = *pval;
 	}
-	port->sdr_base = *pval;
 
 	/* Check if device_type property is set to "pci" or "pci-endpoint".
 	 * Resulting from this setup this PCIe port will be configured
-- 
1.7.6.4
