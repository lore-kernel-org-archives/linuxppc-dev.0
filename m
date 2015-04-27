Return-Path: <tlfalcon@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0597E1A0904
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 08:11:07 +1000 (AEST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tlfalcon@linux.vnet.ibm.com>;
 Mon, 27 Apr 2015 16:11:06 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 276811FF001F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 16:02:13 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3RM93VF30212288
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 15:09:04 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3RMB1xI028691
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 16:11:02 -0600
From: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next v2 3/4] ibmveth: Add GRO support
Date: Mon, 27 Apr 2015 17:10:54 -0500
Message-Id: <1430172655-17606-3-git-send-email-tlfalcon@linux.vnet.ibm.com>
In-Reply-To: <1430172655-17606-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
References: <1430172655-17606-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
Cc: Brian King <brking@linux.vnet.ibm.com>, nfont@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, eric.dumazet@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Cc: Brian King <brking@linux.vnet.ibm.com>
Signed-off-by: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 25cfc26..f0ec4e5 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1139,7 +1139,7 @@ restart_poll:
 			if (csum_good)
 				skb->ip_summed = CHECKSUM_UNNECESSARY;
 
-			netif_receive_skb(skb);	/* send it up */
+			napi_gro_receive(napi, skb);	/* send it up */
 
 			netdev->stats.rx_packets++;
 			netdev->stats.rx_bytes += length;
-- 
1.9.3
