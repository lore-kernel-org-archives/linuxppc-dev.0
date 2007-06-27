Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EECCBDDF54
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2007 04:19:21 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/8] [POWERPC] Remove local_number from pci_controller
Date: Wed, 27 Jun 2007 13:19:12 -0500
Message-Id: <11829683612573-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <11829683604166-git-send-email-galak@kernel.crashing.org>
References: <11829683583721-git-send-email-galak@kernel.crashing.org>
	<11829683604166-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We never actually read local_number so lets just remove it.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/platforms/iseries/pci.c |    2 +-
 include/asm-powerpc/pci-bridge.h     |    1 -
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/iseries/pci.c b/arch/powerpc/platforms/iseries/pci.c
index 23d8762..da87162 100644
--- a/arch/powerpc/platforms/iseries/pci.c
+++ b/arch/powerpc/platforms/iseries/pci.c
@@ -768,7 +768,7 @@ void __init iSeries_pcibios_init(void)
 		if (phb == NULL)
 			continue;
 
-		phb->pci_mem_offset = phb->local_number = bus;
+		phb->pci_mem_offset = bus;
 		phb->first_busno = bus;
 		phb->last_busno = bus;
 		phb->ops = &iSeries_pci_ops;
diff --git a/include/asm-powerpc/pci-bridge.h b/include/asm-powerpc/pci-bridge.h
index b032593..229ead9 100644
--- a/include/asm-powerpc/pci-bridge.h
+++ b/include/asm-powerpc/pci-bridge.h
@@ -146,7 +146,6 @@ struct pci_controller {
 	struct resource io_resource;
 	struct resource mem_resources[3];
 	int global_number;
-	int local_number;
 	unsigned long buid;
 	unsigned long dma_window_base_cur;
 	unsigned long dma_window_size;
-- 
1.5.2.1
