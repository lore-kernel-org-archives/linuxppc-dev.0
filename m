Return-Path: <luis.henriques@canonical.com>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5EDD51A001D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Feb 2016 09:27:24 +1100 (AEDT)
From: Luis Henriques <luis.henriques@canonical.com>
To: Geoff Levand <geoff@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Joe Perches <joe@perches.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] powerpc/ps3: gelic_udbg: use struct ethhdr from
 <linux/if_ether.h>
Date: Mon,  8 Feb 2016 22:27:04 +0000
Message-Id: <1454970427-23017-2-git-send-email-luis.henriques@canonical.com>
In-Reply-To: <1454970427-23017-1-git-send-email-luis.henriques@canonical.com>
References: <1454970427-23017-1-git-send-email-luis.henriques@canonical.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Instead of defining a local version of struct ethhdr use the standard
definition from <linux/if_ether.h>.

The fields in the <linux/if_ether.h> definition have different names:
 - dest -> h_dest
 - src -> h_source
 - type -> h_proto

While there, use a few other standard functions/macros:
 - eth_broadcast_addr (instead of a memset)
 - ETH_ALEN
 - ETH_P_8021Q

Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 arch/powerpc/platforms/ps3/gelic_udbg.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/platforms/ps3/gelic_udbg.c b/arch/powerpc/platforms/ps3/gelic_udbg.c
index 20b46a19a48f..f11059e1ec35 100644
--- a/arch/powerpc/platforms/ps3/gelic_udbg.c
+++ b/arch/powerpc/platforms/ps3/gelic_udbg.c
@@ -13,6 +13,9 @@
  *
  */
 
+#include <linux/if_ether.h>
+#include <linux/etherdevice.h>
+
 #include <asm/io.h>
 #include <asm/udbg.h>
 #include <asm/lv1call.h>
@@ -56,12 +59,6 @@ struct debug_block {
 	u8 pkt[1520];
 } __packed;
 
-struct ethhdr {
-	u8 dest[6];
-	u8 src[6];
-	u16 type;
-} __packed;
-
 struct vlantag {
 	u16 vlan;
 	u16 subtype;
@@ -173,8 +170,8 @@ static void gelic_debug_init(void)
 
 	h_eth = (struct ethhdr *)dbg.pkt;
 
-	memset(&h_eth->dest, 0xff, 6);
-	memcpy(&h_eth->src, &mac, 6);
+	eth_broadcast_addr(h_eth->h_dest);
+	memcpy(&h_eth->h_source, &mac, ETH_ALEN);
 
 	header_size = sizeof(struct ethhdr);
 
@@ -183,7 +180,7 @@ static void gelic_debug_init(void)
 				 GELIC_LV1_VLAN_TX_ETHERNET_0, 0, 0,
 				 &vlan_id, &v2);
 	if (!result) {
-		h_eth->type = 0x8100;
+		h_eth->h_proto= ETH_P_8021Q;
 
 		header_size += sizeof(struct vlantag);
 		h_vlan = (struct vlantag *)(h_eth + 1);
@@ -191,7 +188,7 @@ static void gelic_debug_init(void)
 		h_vlan->subtype = 0x0800;
 		h_ip = (struct iphdr *)(h_vlan + 1);
 	} else {
-		h_eth->type = 0x0800;
+		h_eth->h_proto= 0x0800;
 		h_ip = (struct iphdr *)(h_eth + 1);
 	}
 
