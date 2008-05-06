Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id C07D9DE36B
	for <linuxppc-dev@ozlabs.org>; Wed,  7 May 2008 04:40:27 +1000 (EST)
Message-ID: <4820A601.2020801@scram.de>
Date: Tue, 06 May 2008 20:40:01 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCHv2 2.6.26-rc1] [POWERPC] Fix of_i2c include for module
	compilation
Content-Type: text/plain; charset=ISO-8859-15
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>, "Kernel,
	Linux" <linux-kernel@vger.kernel.org>,
	Scott Wood <scottwood@freescale.com>, Linux I2C <i2c@lm-sensors.org>,
	Jean Delvare <khali@linux-fr.org>, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Remove #ifdef CONFIG_OF_I2C as this breaks module compilation.
Drivers using this header should depend on OF_I2C anyways, so
there's no need to make this conditional

Signed-off-by: Jochen Friedrich <jochen@scram.de>
---
 include/linux/of_i2c.h |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/include/linux/of_i2c.h b/include/linux/of_i2c.h
index 2e5a967..bd2a870 100644
--- a/include/linux/of_i2c.h
+++ b/include/linux/of_i2c.h
@@ -14,11 +14,7 @@
 
 #include <linux/i2c.h>
 
-#ifdef CONFIG_OF_I2C
-
 void of_register_i2c_devices(struct i2c_adapter *adap,
 			     struct device_node *adap_node);
 
-#endif /* CONFIG_OF_I2C */
-
 #endif /* __LINUX_OF_I2C_H */
-- 
1.5.5.1
