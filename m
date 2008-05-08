Return-Path: <ncase@xes-inc.com>
Received: from xes-mad.com (xes-mad.com [216.165.139.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7050BDDDFB
	for <linuxppc-dev@ozlabs.org>; Fri,  9 May 2008 09:26:36 +1000 (EST)
Received: from [10.52.0.27] (natec.xes-mad.com [10.52.0.27])
	by xes-mad.com (8.13.8/8.13.8) with ESMTP id m48NQWYK031276
	for <linuxppc-dev@ozlabs.org>; Thu, 8 May 2008 18:26:33 -0500
Subject: [PATCH] POWERPC: Support ISA legacy addresses in
	of_address_to_resource()
From: Nate Case <ncase@xes-inc.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Thu, 08 May 2008 18:26:32 -0500
Message-Id: <1210289192.13845.281.camel@localhost.localdomain>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When mapping an open firmware device tree node to a resource,
check if the device is on the "isa" legacy bus.  In this case,
pci_address_to_pio() should not be used since that function is only
for addresses above the 64KB reserved region.

This was necessary to get IPMI working on a board that accesses
the IPMI controller via the legacy I/O region.

Signed-off-by: Nate Case <ncase@xes-inc.com>
---
 arch/powerpc/kernel/prom_parse.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/prom_parse.c b/arch/powerpc/kernel/prom_parse.c
index 90eb3a3..28d354d 100644
--- a/arch/powerpc/kernel/prom_parse.c
+++ b/arch/powerpc/kernel/prom_parse.c
@@ -622,7 +622,15 @@ static int __of_address_to_resource(struct device_node *dev, const u32 *addrp,
 	memset(r, 0, sizeof(struct resource));
 	if (flags & IORESOURCE_IO) {
 		unsigned long port;
-		port = pci_address_to_pio(taddr);
+		struct device_node *parent;
+
+		parent = of_get_parent(dev);
+		if (of_bus_isa_match(parent))
+			port = (unsigned long) taddr;
+		else
+			port = pci_address_to_pio(taddr);
+		of_node_put(parent);
+
 		if (port == (unsigned long)-1)
 			return -EINVAL;
 		r->start = port;
-- 
1.5.4.4
