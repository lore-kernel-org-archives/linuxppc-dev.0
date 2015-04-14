Return-Path: <tlfalcon@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2B9461A0143
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2015 06:35:14 +1000 (AEST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tlfalcon@linux.vnet.ibm.com>;
 Tue, 14 Apr 2015 14:35:13 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id AE31B1FF0026
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 14:26:20 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3EKXGTd26804238
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 13:33:17 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3EKZ83X014651
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 14:35:08 -0600
From: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
To: netdev@vger.kernel.org
Subject: [PATCH 4/5] ibmveth: Add support for Large Receive Offload
Date: Tue, 14 Apr 2015 15:35:03 -0500
Message-Id: <1429043704-22552-4-git-send-email-tlfalcon@linux.vnet.ibm.com>
In-Reply-To: <1429043704-22552-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
References: <1429043704-22552-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
Cc: Brian King <brking@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Enables receiving large packets from other LPARs. These packets
have a -1 IP header checksum, so we must recalculate to have
a valid checksum.

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
Signed-off-by: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 08970c7..05eaca6a 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1092,6 +1092,7 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 	struct net_device *netdev = adapter->netdev;
 	int frames_processed = 0;
 	unsigned long lpar_rc;
+	struct iphdr *iph;
 
 restart_poll:
 	while (frames_processed < budget) {
@@ -1134,8 +1135,20 @@ restart_poll:
 			skb_put(skb, length);
 			skb->protocol = eth_type_trans(skb, netdev);
 
-			if (csum_good)
+			if (csum_good) {
 				skb->ip_summed = CHECKSUM_UNNECESSARY;
+				if (be16_to_cpu(skb->protocol) == ETH_P_IP) {
+					skb_set_network_header(skb, 0);
+					skb_set_transport_header(skb, sizeof(struct iphdr));
+					iph = ip_hdr(skb);
+
+					/* If the IP checksum is not offloaded and if the packet
+					 *  is large send, the checksum must be rebuilt.
+					 */
+					if (iph->check == 0xffff)
+						iph->check = ip_fast_csum((unsigned char *)iph, iph->ihl);
+				}
+			}
 
 			napi_gro_receive(napi, skb);	/* send it up */
 
-- 
1.8.3.1
