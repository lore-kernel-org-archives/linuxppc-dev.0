Return-Path: <linus.walleij@linaro.org>
Received: from mail-lf0-x231.google.com (mail-lf0-x231.google.com
 [IPv6:2a00:1450:4010:c07::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x89rj5DW0zDqg2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jul 2017 21:46:44 +1000 (AEST)
Received: by mail-lf0-x231.google.com with SMTP id z78so52426389lff.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jul 2017 04:46:44 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, opensuse-ppc@opensuse.org,
 Linus Walleij <linus.walleij@linaro.org>, stable@vger.kernel.org
Subject: [PATCH] machintosh: select defaults for cooling
Date: Fri, 14 Jul 2017 13:46:29 +0200
Message-Id: <20170714114629.1512-1-linus.walleij@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I have this pretty nasty problem when trying to boot up a fresh
openSuSE DVD on a PowerMac G5: the kernel by default does not have
CONFIG_WINDFARM_PM72 enabled, with the effect that the cooling
is not functioning.

The BIOS on the PowerMac G5 reacts to this by, after a grace
period when the BIOS has waited for the OS to take over, increasing
the fan speeds so it sounds like an airplane is in the room, and
after another grace period simply cutting the power to the
machine. This is done not beacuse the cooling is not working, but
because the BIOS is not recieving handover of cooling from the
OS, so it panics and give up. The problem has been reported by
Linux users online.

Needless to say, this makes it impossible to install the OS
before the machine turns itself off.

The g5_defconfig looks like this:
CONFIG_PMAC_SMU=y
CONFIG_WINDFARM=y
CONFIG_WINDFARM_PM81=y
CONFIG_WINDFARM_PM91=y
CONFIG_WINDFARM_PM112=y
CONFIG_WINDFARM_PM121=y

Notably PM72 is missing, making the PowerMac G5 fail.

The defconfig is not the right place to do this: it should be
done by default when selecting Mac support for PPC/PPC64 and
especially for the Macs CPUfreq driver. We select SMU by default
for PPC_PMAC64, WINDFARM by default on PPC_PMAC and all the
WINDFARM thermal managers by default if CPU_FREQ_PMAC64 is
selected.

I think this will make install images work in the G5 Macs.

Cc: stable@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/macintosh/Kconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/macintosh/Kconfig b/drivers/macintosh/Kconfig
index 97a420c11eed..d7186d8f30a9 100644
--- a/drivers/macintosh/Kconfig
+++ b/drivers/macintosh/Kconfig
@@ -101,6 +101,7 @@ config ADB_PMU_LED_DISK
 config PMAC_SMU
 	bool "Support for SMU  based PowerMacs"
 	depends on PPC_PMAC64
+	default PPC_PMAC64
 	help
 	  This option adds support for the newer G5 iMacs and PowerMacs based
 	  on the "SMU" system control chip which replaces the old PMU.
@@ -194,11 +195,13 @@ config THERM_ADT746X
 config WINDFARM
 	tristate "New PowerMac thermal control infrastructure"
 	depends on PPC
+	default PPC_PMAC
 
 config WINDFARM_PM81
 	tristate "Support for thermal management on iMac G5"
 	depends on WINDFARM && I2C && CPU_FREQ_PMAC64 && PMAC_SMU
 	select I2C_POWERMAC
+	default CPU_FREQ_PMAC64
 	help
 	  This driver provides thermal control for the iMacG5
 
@@ -206,6 +209,7 @@ config WINDFARM_PM72
 	tristate "Support for thermal management on PowerMac G5 (AGP)"
 	depends on WINDFARM && I2C && CPU_FREQ_PMAC64 && ADB_PMU
 	select I2C_POWERMAC
+	default CPU_FREQ_PMAC64
 	help
 	  This driver provides thermal control for the PowerMac G5
 	  "AGP" variants (PowerMac 7,2 and 7,3)
@@ -214,6 +218,7 @@ config WINDFARM_RM31
 	tristate "Support for thermal management on Xserve G5"
 	depends on WINDFARM && I2C && CPU_FREQ_PMAC64 && ADB_PMU
 	select I2C_POWERMAC
+	default CPU_FREQ_PMAC64
 	help
 	  This driver provides thermal control for the Xserve G5
 	  (RackMac3,1)
@@ -222,6 +227,7 @@ config WINDFARM_PM91
 	tristate "Support for thermal management on PowerMac9,1"
 	depends on WINDFARM && I2C && CPU_FREQ_PMAC64 && PMAC_SMU
 	select I2C_POWERMAC
+	default CPU_FREQ_PMAC64
 	help
 	  This driver provides thermal control for the PowerMac9,1
           which is the recent (SMU based) single CPU desktop G5
-- 
2.9.4
