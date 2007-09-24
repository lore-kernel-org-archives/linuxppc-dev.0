Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 80A9FDDE22
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Sep 2007 18:14:01 +1000 (EST)
Date: Mon, 24 Sep 2007 10:15:01 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Andrew Morton <akpm@linux-foundation.org>,
	linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
Subject: [PATCH] fix mace_handle_misc_intrs compilation
Message-ID: <20070924081501.GA1797@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Fix compilation after incomplete struct net_device changes.

Signed-off-by: Olaf Hering <olaf@aepfle.de>

---
 drivers/net/mace.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/net/mace.c
+++ b/drivers/net/mace.c
@@ -633,7 +633,7 @@ static void mace_set_multicast(struct ne
     spin_unlock_irqrestore(&mp->lock, flags);
 }
 
-static void mace_handle_misc_intrs(struct mace_data *mp, int intr)
+static void mace_handle_misc_intrs(struct mace_data *mp, int intr, struct net_device *dev)
 {
     volatile struct mace __iomem *mb = mp->mace;
     static int mace_babbles, mace_jabbers;
@@ -669,7 +669,7 @@ static irqreturn_t mace_interrupt(int ir
     spin_lock_irqsave(&mp->lock, flags);
     intr = in_8(&mb->ir);		/* read interrupt register */
     in_8(&mb->xmtrc);			/* get retries */
-    mace_handle_misc_intrs(mp, intr);
+    mace_handle_misc_intrs(mp, intr, dev);
 
     i = mp->tx_empty;
     while (in_8(&mb->pr) & XMTSV) {
@@ -682,7 +682,7 @@ static irqreturn_t mace_interrupt(int ir
 	 */
 	intr = in_8(&mb->ir);
 	if (intr != 0)
-	    mace_handle_misc_intrs(mp, intr);
+	    mace_handle_misc_intrs(mp, intr, dev);
 	if (mp->tx_bad_runt) {
 	    fs = in_8(&mb->xmtfs);
 	    mp->tx_bad_runt = 0;
@@ -817,7 +817,7 @@ static void mace_tx_timeout(unsigned lon
 	goto out;
 
     /* update various counters */
-    mace_handle_misc_intrs(mp, in_8(&mb->ir));
+    mace_handle_misc_intrs(mp, in_8(&mb->ir), dev);
 
     cp = mp->tx_cmds + NCMDS_TX * mp->tx_empty;
 
