Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 24CC9DE284
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 02:08:03 +1100 (EST)
Received: from ash.ozlabs.ibm.com (ta-1-1.tip.net.au [203.11.71.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by smtps.tip.net.au (Postfix) with ESMTP id 0625D368002
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 02:08:03 +1100 (EST)
Date: Fri, 7 Dec 2007 02:04:33 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 18/19] [POWERPC] Don't special case pci_domain_nr() for iSeries
Message-Id: <20071207020433.96653b94.sfr@canb.auug.org.au>
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


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/pci-common.c     |    9 ++-------
 arch/powerpc/platforms/iseries/pci.c |    2 ++
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 252dd1e..e0d4a2a 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -118,15 +118,10 @@ int pcibios_vaddr_is_ioport(void __iomem *address)
  */
 int pci_domain_nr(struct pci_bus *bus)
 {
-	if (firmware_has_feature(FW_FEATURE_ISERIES))
-		return 0;
-	else {
-		struct pci_controller *hose = pci_bus_to_host(bus);
+	struct pci_controller *hose = pci_bus_to_host(bus);
 
-		return hose->global_number;
-	}
+	return hose->global_number;
 }
-
 EXPORT_SYMBOL(pci_domain_nr);
 
 #ifdef CONFIG_PPC_OF
diff --git a/arch/powerpc/platforms/iseries/pci.c b/arch/powerpc/platforms/iseries/pci.c
index db0a17e..3071a30 100644
--- a/arch/powerpc/platforms/iseries/pci.c
+++ b/arch/powerpc/platforms/iseries/pci.c
@@ -673,6 +673,8 @@ void __init iSeries_pcibios_init(void)
 		phb = pcibios_alloc_controller(node);
 		if (phb == NULL)
 			continue;
+		/* All legacy iSeries PHBs are in domain zero */
+		phb->global_number = 0;
 
 		phb->pci_mem_offset = bus;
 		phb->first_busno = bus;
-- 
1.5.3.7

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
