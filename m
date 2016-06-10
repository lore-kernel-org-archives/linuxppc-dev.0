Return-Path: <linz@li-pro.net>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rQsSW4tCCzDqNn
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2016 16:18:50 +1000 (AEST)
From: Stephan Linz <linz@li-pro.net>
To: linux-leds@vger.kernel.org,
	linux-ide@vger.kernel.org
Cc: Stephan Linz <linz@li-pro.net>, Joseph Jezak <josejx@gentoo.org>,
 =?UTF-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>,
 Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Kumar Gala <galak@codeaurora.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/7] powerpc: use the new LED disk activity trigger
Date: Fri, 10 Jun 2016 07:59:58 +0200
Message-Id: <20160610060021.12382-3-linz@li-pro.net>
In-Reply-To: <20160610060021.12382-1-linz@li-pro.net>
References: <20160610060021.12382-1-linz@li-pro.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

- dts: rename 'ide-disk' to 'disk-activity'
- defconfig: rename 'ADB_PMU_LED_IDE' to 'ADB_PMU_LED_DISK'

Cc: Joseph Jezak <josejx@gentoo.org>
Cc: Jörg Sommer <joerg@alea.gnuu.de>
Signed-off-by: Stephan Linz <linz@li-pro.net>
---
 arch/powerpc/boot/dts/mpc8315erdb.dts |  2 +-
 arch/powerpc/boot/dts/mpc8377_rdb.dts |  2 +-
 arch/powerpc/boot/dts/mpc8378_rdb.dts |  2 +-
 arch/powerpc/boot/dts/mpc8379_rdb.dts |  2 +-
 arch/powerpc/configs/pmac32_defconfig |  2 +-
 arch/powerpc/configs/ppc6xx_defconfig |  2 +-
 drivers/macintosh/Kconfig             | 13 ++++++-------
 drivers/macintosh/via-pmu-led.c       |  4 ++--
 8 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8315erdb.dts b/arch/powerpc/boot/dts/mpc8315erdb.dts
index 4354684..ca5139e 100644
--- a/arch/powerpc/boot/dts/mpc8315erdb.dts
+++ b/arch/powerpc/boot/dts/mpc8315erdb.dts
@@ -472,7 +472,7 @@
 
 		hdd {
 			gpios = <&mcu_pio 1 0>;
-			linux,default-trigger = "ide-disk";
+			linux,default-trigger = "disk-activity";
 		};
 	};
 };
diff --git a/arch/powerpc/boot/dts/mpc8377_rdb.dts b/arch/powerpc/boot/dts/mpc8377_rdb.dts
index 2b4b653..e326139 100644
--- a/arch/powerpc/boot/dts/mpc8377_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8377_rdb.dts
@@ -496,7 +496,7 @@
 
 		hdd {
 			gpios = <&mcu_pio 1 0>;
-			linux,default-trigger = "ide-disk";
+			linux,default-trigger = "disk-activity";
 		};
 	};
 };
diff --git a/arch/powerpc/boot/dts/mpc8378_rdb.dts b/arch/powerpc/boot/dts/mpc8378_rdb.dts
index 74b6a53..71842fc 100644
--- a/arch/powerpc/boot/dts/mpc8378_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8378_rdb.dts
@@ -480,7 +480,7 @@
 
 		hdd {
 			gpios = <&mcu_pio 1 0>;
-			linux,default-trigger = "ide-disk";
+			linux,default-trigger = "disk-activity";
 		};
 	};
 };
diff --git a/arch/powerpc/boot/dts/mpc8379_rdb.dts b/arch/powerpc/boot/dts/mpc8379_rdb.dts
index 3b5cbac..e442a29 100644
--- a/arch/powerpc/boot/dts/mpc8379_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8379_rdb.dts
@@ -446,7 +446,7 @@
 
 		hdd {
 			gpios = <&mcu_pio 1 0>;
-			linux,default-trigger = "ide-disk";
+			linux,default-trigger = "disk-activity";
 		};
 	};
 };
diff --git a/arch/powerpc/configs/pmac32_defconfig b/arch/powerpc/configs/pmac32_defconfig
index ea8705f..3f6c9a6 100644
--- a/arch/powerpc/configs/pmac32_defconfig
+++ b/arch/powerpc/configs/pmac32_defconfig
@@ -158,7 +158,7 @@ CONFIG_ADB=y
 CONFIG_ADB_CUDA=y
 CONFIG_ADB_PMU=y
 CONFIG_ADB_PMU_LED=y
-CONFIG_ADB_PMU_LED_IDE=y
+CONFIG_ADB_PMU_LED_DISK=y
 CONFIG_PMAC_APM_EMU=m
 CONFIG_PMAC_MEDIABAY=y
 CONFIG_PMAC_BACKLIGHT=y
diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/ppc6xx_defconfig
index 99ccbeba..1dde0be 100644
--- a/arch/powerpc/configs/ppc6xx_defconfig
+++ b/arch/powerpc/configs/ppc6xx_defconfig
@@ -442,7 +442,7 @@ CONFIG_ADB=y
 CONFIG_ADB_CUDA=y
 CONFIG_ADB_PMU=y
 CONFIG_ADB_PMU_LED=y
-CONFIG_ADB_PMU_LED_IDE=y
+CONFIG_ADB_PMU_LED_DISK=y
 CONFIG_PMAC_APM_EMU=y
 CONFIG_PMAC_MEDIABAY=y
 CONFIG_PMAC_BACKLIGHT=y
diff --git a/drivers/macintosh/Kconfig b/drivers/macintosh/Kconfig
index 3e8b29e..d28690f 100644
--- a/drivers/macintosh/Kconfig
+++ b/drivers/macintosh/Kconfig
@@ -96,19 +96,18 @@ config ADB_PMU_LED
 	  Support the front LED on Power/iBooks as a generic LED that can
 	  be triggered by any of the supported triggers. To get the
 	  behaviour of the old CONFIG_BLK_DEV_IDE_PMAC_BLINK, select this
-	  and the ide-disk LED trigger and configure appropriately through
-	  sysfs.
+	  and the disk LED trigger and configure appropriately through sysfs.
 
-config ADB_PMU_LED_IDE
-	bool "Use front LED as IDE LED by default"
+config ADB_PMU_LED_DISK
+	bool "Use front LED as DISK LED by default"
 	depends on ADB_PMU_LED
 	depends on LEDS_CLASS
 	depends on IDE_GD_ATA
 	select LEDS_TRIGGERS
-	select LEDS_TRIGGER_IDE_DISK
+	select LEDS_TRIGGER_DISK
 	help
-	  This option makes the front LED default to the IDE trigger
-	  so that it blinks on IDE activity.
+	  This option makes the front LED default to the disk trigger
+	  so that it blinks on disk activity.
 
 config PMAC_SMU
 	bool "Support for SMU  based PowerMacs"
diff --git a/drivers/macintosh/via-pmu-led.c b/drivers/macintosh/via-pmu-led.c
index 19c3718..ae067ab 100644
--- a/drivers/macintosh/via-pmu-led.c
+++ b/drivers/macintosh/via-pmu-led.c
@@ -73,8 +73,8 @@ static void pmu_led_set(struct led_classdev *led_cdev,
 
 static struct led_classdev pmu_led = {
 	.name = "pmu-led::front",
-#ifdef CONFIG_ADB_PMU_LED_IDE
-	.default_trigger = "ide-disk",
+#ifdef CONFIG_ADB_PMU_LED_DISK
+	.default_trigger = "disk-activity",
 #endif
 	.brightness_set = pmu_led_set,
 };
-- 
2.8.4
