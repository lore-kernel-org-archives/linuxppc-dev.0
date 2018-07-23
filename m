Return-Path: <krzk@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Z6DK0kyRzDqmj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2018 02:20:48 +1000 (AEST)
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Pantelis Antoniou <pantelis.antoniou@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Eric Biggers <ebiggers3@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] net: ethernet: fs-enet: Use generic CRC32 implementation
Date: Mon, 23 Jul 2018 18:20:20 +0200
Message-Id: <20180723162020.6221-1-krzk@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use generic kernel CRC32 implementation because it:
1. Should be faster (uses lookup tables),
2. Removes duplicated CRC generation code,
3. Uses well-proven algorithm instead of coding it one more time.

Suggested-by: Eric Biggers <ebiggers3@gmail.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Not tested on hardware.
---
 drivers/net/ethernet/freescale/fs_enet/mac-fec.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fs_enet/mac-fec.c b/drivers/net/ethernet/freescale/fs_enet/mac-fec.c
index 1fc27c97e3b2..99fe2c210d0f 100644
--- a/drivers/net/ethernet/freescale/fs_enet/mac-fec.c
+++ b/drivers/net/ethernet/freescale/fs_enet/mac-fec.c
@@ -18,6 +18,7 @@
 #include <linux/string.h>
 #include <linux/ptrace.h>
 #include <linux/errno.h>
+#include <linux/crc32.h>
 #include <linux/ioport.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
@@ -176,21 +177,10 @@ static void set_multicast_start(struct net_device *dev)
 static void set_multicast_one(struct net_device *dev, const u8 *mac)
 {
 	struct fs_enet_private *fep = netdev_priv(dev);
-	int temp, hash_index, i, j;
+	int temp, hash_index;
 	u32 crc, csrVal;
-	u8 byte, msb;
-
-	crc = 0xffffffff;
-	for (i = 0; i < 6; i++) {
-		byte = mac[i];
-		for (j = 0; j < 8; j++) {
-			msb = crc >> 31;
-			crc <<= 1;
-			if (msb ^ (byte & 0x1))
-				crc ^= FEC_CRC_POLY;
-			byte >>= 1;
-		}
-	}
+
+	crc = ether_crc(6, mac);
 
 	temp = (crc & 0x3f) >> 1;
 	hash_index = ((temp & 0x01) << 4) |
-- 
2.14.1
