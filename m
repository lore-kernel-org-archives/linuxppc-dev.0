Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 8D998DE7B7
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Apr 2008 00:23:18 +1000 (EST)
Message-ID: <4808AEC7.8040000@scram.de>
Date: Fri, 18 Apr 2008 16:23:03 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] [POWERPC] i2c: fix build breakage introduced by OF helpers
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

Fix build breakage introduced in commit
"[POWERPC] i2c: OF helpers for the i2c API".
If i2c-core is compiled as module, the helper needs to be
compiled as module, as well. Rename i2c.c to of_i2c.c to
avoid name space conflict.

Signed-off-by: Jochen Friedrich <jochen@scram.de>
---
 drivers/of/Kconfig             |    2 +-
 drivers/of/Makefile            |    2 +-
 drivers/of/{i2c.c => of_i2c.c} |    0 
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename drivers/of/{i2c.c => of_i2c.c} (100%)

diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index 7c30531..0e39f00 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -9,7 +9,7 @@ config OF_GPIO
 	  OpenFirmware GPIO accessors
 
 config OF_I2C
-	def_bool y
+	def_tristate I2C
 	depends on OF && I2C
 	help
 	  OpenFirmware I2C accessors
diff --git a/drivers/of/Makefile b/drivers/of/Makefile
index a07b953..548772e 100644
--- a/drivers/of/Makefile
+++ b/drivers/of/Makefile
@@ -1,4 +1,4 @@
 obj-y = base.o
 obj-$(CONFIG_OF_DEVICE) += device.o platform.o
 obj-$(CONFIG_OF_GPIO)   += gpio.o
-obj-$(CONFIG_OF_I2C)	+= i2c.o
+obj-$(CONFIG_OF_I2C)	+= of_i2c.o
diff --git a/drivers/of/i2c.c b/drivers/of/of_i2c.c
similarity index 100%
rename from drivers/of/i2c.c
rename to drivers/of/of_i2c.c
-- 
1.5.5
