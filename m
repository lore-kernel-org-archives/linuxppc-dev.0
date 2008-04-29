Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 6B960DE484
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 01:53:20 +1000 (EST)
Date: Tue, 29 Apr 2008 19:53:18 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH 2/3] [NET] uli526x: fix endianness issues in the setup frame
Message-ID: <20080429155318.GB28166@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch fixes uli526x driver's issues on a PowerPC boards: uli chip
is unable to receive the packets.

It appears that send_frame_filter prepares the setup frame in the
endianness unsafe manner. On a big endian machines we should shift
the address nibble by two bytes.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/net/tulip/uli526x.c |   30 ++++++++++++++++++------------
 1 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/net/tulip/uli526x.c b/drivers/net/tulip/uli526x.c
index 1f077ac..2511ca7 100644
--- a/drivers/net/tulip/uli526x.c
+++ b/drivers/net/tulip/uli526x.c
@@ -1368,6 +1368,12 @@ static void update_cr6(u32 cr6_data, unsigned long ioaddr)
  *	This setup frame initialize ULI526X address filter mode
  */
 
+#ifdef __BIG_ENDIAN
+#define FLT_SHIFT 16
+#else
+#define FLT_SHIFT 0
+#endif
+
 static void send_filter_frame(struct net_device *dev, int mc_cnt)
 {
 	struct uli526x_board_info *db = netdev_priv(dev);
@@ -1384,27 +1390,27 @@ static void send_filter_frame(struct net_device *dev, int mc_cnt)
 
 	/* Node address */
 	addrptr = (u16 *) dev->dev_addr;
-	*suptr++ = addrptr[0];
-	*suptr++ = addrptr[1];
-	*suptr++ = addrptr[2];
+	*suptr++ = addrptr[0] << FLT_SHIFT;
+	*suptr++ = addrptr[1] << FLT_SHIFT;
+	*suptr++ = addrptr[2] << FLT_SHIFT;
 
 	/* broadcast address */
-	*suptr++ = 0xffff;
-	*suptr++ = 0xffff;
-	*suptr++ = 0xffff;
+	*suptr++ = 0xffff << FLT_SHIFT;
+	*suptr++ = 0xffff << FLT_SHIFT;
+	*suptr++ = 0xffff << FLT_SHIFT;
 
 	/* fit the multicast address */
 	for (mcptr = dev->mc_list, i = 0; i < mc_cnt; i++, mcptr = mcptr->next) {
 		addrptr = (u16 *) mcptr->dmi_addr;
-		*suptr++ = addrptr[0];
-		*suptr++ = addrptr[1];
-		*suptr++ = addrptr[2];
+		*suptr++ = addrptr[0] << FLT_SHIFT;
+		*suptr++ = addrptr[1] << FLT_SHIFT;
+		*suptr++ = addrptr[2] << FLT_SHIFT;
 	}
 
 	for (; i<14; i++) {
-		*suptr++ = 0xffff;
-		*suptr++ = 0xffff;
-		*suptr++ = 0xffff;
+		*suptr++ = 0xffff << FLT_SHIFT;
+		*suptr++ = 0xffff << FLT_SHIFT;
+		*suptr++ = 0xffff << FLT_SHIFT;
 	}
 
 	/* prepare the setup frame */
-- 
1.5.5.1
