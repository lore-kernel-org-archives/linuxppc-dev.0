Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 027B81A050E
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Mar 2015 03:38:08 +1100 (AEDT)
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Kim Phillips <kim.phillips@freescale.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>
Subject: [PATCH v2 02/17] crypto: talitos - Externalise specific SEC2 reset
 actions
Message-Id: <20150306163805.865ED1A241C@localhost.localdomain>
Date: Fri,  6 Mar 2015 17:38:05 +0100 (CET)
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

During init and reset, some actions are different between SEC1 and SEC2
This patch isolates them in small helper functions that we will be able
to redefine for SEC1

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

---
 drivers/crypto/talitos.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index 857414a..103bfcf 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -88,9 +88,8 @@ static void unmap_single_talitos_ptr(struct device *dev,
 			 be16_to_cpu(talitos_ptr->len), dir);
 }
 
-static int reset_channel(struct device *dev, int ch)
+static unsigned int do_reset_channel(struct talitos_private *priv, int ch)
 {
-	struct talitos_private *priv = dev_get_drvdata(dev);
 	unsigned int timeout = TALITOS_TIMEOUT;
 
 	setbits32(priv->chan[ch].reg + TALITOS_CCCR, TALITOS_CCCR_RESET);
@@ -99,6 +98,14 @@ static int reset_channel(struct device *dev, int ch)
 	       && --timeout)
 		cpu_relax();
 
+	return timeout;
+}
+
+static int reset_channel(struct device *dev, int ch)
+{
+	struct talitos_private *priv = dev_get_drvdata(dev);
+	unsigned int timeout = do_reset_channel(priv, ch);
+
 	if (timeout == 0) {
 		dev_err(dev, "failed to reset channel %d\n", ch);
 		return -EIO;
@@ -144,6 +151,12 @@ static int reset_device(struct device *dev)
 /*
  * Reset and initialize the device
  */
+static void do_init_device(struct talitos_private *priv)
+{
+	setbits32(priv->reg + TALITOS_IMR, TALITOS_IMR_INIT);
+	setbits32(priv->reg + TALITOS_IMR_LO, TALITOS_IMR_LO_INIT);
+}
+
 static int init_device(struct device *dev)
 {
 	struct talitos_private *priv = dev_get_drvdata(dev);
@@ -171,8 +184,7 @@ static int init_device(struct device *dev)
 	}
 
 	/* enable channel done and error interrupts */
-	setbits32(priv->reg + TALITOS_IMR, TALITOS_IMR_INIT);
-	setbits32(priv->reg + TALITOS_IMR_LO, TALITOS_IMR_LO_INIT);
+	do_init_device(priv);
 
 	/* disable integrity check error interrupts (use writeback instead) */
 	if (priv->features & TALITOS_FTR_HW_AUTH_CHECK)
-- 
2.1.0
