Return-Path: <mokuno@sm.sony.co.jp>
Received: from mgw2.sony.co.jp (MGW2.Sony.CO.JP [137.153.0.14])
	by ozlabs.org (Postfix) with ESMTP id 8B2ADDE13B
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 23:06:28 +1100 (EST)
Date: Thu, 13 Dec 2007 21:05:10 +0900
From: Masakazu Mokuno <mokuno@sm.sony.co.jp>
To: netdev@vger.kernel.org
Subject: [PATCH 1/6] PS3: gelic: Fix the wrong dev_id passed
In-Reply-To: <20071213181146.BF69.MOKUNO@sm.sony.co.jp>
References: <20071213181146.BF69.MOKUNO@sm.sony.co.jp>
Message-Id: <20071213205714.BF7C.MOKUNO@sm.sony.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

PS3: gelic: Fix the wrong dev_id passed

The device id for lv1_net_set_interrupt_status_indicator() would be wrong.
This path would be invoked only in the case of the initialization failure.

Signed-off-by: Masakazu Mokuno <mokuno@sm.sony.co.jp>
---
 drivers/net/ps3_gelic_net.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ps3_gelic_net.c
+++ b/drivers/net/ps3_gelic_net.c
@@ -1512,7 +1512,7 @@ static int ps3_gelic_driver_probe (struc
 
 fail_setup_netdev:
 	lv1_net_set_interrupt_status_indicator(bus_id(card),
-					       bus_id(card),
+					       dev_id(card),
 					       0 , 0);
 fail_status_indicator:
 	ps3_dma_region_free(dev->d_region);
