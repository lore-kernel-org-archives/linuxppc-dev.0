Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1630DDDF70
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Apr 2009 00:14:09 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
Subject: [PATCH] gianfar: Use memset instead of cacheable_memzero
Date: Tue, 28 Apr 2009 09:14:01 -0500
Message-Id: <1240928041-10905-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

cacheable_memzero() is completely overkill for the clearing out the FCB
block which is only 8-bytes.  The compiler should easily optimize this
with memset.  Additionally, cacheable_memzero() only exists on ppc32 and
thus breaks builds of gianfar on ppc64.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 drivers/net/gianfar.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/net/gianfar.c b/drivers/net/gianfar.c
index dae1437..2bb038b 100644
--- a/drivers/net/gianfar.c
+++ b/drivers/net/gianfar.c
@@ -1207,7 +1207,8 @@ static int gfar_enet_open(struct net_device *dev)
 static inline struct txfcb *gfar_add_fcb(struct sk_buff *skb)
 {
 	struct txfcb *fcb = (struct txfcb *)skb_push(skb, GMAC_FCB_LEN);
-	cacheable_memzero(fcb, GMAC_FCB_LEN);
+
+	memset(fcb, 0, GMAC_FCB_LEN);
 
 	return fcb;
 }
-- 
1.6.0.6
