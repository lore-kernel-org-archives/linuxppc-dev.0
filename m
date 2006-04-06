Return-Path: <linas@austin.ibm.com>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6568B67B14
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Apr 2006 07:36:35 +1000 (EST)
Received: from e6.ny.us.ibm.com ([192.168.1.106])
	by pokfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k36Kfq4f013539
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Apr 2006 16:41:52 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k36KfgCu014343
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Apr 2006 16:41:42 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k36KfguK219602
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Apr 2006 16:41:42 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k36KfgC2025837
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Apr 2006 16:41:42 -0400
Date: Thu, 6 Apr 2006 15:41:41 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH]: powerpc/pseries: bugfix: balance calls to pci_device_put
Message-ID: <20060406204141.GA27256@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


[PATCH]: powerpc/pseries: bugfix: balance calls to pci_device_put 

Repeated calls to eeh_remove_device() can result in multiple
(and thus unbalanced) calls to pci_dev_put(). Make sure the
pci_device_put() is called only once (since there was only 
one call to the matching pci_device_get()).

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 arch/powerpc/platforms/pseries/eeh.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

Index: linux-2.6.17-rc1/arch/powerpc/platforms/pseries/eeh.c
===================================================================
--- linux-2.6.17-rc1.orig/arch/powerpc/platforms/pseries/eeh.c	2006-04-06 15:35:55.000000000 -0500
+++ linux-2.6.17-rc1/arch/powerpc/platforms/pseries/eeh.c	2006-04-06 15:38:04.968433419 -0500
@@ -957,8 +957,10 @@ static void eeh_remove_device(struct pci
 	pci_addr_cache_remove_device(dev);
 
 	dn = pci_device_to_OF_node(dev);
-	PCI_DN(dn)->pcidev = NULL;
-	pci_dev_put (dev);
+	if (PCI_DN(dn)->pcidev) {
+		PCI_DN(dn)->pcidev = NULL;
+		pci_dev_put (dev);
+	}
 }
 
 void eeh_remove_bus_device(struct pci_dev *dev)
