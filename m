Return-Path: <grant.likely@secretlab.ca>
Date: Thu, 19 Jul 2007 12:37:24 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 1/4] bootwrapper: In cuImage,
	print message for ENET devices not found in tree
In-reply-to: <20070719183415.7458.42622.stgit@trillian>
To: linuxppc-dev@ozlabs.com
Message-id: <20070719183723.7458.63748.stgit@trillian>
Content-type: text/plain; charset=utf-8; format=fixed
References: <20070719183415.7458.42622.stgit@trillian>
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
---

 arch/powerpc/boot/devtree.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/boot/devtree.c b/arch/powerpc/boot/devtree.c
index c995155..8000399 100644
--- a/arch/powerpc/boot/devtree.c
+++ b/arch/powerpc/boot/devtree.c
@@ -97,14 +97,14 @@ void __dt_fixup_mac_addresses(u32 startindex, ...)
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
