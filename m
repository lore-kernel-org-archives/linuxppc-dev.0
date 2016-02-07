Return-Path: <luis.henriques@canonical.com>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 89A341A0205
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Feb 2016 04:39:13 +1100 (AEDT)
From: Luis Henriques <luis.henriques@canonical.com>
To: Geoff Levand <geoff@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] powerpc/ps3: gelic_udbg: use struct vlan_hdr from
 <linux/if_vlan.h>
Date: Sun,  7 Feb 2016 17:38:48 +0000
Message-Id: <1454866730-10481-3-git-send-email-luis.henriques@canonical.com>
In-Reply-To: <1454866730-10481-1-git-send-email-luis.henriques@canonical.com>
References: <1454866730-10481-1-git-send-email-luis.henriques@canonical.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Instead of defining the local struct vlantag use the standard definition
of vlan_hdr from <linux/if_vlan.h>.

The fields in the <linux/if_vlan.h> definition have different names:
 - vlan -> h_vlan_TCI
 - subtype -> h_vlan_encapsulated_proto

Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 arch/powerpc/platforms/ps3/gelic_udbg.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/platforms/ps3/gelic_udbg.c b/arch/powerpc/platforms/ps3/gelic_udbg.c
index ac87811e8b4e..4d6e827edfde 100644
--- a/arch/powerpc/platforms/ps3/gelic_udbg.c
+++ b/arch/powerpc/platforms/ps3/gelic_udbg.c
@@ -14,6 +14,7 @@
  */
 
 #include <linux/if_ether.h>
+#include <linux/if_vlan.h>
 
 #include <asm/io.h>
 #include <asm/udbg.h>
@@ -58,11 +59,6 @@ struct debug_block {
 	u8 pkt[1520];
 } __packed;
 
-struct vlantag {
-	u16 vlan;
-	u16 subtype;
-} __packed;
-
 struct iphdr {
 	u8 ver_len;
 	u8 dscp_ecn;
@@ -84,7 +80,7 @@ struct udphdr {
 } __packed;
 
 static __iomem struct ethhdr *h_eth;
-static __iomem struct vlantag *h_vlan;
+static __iomem struct vlan_hdr *h_vlan;
 static __iomem struct iphdr *h_ip;
 static __iomem struct udphdr *h_udp;
 
@@ -181,10 +177,10 @@ static void gelic_debug_init(void)
 	if (!result) {
 		h_eth->h_proto= 0x8100;
 
-		header_size += sizeof(struct vlantag);
-		h_vlan = (struct vlantag *)(h_eth + 1);
-		h_vlan->vlan = vlan_id;
-		h_vlan->subtype = 0x0800;
+		header_size += sizeof(struct vlan_hdr);
+		h_vlan = (struct vlan_hdr *)(h_eth + 1);
+		h_vlan->h_vlan_TCI = vlan_id;
+		h_vlan->h_vlan_encapsulated_proto = 0x0800;
 		h_ip = (struct iphdr *)(h_vlan + 1);
 	} else {
 		h_eth->h_proto= 0x0800;
