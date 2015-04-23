Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 12FA71A0DAC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2015 14:43:17 +1000 (AEST)
From: David Gibson <david@gibson.dropbear.id.au>
To: anton@au1.ibm.com
Subject: [PATCHv2] ibmveth: Fix off-by-one error in ibmveth_change_mtu()
Date: Thu, 23 Apr 2015 14:43:05 +1000
Message-Id: <1429764185-597-1-git-send-email-david@gibson.dropbear.id.au>
Cc: tlfalcon@linux.vnet.ibm.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, michael@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

AFAIK the PAPR document which defines the virtual device interface used by
the ibmveth driver doesn't specify a specific maximum MTU.  So, in the
ibmveth driver, the maximum allowed MTU is determined by the maximum
allocated buffer size of 64k (corresponding to one page in the common case)
minus the per-buffer overhead IBMVETH_BUFF_OH (which has value 22 for 14
bytes of ethernet header, plus 8 bytes for an opaque handle).

This suggests a maximum allowable MTU of 65514 bytes, but in fact the
driver only permits a maximum MTU of 65513.  This is because there is a <
instead of an <= in ibmveth_change_mtu(), which only permits an MTU which
is strictly smaller than the buffer size, rather than allowing the buffer
to be completely filled.

This patch fixes the buglet.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Acked-by: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Resending with Thomas Falcon's ACK included, since I previously forgot
to include the netdev list amongst the recipients.

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index cd7675a..1813476 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1238,7 +1238,7 @@ static int ibmveth_change_mtu(struct net_device *dev, int new_mtu)
 		return -EINVAL;
 
 	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
-		if (new_mtu_oh < adapter->rx_buff_pool[i].buff_size)
+		if (new_mtu_oh <= adapter->rx_buff_pool[i].buff_size)
 			break;
 
 	if (i == IBMVETH_NUM_BUFF_POOLS)
@@ -1257,7 +1257,7 @@ static int ibmveth_change_mtu(struct net_device *dev, int new_mtu)
 	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
 		adapter->rx_buff_pool[i].active = 1;
 
-		if (new_mtu_oh < adapter->rx_buff_pool[i].buff_size) {
+		if (new_mtu_oh <= adapter->rx_buff_pool[i].buff_size) {
 			dev->mtu = new_mtu;
 			vio_cmo_set_dev_desired(viodev,
 						ibmveth_get_desired_dma
-- 
2.1.0
