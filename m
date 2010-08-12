Return-Path: <weo@goedel.recco.de>
Received: from bastet.recconet.de (bastet.reccoware.net [87.106.68.206])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 30816B6F0D
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 12 Aug 2010 18:39:38 +1000 (EST)
From: Wolfgang Ocker <weo@reccoware.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] fs-enet/mac-fec: Restore multicast and promiscous settings
	during restart
Date: Thu, 12 Aug 2010 10:26:18 +0200
Message-Id: <1281601578-8842-1-git-send-email-weo@reccoware.de>
Cc: Wolfgang Ocker <weo@reccoware.de>, Vitaly Bordug <vbordug@ru.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Wolfgang Ocker <weo@reccoware.de>
---
 drivers/net/fs_enet/mac-fec.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/net/fs_enet/mac-fec.c b/drivers/net/fs_enet/mac-fec.c
index 7ca1642..05f4bb1 100644
--- a/drivers/net/fs_enet/mac-fec.c
+++ b/drivers/net/fs_enet/mac-fec.c
@@ -344,6 +344,9 @@ static void restart(struct net_device *dev)
 	FW(fecp, imask, FEC_ENET_TXF | FEC_ENET_TXB |
 	   FEC_ENET_RXF | FEC_ENET_RXB);
 
+	/* Restore multicast and promiscuous settings */
+	set_multicast_list(dev);
+
 	/*
 	 * And last, enable the transmit and receive processing.
 	 */
-- 
1.7.2.1
