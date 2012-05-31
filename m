Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7D330B6FD9
 for <linuxppc-dev@ozlabs.org>; Thu, 31 May 2012 16:17:49 +1000 (EST)
Received: from /spool/local
 by e1.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Thu, 31 May 2012 02:17:47 -0400
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 4F90C6E8049
 for <linuxppc-dev@ozlabs.org>; Thu, 31 May 2012 02:17:35 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q4V6HZwU25952428
 for <linuxppc-dev@ozlabs.org>; Thu, 31 May 2012 02:17:35 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q4VBmQX2028377
 for <linuxppc-dev@ozlabs.org>; Thu, 31 May 2012 07:48:27 -0400
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/pci: cleanup on duplicate assignment
Date: Thu, 31 May 2012 14:17:29 +0800
Message-Id: <1338445049-20520-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: michael@ellerman.id.au, Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

While creating the PCI root bus through function pci_create_root_bus()
of PCI core, it should have assigned the secondary bus number for the
newly created PCI root bus. Thus we needn't do the explicit assignment
for the secondary bus number again in pcibios_scan_phb().

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/pci-common.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 8e78e93..0f75bd5 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1646,7 +1646,6 @@ void __devinit pcibios_scan_phb(struct pci_controller *hose)
 		pci_free_resource_list(&resources);
 		return;
 	}
-	bus->secondary = hose->first_busno;
 	hose->bus = bus;
 
 	/* Get probe mode and perform scan */
-- 
1.7.9.5
