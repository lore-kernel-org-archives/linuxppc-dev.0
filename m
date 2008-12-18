Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 1FA97DDD0B
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Dec 2008 05:23:23 +1100 (EST)
Date: Thu, 18 Dec 2008 21:23:22 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH 1/6] ucc_geth: Fix endless loop in stop_{tx,rx} routines
Message-ID: <20081218182322.GA30682@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Cc: netdev@vger.kernel.org, Timur Tabi <timur@freescale.com>,
	linuxppc-dev@ozlabs.org, Andy Fleming <afleming@freescale.com>,
	Li Yang <leoli@freescale.com>, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently the routines wait for the various bits w/o an assumption that
bits may never get set. When timeouts happen I see that these bits never
get set and so the routines hang the kernel.

With this patch we'll wait the graceful stop for 100 ms, and then will
simply exit. There is nothing* we can do about that, but it's OK since
we'll do full reset later.

* Well, actually, there is also not-graceful variant for the TX stop,
  but specs says that we never should use it.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/net/ucc_geth.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c
index c87747b..79e6d3d 100644
--- a/drivers/net/ucc_geth.c
+++ b/drivers/net/ucc_geth.c
@@ -1647,6 +1647,7 @@ static int ugeth_graceful_stop_tx(struct ucc_geth_private *ugeth)
 	struct ucc_fast_private *uccf;
 	u32 cecr_subblock;
 	u32 temp;
+	int i = 10;
 
 	uccf = ugeth->uccf;
 
@@ -1664,8 +1665,9 @@ static int ugeth_graceful_stop_tx(struct ucc_geth_private *ugeth)
 
 	/* Wait for command to complete */
 	do {
+		msleep(10);
 		temp = in_be32(uccf->p_ucce);
-	} while (!(temp & UCCE_GRA));
+	} while (!(temp & UCCE_GRA) && --i);
 
 	uccf->stopped_tx = 1;
 
@@ -1677,6 +1679,7 @@ static int ugeth_graceful_stop_rx(struct ucc_geth_private * ugeth)
 	struct ucc_fast_private *uccf;
 	u32 cecr_subblock;
 	u8 temp;
+	int i = 10;
 
 	uccf = ugeth->uccf;
 
@@ -1694,9 +1697,9 @@ static int ugeth_graceful_stop_rx(struct ucc_geth_private * ugeth)
 						ucc_num);
 		qe_issue_cmd(QE_GRACEFUL_STOP_RX, cecr_subblock,
 			     QE_CR_PROTOCOL_ETHERNET, 0);
-
+		msleep(10);
 		temp = in_8(&ugeth->p_rx_glbl_pram->rxgstpack);
-	} while (!(temp & GRACEFUL_STOP_ACKNOWLEDGE_RX));
+	} while (!(temp & GRACEFUL_STOP_ACKNOWLEDGE_RX) && --i);
 
 	uccf->stopped_rx = 1;
 
-- 
1.5.6.5
