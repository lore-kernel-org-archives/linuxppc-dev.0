Return-Path: <wsa@the-dreams.de>
Received: from pokefinder.org (sauhun.de [88.99.104.3])
 by lists.ozlabs.org (Postfix) with ESMTP id 41vv6w4ZfwzF0kx
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Aug 2018 01:02:46 +1000 (AEST)
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-i2c@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 1/2] macintosh: therm_windtunnel: drop using attach_adapter
Date: Tue, 21 Aug 2018 17:02:39 +0200
Message-Id: <20180821150240.19964-2-wsa@the-dreams.de>
In-Reply-To: <20180821150240.19964-1-wsa@the-dreams.de>
References: <20180821150240.19964-1-wsa@the-dreams.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As we now have deferred probing, we can use a custom mechanism and
finally get rid of the legacy interface from the i2c core.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/macintosh/therm_windtunnel.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/macintosh/therm_windtunnel.c b/drivers/macintosh/therm_windtunnel.c
index 68dcbcb4fc5b..8c744578122a 100644
--- a/drivers/macintosh/therm_windtunnel.c
+++ b/drivers/macintosh/therm_windtunnel.c
@@ -432,7 +432,6 @@ static struct i2c_driver g4fan_driver = {
 	.driver = {
 		.name	= "therm_windtunnel",
 	},
-	.attach_adapter = do_attach,
 	.probe		= do_probe,
 	.remove		= do_remove,
 	.id_table	= therm_windtunnel_id,
@@ -445,7 +444,29 @@ static struct i2c_driver g4fan_driver = {
 
 static int therm_of_probe(struct platform_device *dev)
 {
-	return i2c_add_driver( &g4fan_driver );
+	struct i2c_adapter *adap;
+	int ret, i = 0;
+
+	adap = i2c_get_adapter(0);
+	if (!adap)
+		return -EPROBE_DEFER;
+
+	ret = i2c_add_driver(&g4fan_driver);
+	if (ret) {
+		i2c_put_adapter(adap);
+		return ret;
+	}
+
+	/* We assume Macs have consecutive I2C bus numbers starting at 0 */
+	while (adap) {
+		do_attach(adap);
+		if (x.running)
+			return 0;
+		i2c_put_adapter(adap);
+		adap = i2c_get_adapter(++i);
+	}
+
+	return -ENODEV;
 }
 
 static int
-- 
2.11.0
