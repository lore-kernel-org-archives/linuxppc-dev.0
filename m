Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id ACC4ADDF69
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Dec 2007 11:06:31 +1100 (EST)
Received: from ash.ozlabs.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by smtps.tip.net.au (Postfix) with ESMTP id AF4F5368003
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Dec 2007 11:06:30 +1100 (EST)
Date: Tue, 11 Dec 2007 11:03:48 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 16/19] [POWERPC] iSeries: hose->buid is always zero for iSeries
Message-Id: <20071211110348.d08457cc.sfr@canb.auug.org.au>
In-Reply-To: <20071207020155.3466763a.sfr@canb.auug.org.au>
References: <20071206180045.0eb1db98.sfr@canb.auug.org.au>
	<20071207020155.3466763a.sfr@canb.auug.org.au>
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

so remove a firmware feature test.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/pci_64.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index 69364f3..7e74aa2 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -581,12 +581,8 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
 /* Decide whether to display the domain number in /proc */
 int pci_proc_domain(struct pci_bus *bus)
 {
-	if (firmware_has_feature(FW_FEATURE_ISERIES))
-		return 0;
-	else {
-		struct pci_controller *hose = pci_bus_to_host(bus);
-		return hose->buid != 0;
-	}
+	struct pci_controller *hose = pci_bus_to_host(bus);
+	return hose->buid != 0;
 }
 
 void __devinit pci_process_bridge_OF_ranges(struct pci_controller *hose,
-- 
1.5.3.7

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
