Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 65DAB2C00C6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 21:11:10 +1000 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 23 Jul 2013 12:11:06 +0100
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 83CED38C8039
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 07:11:03 -0400 (EDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6NBB41f166240
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 07:11:04 -0400
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r6NBB3SH029391
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 05:11:04 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 04/11] PCI/hotplug: Needn't remove EEH cache again
Date: Tue, 23 Jul 2013 19:10:49 +0800
Message-Id: <1374577856-1712-5-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1374577856-1712-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1374577856-1712-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since pcibios_release_device() called by pci_stop_and_remove_bus_device()
has removed the EEH cache, we needn't do that again.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 drivers/pci/hotplug/rpadlpar_core.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/hotplug/rpadlpar_core.c b/drivers/pci/hotplug/rpadlpar_core.c
index b29e20b..bb7af78 100644
--- a/drivers/pci/hotplug/rpadlpar_core.c
+++ b/drivers/pci/hotplug/rpadlpar_core.c
@@ -388,7 +388,6 @@ int dlpar_remove_pci_slot(char *drc_name, struct device_node *dn)
 	/* Remove the EADS bridge device itself */
 	BUG_ON(!bus->self);
 	pr_debug("PCI: Now removing bridge device %s\n", pci_name(bus->self));
-	eeh_remove_bus_device(bus->self, true);
 	pci_stop_and_remove_bus_device(bus->self);
 
 	return 0;
-- 
1.7.5.4
