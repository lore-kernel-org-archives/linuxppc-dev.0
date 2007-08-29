Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 365B8DDEDE
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Aug 2007 02:47:50 +1000 (EST)
Date: Wed, 29 Aug 2007 11:47:43 -0500
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH 7/9] bootwrapper: Only print MAC addresses when the node is
	actually present.
Message-ID: <20070829164743.GE31640@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070829164534.GA31585@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Some firmwares (such as PlanetCore) only provide a base MAC address, and
expect the kernel to set certain bits to generate the addresses for the
other ports.  As such, MAC addresses are generated that may not correspond
to actual hardware.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/devtree.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/boot/devtree.c b/arch/powerpc/boot/devtree.c
index e1b8122..549463b 100644
--- a/arch/powerpc/boot/devtree.c
+++ b/arch/powerpc/boot/devtree.c
@@ -100,12 +100,14 @@ void __dt_fixup_mac_addresses(u32 startindex, ...)
 		devp = find_node_by_prop_value(NULL, "linux,network-index",
 					       (void*)&index, sizeof(index));
 
-		printf("ENET%d: local-mac-address <-"
-		       " %02x:%02x:%02x:%02x:%02x:%02x\n\r", index,
-		       addr[0], addr[1], addr[2], addr[3], addr[4], addr[5]);
+		if (devp) {
+			printf("ENET%d: local-mac-address <-"
+			       " %02x:%02x:%02x:%02x:%02x:%02x\n\r", index,
+			       addr[0], addr[1], addr[2],
+			       addr[3], addr[4], addr[5]);
 
-		if (devp)
 			setprop(devp, "local-mac-address", addr, 6);
+		}
 
 		index++;
 	}
-- 
1.5.0.3
