Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e38.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3CBC92C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jul 2013 12:14:34 +1000 (EST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 17 Jul 2013 20:14:32 -0600
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
 [9.17.195.107])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id B368819D8036
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jul 2013 20:14:19 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6I2EUEk154170
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jul 2013 20:14:30 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r6I2ETra028559
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jul 2013 20:14:30 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 04/10] PCI/hotplug: Needn't remove EEH cache again
Date: Thu, 18 Jul 2013 10:14:14 +0800
Message-Id: <1374113660-15347-5-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1374113660-15347-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1374113660-15347-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
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
