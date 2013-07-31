Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D32F62C00A1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2013 18:44:07 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 31 Jul 2013 04:44:04 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 47284C9003E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2013 04:44:00 -0400 (EDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6V8i1jC190880
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2013 04:44:01 -0400
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r6V8i1Yb019312
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2013 02:44:01 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/pci: Remove duplicate check in pcibios_fixup_bus()
Date: Wed, 31 Jul 2013 16:43:56 +0800
Message-Id: <1375260236-20689-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

pci_read_bridge_bases() already checks if the PCI bus is root
bus or not, so we needn't do same check in pcibios_fixup_bus()
and just remove it.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/pci-common.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 7d22a67..c55fb35 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1055,8 +1055,7 @@ void pcibios_fixup_bus(struct pci_bus *bus)
 	 * bases. This is -not- called when generating the PCI tree from
 	 * the OF device-tree.
 	 */
-	if (bus->self != NULL)
-		pci_read_bridge_bases(bus);
+	pci_read_bridge_bases(bus);
 
 	/* Now fixup the bus bus */
 	pcibios_setup_bus_self(bus);
-- 
1.7.5.4
