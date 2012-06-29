Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e1.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3E613B700D
 for <linuxppc-dev@ozlabs.org>; Fri, 29 Jun 2012 16:48:03 +1000 (EST)
Received: from /spool/local
 by e1.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Fri, 29 Jun 2012 02:48:00 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q5T6lvc45636534
 for <linuxppc-dev@ozlabs.org>; Fri, 29 Jun 2012 02:47:57 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q5T6lu2D001102
 for <linuxppc-dev@ozlabs.org>; Fri, 29 Jun 2012 03:47:57 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 3/7] pci: make find_pci_host_bridge global
Date: Fri, 29 Jun 2012 14:47:46 +0800
Message-Id: <5cc19d49348943cd7986fa74558e3b82cc60de73.1340949637.git.shangw@linux.vnet.ibm.com>
In-Reply-To: <cover.1340949637.git.shangw@linux.vnet.ibm.com>
References: <cover.1340949637.git.shangw@linux.vnet.ibm.com>
In-Reply-To: <cover.1340949637.git.shangw@linux.vnet.ibm.com>
References: <cover.1340949637.git.shangw@linux.vnet.ibm.com>
Cc: bhelgaas@google.com, yinghai@kernel.org,
 Gavin Shan <shangw@linux.vnet.ibm.com>, linuxram@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch makes function find_pci_host_bridge() global so that the
platforms (e.g. PPC) can access pci_host_bridge.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 drivers/pci/host-bridge.c |    2 +-
 include/linux/pci.h       |    1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
index fc16357..a43d393 100644
--- a/drivers/pci/host-bridge.c
+++ b/drivers/pci/host-bridge.c
@@ -17,7 +17,7 @@ static struct pci_bus *find_pci_root_bus(struct pci_bus *bus)
 	return bus;
 }
 
-static struct pci_host_bridge *find_pci_host_bridge(struct pci_bus *bus)
+struct pci_host_bridge *find_pci_host_bridge(struct pci_bus *bus)
 {
 	struct pci_bus *root_bus = find_pci_root_bus(bus);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index fefb4e1..615ac90 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -385,6 +385,7 @@ struct pci_host_bridge {
 };
 
 #define	to_pci_host_bridge(n) container_of(n, struct pci_host_bridge, dev)
+struct pci_host_bridge *find_pci_host_bridge(struct pci_bus *bus);
 void pci_set_host_bridge_release(struct pci_host_bridge *bridge,
 		     void (*release_fn)(struct pci_host_bridge *),
 		     void *release_data);
-- 
1.7.9.5
