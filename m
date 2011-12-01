Return-Path: <tony@bakeyournoodle.com>
From: Tony Breeds <tony@bakeyournoodle.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Josh Boyer <jwboyer@gmail.com>
Subject: [PATCH 1/8] 44x/pci: Use PCI_BASE_ADDRESS_MEM_PREFETCH rather than
 magic value.
Date: Thu,  1 Dec 2011 18:39:17 +1100
Message-Id: <1322725164-4391-2-git-send-email-tony@bakeyournoodle.com>
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

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
---
 arch/powerpc/sysdev/ppc4xx_pci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

This patch was somehow missed from the original series.

diff --git a/arch/powerpc/sysdev/ppc4xx_pci.c b/arch/powerpc/sysdev/ppc4xx_pci.c
index 862f11b..16f5eba 100644
--- a/arch/powerpc/sysdev/ppc4xx_pci.c
+++ b/arch/powerpc/sysdev/ppc4xx_pci.c
@@ -1739,7 +1739,7 @@ static void __init ppc4xx_configure_pciex_PIMs(struct ppc4xx_pciex_port *port,
 		/* Calculate window size */
 		sa = (0xffffffffffffffffull << ilog2(size));
 		if (res->flags & IORESOURCE_PREFETCH)
-			sa |= 0x8;
+			sa |= PCI_BASE_ADDRESS_MEM_PREFETCH;
 
 		if (of_device_is_compatible(port->node, "ibm,plb-pciex-460sx"))
 			sa |= PCI_BASE_ADDRESS_MEM_TYPE_64;
-- 
1.7.6.4
