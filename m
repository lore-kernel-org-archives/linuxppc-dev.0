Return-Path: <brking@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e32.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1C2AC2C0099
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Apr 2013 08:58:22 +1100 (EST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <brking@linux.vnet.ibm.com>;
 Thu, 4 Apr 2013 15:58:19 -0600
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
 [9.17.195.227])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 3430BC40002
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2013 15:53:18 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r34LwGAY159008
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Apr 2013 15:58:16 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r34LwGAg010682
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Apr 2013 15:58:16 -0600
Message-Id: <201304042158.r34LwEOV010607@d03av02.boulder.ibm.com>
Subject: [PATCH 2/3] powerpc: Enable boot_vga sysfs attribute for graphics
 adapters on Power
To: linux-pci@vger.kernel.org
From: Brian King <brking@linux.vnet.ibm.com>
Date: Thu, 04 Apr 2013 16:58:15 -0500
Cc: klebers@linux.vnet.ibm.com, brking@linux.vnet.ibm.com,
 lucaskt@linux.vnet.ibm.com, bhelgaas@google.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Initialize dev->dev.type such that the PCI group attributes for boot_vga
and SR-IOV can be displayed if appropriate. This fixes an issue seen on
Power preventing X from auto initializing a graphics adapter when using KMS.

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
---

 arch/powerpc/kernel/pci_of_scan.c |    1 +
 1 file changed, 1 insertion(+)

diff -puN arch/powerpc/kernel/pci_of_scan.c~powerpc_set_pci_dev_type arch/powerpc/kernel/pci_of_scan.c
--- linux/arch/powerpc/kernel/pci_of_scan.c~powerpc_set_pci_dev_type	2013-04-03 09:43:19.000000000 -0500
+++ linux-bjking1/arch/powerpc/kernel/pci_of_scan.c	2013-04-03 09:43:19.000000000 -0500
@@ -141,6 +141,7 @@ struct pci_dev *of_create_pci_dev(struct
 	dev->dev.of_node = of_node_get(node);
 	dev->dev.parent = bus->bridge;
 	dev->dev.bus = &pci_bus_type;
+	dev->dev.type = &pci_dev_type;
 	dev->devfn = devfn;
 	dev->multifunction = 0;		/* maybe a lie? */
 	dev->needs_freset = 0;		/* pcie fundamental reset required */
_
