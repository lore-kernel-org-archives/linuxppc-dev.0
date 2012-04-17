Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp02.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D274FB704A
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Apr 2012 15:55:54 +1000 (EST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 17 Apr 2012 11:25:52 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q3H5tgcN3260570
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Apr 2012 11:25:42 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q3HBOu0K004295
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Apr 2012 21:24:57 +1000
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/eeh: crash caused by null eeh_dev
Date: Tue, 17 Apr 2012 13:55:39 +0800
Message-Id: <1334642139-25447-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: anton@samba.org, Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The problem was reported by Anton Blanchard. While EEH error
happened to the PCI device without the corresponding device
driver, kernel crash was seen. Eventually, I successfully
reproduced the problem on Firebird-L machine with utility
"errinjct". Initially, the device driver for Emulex ethernet
MAC has been disabled from .config and force data parity on
the Emulex ethernet MAC with help of "errinjct". Eventually,
I saw the kernel crash after issueing couple of "lspci -v"
command.

The root cause behind is that the PCI device, including the
reference to the corresponding eeh device, will be removed
from the system while EEH does recovery. Afterwards, the
PCI device will be probed again and added into the system
accordingly. So it's not safe to retrieve the eeh device from
the corresponding PCI device after the PCI device has been removed
and not added again.

The patch fixes the issue and retrieve the eeh device from OF node
instead of PCI device after the PCI device has been removed.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/eeh.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platforms/pseries/eeh.c
index 309d38e..a75e37d 100644
--- a/arch/powerpc/platforms/pseries/eeh.c
+++ b/arch/powerpc/platforms/pseries/eeh.c
@@ -1076,7 +1076,7 @@ static void eeh_add_device_late(struct pci_dev *dev)
 	pr_debug("EEH: Adding device %s\n", pci_name(dev));
 
 	dn = pci_device_to_OF_node(dev);
-	edev = pci_dev_to_eeh_dev(dev);
+	edev = of_node_to_eeh_dev(dn);
 	if (edev->pdev == dev) {
 		pr_debug("EEH: Already referenced !\n");
 		return;
-- 
1.7.5.4
