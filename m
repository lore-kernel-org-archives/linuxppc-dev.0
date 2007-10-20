Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (unknown [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 216BDDDE9C
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Oct 2007 05:03:30 +1000 (EST)
Date: Sat, 20 Oct 2007 14:10:03 -0500
From: Olof Johansson <olof@lixom.net>
To: jgarzik@pobox.com
Subject: [PATCH] pasemi_mac: fix typo
Message-ID: <20071020191003.GB30034@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add missing &:

drivers/net/pasemi_mac.c: In function 'pasemi_mac_clean_rx':
drivers/net/pasemi_mac.c:553: warning: passing argument 1 of 'prefetch'
makes pointer from integer without a cast


Signed-off-by: Olof Johansson <olof@lixom.net>

diff --git a/drivers/net/pasemi_mac.c b/drivers/net/pasemi_mac.c
index 9f9a421..ab4d309 100644
--- a/drivers/net/pasemi_mac.c
+++ b/drivers/net/pasemi_mac.c
@@ -550,7 +550,7 @@ static int pasemi_mac_clean_rx(struct pasemi_mac *mac, int limit)
 
 	n = mac->rx->next_to_clean;
 
-	prefetch(RX_RING(mac, n));
+	prefetch(&RX_RING(mac, n));
 
 	for (count = 0; count < limit; count++) {
 		macrx = RX_RING(mac, n);
