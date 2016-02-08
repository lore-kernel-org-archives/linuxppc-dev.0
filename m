Return-Path: <luis.henriques@canonical.com>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CF9431A0290
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Feb 2016 09:27:26 +1100 (AEDT)
From: Luis Henriques <luis.henriques@canonical.com>
To: Geoff Levand <geoff@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Joe Perches <joe@perches.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] powerpc/ps3: gelic_udbg: use struct udphdr from
 <linux/udp.h>
Date: Mon,  8 Feb 2016 22:27:07 +0000
Message-Id: <1454970427-23017-5-git-send-email-luis.henriques@canonical.com>
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

Instead of defining a local version of struct udphdr use the standard
definition from <linux/udp.h>.

The 'src' field is named 'source' in the <linux/udp.h> definition.

Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 arch/powerpc/platforms/ps3/gelic_udbg.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/ps3/gelic_udbg.c b/arch/powerpc/platforms/ps3/gelic_udbg.c
index d69f33dcc64b..09bf24d616a5 100644
--- a/arch/powerpc/platforms/ps3/gelic_udbg.c
+++ b/arch/powerpc/platforms/ps3/gelic_udbg.c
@@ -17,6 +17,7 @@
 #include <linux/etherdevice.h>
 #include <linux/if_vlan.h>
 #include <linux/ip.h>
+#include <linux/udp.h>
 
 #include <asm/io.h>
 #include <asm/udbg.h>
@@ -61,13 +62,6 @@ struct debug_block {
 	u8 pkt[1520];
 } __packed;
 
-struct udphdr {
-	u16 src;
-	u16 dest;
-	u16 len;
-	u16 checksum;
-} __packed;
-
 static __iomem struct ethhdr *h_eth;
 static __iomem struct vlan_hdr *h_vlan;
 static __iomem struct iphdr *h_ip;
@@ -186,7 +180,7 @@ static void gelic_debug_init(void)
 
 	header_size += sizeof(struct udphdr);
 	h_udp = (struct udphdr *)(h_ip + 1);
-	h_udp->src = GELIC_DEBUG_PORT;
+	h_udp->source = GELIC_DEBUG_PORT;
 	h_udp->dest = GELIC_DEBUG_PORT;
 
 	pmsgc = pmsg = (char *)(h_udp + 1);
