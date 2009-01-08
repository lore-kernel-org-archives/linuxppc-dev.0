Return-Path: <Geoffrey.Levand@am.sony.com>
Message-ID: <4965553A.4090003@am.sony.com>
Date: Wed, 7 Jan 2009 17:22:02 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [patch 6/6 v2] mtd/ps3vram: Use msleep in waits
References: <4963CA52.9030902@am.sony.com> <4963CDF4.1070403@am.sony.com>
In-Reply-To: <4963CDF4.1070403@am.sony.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: David Woodhouse <David.Woodhouse@intel.com>, Arnd Bergmann <arnd@arndb.de>,
	Jim Paris <jim@jtan.com>, linuxppc-dev@ozlabs.org,
	Vivien Chappelier <vivien.chappelier@free.fr>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Subject: [patch] mtd/ps3vram: Use msleep in waits

Replace the use of udelay() with msleep() in the looping wait routines
ps3vram_notifier_wait() and ps3vram_wait_ring().

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
v2: Use time_before() in loops.

 drivers/mtd/devices/ps3vram.c |   40 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

--- a/drivers/mtd/devices/ps3vram.c
+++ b/drivers/mtd/devices/ps3vram.c
@@ -109,22 +109,19 @@ static void ps3vram_notifier_reset(struc
 		notify[i] = 0xffffffff;
 }
 
-static int ps3vram_notifier_wait(struct mtd_info *mtd, int timeout_ms)
+static int ps3vram_notifier_wait(struct mtd_info *mtd, unsigned int timeout_ms)
 {
 	struct ps3vram_priv *priv = mtd->priv;
 	u32 *notify = ps3vram_get_notifier(priv->reports, NOTIFIER);
-
-	timeout_ms *= 1000;
+	unsigned long timeout = jiffies + msecs_to_jiffies(timeout_ms);
 
 	do {
-		if (notify[3] == 0)
+		if (!notify[3])
 			return 0;
+		msleep(1);
+	} while (time_before(jiffies, timeout));
 
-		if (timeout_ms)
-			udelay(1);
-	} while (timeout_ms--);
-
-	return -1;
+	return -ETIMEDOUT;
 }
 
 static void ps3vram_init_ring(struct mtd_info *mtd)
@@ -135,25 +132,22 @@ static void ps3vram_init_ring(struct mtd
 	priv->ctrl[CTRL_GET] = FIFO_BASE + FIFO_OFFSET;
 }
 
-static int ps3vram_wait_ring(struct mtd_info *mtd, int timeout)
+static int ps3vram_wait_ring(struct mtd_info *mtd, unsigned int timeout_ms)
 {
 	struct ps3vram_priv *priv = mtd->priv;
+	unsigned long timeout = jiffies + msecs_to_jiffies(timeout_ms);
 
-	/* wait until setup commands are processed */
-	timeout *= 1000;
-	while (--timeout) {
+	do {
 		if (priv->ctrl[CTRL_PUT] == priv->ctrl[CTRL_GET])
-			break;
-		udelay(1);
-	}
-	if (timeout == 0) {
-		dev_dbg(priv->dev, "%s:%d: FIFO timeout (%08x/%08x/%08x)\n",
-			__func__, __LINE__, priv->ctrl[CTRL_PUT],
-			priv->ctrl[CTRL_GET], priv->ctrl[CTRL_TOP]);
-		return -ETIMEDOUT;
-	}
+			return 0;
+		msleep(1);
+	} while (time_before(jiffies, timeout));
 
-	return 0;
+	dev_dbg(priv->dev, "%s:%d: FIFO timeout (%08x/%08x/%08x)\n", __func__,
+		__LINE__, priv->ctrl[CTRL_PUT], priv->ctrl[CTRL_GET],
+		priv->ctrl[CTRL_TOP]);
+
+	return -ETIMEDOUT;
 }
 
 static void ps3vram_out_ring(struct ps3vram_priv *priv, u32 data)
