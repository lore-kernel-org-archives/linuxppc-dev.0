Return-Path: <tony@bakeyournoodle.com>
From: Tony Breeds <tony@bakeyournoodle.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Josh Boyer <jwboyer@gmail.com>
Subject: [PATCH 3/8] 44x/pci: Setup the dma_window properties for each
 pci_controller
Date: Thu,  1 Dec 2011 18:39:19 +1100
Message-Id: <1322725164-4391-4-git-send-email-tony@bakeyournoodle.com>
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

Needed if you want to use swiotlb, harmless otherwise.

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
---
 arch/powerpc/sysdev/ppc4xx_pci.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/ppc4xx_pci.c b/arch/powerpc/sysdev/ppc4xx_pci.c
index ab3293a..45148ef 100644
--- a/arch/powerpc/sysdev/ppc4xx_pci.c
+++ b/arch/powerpc/sysdev/ppc4xx_pci.c
@@ -185,9 +185,15 @@ static int __init ppc4xx_parse_dma_ranges(struct pci_controller *hose,
  out:
 	dma_offset_set = 1;
 	pci_dram_offset = res->start;
+	hose->dma_window_base_cur = res->start;
+	hose->dma_window_size = resource_size(res);
 
 	printk(KERN_INFO "4xx PCI DMA offset set to 0x%08lx\n",
 	       pci_dram_offset);
+	printk(KERN_INFO "4xx PCI DMA window base to 0x%016llx\n",
+	       (unsigned long long)hose->dma_window_base_cur);
+	printk(KERN_INFO "DMA window size 0x%016llx\n",
+	       (unsigned long long)hose->dma_window_size);
 	return 0;
 }
 
-- 
1.7.6.4
