Return-Path: <grant.likely@secretlab.ca>
Received: from pd4mo2so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id BA279DDE49
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Aug 2007 06:27:04 +1000 (EST)
Received: from pd3mr5so.prod.shaw.ca (pd3mr5so-qfe3.prod.shaw.ca [10.0.141.12])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JNL0045GSS124A0@l-daemon> for linuxppc-dev@ozlabs.org;
	Thu, 30 Aug 2007 14:26:25 -0600 (MDT)
Received: from pn2ml5so.prod.shaw.ca ([10.0.121.149])
	by pd3mr5so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JNL00FAKSS1H670@pd3mr5so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Thu, 30 Aug 2007 14:26:26 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JNL00BR6SRTDJ21@l-daemon> for linuxppc-dev@ozlabs.org;
	Thu, 30 Aug 2007 14:26:17 -0600 (MDT)
Date: Thu, 30 Aug 2007 14:26:18 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 1/3] bootwrapper: In cuImage,
	print message for ENET devices not found in tree
To: linuxppc-dev@ozlabs.org
Message-id: <20070830202618.9927.32588.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
CC: Scott Wood <scottwood@freescale.com>
CC: Kumar Gala <galak@kernel.crashing.org>
CC: David Gibson <david@gibson.dropbear.id.au>
---

 arch/powerpc/boot/devtree.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/boot/devtree.c b/arch/powerpc/boot/devtree.c
index e1b8122..8451a1c 100644
--- a/arch/powerpc/boot/devtree.c
+++ b/arch/powerpc/boot/devtree.c
@@ -99,14 +99,14 @@ void __dt_fixup_mac_addresses(u32 startindex, ...)
 	while ((addr = va_arg(ap, const u8 *))) {
 		devp = find_node_by_prop_value(NULL, "linux,network-index",
 					       (void*)&index, sizeof(index));
-
-		printf("ENET%d: local-mac-address <-"
-		       " %02x:%02x:%02x:%02x:%02x:%02x\n\r", index,
-		       addr[0], addr[1], addr[2], addr[3], addr[4], addr[5]);
-
-		if (devp)
+		if (devp) {
+			printf("ENET%d: local-mac-address <-"
+			       " %02x:%02x:%02x:%02x:%02x:%02x\n\r", index,
+			       addr[0], addr[1], addr[2], addr[3], addr[4], addr[5]);
 			setprop(devp, "local-mac-address", addr, 6);
-
+		} else {
+			printf("ENET%d: no device in tree\n\r", index);
+		}
 		index++;
 	}
 	va_end(ap);
