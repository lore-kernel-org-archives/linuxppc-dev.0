Return-Path: <tlfalcon@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D7651A0ACC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2015 06:35:12 +1000 (AEST)
Received: from /spool/local
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tlfalcon@linux.vnet.ibm.com>;
 Tue, 14 Apr 2015 14:35:10 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id A062B19D8047
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 14:26:13 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3EKYoRd34668692
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 13:34:50 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3EKZ7Pk014562
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 14:35:07 -0600
From: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
To: netdev@vger.kernel.org
Subject: [PATCH 3/5] ibmveth: Add GRO support
Date: Tue, 14 Apr 2015 15:35:02 -0500
Message-Id: <1429043704-22552-3-git-send-email-tlfalcon@linux.vnet.ibm.com>
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

Cc: Brian King <brking@linux.vnet.ibm.com>
Signed-off-by: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 2911a57..08970c7 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1137,7 +1137,7 @@ restart_poll:
 			if (csum_good)
 				skb->ip_summed = CHECKSUM_UNNECESSARY;
 
-			netif_receive_skb(skb);	/* send it up */
+			napi_gro_receive(napi, skb);	/* send it up */
 
 			netdev->stats.rx_packets++;
 			netdev->stats.rx_bytes += length;
-- 
1.8.3.1
