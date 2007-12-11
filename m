Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id AF1A3DDF3C
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Dec 2007 11:06:28 +1100 (EST)
Received: from ash.ozlabs.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by smtps.tip.net.au (Postfix) with ESMTP id 13C73368003
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Dec 2007 11:06:27 +1100 (EST)
Date: Tue, 11 Dec 2007 11:02:07 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 14/19] [POWERPC] Inline pci_setup_pci_controller as it has
	become trivial
Message-Id: <20071211110207.0bff605d.sfr@canb.auug.org.au>
In-Reply-To: <20071207015901.4b6c80bf.sfr@canb.auug.org.au>
References: <20071206180045.0eb1db98.sfr@canb.auug.org.au>
	<20071207015901.4b6c80bf.sfr@canb.auug.org.au>
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
 arch/powerpc/kernel/pci-common.c |   21 ++++++---------------
 1 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 15ec71a..78cdb70 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -50,27 +50,18 @@ static DEFINE_SPINLOCK(hose_spinlock);
 /* XXX kill that some day ... */
 static int global_phb_number;		/* Global phb counter */
 
-/*
- * pci_controller(phb) initialized common variables.
- */
-static void __devinit pci_setup_pci_controller(struct pci_controller *hose)
-{
-	memset(hose, 0, sizeof(struct pci_controller));
 
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
