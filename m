Return-Path: <aik@ozlabs.ru>
Received: from mail-ie0-f179.google.com (mail-ie0-f179.google.com
 [209.85.223.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9E5992C009A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Nov 2012 13:51:32 +1100 (EST)
Received: by mail-ie0-f179.google.com with SMTP id 9so3451867iec.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Nov 2012 18:51:29 -0800 (PST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc/pseries: Fix kernel crash caused by NULL PE
Date: Fri, 23 Nov 2012 13:51:10 +1100
Message-Id: <1353639070-11195-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>, linuxppc-dev@lists.ozlabs.org,
 Gavin Shan <shangw@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Gavin Shan <shangw@linux.vnet.ibm.com>

While hooking MSI interrupts, the corresponding device tree node
of the PE that the PCI device has been put into should be checked.
However, those PCI devices (e.g. VirtIO based PCI devices) that
don't have EEH capability shouldn't have the associated PE. So we
shouldn't try to get the PE's device tree node. Otherwise, it
would cause kernel crash.

Actually, it was introduced by commit 66523d9f ("powerpc/eeh: Trace
error based on PE from beginning").

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/msi.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
index d19f497..9284e42 100644
--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -218,9 +218,16 @@ static struct device_node *find_pe_dn(struct pci_dev *dev, int *total)
 	if (!dn)
 		return NULL;
 
-	/* Get the top level device in the PE */
+	/*
+	 * Get the top level device in the PE, but some PCI devices
+	 * without EEH capability (e.g. VirtIO based PCI devices)
+	 * don't have the associated PE. So we should not get the
+	 * top level device from PE for those PCI devices.
+	 */
 	edev = of_node_to_eeh_dev(dn);
-	edev = list_first_entry(&edev->pe->edevs, struct eeh_dev, list);
+	if (edev->pe)
+		edev = list_first_entry(&edev->pe->edevs,
+				struct eeh_dev, list);
 	dn = eeh_dev_to_of_node(edev);
 	if (!dn)
 		return NULL;
-- 
1.7.5.4
