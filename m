Return-Path: <tony@bakeyournoodle.com>
From: Tony Breeds <tony@bakeyournoodle.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Josh Boyer <jwboyer@gmail.com>
Subject: [PATCH 1/6] 44x/pci: Continue pci setup even if there is no sdr-base
 in the device-tree
Date: Wed, 30 Nov 2011 16:23:55 +1100
Message-Id: <1322630640-13708-2-git-send-email-tony@bakeyournoodle.com>
In-Reply-To: <1322630640-13708-1-git-send-email-tony@bakeyournoodle.com>
References: <1322630640-13708-1-git-send-email-tony@bakeyournoodle.com>
Cc: LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
---
 arch/powerpc/sysdev/ppc4xx_pci.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/sysdev/ppc4xx_pci.c b/arch/powerpc/sysdev/ppc4xx_pci.c
index 16f5eba..d3fa380 100644
--- a/arch/powerpc/sysdev/ppc4xx_pci.c
+++ b/arch/powerpc/sysdev/ppc4xx_pci.c
@@ -1974,11 +1974,11 @@ static void __init ppc4xx_probe_pciex_bridge(struct device_node *np)
 	port->node = of_node_get(np);
 	pval = of_get_property(np, "sdr-base", NULL);
 	if (pval == NULL) {
-		printk(KERN_ERR "PCIE: missing sdr-base for %s\n",
+		printk(KERN_INFO "PCIE: missing sdr-base for %s\n",
 		       np->full_name);
-		return;
+	} else {
+		port->sdr_base = *pval;
 	}
-	port->sdr_base = *pval;
 
 	/* Check if device_type property is set to "pci" or "pci-endpoint".
 	 * Resulting from this setup this PCIe port will be configured
-- 
1.7.6.4
