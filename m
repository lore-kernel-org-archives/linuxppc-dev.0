Return-Path: <javier@osg.samsung.com>
Received: from lists.s-osg.org (lists.s-osg.org [54.187.51.154])
 by lists.ozlabs.org (Postfix) with ESMTP id 3C6CC1A076F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2015 02:20:15 +1000 (AEST)
From: Javier Martinez Canillas <javier@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 22/27] macintosh: therm_windtunnel: Export OF module alias
 information
Date: Thu, 30 Jul 2015 18:18:47 +0200
Message-Id: <1438273132-20926-23-git-send-email-javier@osg.samsung.com>
In-Reply-To: <1438273132-20926-1-git-send-email-javier@osg.samsung.com>
References: <1438273132-20926-1-git-send-email-javier@osg.samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The I2C core always reports the MODALIAS uevent as "i2c:<client name"
regardless if the driver was matched using the I2C id_table or the
of_match_table. So technically there's no need for a driver to export
the OF table since currently it's not used.

In fact, the I2C device ID table is mandatory for I2C drivers since
a i2c_device_id is passed to the driver's probe function even if the
I2C core used the OF table to match the driver.

And since the I2C core uses different tables, OF-only drivers needs to
have duplicated data that has to be kept in sync and also the dev node
compatible manufacturer prefix is stripped when reporting the MODALIAS.

To avoid the above, the I2C core behavior may be changed in the future
to not require an I2C device table for OF-only drivers and report the
OF module alias. So, it's better to also export the OF table to prevent
breaking module autoloading if that happens.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 drivers/macintosh/therm_windtunnel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/macintosh/therm_windtunnel.c b/drivers/macintosh/therm_windtunnel.c
index 97269567ec01..68dcbcb4fc5b 100644
--- a/drivers/macintosh/therm_windtunnel.c
+++ b/drivers/macintosh/therm_windtunnel.c
@@ -460,6 +460,7 @@ static const struct of_device_id therm_of_match[] = {{
 	.compatible	= "adm1030"
     }, {}
 };
+MODULE_DEVICE_TABLE(of, therm_of_match);
 
 static struct platform_driver therm_of_driver = {
 	.driver = {
-- 
2.4.3
