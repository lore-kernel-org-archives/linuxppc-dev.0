Return-Path: <LeoLi@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 680C3DDDFA
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Aug 2008 16:54:06 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m766s0Ae002465
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Aug 2008 23:54:01 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m766rx4t000923
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Aug 2008 01:53:59 -0500 (CDT)
From: Li Yang <leoli@freescale.com>
To: jeff@garzik.org, netdev@vger.kernel.org
Subject: [PATCH] net/fs_enet: remove redundant messages for performance
Date: Wed,  6 Aug 2008 15:08:50 +0800
Message-Id: <1218006530-27173-1-git-send-email-leoli@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Li Yang <leoli@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently when we do a packet flood to the Ethernet port, the console
reports error every time when a packet is dropped.  This is too
redundant and cost performance.  Remove message for this type of event.

Signed-off-by: Li Yang <leoli@freescale.com>
---
 drivers/net/fs_enet/mac-fcc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/fs_enet/mac-fcc.c b/drivers/net/fs_enet/mac-fcc.c
index 0a97fc2..1c7ef81 100644
--- a/drivers/net/fs_enet/mac-fcc.c
+++ b/drivers/net/fs_enet/mac-fcc.c
@@ -126,7 +126,7 @@ out:
 #define FCC_NAPI_RX_EVENT_MSK	(FCC_ENET_RXF | FCC_ENET_RXB)
 #define FCC_RX_EVENT		(FCC_ENET_RXF)
 #define FCC_TX_EVENT		(FCC_ENET_TXB)
-#define FCC_ERR_EVENT_MSK	(FCC_ENET_TXE | FCC_ENET_BSY)
+#define FCC_ERR_EVENT_MSK	(FCC_ENET_TXE)
 
 static int setup_data(struct net_device *dev)
 {
-- 
1.5.5.1.248.g4b17
