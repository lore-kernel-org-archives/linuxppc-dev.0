Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B63C12C007E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Dec 2013 12:29:30 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] ibmveth: Fix more little endian issues
Date: Mon, 23 Dec 2013 02:29:23 +0100
Message-Id: <1387762163-39662-1-git-send-email-agraf@suse.de>
Cc: Santiago Leon <santil@linux.vnet.ibm.com>, Dinar Valeev <dvaleev@suse.com>,
 Anton Blanchard <anton@samba.org>, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The ibmveth driver is memcpy()'ing the mac address between a variable
(register) and memory. This assumes a certain endianness of the
system, so let's make that implicit assumption work again.

This patch adds be64_to_cpu() calls to all places where the mac address
gets memcpy()'ed into a local variable.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 drivers/net/ethernet/ibm/ibmveth.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 952d795..97f4ee96 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -581,7 +581,7 @@ static int ibmveth_open(struct net_device *netdev)
 	adapter->rx_queue.toggle = 1;
 
 	memcpy(&mac_address, netdev->dev_addr, netdev->addr_len);
-	mac_address = mac_address >> 16;
+	mac_address = be64_to_cpu(mac_address) >> 16;
 
 	rxq_desc.fields.flags_len = IBMVETH_BUF_VALID |
 					adapter->rx_queue.queue_len;
@@ -1186,6 +1186,7 @@ static void ibmveth_set_multicast_list(struct net_device *netdev)
 			/* add the multicast address to the filter table */
 			unsigned long mcast_addr = 0;
 			memcpy(((char *)&mcast_addr)+2, ha->addr, ETH_ALEN);
+			mcast_addr = cpu_to_be64(mcast_addr);
 			lpar_rc = h_multicast_ctrl(adapter->vdev->unit_address,
 						   IbmVethMcastAddFilter,
 						   mcast_addr);
-- 
1.8.1.4
