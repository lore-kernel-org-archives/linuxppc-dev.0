Return-Path: <wsa@the-dreams.de>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 268B41A0282
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Dec 2014 03:42:20 +1100 (AEDT)
Received: from pokefinder.org (sauhun.de [89.238.76.85])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4EDD51400E2
 for <linuxppc-dev@ozlabs.org>; Fri,  5 Dec 2014 03:42:18 +1100 (AEDT)
From: Wolfram Sang <wsa@the-dreams.de>
To: linuxppc-dev@ozlabs.org
Subject: [RFC 1/2] macintosh: therm_windtunnel: drop using attach adapter
Date: Thu,  4 Dec 2014 17:41:52 +0100
Message-Id: <1417711313-7257-2-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1417711313-7257-1-git-send-email-wsa@the-dreams.de>
References: <1417711313-7257-1-git-send-email-wsa@the-dreams.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Wolfram Sang <wsa@the-dreams.de>
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
index 3b4a157714b1..9de83cdd0bca 100644
--- a/drivers/macintosh/therm_windtunnel.c
+++ b/drivers/macintosh/therm_windtunnel.c
@@ -431,7 +431,6 @@ static struct i2c_driver g4fan_driver = {
 	.driver = {
 		.name	= "therm_windtunnel",
 	},
-	.attach_adapter = do_attach,
 	.probe		= do_probe,
 	.remove		= do_remove,
 	.id_table	= therm_windtunnel_id,
@@ -444,7 +443,29 @@ static struct i2c_driver g4fan_driver = {
 
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
+			break;
+		i2c_put_adapter(adap);
+		adap = i2c_get_adapter(++i);
+	}
+
+	return 0;
 }
 
 static int
-- 
2.1.3
