Return-Path: <beckyb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E36FADDFEC
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2009 02:27:03 +1000 (EST)
From: Becky Bruce <beckyb@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org, fujita.tomonori@lab.ntt.co.jp
Subject: [PATCH 3/5] powerpc: make dma_window_* in pci_controller struct avail
	on 32b
Date: Mon, 20 Apr 2009 11:26:48 -0500
Message-Id: <1240244810-32193-6-git-send-email-beckyb@kernel.crashing.org>
In-Reply-To: <1240244810-32193-5-git-send-email-beckyb@kernel.crashing.org>
References: <1240244810-32193-1-git-send-email-beckyb@kernel.crashing.org>
	<1240244810-32193-2-git-send-email-beckyb@kernel.crashing.org>
	<1240244810-32193-3-git-send-email-beckyb@kernel.crashing.org>
	<1240244810-32193-4-git-send-email-beckyb@kernel.crashing.org>
	<1240244810-32193-5-git-send-email-beckyb@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Also, convert them to resource_size_t (which is unsigned long
on 64-bit, so it's not a change there).

We will be using these on fsl 32b to indicate the start and size
address of memory that the pci controller can actually reach - this
is needed to determine if an address requires bounce buffering.  For
now, initialize them to a standard value; in the near future, the
value will be calculated based on how the inbound windows are
programmed.

Signed-off-by: Becky Bruce <beckyb@kernel.crashing.org>
---
 arch/powerpc/include/asm/pci-bridge.h |    6 ++++--
 arch/powerpc/sysdev/fsl_pci.c         |    4 ++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 84007af..9861258 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -140,10 +140,12 @@ struct pci_controller {
 	struct resource	io_resource;
 	struct resource mem_resources[3];
 	int global_number;		/* PCI domain number */
+
+	resource_size_t dma_window_base_cur;
+	resource_size_t dma_window_size;
+
 #ifdef CONFIG_PPC64
 	unsigned long buid;
-	unsigned long dma_window_base_cur;
-	unsigned long dma_window_size;
 
 	void *private_data;
 #endif	/* CONFIG_PPC64 */
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 78021d8..376603d 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -152,6 +152,10 @@ static void __init setup_pci_atmu(struct pci_controller *hose,
 	out_be32(&pci->piw[2].piwbar,0x00000000);
 	out_be32(&pci->piw[2].piwar, PIWAR_2G);
 
+	/* Save the base address and size covered by inbound window mappings */
+	hose->dma_window_base_cur = 0x00000000;
+	hose->dma_window_size = 0x80000000;
+
 	iounmap(pci);
 }
 
-- 
1.6.0.6
