Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id B3AA8DDDF9
	for <linuxppc-dev@ozlabs.org>; Sat,  3 May 2008 22:43:02 +1000 (EST)
Message-ID: <481C5DD0.5090503@scram.de>
Date: Sat, 03 May 2008 14:42:56 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] [POWERPC] Fix of_i2c include for module compilation
Content-Type: text/plain; charset=ISO-8859-15
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>, "Kernel,
	Linux" <linux-kernel@vger.kernel.org>,
	Scott Wood <scottwood@freescale.com>, Paul Mackerras <paulus@samba.org>,
	Jean Delvare <khali@linux-fr.org>, David Miller <davem@davemloft.net>,
	Linux I2C <i2c@lm-sensors.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Now that of_i2c may be compiled as module, the header must be
exported for module compilation, as well.

Signed-off-by: Jochen Friedrich <jochen@scram.de>
---
 include/linux/of_i2c.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/of_i2c.h b/include/linux/of_i2c.h
index 2e5a967..dca6013 100644
--- a/include/linux/of_i2c.h
+++ b/include/linux/of_i2c.h
@@ -14,7 +14,7 @@
 
 #include <linux/i2c.h>
 
-#ifdef CONFIG_OF_I2C
+#if defined(CONFIG_OF_I2C) || defined(CONFIG_OF_I2C_MODULE)
 
 void of_register_i2c_devices(struct i2c_adapter *adap,
 			     struct device_node *adap_node);
-- 
1.5.5.1
