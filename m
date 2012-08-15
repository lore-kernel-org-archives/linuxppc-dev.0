Return-Path: <abounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B9FF32C0086
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Aug 2012 06:12:29 +1000 (EST)
From: Alexandre Bounine <alexandre.bounine@idt.com>
To: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] rapidio/tsi721: fix inbound doorbell interrupt handling
Date: Wed, 15 Aug 2012 15:55:48 -0400
Message-Id: <1345060548-14859-1-git-send-email-alexandre.bounine@idt.com>
Cc: Alexandre Bounine <alexandre.bounine@idt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Make sure that there is no doorbell messages left behind due to disabled
interrupts during inbound doorbell processing.

The most common case for this bug is loss of rionet JOIN messages in
systems with three or more rionet participants and MSI or MSI-X enabled.
As result, requests for packet transfers may finish with
"destination unreachable" error message.

This patch is applicable to kernel versions starting from v3.2.

Signed-off-by: Alexandre Bounine <alexandre.bounine@idt.com>
Cc: Matt Porter <mporter@kernel.crashing.org>
---
 drivers/rapidio/devices/tsi721.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/rapidio/devices/tsi721.c b/drivers/rapidio/devices/tsi721.c
index 722246c..c0d6a04 100644
--- a/drivers/rapidio/devices/tsi721.c
+++ b/drivers/rapidio/devices/tsi721.c
@@ -435,6 +435,9 @@ static void tsi721_db_dpc(struct work_struct *work)
 				" info %4.4x\n", DBELL_SID(idb.bytes),
 				DBELL_TID(idb.bytes), DBELL_INF(idb.bytes));
 		}
+
+		wr_ptr = ioread32(priv->regs +
+				  TSI721_IDQ_WP(IDB_QUEUE)) % IDB_QSIZE;
 	}
 
 	iowrite32(rd_ptr & (IDB_QSIZE - 1),
@@ -445,6 +448,10 @@ static void tsi721_db_dpc(struct work_struct *work)
 	regval |= TSI721_SR_CHINT_IDBQRCV;
 	iowrite32(regval,
 		priv->regs + TSI721_SR_CHINTE(IDB_QUEUE));
+
+	wr_ptr = ioread32(priv->regs + TSI721_IDQ_WP(IDB_QUEUE)) % IDB_QSIZE;
+	if (wr_ptr != rd_ptr)
+		schedule_work(&priv->idb_work);
 }
 
 /**
-- 
1.7.8.4
