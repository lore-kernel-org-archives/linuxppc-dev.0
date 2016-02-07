Return-Path: <luis.henriques@canonical.com>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2648A1A01A3
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Feb 2016 04:39:14 +1100 (AEDT)
From: Luis Henriques <luis.henriques@canonical.com>
To: Geoff Levand <geoff@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] powerpc/ps3: gelic_udbg: use struct iphdr from
 <linux/ip.h>
Date: Sun,  7 Feb 2016 17:38:49 +0000
Message-Id: <1454866730-10481-4-git-send-email-luis.henriques@canonical.com>
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

Instead of defining a local version of struct iphdr use the standard
definition from <linux/ip.h>.

Several fields in the <linux/ip.h> definition have different names:
 - proto -> protocol
 - src -> saddr
 - dest -> daddr
 - total_length -> tot_len
 - checksum -> check

Also, 'ver_len' is composed by 'version' and 'ihl' in <linux/ip.h>.

Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 arch/powerpc/platforms/ps3/gelic_udbg.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/platforms/ps3/gelic_udbg.c b/arch/powerpc/platforms/ps3/gelic_udbg.c
index 4d6e827edfde..01d274fcbe51 100644
--- a/arch/powerpc/platforms/ps3/gelic_udbg.c
+++ b/arch/powerpc/platforms/ps3/gelic_udbg.c
@@ -15,6 +15,7 @@
 
 #include <linux/if_ether.h>
 #include <linux/if_vlan.h>
+#include <linux/ip.h>
 
 #include <asm/io.h>
 #include <asm/udbg.h>
@@ -59,19 +60,6 @@ struct debug_block {
 	u8 pkt[1520];
 } __packed;
 
-struct iphdr {
-	u8 ver_len;
-	u8 dscp_ecn;
-	u16 total_length;
-	u16 ident;
-	u16 frag_off_flags;
-	u8 ttl;
-	u8 proto;
-	u16 checksum;
-	u32 src;
-	u32 dest;
-} __packed;
-
 struct udphdr {
 	u16 src;
 	u16 dest;
@@ -188,11 +176,12 @@ static void gelic_debug_init(void)
 	}
 
 	header_size += sizeof(struct iphdr);
-	h_ip->ver_len = 0x45;
+	h_ip->version = 4;
+	h_ip->ihl = 5;
 	h_ip->ttl = 10;
-	h_ip->proto = 0x11;
-	h_ip->src = 0x00000000;
-	h_ip->dest = 0xffffffff;
+	h_ip->protocol = 0x11;
+	h_ip->saddr = 0x00000000;
+	h_ip->daddr = 0xffffffff;
 
 	header_size += sizeof(struct udphdr);
 	h_udp = (struct udphdr *)(h_ip + 1);
@@ -217,16 +206,16 @@ static void gelic_sendbuf(int msgsize)
 	int i;
 
 	dbg.descr.buf_size = header_size + msgsize;
-	h_ip->total_length = msgsize + sizeof(struct udphdr) +
+	h_ip->tot_len = msgsize + sizeof(struct udphdr) +
 			     sizeof(struct iphdr);
 	h_udp->len = msgsize + sizeof(struct udphdr);
 
-	h_ip->checksum = 0;
+	h_ip->check = 0;
 	sum = 0;
 	p = (u16 *)h_ip;
 	for (i = 0; i < 5; i++)
 		sum += *p++;
-	h_ip->checksum = ~(sum + (sum >> 16));
+	h_ip->check = ~(sum + (sum >> 16));
 
 	dbg.descr.dmac_cmd_status = GELIC_DESCR_DMA_CMD_NO_CHKSUM |
 				    GELIC_DESCR_TX_DMA_FRAME_TAIL;
