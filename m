Return-Path: <cascardo@linux.vnet.ibm.com>
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e24smtp02.br.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7526FB6EEC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2012 06:10:35 +1100 (EST)
Received: from /spool/local
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cascardo@linux.vnet.ibm.com>;
 Wed, 11 Jan 2012 17:10:25 -0200
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay01.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q0BJ6j6a2736184
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jan 2012 16:06:45 -0300
Received: from d24av03.br.ibm.com (loopback [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q0BJAUdW030168
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jan 2012 17:10:31 -0200
From: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH] ppc/eeh: fix crash when error happens during device probe
Date: Wed, 11 Jan 2012 17:09:58 -0200
Message-Id: <1326308998-24263-1-git-send-email-cascardo@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 linux-kernel@vger.kernel.org,
 Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

EEH may happen during a PCI driver probe. If the driver is trying to
access some register in a loop, the EEH code will try to print the
driver name. But the driver pointer in struct pci_dev is not set until
probe returns successfully.

Use a function to test if the device and the driver pointer is NULL
before accessing the driver's name.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/ppc-pci.h   |    5 +++++
 arch/powerpc/platforms/pseries/eeh.c |    4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc-pci.h b/arch/powerpc/include/asm/ppc-pci.h
index 43268f1..6d42297 100644
--- a/arch/powerpc/include/asm/ppc-pci.h
+++ b/arch/powerpc/include/asm/ppc-pci.h
@@ -142,6 +142,11 @@ static inline const char *eeh_pci_name(struct pci_dev *pdev)
 	return pdev ? pci_name(pdev) : "<null>";
 } 
 
+static inline const char *eeh_driver_name(struct pci_dev *pdev)
+{
+	return (pdev && pdev->driver) ? pdev->driver->name : "<null>";
+}
+
 #endif /* CONFIG_EEH */
 
 #else /* CONFIG_PCI */
diff --git a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platforms/pseries/eeh.c
index 5658690..c0b40af 100644
--- a/arch/powerpc/platforms/pseries/eeh.c
+++ b/arch/powerpc/platforms/pseries/eeh.c
@@ -551,9 +551,9 @@ int eeh_dn_check_failure(struct device_node *dn, struct pci_dev *dev)
 			printk (KERN_ERR "EEH: %d reads ignored for recovering device at "
 				"location=%s driver=%s pci addr=%s\n",
 				pdn->eeh_check_count, location,
-				dev->driver->name, eeh_pci_name(dev));
+				eeh_driver_name(dev), eeh_pci_name(dev));
 			printk (KERN_ERR "EEH: Might be infinite loop in %s driver\n",
-				dev->driver->name);
+				eeh_driver_name(dev));
 			dump_stack();
 		}
 		goto dn_unlock;
-- 
1.7.4.4
