Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 24F67DE069
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 02:08:01 +1100 (EST)
Received: from ash.ozlabs.ibm.com (ta-1-1.tip.net.au [203.11.71.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by smtps.tip.net.au (Postfix) with ESMTP id 05021368002
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 02:08:00 +1100 (EST)
Date: Fri, 7 Dec 2007 01:59:01 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 14/19] [POWERPC] Inline pci_setup_pci_controller as it has
	become trivial
Message-Id: <20071207015901.4b6c80bf.sfr@canb.auug.org.au>
In-Reply-To: <20071206180045.0eb1db98.sfr@canb.auug.org.au>
References: <20071206180045.0eb1db98.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

and it becomes clear that we should use zalloc_maybe_bootmem.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/pci-common.c |   22 ++++++----------------
 1 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 0bf969e..252dd1e 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -54,27 +54,17 @@ static int global_phb_number;		/* Global phb counter */
 resource_size_t isa_mem_base    = 0;
 
 
-/*
- * pci_controller(phb) initialized common variables.
- */
-static void __devinit pci_setup_pci_controller(struct pci_controller *hose)
-{
-	memset(hose, 0, sizeof(struct pci_controller));
-
-	spin_lock(&hose_spinlock);
-	hose->global_number = global_phb_number++;
-	list_add_tail(&hose->list_node, &hose_list);
-	spin_unlock(&hose_spinlock);
-}
-
-struct pci_controller * pcibios_alloc_controller(struct device_node *dev)
+struct pci_controller *pcibios_alloc_controller(struct device_node *dev)
 {
 	struct pci_controller *phb;
 
-	phb = alloc_maybe_bootmem(sizeof(struct pci_controller), GFP_KERNEL);
+	phb = zalloc_maybe_bootmem(sizeof(struct pci_controller), GFP_KERNEL);
 	if (phb == NULL)
 		return NULL;
-	pci_setup_pci_controller(phb);
+	spin_lock(&hose_spinlock);
+	phb->global_number = global_phb_number++;
+	list_add_tail(&phb->list_node, &hose_list);
+	spin_unlock(&hose_spinlock);
 	phb->arch_data = dev;
 	phb->is_dynamic = mem_init_done;
 #ifdef CONFIG_PPC64
-- 
1.5.3.7


-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
