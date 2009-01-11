Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id E7505DDFBA
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jan 2009 03:51:37 +1100 (EST)
Date: Sun, 11 Jan 2009 19:51:36 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] powerpc/83xx: Move mcu_mpc8349emitx driver out of
	drivers/i2c/chips/
Message-ID: <20090111165136.GA26096@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: Jean Delvare <khali@linux-fr.org>, linuxppc-dev@ozlabs.org,
	linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch is used to help Jean Delvare to get rid of drivers/i2c/chips/
directory. The new location suggested by Kumar Gala: as the driver is
83xx specific it's placed into arch/powerpc/platforms/83xx/.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

This is git patch.

 arch/powerpc/platforms/83xx/Makefile               |    1 +
 .../powerpc/platforms/83xx}/mcu_mpc8349emitx.c     |    0 
 arch/powerpc/platforms/Kconfig                     |   11 +++++++++++
 drivers/i2c/chips/Kconfig                          |   11 -----------
 drivers/i2c/chips/Makefile                         |    1 -
 5 files changed, 12 insertions(+), 12 deletions(-)
 rename {drivers/i2c/chips => arch/powerpc/platforms/83xx}/mcu_mpc8349emitx.c (100%)

diff --git a/arch/powerpc/platforms/83xx/Makefile b/arch/powerpc/platforms/83xx/Makefile
index ba5028e..051777c 100644
--- a/arch/powerpc/platforms/83xx/Makefile
+++ b/arch/powerpc/platforms/83xx/Makefile
@@ -3,6 +3,7 @@
 #
 obj-y				:= misc.o usb.o
 obj-$(CONFIG_SUSPEND)		+= suspend.o suspend-asm.o
+obj-$(CONFIG_MCU_MPC8349EMITX)	+= mcu_mpc8349emitx.o
 obj-$(CONFIG_MPC831x_RDB)	+= mpc831x_rdb.o
 obj-$(CONFIG_MPC832x_RDB)	+= mpc832x_rdb.o
 obj-$(CONFIG_MPC834x_MDS)	+= mpc834x_mds.o
diff --git a/drivers/i2c/chips/mcu_mpc8349emitx.c b/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c
similarity index 100%
rename from drivers/i2c/chips/mcu_mpc8349emitx.c
rename to arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index 47fe2be..200b9cb 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -323,4 +323,15 @@ config SIMPLE_GPIO
 	  chip-selects, Ethernet/USB PHY's power and various other small
 	  on-board peripherals.
 
+config MCU_MPC8349EMITX
+	tristate "MPC8349E-mITX MCU driver"
+	depends on I2C && PPC_83xx
+	select GENERIC_GPIO
+	select ARCH_REQUIRE_GPIOLIB
+	help
+	  Say Y here to enable soft power-off functionality on the Freescale
+	  boards with the MPC8349E-mITX-compatible MCU chips. This driver will
+	  also register MCU GPIOs with the generic GPIO API, so you'll able
+	  to use MCU pins as GPIOs.
+
 endmenu
diff --git a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
index 4c35702..d383e81 100644
--- a/drivers/i2c/chips/Kconfig
+++ b/drivers/i2c/chips/Kconfig
@@ -174,15 +174,4 @@ config MENELAUS
 	  and other features that are often used in portable devices like
 	  cell phones and PDAs.
 
-config MCU_MPC8349EMITX
-	tristate "MPC8349E-mITX MCU driver"
-	depends on I2C && PPC_83xx
-	select GENERIC_GPIO
-	select ARCH_REQUIRE_GPIOLIB
-	help
-	  Say Y here to enable soft power-off functionality on the Freescale
-	  boards with the MPC8349E-mITX-compatible MCU chips. This driver will
-	  also register MCU GPIOs with the generic GPIO API, so you'll able
-	  to use MCU pins as GPIOs.
-
 endmenu
diff --git a/drivers/i2c/chips/Makefile b/drivers/i2c/chips/Makefile
index 23d2a31..7e769b0 100644
--- a/drivers/i2c/chips/Makefile
+++ b/drivers/i2c/chips/Makefile
@@ -22,7 +22,6 @@ obj-$(CONFIG_ISP1301_OMAP)	+= isp1301_omap.o
 obj-$(CONFIG_TPS65010)		+= tps65010.o
 obj-$(CONFIG_MENELAUS)		+= menelaus.o
 obj-$(CONFIG_SENSORS_TSL2550)	+= tsl2550.o
-obj-$(CONFIG_MCU_MPC8349EMITX)	+= mcu_mpc8349emitx.o
 
 ifeq ($(CONFIG_I2C_DEBUG_CHIP),y)
 EXTRA_CFLAGS += -DDEBUG
-- 
1.5.6.5
