Return-Path: <tlfalcon@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qcG6j42h3zDq5j
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Apr 2016 09:20:45 +1100 (AEDT)
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tlfalcon@linux.vnet.ibm.com>;
 Fri, 1 Apr 2016 16:20:42 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 5C0211FF001E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Apr 2016 16:08:46 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u31MKbKJ34406488
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Apr 2016 15:20:37 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u31MKaX4025199
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Apr 2016 16:20:37 -0600
From: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
To: netdev@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, davem@davemloft.net,
 John Allen <jallen@linux.vnet.ibm.com>
Subject: [net-next PATCH 2/2 v4] ibmvnic: enable RX checksum offload
Date: Fri,  1 Apr 2016 17:20:35 -0500
Message-Id: <1459549235-22039-2-git-send-email-tlfalcon@linux.vnet.ibm.com>
In-Reply-To: <1459549235-22039-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
References: <1459549235-22039-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Enable RX Checksum offload feature in the ibmvnic driver.

Signed-off-by: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Cc: John Allen <jallen@linux.vnet.ibm.com>
---
v4: this patch included since it is enabled by the previous patch
---
 drivers/net/ethernet/ibm/ibmvnic.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 4e97e76..21bccf6 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -2105,6 +2105,10 @@ static void handle_query_ip_offload_rsp(struct ibmvnic_adapter *adapter)
 	if (buf->tcp_ipv6_chksum || buf->udp_ipv6_chksum)
 		adapter->netdev->features |= NETIF_F_IPV6_CSUM;
 
+	if ((adapter->netdev->features &
+	    (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM)))
+		adapter->netdev->features |= NETIF_F_RXCSUM;
+
 	memset(&crq, 0, sizeof(crq));
 	crq.control_ip_offload.first = IBMVNIC_CRQ_CMD;
 	crq.control_ip_offload.cmd = CONTROL_IP_OFFLOAD;
-- 
2.4.11
