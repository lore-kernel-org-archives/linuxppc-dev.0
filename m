Return-Path: <brking@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0883E2C0169
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Apr 2013 23:05:24 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <brking@linux.vnet.ibm.com>;
 Mon, 8 Apr 2013 07:05:21 -0600
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id CE21138C801A
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Apr 2013 09:05:12 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r38D5CI5242374
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Apr 2013 09:05:12 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r38D58CY000508
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Apr 2013 09:05:09 -0400
Message-Id: <201304081305.r38D5765032748@d01av04.pok.ibm.com>
Subject: [PATCH 1/2] pci: Set dev->dev.type in alloc_pci_dev
To: linux-pci@vger.kernel.org
From: Brian King <brking@linux.vnet.ibm.com>
Date: Mon, 08 Apr 2013 08:05:07 -0500
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


Set dev->dev.type in alloc_pci_dev so that archs that have their own
versions of pci_setup_device get this set properly in order to ensure
things like the boot_vga sysfs parameter get created as expected.

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
---

 drivers/pci/probe.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/pci/probe.c~pci_set_dev_type_early drivers/pci/probe.c
--- linux/drivers/pci/probe.c~pci_set_dev_type_early	2013-04-08 06:12:51.000000000 -0500
+++ linux-bjking1/drivers/pci/probe.c	2013-04-08 06:14:33.000000000 -0500
@@ -988,7 +988,6 @@ int pci_setup_device(struct pci_dev *dev
 	dev->sysdata = dev->bus->sysdata;
 	dev->dev.parent = dev->bus->bridge;
 	dev->dev.bus = &pci_bus_type;
-	dev->dev.type = &pci_dev_type;
 	dev->hdr_type = hdr_type & 0x7f;
 	dev->multifunction = !!(hdr_type & 0x80);
 	dev->error_state = pci_channel_io_normal;
@@ -1208,6 +1207,7 @@ struct pci_dev *alloc_pci_dev(void)
 		return NULL;
 
 	INIT_LIST_HEAD(&dev->bus_list);
+	dev->dev.type = &pci_dev_type;
 
 	return dev;
 }
_
