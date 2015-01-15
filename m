Return-Path: <yinghai@kernel.org>
Received: from aserp1050.oracle.com (aserp1050.oracle.com [141.146.126.70])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 39F7D1A0D8B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 15:34:56 +1100 (AEDT)
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by aserp1050.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id
 t0F4YrlR018281
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 04:34:54 GMT
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 09/10] PCI,
 powerpc: clip firmware assigned resource under parent bridge's
Date: Wed, 14 Jan 2015 20:31:36 -0800
Message-Id: <1421296297-6371-10-git-send-email-yinghai@kernel.org>
In-Reply-To: <1421296297-6371-1-git-send-email-yinghai@kernel.org>
References: <1421296297-6371-1-git-send-email-yinghai@kernel.org>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Andrew Murray <amurray@embedded-bits.co.uk>,
 Sebastian Ott <sebott@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>, linux-pci@vger.kernel.org,
 Yinghai Lu <yinghai@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some bios put range that is not fully coverred by root bus resources.
Try to clip them and update them in pci bridge bars.

We'd like to fix other arches instead of just x86.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=85491
Reported-by: Marek Kordik <kordikmarek@gmail.com>
Fixes: 5b28541552ef ("PCI: Restrict 64-bit prefetchable bridge windows to 64-bit resources")
Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: Anton Blanchard <anton@samba.org>
Cc: Sebastian Ott <sebott@linux.vnet.ibm.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: Andrew Murray <amurray@embedded-bits.co.uk>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/kernel/pci-common.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 37d512d..2a525c9 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1184,6 +1184,8 @@ static void pcibios_allocate_bus_resources(struct pci_bus *bus)
 			 pr, (pr && pr->name) ? pr->name : "nil");
 
 		if (pr && !(pr->flags & IORESOURCE_UNSET)) {
+			struct pci_dev *dev = bus->self;
+
 			if (request_resource(pr, res) == 0)
 				continue;
 			/*
@@ -1193,6 +1195,11 @@ static void pcibios_allocate_bus_resources(struct pci_bus *bus)
 			 */
 			if (reparent_resources(pr, res) == 0)
 				continue;
+
+			if (dev && i < PCI_BRIDGE_RESOURCE_NUM &&
+			    pci_claim_bridge_resource(dev,
+						i + PCI_BRIDGE_RESOURCES) == 0)
+				continue;
 		}
 		pr_warning("PCI: Cannot allocate resource region "
 			   "%d of PCI bridge %d, will remap\n", i, bus->number);
@@ -1401,7 +1408,10 @@ void pcibios_claim_one_bus(struct pci_bus *bus)
 				 (unsigned long long)r->end,
 				 (unsigned int)r->flags);
 
-			pci_claim_resource(dev, i);
+			if (pci_claim_resource(dev, i) == 0)
+				continue;
+
+			pci_claim_bridge_resource(dev, i);
 		}
 	}
 
-- 
1.8.4.5
